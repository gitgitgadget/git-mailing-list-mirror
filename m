From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in git-apply
Date: Sun, 06 Apr 2008 18:11:13 -0700
Message-ID: <7vej9isc3y.fsf@gitster.siamese.dyndns.org>
References: <20080406235334.GA8483@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 03:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JifuZ-0007fY-BE
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 03:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbYDGBLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 21:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbYDGBLa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 21:11:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757070AbYDGBL3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 21:11:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77D92A817;
	Sun,  6 Apr 2008 21:11:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 68169A813; Sun,  6 Apr 2008 21:11:21 -0400 (EDT)
cc: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20080406235334.GA8483@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Mon, 7 Apr 2008 01:53:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78945>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> I bisected, and the culprit was this commit:
>
> commit dc41976a3eed1d9c93fdc08c448bab969db4e0ec

I think the issue is much older than that.  The faulty one is 4be6096
(apply --unidiff-zero: loosen sanity checks for --unidiff=3D0 patches,
2006-09-17), which incorrectly loosened the match_beginning/match_end
computation too much, whose botch may have been hidden by what the
surrounding code did.

And 65aadb9 (apply: force matching at the beginning., 2006-05-24) is
equally wrong in that it tried to take hints from leading context lines=
,
to decide if the hunk must match at the beginning, but in this case we
can just look at the line number in the hunk to decide.

How about doing this?


 builtin-apply.c           |   29 ++++++++++++++++-------------
 t/t4104-apply-boundary.sh |   13 +++++++++++++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b5f78ac..abe73a0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1937,21 +1937,24 @@ static int apply_one_fragment(struct image *img=
, struct fragment *frag,
 	trailing =3D frag->trailing;
=20
 	/*
-	 * If we don't have any leading/trailing data in the patch,
-	 * we want it to match at the beginning/end of the file.
+	 * A hunk to change lines at the beginning would begin with
+	 * @@ -1,L +N,M @@
 	 *
-	 * But that would break if the patch is generated with
-	 * --unified=3D0; sane people wouldn't do that to cause us
-	 * trouble, but we try to please not so sane ones as well.
+	 * And a hunk to add to an empty file would begin with
+	 * @@ -0,0 +N,M @@
+	 *
+	 * In other words, a hunk that is (frag->oldpos <=3D 1) with or
+	 * without leading context must match at the beginning.
 	 */
-	if (unidiff_zero) {
-		match_beginning =3D (!leading && !frag->oldpos);
-		match_end =3D 0;
-	}
-	else {
-		match_beginning =3D !leading && (frag->oldpos =3D=3D 1);
-		match_end =3D !trailing;
-	}
+	match_beginning =3D frag->oldpos <=3D 1;
+
+	/*
+	 * A hunk without trailing lines must match at the end.
+	 * However, we simply cannot tell if a hunk must match end
+	 * from the lack of trailing lines if the patch was generated
+	 * with unidiff without any context.
+	 */
+	match_end =3D !unidiff_zero && !trailing;
=20
 	pos =3D frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf =3D oldlines;
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 64f34e3..0007535 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -112,4 +112,17 @@ do
 	'
 done
=20
+test_expect_success 'two lines' '
+
+	>file &&
+	git add file &&
+	echo aaa >file &&
+	git diff >patch &&
+	git add file &&
+	echo bbb >file &&
+	git add file &&
+	test_must_fail git apply patch
+
+'
+
 test_done
