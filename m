From: adatoccpptranslator@free.fr
Subject: Issue when merging a subtree whose a file has been removed
Date: Thu, 21 May 2015 17:40:05 +0200 (CEST)
Message-ID: <1191356813.419782668.1432222805047.JavaMail.root@zimbra41-e7.priv.proxad.net>
References: <160239201.419722978.1432221938533.JavaMail.root@zimbra41-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 17:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvSZx-0007ia-0X
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 17:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbbEUPkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 11:40:07 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:29573 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424AbbEUPkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 11:40:06 -0400
X-Greylist: delayed 10526 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2015 11:40:06 EDT
Received: from zimbra41-e7.priv.proxad.net (unknown [172.20.243.191])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DDB9D9400E1
	for <git@vger.kernel.org>; Thu, 21 May 2015 17:36:39 +0200 (CEST)
In-Reply-To: <160239201.419722978.1432221938533.JavaMail.root@zimbra41-e7.priv.proxad.net>
X-Originating-IP: [37.163.199.1]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: adatoccpptranslator@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269599>

Hi all,

I want to use subtrees in one of my projects and I use method desribed here https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging
I`m facing issues when merging subtree in my subproject in case some files have been removed from the subtree.

I`m running git 1.9.1 on Kubuntu  14.04
sub_project is integrated as subtree in my main project. I modify a file and remove an other file from my sub_project, commit the modification, go in my main_project, checkout the sub_project integration branch, pull the modification.
I see the modification of the modified file and the deletion of the removed file
I checkout the master branch of my main project.
git diff-tree -p sub_project_branch indicate that one file has been modified and one files has been deleted
then I perform a merge of my subtree integration branch into master branch.

Here are the corresponding commands:
#!/bin/sh

# Creating project that will be used as subtree
$ mkdir sub_project
$ cd sub_project
$ git init
$ touch toto
$ echo "-----------------" >> toto
$ echo "- toto file">> toto
$ echo "-----------------" >> toto
$ touch tata
$ echo "-----------------" >> tata
$ echo "- tata file">> tata
$ echo "-----------------" >> tata
$ git add toto tata
$ git commit -m "Initial commit"
$ echo "echo toto" >> toto
$ echo "echo tata" >> tata
$ git commit -am "Add content to file"
$ cd ..

# Creating main project that will use the subtree
$ mkdir main_project
$ cd main_project
$ git init
$ touch tutu
$ echo "-----------------" >> tutu
$ echo "- tutu file">> tutu
$ echo "-----------------" >> tutu
$ git add tutu
$ git commit -m "Add tutu file"
# Creation of subtree
$ mkdir sources
$ git remote add sub_project_remote ../sub_project
$ git fetch sub_project_remote
$ git checkout -b sub_project_branch sub_project_remote/master
$ git checkout master
$ git read-tree --prefix=sources/sub_project/ -u sub_project_branch
$ git commit -am "Integration of subtree"

$ echo "------------------------"
------------------------
$ echo "Subtree well integrated "
Subtree well integrated 
$ ls *
tutu

sources:
sub_project
$ ls sources/sub_project
tata
toto
$ echo "------------------------"
------------------------

# Go in subtree to remove tata file
$ cd ../sub_project
$ echo "#EOF" >> toto
$ git add toto
$ git rm tata
$ git commit -m "Add EOF and remove tata"

# go back in main project to integrate subtree modifications
$ cd ../main_project
$ git checkout sub_project_branch
$ git fetch sub_project_remote
$ git pull

$ echo "------------------------"
------------------------
$ echo "Check that tata has been removed "
Check that tata has been removed 
$ ls *
toto
$ echo "------------------------"
------------------------

$ git checkout master
$ git diff-tree -p sub_project_branch
diff --git a/tata b/tata
deleted file mode 100644
index a4f4cc4..0000000
--- a/tata
+++ /dev/null
@@ -1,4 +0,0 @@
------------------
-- tata file
------------------
-echo tata
diff --git a/toto b/toto
index 8dfbe14..98ae756 100644
--- a/toto
+++ b/toto
@@ -2,3 +2,4 @@
 - toto file
 -----------------
 echo toto
+#EOF

$ git merge -v --squash --no-commit -X subtree=sources/sub_project -X theirs sub_project_branch

