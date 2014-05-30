From: Keval Patel <patel.keval88@gmail.com>
Subject: [PATCH 2/2] contrib/subtree: List subcmd and modify push/pull to use .gittrees
Date: Fri, 30 May 2014 13:45:15 -0400
Message-ID: <1401471915-47195-2-git-send-email-kapatel@lutron.com>
References: <1401471915-47195-1-git-send-email-kapatel@lutron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Keval Patel <patel.keval88@gmail.com>,
	Keval Patel <kapatel@lutron.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 30 19:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQs9-0007Fh-D9
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbaE3Rpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 May 2014 13:45:36 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:48744 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbaE3Rpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:45:36 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so6321099qgd.15
        for <git@vger.kernel.org>; Fri, 30 May 2014 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jMD287PI1Cx1IYa+LRn0ZcNleYj+7RQ+o78oWpUnCyY=;
        b=fmcc1HP5iBB3dlPuZd3pC3PZ5y8Wo6Fb9lt9Z4h+DXJ0uJo8cbSVP8IXfa00GQf/Q2
         qCsl/ZRLmKiNUZjqDTUeJOZKFuH4Curs6F7JBEDDyvouQfuGJs83EUzqC5vqUH4gQ8du
         5961VbLMvo3dclsuIT9fPtgOoABAJJytJ4pkcN2W1ELrZuYi5FdTtabMuB1r2owd+V/a
         7AID3bv/u28X/6V1wjjVV0FN2TyAr4cGUUohSlUF/KEa1NQOctnlCJ0gym5SLB6ELS4z
         4nioa0ngEmZM0d4gD88r4KGepeC0iDQzmYMR4SwAXxZLr8yYRWSoQBj81sx1CIE9y6xO
         4NuA==
X-Received: by 10.140.104.195 with SMTP id a61mr21733003qgf.102.1401471935170;
        Fri, 30 May 2014 10:45:35 -0700 (PDT)
Received: from dangoudesiphone.intra.lutron.com.com (lutron48.lutron.com. [8.14.172.48])
        by mx.google.com with ESMTPSA id 6sm7186512qam.44.2014.05.30.10.45.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 10:45:34 -0700 (PDT)
X-Google-Original-From: Keval Patel <kapatel@lutron.com>
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1401471915-47195-1-git-send-email-kapatel@lutron.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250454>

- Add subtree list sub-command
- git subtree list - Lists the subtrees in current project
- Changes taken from helmo=E2=80=99s repository from following URL:
https://github.com/helmo/git-subtree/blob/master/git-subtree.sh
- Add tests for subtree list and subtree push/pull using .gittrees
- Files changed in this commit:
1. git/contrib/subtree/git-subtree.sh
2. git/contrib/subtree/t/t7900-subtree.sh

Signed-off-by: Keval Patel <kapatel@lutron.com>
---
A selection of updates to git-subtree were offered to the list by coupl=
e of people
($gmane/196667) by Herman van Rink and ($gmane/217820) by Paul Campbell
=46or various reasons the work stalled and I would like to pick it up f=
rom there

The following patches take a selection of these commits and rebase them=
=20
against the tip of master.
The make test works and I have added more tests to cover the new comman=
ds and=20
use of .gittrees file for storing the subtree metadata

Thanks-to and Based-on-patch-by:
- Herman van Rink
- Matt Hoffman
- Michael Hart
- Nate Jones
- Paul Campbell
- Paul Cartwright
- Peter Jaros
- bibendi

 contrib/subtree/git-subtree.sh     |   25 ++++++++++--
 contrib/subtree/t/t7900-subtree.sh |   72 ++++++++++++++++++++++++++++=
++++++++
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
index 7d01b4b..1151884 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -10,9 +10,10 @@ fi
 OPTS_SPEC=3D"\
 git subtree add   --prefix=3D<prefix> <repository> <refspec>
 git subtree merge --prefix=3D<prefix> <commit>
-git subtree pull  --prefix=3D<prefix> <repository> <ref>
-git subtree push  --prefix=3D<prefix> <repository> <ref>
+git subtree pull  --prefix=3D<prefix> [<repository> [<refspec>...]]
+git subtree push  --prefix=3D<prefix> [<repository> [<refspec>...]]
 git subtree split --prefix=3D<prefix> <commit...>
