From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk headers
Date: Fri, 30 Oct 2009 10:20:27 -0700
Message-ID: <7v3a50n6hw.fsf@alter.siamese.dyndns.org>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
 <200910291222.42598.markus.heidelberg@web.de>
 <alpine.DEB.1.00.0910291425010.3687@felix-maschine>
 <200910291729.23562.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Oct 30 18:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3v9Z-0008Ch-Tv
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbZJ3RUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbZJ3RUe
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:20:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbZJ3RUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 13:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA676D793;
	Fri, 30 Oct 2009 13:20:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4uy8UNMWgToyd2fnCMxlFFr+iM=; b=kp6j/5
	dqCxEVj0oa0dH0p23ziW9MvDWDKLHMapYdSu3eL9vjjhbA+N88b9o3j+EQM5EQ8M
	1ArX4oZyvIFJte6xvYXRHuJcE6fhJ+IaYiTWLNYs6eSXMiNGEAJX/GdSujJxzyui
	JQfwdjOqS4PFix+0AsU+o3eKYHBRYW9e50u3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MJnCEqfekPzt9xskvW/qYl6nnsxNMjrd
	Cdb1Ha/u2ZSQ7HODqqxyiVfHLq+72rL5odmQPRVbzjtwcAjEMfp3xYYez/0ZqgqB
	tp1MpANgaJOy3IHNYHh+8BtRFZMnf1i5aFKcprH2p/gOjWUyvwrMFBpQsS921zoW
	As4uCDK6EPw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65AE86D792;
	Fri, 30 Oct 2009 13:20:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E80496D790; Fri, 30 Oct
 2009 13:20:28 -0400 (EDT)
In-Reply-To: <200910291729.23562.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Thu\, 29 Oct 2009 17\:29\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8873EEEC-C578-11DE-90F9-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131716>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> I try to reword:
> With 2/3 and 3/3 I wanted to keep --color-words specific code in the
> block starting with
>
> 	if (ecbdata->diff_words) {
>
> and didn't want to contaminate the block starting with
>
> 	if (line[0] == '@') {
>
> with non-hunk-header content.

The contamination was already done long time ago.  The way "color words"
mode piggybacks into the rest of the code is to let the line oriented diff
codepath run, capture the lines to its buffer so that it can split them
into words and compare, and hijack the control flow not to let the line
oriented diff to be output, and in the context of the original design,
Dscho's patch makes sense.

I do think that the way the "color words" logic has to touch line-oriented
codepaths unnecessarily makes it look intrusive; one reason is because it
exposes the state that is only interesting to the "color words" mode to
these places too much.

With a small helper function on top of Dscho's patch, I think the code can
be made a lot more readable.  This way, "consume" codepath is made more
about "here is what we do when we get a line from the line-oriented diff
engine", and we can keep the knowledge of "color words" mode to the
minimum (no more than "here is where we may need to flush the buffer").
The helper hides the implementation details such as how we decide if we
have accumulated words or what we do when we do need to flush.

There is another large-ish "if (ecbdata->diff_words)" codeblock in
fn_out_consume() that peeks into *(ecbdata->diff_words); I think it should
be ejected from the main codepath for the same reason (i.e. readability).
.
Probably we can make a helper function that has only a single caller, like
this:

        static void diff_words_use_line(char *line, unsigned long len,
                                        struct emit_callback *ecbdata,
                                        const char *plain, const char *reset)
        {
                if (line[0] == '-') {
                        diff_words_append(line, len,
                                          &ecbdata->diff_words->minus);
                        return;
                } else if (line[0] == '+') {
                        diff_words_append(line, len,
                                          &ecbdata->diff_words->plus);
                        return;
                }
                diff_words_flush(ecbdata);
                line++;
                len--;
                emit_line(ecbdata->file, plain, reset, line, len);
        }

It would even be cleaner to change "diff_words_append()" function to do
all of the above.

But that is outside the scope of this comment.


 diff.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index b7ecfe3..8c66e4a 100644
--- a/diff.c
+++ b/diff.c
@@ -541,14 +541,18 @@ struct emit_callback {
 	FILE *file;
 };
 
+/* In "color-words" mode, show word-diff of words accumulated in the buffer */
+static void diff_words_flush(struct emit_callback *ecbdata)
+{
+	if (ecbdata->diff_words->minus.text.size ||
+	    ecbdata->diff_words->plus.text.size)
+		diff_words_show(ecbdata->diff_words);
+}
+
 static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
-		/* flush buffers */
-		if (ecbdata->diff_words->minus.text.size ||
-				ecbdata->diff_words->plus.text.size)
-			diff_words_show(ecbdata->diff_words);
-
+		diff_words_flush(ecbdata);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
@@ -656,12 +660,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	for (i = 0; i < len && line[i] == '@'; i++)
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
-		/* flush --color-words even for --unified=0 */
-		if (ecbdata->diff_words &&
-		    (ecbdata->diff_words->minus.text.size ||
-		     ecbdata->diff_words->plus.text.size))
-			diff_words_show(ecbdata->diff_words);
-
+		if (ecbdata->diff_words)
+			diff_words_flush(ecbdata);
 		ecbdata->nparents = i - 1;
 		len = sane_truncate_line(ecbdata, line, len);
 		emit_line(ecbdata->file,
@@ -691,9 +691,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 					  &ecbdata->diff_words->plus);
 			return;
 		}
-		if (ecbdata->diff_words->minus.text.size ||
-		    ecbdata->diff_words->plus.text.size)
-			diff_words_show(ecbdata->diff_words);
+		diff_words_flush(ecbdata);
 		line++;
 		len--;
 		emit_line(ecbdata->file, plain, reset, line, len);
