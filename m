From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 03 Feb 2013 13:07:48 -0800
Message-ID: <7v8v7585sr.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U26nO-00010G-M8
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 22:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab3BCVHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 16:07:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab3BCVHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 16:07:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E7ADC7AC;
	Sun,  3 Feb 2013 16:07:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGKG3lgp5Sl2UhCGFWQ8t9R3/aw=; b=C1G86L
	WwstUkVHt0GkEk1zCiLdCH4eUQszb4HMLQgEMG3lnyaWxuzjx/PWBzMaCJlSDtHi
	2D22/NRQqEkj4p3Dd7mHEQxI51ft5XEeD3fdKaHbHw02dX0iCdzRlFuOVat+ycCs
	VXkBu8sS5kjJt5hlGcjabYT5ueRb3JVzA2IT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qCyzUgxJYYUJR8C2ZtIXC65UX1rTfTYJ
	cAY8DmnounN7r4VWr6qK4BSsiqC+fIqOScVR6lX58paQ/KijYHBDfB9miNwIYZf7
	g5oKQVrf4M/93aXGeVKfbeMBI+ecJ2Br6veD30pHKxLdurdtnM4uv8FE2EDIxqTk
	/tHYSl7aUlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22DB5C7AB;
	Sun,  3 Feb 2013 16:07:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 697EEC7AA; Sun,  3 Feb 2013
 16:07:50 -0500 (EST)
In-Reply-To: <20130203203150.GU1342@serenity.lan> (John Keeping's message of
 "Sun, 3 Feb 2013 20:31:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C494A6B8-6E45-11E2-A17D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215335>

John Keeping <john@keeping.me.uk> writes:

> A quick search turned up the original thread where this feature was
> added to Clang [1].  It seems that it does find genuine bugs where
> people try to log values by doing:
>
>     log("failed to handle error: " + errno);

To be perfectly honest, anybody who writes such a code should be
sent back to school before trying to touch out code ever again ;-).
It is not even valid Python, Perl nor Java, I would think.

> Are you happy to change COLONS to a const char[] instead of a #define?

Happy?  Not really.

It could be a good change for entirely different reason. We will
save space if we ever need to use it in multiple places.  But the
entire "COLONS + offset" thing was a hack we did, knowing that it
will break when we end up showing a muiti-way diff for more than 32
blobs.

If we were to be touching that area of code, I'd rather see a change
to make it more robust against such a corner case.  If it results in
squelching misguided clang warnings against programmers who should
not be writing in C, that is a nice side effect, but I loathe to see
any change whose primary purpose is to squelch pointless warnings.

 combine-diff.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..7f6187f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -982,14 +982,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	free(sline);
 }
 
-#define COLONS "::::::::::::::::::::::::::::::::"
-
 static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int i, offset;
-	const char *prefix;
-	int line_termination, inter_name_termination;
+	int line_termination, inter_name_termination, i;
 
 	line_termination = opt->line_termination;
 	inter_name_termination = '\t';
@@ -1000,17 +996,14 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		show_log(rev);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
-		offset = strlen(COLONS) - num_parent;
-		if (offset < 0)
-			offset = 0;
-		prefix = COLONS + offset;
+		/* As many colons as there are parents */
+		for (i = 0; i < num_parent; i++)
+			putchar(':');
 
 		/* Show the modes */
-		for (i = 0; i < num_parent; i++) {
-			printf("%s%06o", prefix, p->parent[i].mode);
-			prefix = " ";
-		}
-		printf("%s%06o", prefix, p->mode);
+		for (i = 0; i < num_parent; i++)
+			printf("%06o ", p->parent[i].mode);
+		printf("%06o", p->mode);
 
 		/* Show sha1's */
 		for (i = 0; i < num_parent; i++)
