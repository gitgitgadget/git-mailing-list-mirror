From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Fri, 20 May 2011 23:58:47 -0700
Message-ID: <1305961127-26540-5-git-send-email-gitster@pobox.com>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg9s-0006kd-7t
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab1EUG71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:59:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1EUG7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:59:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A45355DFA
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+BKF
	TZCLdjfAYA+dNTVYfXiopUI=; b=Majqrn7AOSLyF9iVU6yct11dr5MUtruk9EDx
	RHD5pSpp7nFa/g49Aod7k3JBCXFFnatOw5W4a+ycgXL3Tt/xN6Sglr7Skw+H8InF
	yEBAyLwBDLM4d2SMzeG5FWPRwMXMAlc34p6kg3jDvVoWDm2TY38TzgzHRYzPhNTn
	hs8Avqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wzRIDm
	mXzA5amA1yzSmCyl5EvgjBIV3syftmJOmx8OuVWaLlXryEAmKKRP/GIzEmCn9LUU
	bLEZ3z8MKK/tZGUTBNNJxPQ6O/JEy1ADhwiUO8IA8zFh5rXnlkRZy1XDLez1hWxP
	pbmAUtcGomVwIUtz+LkjVNy335G2ZA6wYxreE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0D5F5DF9
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:01:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A603E5DF8 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:01:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305961127-26540-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 283E1D9E-8378-11E0-ADB3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174111>

Add support for "ident" filter on the output codepath. Because we now have
more than one filter active, also add support to cascade them together.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There is one known issue in this "ident" filter implementation. If the
   input data ends while the filter is still in the "SKIPPING" state, it
   should go to the "DRAINING" codepath using the same logic that triggers
   when it gets to the end of line, copying out what was already queued.
   However, the API does not offer an explicit way for the input side to
   say "that's all". We probably need to make a zero-byte input to the
   filter function as an explicit EOF signal or something---currently I
   think it will loop forever, but it is getting late, so I will not be
   further touching this code tonight.

 convert.c |  254 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 246 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index 82fb75b..6b90c4d 100644
--- a/convert.c
+++ b/convert.c
@@ -868,6 +868,10 @@ int is_null_stream_filter(struct stream_filter *filter)
 	return filter == &null_filter_singleton;
 }
 
+
+/*
+ * LF-to-CRLF filter
+ */
 static int lf_to_crlf_filter_fn(struct stream_filter *filter,
 				const char *input, size_t *isize_p,
 				char *output, size_t *osize_p)
@@ -901,6 +905,237 @@ static struct stream_filter lf_to_crlf_filter_singleton = {
 	&lf_to_crlf_vtbl,
 };
 