+git subtree list
 --
 h,help        show the help
 q             quiet
@@ -102,15 +103,16 @@ command=3D"$1"
 shift
 case "$command" in
 	add|merge|pull) default=3D ;;
-	split|push) default=3D"--default HEAD" ;;
+	split|push|list) default=3D"--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
=20
-if [ -z "$prefix" ]; then
+if [ -z "$prefix" -a "$command" !=3D "list" ]; then
 	die "You must provide the --prefix option."
 fi
=20
 case "$command" in
+	list);;
 	add) [ -e "$prefix" ] &&=20
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||=20
@@ -759,4 +761,19 @@ cmd_push()
 	fi
 }
=20
+subtree_list()=20
+{
+	git config -f .gittrees -l | grep subtree | grep path | grep -o '=3D.=
*' | grep -o '[^=3D].*' |
+	while read path; do=20
+		repository=3D$(git config -f .gittrees subtree.$path.url)
+		refspec=3D$(git config -f .gittrees subtree.$path.branch)
+		echo "    $path        (merged from $repository branch $refspec) "
+	done
+}
+
+cmd_list()
+{
+	subtree_list
+}
+
 "cmd_$command" "$@"
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t79=
00-subtree.sh
index 05110f7..c29993e 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -571,4 +571,76 @@ test_expect_success 'add another subtree with mast=
er branch' '
         check_equal ''"$(last_commit_message)"'' "Add sub2 subtree"
 '
=20
+# Lets commit the changes we made to .gittrees file
+test_expect_success 'Commit chages to .gittrees for sub1 and sub2 in r=
epo' '
+        git add .gittrees &&
+        git commit -m "Add .gittrees file"
+'
+# Tests for subtree list
+# Hardcode expected output to a file
+cat >expect <<-\EOF
+    sub1        (merged from ../shared_projects/subtree1 branch master=
)=20
+    sub2        (merged from ../shared_projects/subtree2 branch master=
)=20
+EOF
+
+test_expect_success 'check subtree list gives correct output' '
+        git subtree list>output &&
+        test_cmp expect output
+'
+# Lets commit the changes to parent1 before proceeding
+test_expect_success 'Commit changes to the repository' '
+        git add --all &&
+        git commit -m "Commit expect and output file additions"
+'
+
+# Tests for individual subtree pull using information in .gittrees
+# Go to subtree1 and make a change
+cd ../shared_projects/subtree1
+
+subtree1_change1=3D"Add_line_to_Sub1_File2"
+
+echo $subtree1_change1>>sub1_file2
+
+# Lets commit the changes to subtree1 before proceeding
+test_expect_success 'Commit changes to the subtree1' '
+        git add --all &&
+        git commit -m "Commit change to sub1_file2"
+'
+
+# Switch to develop branch for a future test to push changes to master
+test_expect_success 'Switch to branch develop' '
+        git checkout -b develop
+'
+
+# Back to parent1
+cd ../../parent1
+
+test_expect_success 'check  git subtree pull <prefix> works' '
+        git subtree pull -P sub1 master &&
+        test_cmp sub1/sub1_file1 ../shared_projects/subtree1/sub1_file=
1 &&
+        test_cmp sub1/sub1_file2 ../shared_projects/subtree1/sub1_file=
2
+'
+
+# Now lets make local change on subtree and push it to subtree remote
+cd sub1
+
+local_change=3D"Local addition of line to sub1 file 2"
+echo $local_change1>>sub1_file2
+
+# Back to parent1
+cd ..
+
+# Lets commit the changes to parent1 before proceeding
+test_expect_success 'Commit changes to parent repository' '
+        git add --all &&
+        git commit -m "Commit local changes to sub1/sub1 file2"
+'
+
+test_expect_success 'check git subtree push <prefix> works' '
+        git subtree push -P sub1 &&
+        cd ../shared_projects/subtree1 &&
+        git checkout master &&
+        test_cmp ../../parent1/sub1/sub1_file1 sub1_file1 &&
+        test_cmp ../../parent1/sub1/sub1_file2 sub1_file2
+'
 test_done
--=20
1.7.9