$ echo "------------------------"
------------------------
$ echo "Check after merge that tata has been removed "
Check after merge that tata has been removed 
$ ls sources/*
tata
toto
$ echo "------------------------"
------------------------
$ git commit -m "Second integration from subtree"
$ cd ..
#EOF

I was expecting to see the in master the modification of the file and the deletion of the other file but the removed file is still there and tracked. The modification of file has been done but It looks like the deletion has not been "merged".

The behaviour I expect is the same that the one illustrated in command sequence below which perform exactly the same actions excepted they are done in a branch instead of a subtree:
toto should have been modified, tata should no more be there or at least no more be tracked
#!/bin/sh
$ git init
$ touch toto
$ echo "-----------------" >> toto
$ echo "- toto file">> toto
$ echo "-----------------" >> toto
$ touch tata
$ echo "-----------------" >> tata
$ echo "- tata file">> tata
$ echo "-----------------" >> tata
$ git add toto tata
$ git commit -m "Initial commit"
$ echo "echo toto" >> toto
$ echo "echo tata" >> tata
$ git commit -am "Add content to file"
$ git checkout -b headers
$ echo "#EOF" >> toto
$ git add toto
$ git rm tata
$ git commit -m "Add EOF and remove tata"
$ git checkout master
$ touch tutu
$ echo "-----------------" >> tutu
$ echo "- tutu file">> tutu
$ echo "-----------------" >> tutu
$ git add tutu
$ git commit -m "Add tutu file"
$ git merge -m "Merge from headers branch" headers
Merge made by the 'recursive' strategy.
 tata | 4 ----
 toto | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 tata
[master a9cad6d] Add EOF
 1 file changed, 1 insertion(+)
$ echo "#EOF" >> tutu
$ git add tutu
$ git commit -m "Add EOF"
$ ls
toto
tutu
#EOF


According to what I see it seems that the subtree merge is doing a kind of copy instead of a real merge meaning that if source file disappear then the corresponding target file is untouched instead of being deleted.
Is this behaviour correct or is it my understanding of what subtree merge should do that is wrong ?


Thanks by advance
Julien

PS : as my subtree prefix has 2 levels I also test with a single level like in subtree tutorial to ensure this was not the cause of my issue but the problem remains the same. the single level test is performed by the following command sequence:

#!/bin/sh

# Creating project that will be used as subtree
$ mkdir sub_project
$ cd sub_project
$ git init
$ touch toto
$ echo "-----------------" >> toto
$ echo "- toto file">> toto
$ echo "-----------------" >> toto
$ touch tata
$ echo "-----------------" >> tata
$ echo "- tata file">> tata
$ echo "-----------------" >> tata
$ git add toto tata
$ git commit -m "Initial commit"
$ echo "echo toto" >> toto
$ echo "echo tata" >> tata
$ git commit -am "Add content to file"
$ cd ..

# Creating main project that will use the subtree
$ mkdir main_project
$ cd main_project
$ git init
$ touch tutu
$ echo "-----------------" >> tutu
$ echo "- tutu file">> tutu
$ echo "-----------------" >> tutu
$ git add tutu
$ git commit -m "Add tutu file"
# Creation of subtree
$ git remote add sub_project_remote ../sub_project
$ git fetch sub_project_remote
$ git checkout -b sub_project_branch sub_project_remote/master
$ git checkout master
$ git read-tree --prefix=sub_project/ -u sub_project_branch
$ git commit -am "Integration of subtree"

$ echo "------------------------"
------------------------
$ echo "Subtree well integrated "
Subtree well integrated
$ ls *
tutu

sub_project:
tata
toto
$ echo "------------------------"
------------------------

# Go in subtree to remove tata file
$ cd ../sub_project
$ echo "#EOF" >> toto
$ git add toto
$ git rm tata
$ git commit -m "Add EOF and remove tata"

# go back in main project to integrate subtree modifications
$ cd ../main_project
$ git checkout sub_project_branch
$ git fetch sub_project_remote
$ git pull

$ echo "------------------------"
------------------------
$ echo "Check that tata has been removed "
Check that tata has been removed 
$ ls *
toto
$ echo "------------------------"
------------------------

$ git checkout master
$ git diff-tree -p sub_project_branch
diff --git a/tata b/tata
deleted file mode 100644
index a4f4cc4..0000000
--- a/tata
+++ /dev/null
@@ -1,4 +0,0 @@
------------------
-- tata file
------------------
-echo tata
diff --git a/toto b/toto
index 8dfbe14..98ae756 100644
--- a/toto
+++ b/toto
@@ -2,3 +2,4 @@
 - toto file
 -----------------
 echo toto
+#EOF
$ git merge -v --squash --no-commit -s subtree -X theirs sub_project_branch

$ echo "------------------------"
------------------------
$ echo "Check after merge that tata has been removed "
Check after merge that tata has been removed 
$ ls *
tutu

sub_project:
tata
toto
$ echo "------------------------"
------------------------
$ git commit -m "Second integration from subtree"
$ cd ..
#EOF
