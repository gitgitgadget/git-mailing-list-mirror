From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Tracking vendor release with Git
Date: Tue, 11 Jun 2013 19:06:50 +0200
Message-ID: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 19:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmS6T-0004X3-UF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab3FKRL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:11:27 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:60310 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab3FKRLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:11:24 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id E38C177D487
	for <git@vger.kernel.org>; Tue, 11 Jun 2013 19:11:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [37.161.229.40])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B26A84B01E8;
	Tue, 11 Jun 2013 19:10:41 +0200 (CEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.7/8.14.5) with ESMTP id r5BHAdwD008139;
	Tue, 11 Jun 2013 19:10:39 +0200
Received: (from ydroneaud@localhost)
	by localhost.localdomain (8.14.7/8.14.7/Submit) id r5BH6t7K007972;
	Tue, 11 Jun 2013 19:06:55 +0200
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227466>

Hi,

I'm trying to setup a workflow to track vendor releases (upstream).
Each new release are provided as an archive of source code, data,
documentation, etc.

For each vendor releases, fixes need to be applied before making them
available to users (downstream).

Seems to be a rather common use case, applied by most Linux distribution
for decades.

In my case, on top of each releases, a common set of patches will be applied,
the biggest, the most intrusive one, being converting CRLF to LF using dos2unix,
the others being small portability fixes. In this case, fixes are not going to
be applied by upstream.

I'm trying to "design" (copy ;) a workflow with following properties,
in order of importance:

1- I wish to keep a branch with each new vendor release as a commit.
   This branch's history is only about vendor releases,
   so it's easy to read the "changelog" of the vendor releases
   with command such as git log <vendor-release-branch>

2- I'd like to ease the process of applying our patches on top
   of each new vendor release, eg. reduces the likeliness of conflicts.

3- I wish to keep a branch with each new fixed vendor release as a commit.
   Just like the upstream <vendor-release-branch>, only one commit
   per release, so it's easy to read the "changelog" of the vendor releases
   with command such as git log <patched-release-branch>
   
(4- I wish nobody is going to think about ponies ...)

The workflow, as I tried to implement it is, can be described like this:
For each release, the new sources are imported in the upstream branch,
then the previous branch holding fixes is rebased against the updated
upstream branch, and finally, the updated fixes branch is merged in
the downstream branch.

Please find a diagram trying to explain the following workflow:

                           Input       Output

                             .     *(1)  .
                             .    / \    .
                             .   /   \   .
                             .  /     \  .
                             . /       \ .
                             ./         \.
                             /           \
Upstream release 1           |           |
                  \          v           |
                   --------->*           |
                             |\          |
                             | \         |
                             |  |        |
                             |  v        |
Upstream release 2           |  * fix 1  |
                  \          |   \       |
                   \         |    \      v
                    \        |     ----->*  Downstream release 1
                     \       v           |
                      ------>*           |
                             |\          |
                             | \         |
                             |  |        |
                             |  v        |
                             |  * fix 1' |
                             |  |        |
Upstream release 3           |  v        |
                  \          |  * fix 2' |
                   \         |   \       |
                    \        |    \      v
                     \       |     ----->* Downstream release 2
                      \      |           |
                       \     v           |
                        ---->*           |
                             |\          |
                             . \         |
                             |  |        |
                             .  v        |
                             .  * fix 1" |
                             |  |        |
                             .  v        |
                             .  * fix 2" |
                             .  |        |
                             |  v        |
                                * fix 3" |
                                 \       |
                                  \      v
                                   ----->* Downstream release 3
                                         |
                                         .
                                         |
                                         .
                                         .

(1) empty root commit

I hope someone would come with an easier workflow, more sustainable.
At least, please help me find flaws in this workflow, tell me where
I can found the documentation of others workflows achieving the same
results.

BTW while testing the workflow, I tried "git merge -s theirs"
and found it doesn't exist. I thought it would be available for
such a common use case. For each merge to the of the fixes branch
to the downstream branch, something like a whole new content is dropped
to the branch. The previous content is still needed but its only for history.
So I prefer to overwrite the content of the downstream branch, instead
of fixing each conflicts "manually" when using "git merge" with default
strategy and option.

