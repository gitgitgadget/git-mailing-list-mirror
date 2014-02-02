From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Determining update/merge/current state of a workspace
Date: Sun, 02 Feb 2014 16:15:09 -0600
Message-ID: <85ppn540wi.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 23:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA5Jz-0000KN-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 23:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaBBWPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 17:15:15 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:51495 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752462AbaBBWPO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Feb 2014 17:15:14 -0500
Received: from [70.94.38.149] ([70.94.38.149:49660] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id F8/55-05632-F63CEE25; Sun, 02 Feb 2014 22:15:12 +0000
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241385>

I'm working on the DVC Emacs front-end for git
(http://www.emacswiki.org/emacs/DistributedVersionControl), adding
features similar to the ones I added for monotone
(http://www.monotone.ca). I'm used to monotone and new to git, so this
may seem like an odd workflow.

I always do 'fetch' and 'merge' separately, never 'pull'. So after a
'fetch', the DVC Emacs front end must determine what needs to happen
next. I think there are three cases:

1) 'fetch' did not retrieve any revisions from remote; the last local
   commit is the head of the branch.

    The workspace is up to date (it may need to be comitted).

2) 'fetch' retrieved revisions, and there were no local commits since
   the previous fetch.

    The last fetch is the head of the branch; if not equal to HEAD, the
    workspace needs to be updated (via 'merge').

3) fetch retrieved revisions, and there were local commits since
   the previous fetch.

   There are two heads for the branch (the two described above), they
   need to be merged, then the workspace updated.

I'm not sure how 'git fetch' handles case 3); I have not tested that
case yet.

The question I have is:

What git queries can I run to determine which of the three states the
current workspace is in?

'rev-parse HEAD' gives the last workspace commit.

'rev-parse refs/remotes/<remote>/<branch>' gives the head of the branch
in the remote repository as of the most recent fetch.

But to distinguish among the cases, I need to determine if one of these
two revs is a child of the other or not. I don't see a git query to
determine that directly.

I could try parsing a 'log' output; I have not investigated that.

This is easy in monotone; there is a command 'mtn heads' that gives this
result directly (it returns either one or two revs), and another command
'mtn automate toposort' that orders revs topologically (by parent/child
relationships).

-- 
-- Stephe
