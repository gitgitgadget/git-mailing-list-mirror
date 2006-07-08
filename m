From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [Patch] Using 'perl' in *.sh
Date: Sat, 8 Jul 2006 17:32:04 +0200
Organization: NextSoft
Message-ID: <200607081732.04273.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 08 17:32:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzEmz-00078z-51
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 17:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGHPcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Jul 2006 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWGHPcI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 11:32:08 -0400
Received: from s3.icr.cz ([82.142.72.7]:56267 "EHLO s3.icr.cz")
	by vger.kernel.org with ESMTP id S964867AbWGHPcG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 11:32:06 -0400
Received: (from root@localhost)
	by s3.icr.cz (8.11.4/8.11.4) id k68FW5Z21179
	for git@vger.kernel.org; Sat, 8 Jul 2006 17:32:05 +0200
Received: from michal.rokos.cz (mx1.evangnet.cz [88.83.237.35] (may be forged))
	by s3.icr.cz (8.11.4/8.11.4) with ESMTP id k68FW4S21139
	for <git@vger.kernel.org>; Sat, 8 Jul 2006 17:32:04 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
X-scanner: scanned by Inflex 1.0.10 - (http://pldaniels.com/inflex/)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23488>

Hi,

some GIT's shell script are using bare 'perl' for perl invocation. It's=
=20
causing me problems... I compile git with PERL_PATH set and I'd suggest=
 to=20
use it everywhere.

So @@PERL@@ would be replaced with PERL_PATH_SQ instead.

What do you think?

Michal

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index 202f261..8f9881f 100644
--- a/Makefile
+++ b/Makefile
@@ -514,6 +514,7 @@ common-cmds.h: Documentation/git-*.txt
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's!@@PERL@@!$(PERL_PATH_SQ)!g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
diff --git a/git-bisect.sh b/git-bisect.sh
index 03df143..06a8d26 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -13,7 +13,7 @@ git bisect log			show bisect log.'
 . git-sh-setup
=20
 sq() {
-	perl -e '
+	@@PERL@@ -e '
 		for (@ARGV) {
 			s/'\''/'\'\\\\\'\''/g;
 			print " '\''$_'\''";
diff --git a/git-clone.sh b/git-clone.sh
index 6a14b25..0368803 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -324,7 +324,7 @@ test -d "$GIT_DIR/refs/reference-tmp" &&
 if test -f "$GIT_DIR/CLONE_HEAD"
 then
 	# Read git-fetch-pack -k output and store the remote branches.
-	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin"
+	@@PERL@@ -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin"
 fi
=20
 cd "$D" || exit
diff --git a/git-commit.sh b/git-commit.sh
index 22c4ce8..08d786d 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -147,7 +147,7 @@ #'
 	    git-ls-files -z --others $option \
 		--exclude-per-directory=3D.gitignore
 	fi |
-	perl -e '$/ =3D "\0";
+	@@PERL@@ -e '$/ =3D "\0";
 	    my $shown =3D 0;
 	    while (<>) {
 		chomp;
diff --git a/git-fetch.sh b/git-fetch.sh
index 48818f8..f80299d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -278,7 +278,7 @@ fetch_main () {
 	  head=3D"ref: $remote_name"
 	  while (expr "z$head" : "zref:" && expr $depth \< $max_depth) >/dev/=
null
 	  do
-	    remote_name_quoted=3D$(perl -e '
+	    remote_name_quoted=3D$(@@PERL@@ -e '
 	      my $u =3D $ARGV[0];
               $u =3D~ s/^ref:\s*//;
 	      $u =3D~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
diff --git a/git-rebase.sh b/git-rebase.sh
index 3945e06..1b9e986 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -311,7 +311,7 @@ echo "$prev_head" > "$dotest/prev_head"
=20
 msgnum=3D0
 for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
-			| perl -e 'print reverse <>'`
+			| @@PERL@@ -e 'print reverse <>'`
 do
 	msgnum=3D$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
