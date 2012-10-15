From: Johan Herland <johan@herland.net>
Subject: BUG when trying to delete symbolic refs
Date: Mon, 15 Oct 2012 10:50:58 +0200
Message-ID: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 10:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNgOP-0004aA-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 10:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab2JOIvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 04:51:10 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:59042 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab2JOIvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 04:51:09 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TNgOA-000KXL-Nj
	for git@vger.kernel.org; Mon, 15 Oct 2012 10:51:07 +0200
Received: by mail-oa0-f46.google.com with SMTP id h16so4704645oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 01:50:58 -0700 (PDT)
Received: by 10.60.22.161 with SMTP id e1mr2867020oef.93.1350291058833; Mon,
 15 Oct 2012 01:50:58 -0700 (PDT)
Received: by 10.76.154.135 with HTTP; Mon, 15 Oct 2012 01:50:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207726>

Hi,

At $dayjob we renamed a branch, and for a grace period, we kept the
old name as a symref/alias to the new name, to give our users a window
for switching. This has worked well, until we tried to remove the
symref/alias. The following script demonstrates what we discovered:

 $ git --version
 git version 1.8.0.rc2.249.g6cc8227
 $ git init symref_delete_test/
 Initialized empty Git repository in .../symref_delete_test/.git/
 $ cd symref_delete_test/
 $ echo foo > foo && git add foo && git commit -m foo
 [master (root-commit) c7ae77e] foo
  1 file changed, 1 insertion(+)
  create mode 100644 foo
 $ git gc
 Counting objects: 3, done.
 Writing objects: 100% (3/3), done.
 Total 3 (delta 0), reused 0 (delta 0)
 $ cat .git/packed-refs
 # pack-refs with: peeled
 c7ae77e537138bee3f722e57e1af87a7011466cb refs/heads/master
 $ echo bar > foo && git commit -am bar
 [master 7451bf0] bar
  1 file changed, 1 insertion(+), 1 deletion(-)
 $ git symbolic-ref refs/heads/alias refs/heads/master
 $ git rev-parse master
 7451bf08b7aacedc9e88a9fa37a6c1f701071bbe
 $ git rev-parse alias
 7451bf08b7aacedc9e88a9fa37a6c1f701071bbe
 $ git branch -d alias
 Deleted branch alias (was 7451bf0).
 $ git rev-parse master
 c7ae77e537138bee3f722e57e1af87a7011466cb
 $ git rev-parse alias
 c7ae77e537138bee3f722e57e1af87a7011466cb
 $ cat .git/packed-refs
 # pack-refs with: peeled
 c7ae77e537138bee3f722e57e1af87a7011466cb refs/heads/master
 $ ls .git/refs/heads/
 alias

Basically, there is a "master" branch, and an "alias" symref to
"master". When we naively try to delete the symref with "git branch -d
alias", it ends up:

 - NOT deleting the "alias" symref
 - DELETING the "master" loose ref
 - NOT deleting the "master" packed ref

So, from the user perspective, "git branch -d alias" ends up resetting
"master" (and "alias") back to the last time we happened to run "git
gc". Needless to say, this is not quite what we had in mind...

AFAICS, there may be three possible "acceptable" outcomes when we run
"git branch -d alias" in the above scenario:

 A. The symbolic ref is deleted. This is obviously what we expected...

 B. The command fails because "alias" is a symref. This would be
understandable if we don't want to teach "branch -d" about symrefs.
But then, the error message should ideally explain which command we
should use to remove the symref.

 C. The "master" ref (BOTH loose and packed versions of it) is
deleted. This would be less helpful for us, but Git would at least be
internally consistent (in that the symref would be resolved, and the
command would become "git branch -d master").

Obviously, I would advocate for option A. What say you?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
