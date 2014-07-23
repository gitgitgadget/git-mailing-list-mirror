From: Sergei Organov <osv@javad.com>
Subject: rebase flattens history when it shouldn't?
Date: Wed, 23 Jul 2014 17:34:25 +0400
Message-ID: <87k374xkpq.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 15:34:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9wgi-00069t-MC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 15:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaGWNe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 09:34:28 -0400
Received: from mail.javad.com ([54.86.164.124]:40415 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbaGWNe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 09:34:28 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id B47996184D
	for <git@vger.kernel.org>; Wed, 23 Jul 2014 13:34:26 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1X9wgb-00060S-1S
	for git@vger.kernel.org; Wed, 23 Jul 2014 17:34:25 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254075>

Hello,

$ git --version
git version 1.9.3

Please consider the following history:

     --C--
    /     \
   /   ----M topic,HEAD
  /   /
 A---B master

shouldn't

$ git rebase master

be a no-op here? According to my reading of the rebase manual page, it
should be a no-op, as 'topic' is a descendant of the 'master'. Instead,
"git rebase master" flattens the history to:

       ----C topic,HEAD
      /
 A---B master

I'd expect --force-rebase to be required for this to happen:

-f, --force-rebase
    Force the rebase even if the current branch is a descendant of the
    commit you are rebasing onto. Normally non-interactive rebase will
    exit with the message "Current branch is up to date" in such a
    situation. Incompatible with the --interactive option.

Also notice that:

$ git rebase --preserve-merges --verbose master

does perform the rebasing work, even though it does not change the
history in the end.

Here is use-case where it came from and where it gave me real surprise:

I have pull.rebase=true in configuration. Being on a remote tracking
branch, I've successfully pulled from the origin and had no any local
changes on this branch. Then I've successfully merged another branch to
the current one but didn't push the changes back upstream. A few hours
later I returned to the work and issued "git pull" that instead of doing
nothing (as it would be should pull.rebase be either "false" or
"preserve") created a surprising mess.

Do you think it's worth fixing?

Here are reproduction commands for the example history:

git init t
cd t
echo A > a
echo B > b
git add a b
git commit -m A -a
git checkout -b x
echo A >> a
git commit -m C -a
git checkout master
echo B >> b
git commit -m B -a
git checkout -b topic
git merge -m M x
git branch -d x
git rebase master

-- 
Sergey.
