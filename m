From: Thibault Kruse <tibokruse@googlemail.com>
Subject: git clone combined with --depth, --branch and --single-branch
Date: Sun, 17 Feb 2013 13:29:17 +0100
Message-ID: <CAByu6UWNZLrtwo+FUeq2OELoX3jo1Qng9amko36JGa5pq+y11A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 13:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U73NQ-00028x-SP
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 13:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab3BQM3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2013 07:29:20 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55798 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab3BQM3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2013 07:29:19 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so4825963obb.24
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 04:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=4yiI+MOnXbiOFtnqvpqLgJBpWHSjZ/rLfoZzdOfh5ZI=;
        b=BoZpNMna9EjeihnFt9bTDoX/Kz6/zwjYiZRMlCiigl6G2U0i8OS0uZEueH1xtobeV3
         96bZAleetp58Q25UjBmA5QxcSbtNqda7r6Go90fQ+UMkJ3EMpTqCOficdnSeieTLKeuT
         BYnxWu35dWLoBsmA0S88wjwe+FCNReIZcVzakyR+ji7ZYEdJx69m27JBzJ75eOpE2wIp
         Xaq30WkuVoi69vj9/xrzUXXqG8VDyX0G7sVXd94ouV03RmEpWB4cQ+jYkvR3lC0ZYe9U
         6qH9LTaBevJczHJkWTjRp3fSgBV1pkp7LC2J0UOV7B7TqVEk6DSkxGwWPeRvQCp6rS9U
         ZldA==
X-Received: by 10.60.27.169 with SMTP id u9mr4580877oeg.138.1361104157117;
 Sun, 17 Feb 2013 04:29:17 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Sun, 17 Feb 2013 04:29:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216393>

Hi all,

Using git 1.7.10.4

I find the behavior or documentation of "git clone  --single-branch"
confusing. Docs currently say:

man git-clone

       --single-branch
           Clone only the history leading to the tip of a single
branch, either specified by the --branch option or the primary branch
remote=EF=BF=BD<80><99>s HEAD points
           at. When creating a shallow clone with the --depth option,
this is the default, unless --no-single-branch is given to fetch the
histories near
           the tips of all branches.

based onthis documentation, I cannot understand any of the results I
get when combining --depth and --singe-branch.

I start with this repo1 (for how to createin linux, see bottom):

git log --pretty=3Dformat:'%h-%s %d' --graph --decorate  --all
* 4565162-5  (foo)
* 20ce846-4
* a0615eb-3
* fa4131d-2
* f0683bd-1  (bar)
| * 432b5ec-m1  (HEAD, master)
|/
* 39df203-0

git clone repo1 repo2 --depth 1
cd repo2
git log --pretty=3Dformat:'%h-%s %d' --graph --decorate  --all
* 432b5ec-m1  (HEAD, origin/master, origin/HEAD, master)
* 39df203-0

# Why are branches "foo" and "bar" missing?

cd ..
git clone repo1 repo3 --depth 1 --branch foo
git log --pretty=3Dformat:'%h-%s %d' --graph --decorate  --all
* 4565162-5  (HEAD, origin/foo, foo)
* 20ce846-4
* a0615eb-3
* fa4131d-2
* f0683bd-1
| * 432b5ec-m1  (origin/master, origin/HEAD)
|/
* 39df203-0

# Why is --depth not having effect, and why is branch bar not there,
yet master is?

cd ..
git clone repo1 repo4 --depth 1 --branch foo --single-branch
git log --pretty=3Dformat:'%h-%s %d' --graph --decorate  --all
* 4565162-5  (HEAD, origin/foo, foo)
* 20ce846-4
* a0615eb-3
* fa4131d-2
* f0683bd-1
| * 432b5ec-m1  (origin/master, origin/HEAD)
|/
* 39df203-0

# Why is --depth not having effect, and why is branch master still ther=
e?

###################################
# Okay, so --depth seems to generally not work when cloning locally.
So maybe when doing so from github:

git clone https://github.com/git/git --depth 1
cd git
git log --pretty=3Dformat:'%h-%s %d' --graph --decorate  --all
* 7b6e784-Update draft release notes to 1.8.2  (HEAD, origin/master,
origin/HEAD, master)
* 17e45f8-Merge branch
'wk/man-deny-current-branch-is-default-these-days'  (grafted)
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
git tag
>

# Why don't other branches appear here?
# Hm, I'll add "--branch master" to the command

git clone https://github.com/git/git git3 --depth 1 --branch master
cd git3
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/next
  remotes/origin/pu
  remotes/origin/todo
git tag
> gitgui-0.10.0
> gitgui-0.10.1
> gitgui-0.10.2
> ...

# And why DO they appear here? Why do I now get all tags?
# Same result for --branch next
# okay, let's try adding --single-branch

git clone https://github.com/git/git git4 --depth 1 --branch next
--single-branch
cd git4
git branch -a
* next
  remotes/origin/next
  remotes/origin/pu
  remotes/origin/todo

# Now I don't get master, but I still get those other branches??? And a=
lso tags?


Now I am aware that a bug was fixed in git 1.8.0:
https://raw.github.com/gitster/git/master/Documentation/RelNotes/1.8.0.=
txt

 * A repository created with "git clone --single" had its fetch
   refspecs set up just like a clone without "--single", leading the
   subsequent "git fetch" to slurp all the other branches, defeating
   the whole point of specifying "only this branch".


But even considering that bug (and assuming it also affected git clone)=
,
the results I get for 1.7.10.4 seem all weird, and not really
following the documentation.


So I am sorry I cannot phrase this as a single question, as the
results are not consistent with each other or the documentation, and
those results seem to be related.

cheers,
  Thibault Kruse




How to create local repo1:

mkdir repo1
cd repo1
git init
echo 0 >> foo.txt
git add foo.txt
git commit -m 0
git co master -b bar
echo 1 >> bar.txt
git add bar.txt
git commit -m 1
git co bar -b foo
echo 2 >> foo.txt
git add foo.txt
git commit -m 2
echo 3 >> foo.txt
git add foo.txt
git commit -m 3
echo 4 >> foo.txt
git add foo.txt
git commit -m 4
echo 5 >> foo.txt
git add foo.txt
git commit -m 5
git co master
echo 1 > master.txt
git add master.txt
git commit -m m1
