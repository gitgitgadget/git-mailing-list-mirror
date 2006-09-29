From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 5/5] fetch: Clean output
Date: Fri, 29 Sep 2006 20:08:15 +0200
Message-ID: <8764f61r74.fsf@gmail.com>
References: <87r6xu1rci.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 20:08:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMmf-00046A-Bf
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWI2SIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWI2SIU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:08:20 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:23208 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751245AbWI2SIR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:08:17 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8TI8FQ04107
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 20:08:15 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87r6xu1rci.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 29 Sep
	2006 20:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28122>


Do not show duplicated remote branch information and reformat the outpu=
t as:

$ git fetch -v   # the committish lines for the -v.
* refs/heads/origin: fast forward to remote branch 'master' of ../git/
  1ad7a06..bc1a580
  committish: bc1a580
* refs/heads/pu: does not fast forward to remote branch 'pu' of ../git/=
;
  7c733a8...5faa935
  not updating.
  forcing update.
  committish: 5faa935
* refs/heads/next: same as remote branch 'origin/next' of ../git/
  committish: ce47b9f
=2E..
* refs/tags/v1.4.2-rc4: storing tag 'v1.4.2-rc4' of ../git/
  committish: 8c7a107

$ git fetch -v origin refs/heads/master
* committish: 695dffe
  branch 'master' of ../git/

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index ee4f5bd..cc71612 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -129,19 +129,26 @@ append_fetch_head () {
     then
 	headc_=3D$(git-rev-parse --verify "$head_^0") || exit
 	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* committish: $(git-rev-parse --short $he=
ad_)"
-	[ "$verbose" ] && echo >&2 "  $note_"
+	committish=3Dcommittish
     else
 	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* non-commit: $(git-rev-parse --short $he=
ad_)"
-	[ "$verbose" ] && echo >&2 "  $note_"
+	committish=3Dnon-commit
     fi
+    star_prefix=3D"*"
     if test "$local_name_" !=3D ""
     then
 	# We are storing the head locally.  Make sure that it is
 	# a fast forward (aka "reverse push").
 	fast_forward_local "$local_name_" "$head_" "$note_"
+	exit=3D$?
+	star_prefix=3D" "
     fi
+    if test "$verbose"
+    then
+	echo >&2 "$star_prefix $committish: $(git-rev-parse --short $head_)"
+	[ -z "$local_name_" ] && echo >&2 "  $note_"
+    fi
+    return ${exit:-0}
 }
=20
 fast_forward_local () {
--=20
1.4.2.1.g38049
