From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2?] streaming: filter cascading
Date: Tue, 24 May 2011 19:23:04 -0700
Message-ID: <7vfwo35xiv.fsf_-_@alter.siamese.dyndns.org>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
 <1305961127-26540-5-git-send-email-gitster@pobox.com>
 <4DD82931.6000101@lsrfire.ath.cx> <4DD82DB2.8000101@lsrfire.ath.cx>
 <7vy61v612b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 04:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP3kk-0004XA-CX
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 04:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab1EYCXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 22:23:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab1EYCXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 22:23:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 511905DD0;
	Tue, 24 May 2011 22:25:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVMhKPTH+DiWo/biwRca3sURWBE=; b=JNWnNU
	RcQKpyG+SVhakkpqxraeE9cfiRvpeDgOa6b/kLhL+JG5h/dyEtC7os/r+GCfe9XE
	DnUyncEkOKdTwrC+oFqn1Y9mNLZkdTGluVPQs9QKoBu3Dg7V539jk7/J7D4h935E
	/PEQbZ5rY0Cb+FNZ5IGVNZJPNZRmxYZx3kMXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OO+xHZO6TvhPMSFD5+mlefvtUGIJPJxv
	kjbcwkjqhvDUEZLmgzlsqXshKGjg6FiCjOm3J3tmAgSEcy4hGX6OjE42I8hN6Zc6
	C8UI8T63JzRvYlu1nnBGsbQNylX4IyTEJmhryk810SCuAL9xP+8+R/9VWAXyOscS
	tIpjYQBXg7s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 243AB5DCF;
	Tue, 24 May 2011 22:25:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CCBE15DCE; Tue, 24 May 2011
 22:25:13 -0400 (EDT)
In-Reply-To: <7vy61v612b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 May 2011 18:06:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AB6C948-8676-11E0-9086-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174368>

This implements an internal "cascade" filter mechanism that plugs
two filters in series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I said that I suspect cascade was not working when I sent out "What's
   cooking", and I was right X-<.

   This replaces what has been queued for a few days.

 convert.c |  126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index 0c42bcb..85939c2 100644
--- a/convert.c
+++ b/convert.c
@@ -915,6 +915,112 @@ static struct stream_filter lf_to_crlf_filter_singleton = {
 
 
 /*
+ * Cascade filter
+ */
+#define FILTER_BUFFER 1024
+struct cascade_filter {
+	struct stream_filter filter;
+	struct stream_filter *one;
+	struct stream_filter *two;
+	char buf[FILTER_BUFFER];
+	int end, ptr;
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
+	 * input -- (one) --> buf -- (two) --> output
+	 */
+	while (filled < sz) {
+		remaining = sz - filled;
+
+		/* do we already have something to feed two with? */
+		if (cas->ptr < cas->end) {
+			to_feed = cas->end - cas->ptr;
+			if (stream_filter(cas->two,
+					  cas->buf + cas->ptr, &to_feed,
+					  output + filled, &remaining))
+				return -1;
+			cas->ptr += (cas->end - cas->ptr) - to_feed;
+			filled = sz - remaining;
+			continue;
+		}
+
+		/* feed one from upstream and have it emit into our buffer */
+		to_feed = input ? *isize_p : 0;
+		if (input && !to_feed)
+			break;
+		remaining = sizeof(cas->buf);
+		if (stream_filter(cas->one,
+				  input, &to_feed,
+				  cas->buf, &remaining))
+			return -1;
+		cas->end = sizeof(cas->buf) - remaining;
+		cas->ptr = 0;
+		if (input) {
+			size_t fed = *isize_p - to_feed;
+			*isize_p -= fed;
+			input += fed;
+		}
+
+		/* do we know that we drained one completely? */
+		if (input || cas->end)
+			continue;
+
+		/* tell two to drain; we have nothing more to give it */
+		to_feed = 0;
+		remaining = sz - filled;
+		if (stream_filter(cas->two,
+				  NULL, &to_feed,
+				  output + filled, &remaining))
+			return -1;
+		if (remaining == (sz - filled))
+			break; /* completely drained two */
+		filled = sz - remaining;
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
+	cascade->end = cascade->ptr = 0;
+	cascade->filter.vtbl = &cascade_vtbl;
+	return (struct stream_filter *)cascade;
+}
+
+/*
  * ident filter
  */
 #define IDENT_DRAINING (-1)
@@ -1083,20 +1189,12 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
 
 	if ((crlf_action == CRLF_BINARY) || (crlf_action == CRLF_INPUT) ||
-	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE)) {
-		if (filter) {
-			free_stream_filter(filter);
-			return NULL;
-		}
-		return &null_filter_singleton;
-	} else if (output_eol(crlf_action) == EOL_CRLF &&
-		   !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS)) {
-		if (filter) {
-			free_stream_filter(filter);
-			return NULL;
-		}
-		return &lf_to_crlf_filter_singleton;
-	}
+	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
+		filter = cascade_filter(filter, &null_filter_singleton);
+
+	else if (output_eol(crlf_action) == EOL_CRLF &&
+		 !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
+		filter = cascade_filter(filter, &lf_to_crlf_filter_singleton);
 
 	return filter;
 }
-- 
1.7.5.2.483.gc61ca
