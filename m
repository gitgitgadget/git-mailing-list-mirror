From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Wed, 07 May 2008 12:33:07 -0700
Message-ID: <7vej8ddi4s.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
 <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
 <alpine.DEB.1.00.0805060954470.30431@racer>
 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
 <alpine.DEB.1.00.0805071223450.30431@racer>
 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 07 21:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtpP4-0000jC-NQ
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436AbYEGTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 15:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757209AbYEGTdU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 15:33:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856AbYEGTdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 15:33:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 309313D00;
	Wed,  7 May 2008 15:33:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2BF1738FC; Wed,  7 May 2008 15:33:10 -0400 (EDT)
In-Reply-To: <7viqxqc4gs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 May 2008 12:13:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7094EEE0-1C6C-11DD-9067-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81475>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't tested this at all (this is a lunchtime hack) and have a mild
> suspicion that it may have corner case miscounting (e.g. I blindly
> subtracts 3 from len when dealing with a line that represents a single
> token from the internal diff output --- do I always have 3 there even when
> the original file ends with an incomplete line?  I didn't check), but
> other than that I think this is a lot easier to read and follow.

And this adds "--color-words -b" support as an example.

The second hunk, however, is a bugfix to the previous one.  The code wants
the LF at the end of the line always returned as a single token.

---
 diff.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 344aaa6..bce0626 100644
--- a/diff.c
+++ b/diff.c
@@ -357,6 +357,7 @@ struct emit_callback {
 	struct xdiff_emit_state xm;
 	int nparents, color_diff;
 	unsigned ws_rule;
+	struct diff_options *diffopt;
 	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
@@ -378,19 +379,36 @@ static size_t diff_words_tokenize(struct emit_callback *ecbdata,
 
 	if (!len)
 		return 0;
+	/*
+	 * Always return LF at the end as a single separate token.
+	 */
+	if ((len == 1) && *line == '\n')
+		return 1;
 
 	is_space = isspace(*line);
 	while (len && (isspace(*line) == is_space)) {
 		line++;
 		len--;
 	}
+	if (is_space && !len)
+		line--;
 	return line - line0;
 }
 
+static int token_is_ws_only(char *line, size_t len)
+{
+	while (len--)
+		if (!isspace(*line))
+			return 0;
+	return 1;
+}
+
 static void diff_words_append(struct emit_callback *ecbdata,
 			      char *line, unsigned long len,
 			      struct strbuf *text)
 {
+	struct diff_options *diffopt = ecbdata->diffopt;
+
 	/* Skip leading +/- first. */
 	line++;
 	len--;
@@ -407,9 +425,14 @@ static void diff_words_append(struct emit_callback *ecbdata,
 			 * so that we can recover the original
 			 * end-of-line easily.  Stupid, but works.
 			 */
-			strbuf_add(text, " ", 1);
-			strbuf_add(text, line, token_len);
-			strbuf_add(text, "\n", 1);
+			if ((diffopt->xdl_opts & XDF_IGNORE_WHITESPACE) &&
+			    token_is_ws_only(line, token_len)) {
+				strbuf_add(text, "  \n", 3);
+			} else {
+				strbuf_add(text, " ", 1);
+				strbuf_add(text, line, token_len);
+				strbuf_add(text, "\n", 1);
+			}
 			len -= token_len;
 			line += token_len;
 		} else {
@@ -1447,6 +1470,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		ecbdata.file = o->file;
+		ecbdata.diffopt = o;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
