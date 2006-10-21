From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sat, 21 Oct 2006 16:29:38 +0200
Message-ID: <453A2ED2.1000709@lsrfire.ath.cx>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021021235.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 16:30:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHrv-0000SY-NX
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 16:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993091AbWJUOac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 10:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993092AbWJUOac
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 10:30:32 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:65484
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S2993091AbWJUOac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 10:30:32 -0400
Received: from [10.0.1.3] (p508E7012.dip.t-dialin.net [80.142.112.18])
	by neapel230.server4you.de (Postfix) with ESMTP id C52C31B00C;
	Sat, 21 Oct 2006 16:30:29 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20061021021235.GA29920@ftp.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29618>

Al Viro schrieb:
> Speaking of irritations...  There is a major (and AFAICS fixable)
> suckitude in git-cherry.

[...]

> For one thing, there are better ways to do set comparison than creati=
ng
> a file for each element in one set and going through another checking
> if corresponding files exist (join(1) and sort(1) or just use perl ha=
shes).

[...]

> Note that we are calculating a function of commit; it _never_ changes=
=2E
> Even if we don't just calculate and memorize it at commit time, a cac=
he
> somewhere under .git would speed the things up a lot...

How about this patch?  It does away with using temporary files and inst=
ead
creates persistent cache files under .git/patch-ids/.  It is a very stu=
pid
cache layout: file name =3D commit SHA1, file contents =3D patch ID.  P=
erhaps
it needs fan-out directories like .git/objects/ has before it can be
considered for merge.

The set compare is stupid, too, but at least it is in-shell now, using =
a
space separated list and the is_in function.

And the cache file creation is not safe for multiple parallel git-cherr=
y's.

It survives "make test" and is otherwise untested.  Care to test drive
this prototype? :-D

Thanks,
Ren=E9


diff --git a/git-cherry.sh b/git-cherry.sh
index 8832573..c88afc3 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -46,18 +46,29 @@ # not that the order in inup matters...
 inup=3D`git-rev-list ^$ours $upstream` &&
 ours=3D`git-rev-list $ours ^$limit` || exit
=20
-tmp=3D.cherry-tmp$$
-patch=3D$tmp-patch
-mkdir $patch
-trap "rm -rf $tmp-*" 0 1 2 3 15
+is_in() {
+	what=3D"$1"
+	while [ $# -gt 1 ]; do
+		shift
+		[ "$what" =3D "$1" ] && return 0
+	done
+	return 1
+}
=20
+# prime patch-ID cache
+PATCH_ID_CACHE=3D"$GIT_DIR/patch-ids"
+mkdir -p "$PATCH_ID_CACHE"
+for commit in $inup $ours; do
+	[ -f "$PATCH_ID_CACHE/$commit" ] && continue
+	set x `git-diff-tree -p $commit | git-patch-id`
+	echo "$2" >"$PATCH_ID_CACHE/$commit"
+done
+
+ids_inup=3D
 for c in $inup
 do
-	git-diff-tree -p $c
-done | git-patch-id |
-while read id name
-do
-	echo $name >>$patch/$id
+	read id <"$PATCH_ID_CACHE/$c"
+	ids_inup=3D"$ids_inup $id"
 done
=20
 LF=3D'
@@ -66,10 +77,10 @@ LF=3D'
 O=3D
 for c in $ours
 do
-	set x `git-diff-tree -p $c | git-patch-id`
-	if test "$2" !=3D ""
+	read id <"$PATCH_ID_CACHE/$c"
+	if test "$id" !=3D ""
 	then
-		if test -f "$patch/$2"
+		if is_in $id $ids_inup
 		then
 			sign=3D-
 		else
