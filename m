From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Git rebase dies with fatal: Unable to create '.../.git/index.lock':
 File exists.
Date: Mon, 16 Sep 2013 12:28:52 -0600
Message-ID: <20130916182852.GA14513@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 16 20:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLdXe-0002gY-Li
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab3IPS2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 14:28:54 -0400
Received: from quartz.orcorp.ca ([184.70.90.242]:47925 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab3IPS2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 14:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=obsidianresearch.com; s=rsa1;
	h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=aCh35uyJM0Z0sSq3Qvl7cSBPISm0GRF+79R/q0SXDFI=;
	b=exnOrsE5Zmw+8DSkNzFuqQDoH1xQ9LYLUCenRaBVlUhRAqlVSIiSx2W8LJgmPu2AduZGQX4XwYFMbQbH38em3Dmk5UJ/2limd7/ufujsZ5pnc0IgWDDgBAd3ynmSgnejFwjelcXA/KCgS72ebEFOAGbUXs2lwEPwojpeTiLKYGU=;
Received: from [10.0.0.161] (helo=jggl.edm.orcorp.ca)
	by quartz.orcorp.ca with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1VLdXY-0001BH-Dg
	for git@vger.kernel.org; Mon, 16 Sep 2013 12:28:52 -0600
Received: from jgg by jggl.edm.orcorp.ca with local (Exim 4.80)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1VLdXY-0004za-2y
	for git@vger.kernel.org; Mon, 16 Sep 2013 12:28:52 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Broken-Reverse-DNS: no host name found for IP address 10.0.0.161
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234839>

Scenario, run:

 $ git rebase  v3.10.12 --autosquash  -i

And randomly get this:

 fatal: Unable to create '.../linux/.git/index.lock': File exists.

 If no other git process is currently running, this probably means a
 git process crashed in this repository earlier. Make sure no other git
 process is running and remove the file manually to continue.
 Could not apply ....

I've noticed this happening randomly for a few years now, and always
chalked it up to NFS weirdness, but I figured out what is going on
today (as I am not using NFS right now)..

I have emacs windows open that have files within the git tree open in
them. My emacs has vc-git mode loaded and global-auto-revert-mode set.

During the rebase the files open in emacs are changed by git, when
emacs notices this (which is random with respect to the ongoing
rebase) it auto reverts and runs git commands (due to vc-git), which
causes the rebase to randomly fail.

Worse, I've noticed that this also randomly seems to cause the rebase
to loose a commit if you --continue from that point.

Can git have some retry in the locking so this doesn't happen?

Jason