+
+/*
+ * Cascade filter
+ */
+#define FILTER_BUFFER 1024
+struct cascade_filter {
+	struct stream_filter filter;
+	struct stream_filter *one;
+	struct stream_filter *two;
+	char ibuf[FILTER_BUFFER];
+	char obuf[FILTER_BUFFER];
+	int i_end, i_ptr;
+	int o_end, o_ptr;
+};
+
+static int cascade_filter_fn(struct stream_filter *filter,
+			     const char *input, size_t *isize_p,
+			     char *output, size_t *osize_p)
+{
+	struct cascade_filter *cas = (struct cascade_filter *) filter;
+	size_t filled = 0;
+	size_t sz = *osize_p;
+	size_t to_feed, remaining;
+
+	/*
+	 * input --> ibuf --(one)--> obuf --(two)--> output
+	 */
+	while (filled < sz) {
+		/* do we already have output to feed two? */
+		if (cas->o_ptr < cas->o_end) {
+			to_feed = cas->o_end - cas->o_ptr;
+			remaining = sz - filled;
+			if (stream_filter(cas->two,
+					  cas->obuf + cas->o_ptr, &to_feed,
+					  output + filled, &remaining))
+				return -1;
+			cas->o_ptr += (cas->o_end - cas->o_ptr) - to_feed;
+			filled = sz - remaining;
+			continue;
+		}
+		cas->o_end = cas->o_ptr = 0;
+
+		/* do we have anything to feed one? */
+		if (cas->i_ptr < cas->i_end) {
+			to_feed = cas->i_end - cas->i_ptr;
+			remaining = sizeof(cas->obuf);
+			if (stream_filter(cas->one,
+					  cas->ibuf + cas->i_ptr, &to_feed,
+					  cas->obuf, &remaining))
+				return -1;
+			cas->i_ptr += (cas->i_end - cas->i_ptr) - to_feed;
+			cas->o_end = sizeof(cas->obuf) - remaining;
+			continue;
+		}
+		cas->i_end = cas->i_ptr = 0;
+
+		/* read from our upstream */
+		to_feed = *isize_p;
+		if (sizeof(cas->ibuf) < to_feed)
+			to_feed = sizeof(cas->ibuf);
+		if (!to_feed)
+			break;
+		memcpy(cas->ibuf, input, to_feed);
+		input += to_feed;
+		*isize_p -= to_feed;
+		cas->i_end = to_feed;
+	}
+	*osize_p -= filled;
+	return 0;
+}
+
+static void cascade_free_fn(struct stream_filter *filter)
+{
+	struct cascade_filter *cas = (struct cascade_filter *)filter;
+	free_stream_filter(cas->one);
+	free_stream_filter(cas->two);
+	free(filter);
+}
+
+static struct stream_filter_vtbl cascade_vtbl = {
+	cascade_filter_fn,
+	cascade_free_fn,
+};
+
+static struct stream_filter *cascade_filter(struct stream_filter *one,
+					    struct stream_filter *two)
+{
+	struct cascade_filter *cascade;
+
+	if (!one || is_null_stream_filter(one))
+		return two;
+	if (!two || is_null_stream_filter(two))
+		return one;
+
+	cascade = xmalloc(sizeof(*cascade));
+	cascade->one = one;
+	cascade->two = two;
+	cascade->i_end = cascade->i_ptr = 0;
+	cascade->o_end = cascade->o_ptr = 0;
+	cascade->filter.vtbl = &cascade_vtbl;
+	return (struct stream_filter *)cascade;
+}
+
+/*
+ * ident filter
+ */
+#define IDENT_DRAINING (-1)
+#define IDENT_SKIPPING (-2)
+struct ident_filter {
+	struct stream_filter filter;
+	struct strbuf left;
+	int state;
+	char ident[45]; /* ": x40 $" */
+};
+
+static int is_foreign_ident(const char *str)
+{
+	int i;
+
+	if (prefixcmp(str, "$Id: "))
+		return 0;
+	for (i = 5; str[i]; i++) {
+		if (isspace(str[i]) && str[i+1] != '$')
+			return 1;
+	}
+	return 0;
+}
+
+static int ident_filter_fn(struct stream_filter *filter,
+			   const char *input, size_t *isize_p,
+			   char *output, size_t *osize_p)
+{
+	struct ident_filter *ident = (struct ident_filter *)filter;
+	static const char head[] = "$Id";
+
+	while (*isize_p || (ident->state == IDENT_DRAINING)) {
+		int ch;
+
+		if (ident->state == IDENT_DRAINING) {
+			/* Draining what is in left */
+			size_t to_drain = ident->left.len;
+
+			if (!to_drain) {
+				ident->state = 0;
+				continue;
+			}
+			if (!*osize_p)
+				break;
+			if (*osize_p < to_drain)
+				to_drain = *osize_p;
+			memcpy(output, ident->left.buf, to_drain);
+			strbuf_remove(&ident->left, 0, to_drain);
+			output += to_drain;
+			(*osize_p) -= to_drain;
+			continue;
+		}
+
+		ch = *(input++);
+		(*isize_p)--;
+
+		if (ident->state == IDENT_SKIPPING) {
+			/*
+			 * Skipping until '$' or LF, but keeping them
+			 * in case it is a foreign ident.
+			 */
+			strbuf_addch(&ident->left, ch);
+			if (ch != '\n' && ch != '$')
+				continue;
+			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
+				strbuf_reset(&ident->left);
+				strbuf_addstr(&ident->left, head);
+				strbuf_addstr(&ident->left, ident->ident);
+			}
+			ident->state = IDENT_DRAINING;
+			continue;
+		}
+
+		if (ident->state < sizeof(head) &&
+		    head[ident->state] == ch) {
+			ident->state++;
+			continue;
+		}
+
+		if (ident->state)
+			strbuf_add(&ident->left, head, ident->state);
+		if (ident->state == sizeof(head) - 1) {
+			if (ch != ':' && ch != '$') {
+				strbuf_addch(&ident->left, ch);
+				ident->state = 0;
+				continue;
+			}
+
+			if (ch == ':') {
+				strbuf_addch(&ident->left, ch);
+				ident->state = IDENT_SKIPPING;
+			} else {
+				strbuf_addstr(&ident->left, ident->ident);
+				ident->state = IDENT_DRAINING;
+			}
+			continue;
+		}
+
+		strbuf_addch(&ident->left, ch);
+		ident->state = IDENT_DRAINING;
+	}
+	return 0;
+}
+
+static void ident_free_fn(struct stream_filter *filter)
+{
+	struct ident_filter *ident = (struct ident_filter *)filter;
+	strbuf_release(&ident->left);
+	free(filter);
+}
+
+static struct stream_filter_vtbl ident_vtbl = {
+	ident_filter_fn,
+	ident_free_fn,
+};
+
+static struct stream_filter *ident_filter(const unsigned char *sha1)
+{
+	struct ident_filter *ident = xmalloc(sizeof(*ident));
+
+	sprintf(ident->ident, ": %s $", sha1_to_hex(sha1));
+	strbuf_init(&ident->left, 0);
+	ident->filter.vtbl = &ident_vtbl;
+	ident->state = 0;
+	return (struct stream_filter *)ident;
+}
+
 /*
  * Return an appropriately constructed filter for the path, or NULL if
  * the contents cannot be filtered without reading the whole thing
@@ -913,23 +1148,26 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 {
 	struct conv_attrs ca;
 	enum crlf_action crlf_action;
+	struct stream_filter *filter = NULL;
 
 	convert_attrs(&ca, path);
 
-	if (ca.ident ||
-	    (ca.drv && (ca.drv->smudge || ca.drv->clean)))
-		return NULL;
+	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
+		return filter;
+
+	if (ca.ident)
+		filter = ident_filter(sha1);
 
 	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 	if ((crlf_action == CRLF_BINARY) || (crlf_action == CRLF_INPUT) ||
 	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
-		return &null_filter_singleton;
+		filter = cascade_filter(filter, &null_filter_singleton);
 
-	if (output_eol(crlf_action) == EOL_CRLF &&
-	    !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
-		return &lf_to_crlf_filter_singleton;
+	else if (output_eol(crlf_action) == EOL_CRLF &&
+		 !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
+		filter = cascade_filter(filter, &lf_to_crlf_filter_singleton);
 
-	return NULL;
+	return filter;
 }
 
 void free_stream_filter(struct stream_filter *filter)
-- 
1.7.5.2.369.g8fc017
