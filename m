From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH] branch: write branch properties
Date: Mon, 25 Sep 2006 01:00:57 +0200
Message-ID: <877izs98eu.fsf@gmail.com>
References: <87r6y06g5h.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 25 01:01:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcyD-0006rd-8l
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWIXXBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWIXXBD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:01:03 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:60127 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932274AbWIXXBA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:01:00 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8ON0vQ07038
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:00:58 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87r6y06g5h.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Mon, 25 Sep
	2006 00:42:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27711>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> If you want to work in the 'next' branch of git.git:
>
> $ git clone --use-separate-remote git://git.kernel.org/pub/scm/git/gi=
t.git
> $ cd git
> $ git branch next origin next

this has to be: git branch next origin refs/heads/next

and then you work as usual with:

=2E.. work
$ git pull

and it does the right thing.

Please use this instead:

-- >8 --
[PATCH] branch: write branch properties

If you want to work in the 'next' branch of git.git:

$ git clone --use-separate-remote git://git.kernel.org/pub/scm/git/git.=
git
$ cd git
$ git branch next origin refs/heads/next
=2E.. work/edit/commit ...
$ git pull

and it merges from branch 'refs/heads/next' of origin.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/git-branch.txt |    7 +++++--
 git-branch.sh                |   17 +++++++++++++++--
 git-parse-remote.sh          |   21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index d43ef1d..de2889d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [-r]
-'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' [-l] [-f] <branchname> [<start-point> | <remote> <remoteb=
ranch>]
 'git-branch' (-d | -D) <branchname>...
=20
 DESCRIPTION
@@ -18,9 +18,12 @@ With no arguments given (or just `-r`) a
 will be shown, the current branch will be highlighted with an asterisk=
=2E
=20
 In its second form, a new branch named <branchname> will be created.
-It will start out with a head equal to the one given as <start-point>.
+It will start out with a head equal to the one given as <start-point>,
+or from branch <remotebranch> of the repository <remote>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
+In the form <remote> <remotebranch> it will also record the branch
+properties `branch.<branchname>.remote` and `branch.<branchname>.merge=
`.
=20
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
diff --git a/git-branch.sh b/git-branch.sh
index e0501ec..94dd157 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
=20
-USAGE=3D'[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-po=
int>]] | -r'
+USAGE=3D'[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-po=
int> | <remote> <remotebranch>]] | -r'
 LONG_USAGE=3D'If no arguments, show available branches and mark curren=
t branch with a star.
 If one argument, create a new branch <branchname> based off of current=
 HEAD.
-If two arguments, create a new branch <branchname> based off of <start=
-point>.'
+If two arguments, create a new branch <branchname> based off of <start=
-point>.
+If three arguments, create a new branch <branchname> based off the bra=
nch <remotebranch> of the repository <remote>, writing the branch prope=
rties for fetch.'
=20
 SUBDIRECTORY_OK=3D'Yes'
 . git-sh-setup
@@ -104,6 +105,12 @@ case "$#" in
 	head=3DHEAD ;;
 2)
 	head=3D"$2^0" ;;
+3)
+	remote=3D"$2"
+	remote_branch=3D"$3"
+	. ./git-parse-remote.sh
+	ref=3D$(get_ref_for_remote_branch "$2" "$3")
+	head=3D"$ref^0";;
 esac
 branchname=3D"$1"
=20
@@ -128,3 +135,9 @@ then
 	touch "$GIT_DIR/logs/refs/heads/$branchname"
 fi
 git update-ref -m "branch: Created from $head" "refs/heads/$branchname=
" $rev
+
+if test -n "$ref"
+then
+	git repo-config branch."$branchname".remote "$remote"
+	git repo-config branch."$branchname".merge "$remote_branch"
+fi
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..51f3b9b 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -209,3 +209,24 @@ resolve_alternates () {
 		esac
 	done
 }
+
+get_ref_for_remote_branch (){
+	data_source=3D$(get_data_source "$1")
+	case "$data_source" in
+	'' | config-partial | branches | branches-partial)
+		;;
+	config)
+		ref=3D$(git-repo-config --get-all "remote.$1.fetch" |\
+			grep "^$2:")
+		expr "z$ref" : 'z[^:]*:\(.*\)'
+		;;
+	remotes)
+		ref=3D$(sed -ne '/^Pull: */{
+				s///p
+			}' "$GIT_DIR/remotes/$1" | grep "$2:")
+		expr "z$ref" : 'z[^:]*:\(.*\)'
+		;;
+	*)
+		die "internal error: get-ref-for-remote-branch $1 $2" ;;
+	esac
+}
--=20
1.4.2.1.g279b