In some article[1], I've found an explanation of the lack of
"git merge -s theirs", quoting maintainer opinion[2] regarding it.

[1] <http://www.seanius.net/blog/2011/02/git-merge-s-theirs/>
[2] <http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=89024>

I was able to use "git merge --strategy=recursive --strategy-option=theirs" aka.
"git merge -X theirs". So I'm only frustrated to see my workflow not being
considered. But happy to be able to do it with "uncommon" options.


Appended here a script to reproduce the workflow described previously:

#! /bin/sh

set -e

GIT_AUTHOR_DATE=`date -R`
GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"

export GIT_AUTHOR_DATE
export GIT_COMMITTER_DATE

# cleanup
rm -rf .git main.c

# prepare
git init
git commit --allow-empty -m "empty root commit"
git branch downstream master
git branch upstream master

#
# import first upstream release: v1
git checkout upstream
cat > main.c <<EOF

/* version string */
#define VERSION "1"

int
main(void)
{
    printf("version " VERSION);
}
EOF
git add main.c
git commit -m "Upstream release 1"

# apply fix on top of upstream release
# in an integration branch
git checkout -b upstream-1-fix upstream
cat > main.c <<EOF

/* version string */
#define VERSION "1"

int
main(void)
{
    printf("version " VERSION "\n");
}
EOF
git add main.c
git commit -m "Fix 1"

# make the "fixed" release available
# merge the integration branch
git checkout downstream
git merge --no-edit --no-ff upstream-1-fix
git tag downstream-default-1

#
# new upstream release: v2
git checkout upstream
cat > main.c <<EOF

/* version string */
#define VERSION "2"

int
main(void)
{
    printf("version " VERSION);
}
EOF
git add main.c
git commit -m "Upstream release 2"

# re-apply fix on top of new upstream release
# create a new integration branch to apply
# previous fix on top of the new release
git checkout -b upstream-2-fix upstream-1-fix
git rebase upstream
# apply a new fix
cat > main.c <<EOF

#include <stdio.h>

/* version string */
#define VERSION "2"

int
main(void)
{
    printf("version " VERSION "\n");
}
EOF
git add main.c
git commit -m "Fix 2"

# make the "fixed" release available
# merge the integration branch
git checkout downstream
git merge --no-edit --no-ff upstream-2-fix
git tag downstream-default-2

#
# new upstream release: v3
git checkout upstream
cat > main.c <<EOF

/* version string */
#define VERSION "3"
#define PACKAGE "foo"

int
main(void)
{
    printf("version " VERSION);
}
EOF
git add main.c
git commit -m "Upstream release 3"

# re-apply fixes on top of new upstream release
# create a new integration branch to apply
# previous fixes on top of the new release
git checkout -b upstream-3-fix upstream-2-fix
git rebase upstream
# apply a new fix
cat > main.c <<EOF

#include <stdio.h>

/* version string */
#define VERSION "3"
#define PACKAGE "foo"

int
main(void)
{
    printf("version " VERSION "\n");

    return 0;
}
EOF
git add main.c
git commit -m "Fix 3"

# make the "fixed" release available
# try to merge the integration branch
git checkout downstream
git merge --no-edit --no-ff upstream-3-fix || { 
echo "Merge failed, \"manually\" resolve conflict ..."
cat > main.c <<EOF

#include <stdio.h>

/* version string */
#define VERSION "3"
#define PACKAGE "foo"

int
main(void)
{
    printf("version " VERSION "\n");

    return 0;
}
EOF
git add main.c
git commit --no-edit
}
git tag downstream-default-3

# now, try a different merge strategy
git checkout master
git branch -D downstream
git branch downstream master

git checkout downstream

git merge --no-edit --no-ff --strategy-option theirs upstream-1-fix
git tag downstream-theirs-1
git merge --no-edit --no-ff --strategy-option theirs upstream-2-fix
git tag downstream-theirs-2
git merge --no-edit --no-ff --strategy-option theirs upstream-3-fix
git tag downstream-theirs-3

git checkout master

# "default" and "theirs" should match
# but have a different commit message:
# no conflict reported for "theirs"
git diff downstream-default-3 downstream-theirs-3


# Regards !

-- 
Yann Droneaud <ydroneaud@opteya.com>
OPTEYA
