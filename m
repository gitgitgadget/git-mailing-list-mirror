From: sf <sf@b-i-t.de>
Subject: BUG: rebase -p after cherry-pick does not work
Date: Mon, 18 Feb 2008 15:06:52 +0100
Message-ID: <47B990FC.9090600@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 15:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6el-0001nQ-5n
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYBROHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYBROHH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:07:07 -0500
Received: from main.gmane.org ([80.91.229.2]:38095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbYBROHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:07:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JR6e4-0002ab-MD
	for git@vger.kernel.org; Mon, 18 Feb 2008 14:07:00 +0000
Received: from ip-213157015184.static.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 14:07:00 +0000
Received: from sf by ip-213157015184.static.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 14:07:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.static.heagmedianet.de
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74294>

Hello,

git-rebase -p does not work when one of the changes is cherry-picked
before rebase. Test case:

set -e -u
mkdir git
cd git
git init
for x in abc def ghi
do
  echo $x >$x
  git add $x
  git commit -m$x
done
git branch first
git reset --hard first~2
git cherry-pick first^
git branch second
EDITOR=: git rebase --verbose --interactive --preserve-merges \
second first
git status

The result for me is:

Initialized empty Git repository in .git/
Created initial commit fc8b37c: abc
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 abc
Created commit 3d6ca20: def
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 def
Created commit 4c5e07a: ghi
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 ghi
HEAD is now at fc8b37c... abc
Finished one cherry-pick.
Created commit 3d6ca20: def
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 def
Switched to branch "first"
Note: moving to "3d6ca204f4823bde7273a4bb83676055ae415224" which isn't a
local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 3d6ca20... def
Rebasing (1/1)
4c5e07a7107c87dec18244200ad1b52b76e71ea0
Fast forward to 4c5e07a7107c87dec18244200ad1b52b76e71ea0
Successfully rebased and updated refs/heads/first.
# On branch first
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    ghi
#

The problem area is function pick_one_preserving_merges in
git-rebase--interactive.sh:

    # rewrite parents; if none were rewritten, we can fast-forward.
    fast_forward=t
    preserve=t
    new_parents=
    for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
    do
        if test -f "$REWRITTEN"/$p
        then
            preserve=f
            new_p=$(cat "$REWRITTEN"/$p)
            test $p != $new_p && fast_forward=f
            case "$new_parents" in
            *$new_p*)
                ;; # do nothing; that parent is already there
            *)
                new_parents="$new_parents $new_p"
                ;;
            esac
        fi
    done

If a commit's parent is not applied during rebase (e.g. because it was
cherry-picked already) then it is not rewritten either.

Regards

Stephan
