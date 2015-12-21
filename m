From: "Philip Oakley" <philipoakley@iee.org>
Subject: Case insensitive branch names
Date: Mon, 21 Dec 2015 11:01:40 -0000
Organization: OPDS
Message-ID: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Git List" <git@vger.kernel.org>,
	"git-for-windows" <git-for-windows@googlegroups.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 12:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAyDr-0004rz-4x
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 12:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbbLULBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 06:01:42 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:29194 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750986AbbLULBl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 06:01:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BRCwAG23dWPH0FFlxdHRABAgKDCFJth06FBLMTEg+FZgQCgSNNAQEBAQEBBwEBAQFBJBtBDgGDXxQBAS4eAQEhCwIIAgEkOQEEGgYHAwYBEwEaAgECAwGIIgqjTI5nAQMFAQENAwGLQiGGVo0kgRoFjTc6iQ8BgQsnhAiKNZsHhGg+NIMPgh0BAQE
X-IPAS-Result: A2BRCwAG23dWPH0FFlxdHRABAgKDCFJth06FBLMTEg+FZgQCgSNNAQEBAQEBBwEBAQFBJBtBDgGDXxQBAS4eAQEhCwIIAgEkOQEEGgYHAwYBEwEaAgECAwGIIgqjTI5nAQMFAQENAwGLQiGGVo0kgRoFjTc6iQ8BgQsnhAiKNZsHhGg+NIMPgh0BAQE
X-IronPort-AV: E=Sophos;i="5.20,459,1444690800"; 
   d="scan'208";a="820576887"
Received: from host-92-22-5-125.as13285.net (HELO PhilipOakley) ([92.22.5.125])
  by out1.ip01ir2.opaltelecom.net with SMTP; 21 Dec 2015 11:01:38 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282791>

On the Git User's list, Diego J. reported that:

'When I "checkout" a branch using different Upper Case/Lower Case than the
original, the branch doesn't show in "git branch [--list]"' [1]

While case sensitivity for filenames is a common issue on Windows and the
like, I haven't seen any discussion regarding ref name sensitivity - any
pointers to past discussions?

In particular, if I have a branch 'nocase', and ask to checkout 'NoCase',
then git(-for-Windows) will happily say that 'NoCase' has been checked out,
but then it gets confusing.

We are both, not on any branch, and yet not detached. In fact HEAD points to
NoCase (which does not exist with that case setting). The checkout is
actually of 'nocase', and 'git branch' does not mark any branch ref current
(with the *). [see test script: 2].

While this is the way it is, should the 'git checkout' in some way check for
the branch case sensitivity issue?

For example, maybe simply correcting the checkout name to that as recorded
in the File System (but that has lots of code impact because the path and 
name are distinct elements of the branch struct), or maybe a warning could 
be emitted (config?), or even
an err/die.

My gut feeling was that, at least for refs, that something should be done.
My delving into the complexities of the code for 'git checkout' got me to
refs.c ~#L1603 where the requested path is lstat'd. Perhaps this point is a
special case for the mingw_lstat where the true pathname can be compared to
the requested pathname (or at least the refs/heads/name part) to detect this
mis-checkout case?

Thoughts? Is it a rabbit hole others have explored? Is it even worth 
pursuing?

--
Philip

[1] https://groups.google.com/forum/#!topic/git-users/EryCnwKL4_E
[2] Script
git init casetest
cd casetest/
>temp.txt
git add -A & git commit -m'first'
git status
git branch case
git branch
# two branches, * on master.
git status
git checkout Case
# successful checkout, uses branch name as given!
git branch
# note that no branch is marked as current, but neither are we detached 
head..
git status
cat .git/HEAD
# HEAD records the requested name, not the branch that was actually checked 
out!
# User left confused...

=== output
Philip@PhilipOakley MINGW32 /c
$ bash -v ./casetest.sh

git init casetest
Initialized empty Git repository in C:/casetest/.git/
cd casetest/
>temp.txt
git add -A & git commit -m'first'
[master (root-commit) 988c046] first
1 file changed, 0 insertions(+), 0 deletions(-)
create mode 100644 temp.txt
git status
On branch master
nothing to commit, working directory clean
git branch case
git branch
case
* master
# two branches, * on master.
git status
On branch master
nothing to commit, working directory clean
git checkout Case
Switched to branch 'Case'
# successful checkout, uses branch name as given!
git branch
case
master
# note that no branch is marked as current, but neither are we detached 
head..
git status
On branch Case
nothing to commit, working directory clean
cat .git/HEAD
ref: refs/heads/Case
# HEAD records the requested name, not the branch that was actually checked 
out!
# User left confused..
-- 
