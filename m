From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Thu, 25 Sep 2014 18:08:31 -0400
Message-ID: <20140925220831.GA14433@logfs.org>
References: <20140924213512.GA7619@logfs.org>
 <xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:13:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXHHk-0002Oh-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 00:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbaIYWNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 18:13:05 -0400
Received: from longford.logfs.org ([213.229.74.203]:44070 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbaIYWNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 18:13:04 -0400
Received: from joern by longford.logfs.org with local (Exim 4.72)
	(envelope-from <joern@logfs.org>)
	id 1XXHDD-00040R-9h; Thu, 25 Sep 2014 18:08:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257500>

On Wed, 24 September 2014 22:09:33 -0700, Junio C Hamano wrote:
>=20
> This is fine for those who use quilt with --fuzz=3D0, but how are you
> helping those who use quilt without --fuzz=3D0?
>=20
> I agree that unconditionally passing -C1 is a bad thing, but
> unconditionally passing -C2 is not that better.  Shouldn't this be
> done by introducing a new --fuzz=3D<number> option to quiltimport?

Maybe the patch below then?  Defaulting to no fuzz is both me
enforcing my (and Linus') preference and that alternatives are hard
and messy.  How would one specify fuzz=3D0?  -C3 would work for standar=
d
patches, but be wrong for patches with more context.  -C0 would
arguably also be wrong.  There really is no good choice.  And I won't
add a fuzz parameter until git-apply has one, as it can only be
transformed to -C by either making assumptions about the context or
parsing the patches - ick!

J=C3=B6rn

--
When I am working on a problem I never think about beauty.  I think
only how to solve the problem.  But when I have finished, if the
solution is not beautiful, I know it is wrong.
-- R. Buckminster Fuller

Subject: [PATCH] git-quiltimport.sh: disallow fuzz by default

git-quiltimport passed "-C1" to git-apply, supposedly to roughly match
the quilt default of --fuzz 2.  This is against the spirit of git.
Quoting Linus:
  Except unlike the standard "patch" program, "git apply" doesn't accep=
t
  fuzz by default (which to me is a huge deal - I hate how "patch" trie=
s
  to apply stuff that clearly isn't valid any more)

Users that want to want to emulate quilt defaults can pass "-C 1" to
git-quiltimport now.

Also note that -C1 and fuzz=3D2 is not identical.  Most patches have th=
ree
lines of context, so fuzz=3D2 leaves one relevant line of context.  But
for any patches with more or less context this is not true.  git-apply
has no option for fuzz, so any emulation will always be best-effort.

Signed-off-by: Joern Engel <joern@logfs.org>
---
 git-quiltimport.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 167d79fea809..f45ee5ff6599 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -4,8 +4,9 @@ OPTIONS_STUCKLONG=3D
 OPTIONS_SPEC=3D"\
 git quiltimport [options]
 --
-n,dry-run     dry run
 author=3D       author name and email address for patches without any
+C=3D            minimum context (see git apply)
+n,dry-run     dry run
 patches=3D      path to the quilt series and patches
 "
 SUBDIRECTORY_ON=3DYes
@@ -13,6 +14,7 @@ SUBDIRECTORY_ON=3DYes
=20
 dry_run=3D""
 quilt_author=3D""
+cflag=3D""
 while test $# !=3D 0
 do
 	case "$1" in
@@ -20,6 +22,15 @@ do
 		shift
 		quilt_author=3D"$1"
 		;;
+	-C)
+		shift
+		# ensure numerical parameter
+		case $1 in
+			''|*[!0-9]*) usage;;
+			*) ;;
+		esac
+		cflag=3D"-C$1"
+		;;
 	-n|--dry-run)
 		dry_run=3D1
 		;;
@@ -130,7 +141,7 @@ do
 	fi
=20
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
+		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
 		tree=3D$(git write-tree) &&
 		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tre=
e $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
--=20
2.1.0
