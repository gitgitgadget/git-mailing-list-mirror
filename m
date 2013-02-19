From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 1/3] contrib/subtree: Store subtree sources in .gitsubtree
Date: Tue, 19 Feb 2013 12:29:32 +0000
Message-ID: <CALeLG_nUHzU49DNufqKLCwQFFu-JCg7TtqE6p0Qd65WWBW__+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 13:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7mKc-0002bI-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 13:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706Ab3BSM3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 07:29:35 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:38160 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab3BSM3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 07:29:34 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so2757257eaa.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 04:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=92VU+QyNM/7dRLjq+/AcdAFbte5LXvmG3JHXjUe8iwg=;
        b=QSqEOZHu9RC8dK6SIVpmiG8/BYauRId5cbVdk9C9vPYYPEvmIvF6nyhobJ+TGNqqdP
         CrV69OhOpQA/P+E9MjPy+fTngPU8JgDzOJmBNbjT1GnVdvAY1lv21puAEJGoZGmJhm2K
         WqZ3KbEOtN0wDORdsQOi0XbdZ4oDyN2CYxNyiIzQd41Httr47oFB1EadBqwlJBmnB5OT
         92ze7gtrBWIzSLaGWt2o6IIGAjcx1KLfd/THrk+EJofLFHoMsTsQQJyh4XqhsPHHScVA
         jY2PAXB7nee1Vl8PTqH/2y4n4yQr8WC5nP2Kbaq7xdHVbOMtGS3rEI6ahJZd0orKwn/N
         fSkw==
X-Received: by 10.14.211.132 with SMTP id w4mr56214101eeo.36.1361276973317;
 Tue, 19 Feb 2013 04:29:33 -0800 (PST)
Received: by 10.14.45.4 with HTTP; Tue, 19 Feb 2013 04:29:32 -0800 (PST)
X-Originating-IP: [212.219.195.16]
X-Gm-Message-State: ALoCoQnvOijMqeEIqt5TcQ1+75GJ4+xmsWFB24MhTvqhJJgYN7pb1dLB4iaLxVs/97xuFkIf/OHB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216610>

Add the prefix, repository and refspec in the file .gitsubtree when
git subtree add is used. Then when a git subtree push or pull is needed
the repository and refspec from .gitsubtree are used as the default
values.

Having to remember what subtree came from what source is a waste of
developer memory and doesn't transfer easily to other developers.

git subtree push/pull operations would typically be to/from the same
source that the original subtree was cloned from with git subtree add.

The <repository> and <refspec>, or <commit>, used in the git subtree add
operation are stored in .gitsubtree. One line each, delimited by a space:
"<prefix> <repository> <refspec>" or "<prefix> . <commit>".

Subsequent git subtree push/pull operations now default to the values
stored in .gitsubtree, unless overridden from the command line.

The .gitsubtree file should be tracked as part of the repo as it
describes where parts of the tree came from and can be used to update
to and from that source.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 75 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..1d0bf35 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -11,8 +11,8 @@ OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
-git subtree pull  --prefix=<prefix> <repository> <refspec...>
-git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree pull  --prefix=<prefix> [<repository> <refspec...>]
+git subtree push  --prefix=<prefix> [<repository> <refspec...>]
 git subtree split --prefix=<prefix> <commit...>
 --
 h,help        show the help
@@ -489,6 +489,28 @@ ensure_clean()
 	fi
 }

+add_subtree () {
+	if ( grep "^$dir " .gitsubtree 2>/dev/null )
+	then
+		# remove $dir from .gitsubtree - there's probably a clever way to
do this with sed
+		grep -v "^$dir " .gitsubtree >.gitsubtree.temp
+		rm .gitsubtree
+		mv .gitsubtree.temp .gitsubtree
+	fi
+	if test $# -eq 1
+	then
+		# Only a commit provided, thus use the current repository
+		echo "$dir . $@" >>.gitsubtree
+	elif test $# -eq 2
+	then
+		echo "$dir $@" >>.gitsubtree
+	fi
+}
+
+get_subtree () {
+	grep "^$dir " .gitsubtree || die "Subtree not found in .gitsubtree: " "$dir"
+}
+
 cmd_add()
 {
 	if [ -e "$dir" ]; then
@@ -497,6 +519,8 @@ cmd_add()

 	ensure_clean
 	
+	add_subtree "$@"
+
 	if [ $# -eq 1 ]; then
 	    git rev-parse -q --verify "$1^{commit}" >/dev/null ||
 	    die "'$1' does not refer to a commit"
@@ -700,7 +724,23 @@ cmd_merge()
 cmd_pull()
 {
 	ensure_clean
-	git fetch "$@" || exit $?
+	if test $# -eq 0
+	then
+		subtree=($(get_subtree))
+		repository=${subtree[1]}
+		refspec=${subtree[2]}
+		if test "$repository" == "."
+		then
+			echo "Pulling into $dir from branch $refspec"
+		else
+			echo "Pulling into $dir from $repository $refspec"
+		fi
+		echo "git fetch using: " $repository $refspec
+		git fetch "$repository" "$refspec" || exit $?
+	else
+		echo "git fetch using: $@"
+		git fetch "$@" || exit $?
+	fi
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_merge "$@"
@@ -708,16 +748,29 @@ cmd_pull()

 cmd_push()
 {
-	if [ $# -ne 2 ]; then
-	    die "You must provide <repository> <refspec>"
+	repository=$1
+	refspec=$2
+	if test $# -eq 0
+	then
+		subtree=($(get_subtree))
+		repository=${subtree[1]}
+		refspec=${subtree[2]}
+		if test "$repository" == "."
+		then
+			echo "Pushing from $dir into branch $refspec"
+		else
+			echo "Pushing from $dir into $repository $refspec"
+		fi
+	elif test $# -ne 2
+	then
+		die "You must provide <repository> <refspec>, or a <prefix> listed
in .gitsubtree"
 	fi
-	if [ -e "$dir" ]; then
-	    repository=$1
-	    refspec=$2
-	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
+	if test -e "$dir"
+	then
+		echo "git push using: " $repository $refspec
+		git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }

-- 
1.8.2.rc0.16.g20a599e
