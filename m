From: John Keeping <john@keeping.me.uk>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:19:16 +0100
Message-ID: <20160421131916.GB1589@serenity.lan>
References: <20160421113004.GA3140@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:19:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atEW1-00075b-CM
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 15:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbcDUNT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 09:19:27 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:37380 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752386AbcDUNTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 09:19:25 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 3D79A230D6;
	Thu, 21 Apr 2016 14:19:23 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 38C3F34A8;
	Thu, 21 Apr 2016 14:19:23 +0100 (BST)
X-Quarantine-ID: <VlRWRUpaeSpm>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.15
X-Spam-Level: 
X-Spam-Status: No, score=-2.15 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, KAM_INFOUSMEBIZ=0.75]
	autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VlRWRUpaeSpm; Thu, 21 Apr 2016 14:19:19 +0100 (BST)
Received: from serenity.lan (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 23A933466;
	Thu, 21 Apr 2016 14:19:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160421113004.GA3140@aepfle.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292109>

On Thu, Apr 21, 2016 at 01:30:04PM +0200, Olaf Hering wrote:
> To track the changes in hyperv related files I created some scripts
> years ago to automate the process of finding relevant commits in
> linux.git. Part of that process is to record the tag when a commit
> appeared in mainline. This worked fine, until very recently.
> 
> Suddenly years-old commits are declared as having-just-arrived in
> linux.git. Look at this example:
> 
>   $ git log --oneline -- drivers/input/serio/hyperv-keyboard.c
>   2048157 Drivers: hv: vmbus: fix the building warning with hyperv-keyboard
>   62238f3 Input: hyperv-keyboard - register as a wakeup source
>   c3c4d99 Input: hyperv-keyboard - pass through 0xE1 prefix
>   aed06b9 Input: add a driver to support Hyper-V synthetic keyboard
>   $ git describe --contains aed06b9
>   v4.6-rc1~9^2~792
>   $ git show aed06b9 | head
>   commit aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
>   Author: K. Y. Srinivasan <kys@microsoft.com>
>   Date:   Wed Sep 18 12:50:42 2013 -0700
> 
> Obviously that and other commits are in the tree since a very long time.
> 
> How can I find out whats going on? Is my git(1) 2.8.1 broken, or did
> Linus just pull some junk tree (and does he continue to do so)?

I suspect it indicates that an old tree was pulled in such that the path
to v4.6-rc1 is shorter than to the older version.  The commit is clearly
in v3.13-rc1:

	$ git tag --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
	v3.13
	v3.13-rc1
	v3.13-rc2
	[snip]

The behaviour of describe is a bit clearer if you limit it to v3.*:

	$ git describe --match='v3.*' --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
	v3.13-rc7~9^2~14^2~42

	$ git describe --match='v3.13-rc1' --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
	v3.13-rc1~65^2^2~42

It seems that the path to v4.6-rc1 is "more direct" than to either of
these commits: there is only one second-parent merge transition.

>From a quick look, I think the problem is in commit c155c7492c9a ("Merge
branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input")
which merges a branch that has repeatedly had master merged back into it
but does not build on any recent releases.  The most recent tag on the
first-parent history of that branch is v3.0-rc4.

I think it is as simple as git-describe (or git-name-rev which is used
in the --contains case) preferring a less branchy path, which has been
introduced in v4.6 with the merge commit above.
