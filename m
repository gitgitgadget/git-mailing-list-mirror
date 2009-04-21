From: Junio C Hamano <gitster@pobox.com>
Subject: Re: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 20:09:22 -0700
Message-ID: <7vskk2bt3x.fsf@gitster.siamese.dyndns.org>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
 <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
 <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
 <20090421024433.GC14479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6O2-0004tw-HZ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbZDUDJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZDUDJc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:09:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZDUDJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:09:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A0D9109B9;
	Mon, 20 Apr 2009 23:09:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3A7EA109B7; Mon,
 20 Apr 2009 23:09:24 -0400 (EDT)
In-Reply-To: <20090421024433.GC14479@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 20 Apr 2009 22:44:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D493A0C2-2E21-11DE-895E-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117082>

Jeff King <peff@peff.net> writes:

> So basically one branch removes a file and adds an identical file under
> a different name, while the other branch modifies the original file. Git
> detects it as a rename, and applies the change from the second branch to
> the newly added file instead of generating a conflict.
>
> This is _exactly_ what git's rename detection is designed to do. Yes, it
> seems horribly confusing in this toy example, but that is because it is
> a toy example: both 'date' and 'LICENSE' are empty files. But with real
> files, if a source file has actual content but is deleted, there is a
> new filename with the identical or near-identical content, and the patch
> applies to the new content without conflicts, then applying it there is
> probably exactly what you want.

I had to briefly wonder what the fallout would be if we begin special-
casing empty blobs excluded even from exact renames.  We effectively do
not consider fuzzy renames for blobs smaller than certain threshold, and
sane projects would not have an empty file tracked anyway, so...

A much lessor impact change would be to keep the diffcore-rename as-is, so
that it does detect exact renames between a pair of empty files, but
special case it in merge-recursive.  I think I like the latter approach
better.

In any case, here is what the damage would look like...

 diffcore-rename.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0b0d6b8..dc1f159 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -59,11 +59,14 @@ static struct diff_rename_src {
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
-						   unsigned short score)
+static void register_rename_src(struct diff_filespec *one,
+				unsigned short score)
 {
 	int first, last;
 
+	if (is_empty_blob_sha1(one->sha1))
+		return;
+
 	first = 0;
 	last = rename_src_nr;
 	while (last > first) {
@@ -71,7 +74,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 		struct diff_rename_src *src = &(rename_src[next]);
 		int cmp = strcmp(one->path, src->one->path);
 		if (!cmp)
-			return src;
+			return;
 		if (cmp < 0) {
 			last = next;
 			continue;
@@ -91,7 +94,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filespec *one,
 			(rename_src_nr - first - 1) * sizeof(*rename_src));
 	rename_src[first].one = one;
 	rename_src[first].score = score;
-	return &(rename_src[first]);
+	return;
 }
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
@@ -436,6 +439,8 @@ void diffcore_rename(struct diff_options *options)
 			else if (options->single_follow &&
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
+			else if (is_empty_blob_sha1(p->two->sha1))
+				continue; /* not interested */
 			else
 				locate_rename_dst(p->two, 1);
 		}
