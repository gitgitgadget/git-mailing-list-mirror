From: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [BUG] Wrong worktree path when using multiple worktree
Date: Tue, 3 Nov 2015 17:58:06 +0100
Message-ID: <5638E79E.10407@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 18:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtfTJ-0003jS-8L
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 18:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbbKCReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 12:34:08 -0500
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:59542 "EHLO
	9.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbbKCReG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 12:34:06 -0500
X-Greylist: delayed 1804 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 12:34:05 EST
Received: from mail97.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id 91FAC1000B88
	for <git@vger.kernel.org>; Tue,  3 Nov 2015 17:58:12 +0100 (CET)
Received: from localhost (HELO queueout) (127.0.0.1)
	by localhost with SMTP; 3 Nov 2015 18:58:11 +0200
Received: from unknown (HELO sat.lin.mbt.kalray.eu) (nicolas@morey-chaisemartin.com@92.103.151.218)
  by ns0.ovh.net with SMTP; 3 Nov 2015 18:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:43.0) Gecko/20100101
 Thunderbird/43.0a2
X-Ovh-Tracer-Id: 16690340220637538270
X-Ovh-Remote: 92.103.151.218 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekhedrvdekucetufdoteggodftvfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekhedrvdekucetufdoteggodftvfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280804>

Hi,

There seem to be an issue with the path computed for a worktree when multiple worktree were created (using git worktree)
In my Setup, I have 3 repos:
A/repo (main One)
A/repo-patches (worktree, using branch dev)
B/repo (worktree, using branch next)

I'm working in A/repo-patches an run:
$ git checkout next
fatal: 'next' is already checked out at 'A/repo-patches'

Which is partially true but not completely.
I looked a bit in the code and found that the issue comes from here (get_linked_worktree):
    if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
        strbuf_reset(&worktree_path);
        strbuf_addstr(&worktree_path, absolute_path("."));
        strbuf_strip_suffix(&worktree_path, "/.");
    }
Because it wrongfully assumes that I am in the linked worktree.
I checked in the .git/worktree files and couldn't see anything that actually points to where the repo are setup.

Nicolas
