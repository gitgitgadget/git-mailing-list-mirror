From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 16:38:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191627420.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <426583D5.2020308@mesatop.com>
 <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org> <200504191704.48976.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2Ci-0004DK-4q
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDSXgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVDSXgf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:36:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:21714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261270AbVDSXg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:36:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JNaKs4029914
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 16:36:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JNaJVa007212;
	Tue, 19 Apr 2005 16:36:19 -0700
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <200504191704.48976.elenstev@mesatop.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Steven Cole wrote:
> 
> I wasn't complaining about the 4 minutes, just the lack of feedback
> during the majority of that time.  And most of it was after the last
> patching file message.

That should be exactly the thing that the new "read-tree -m" fixes.

Before, when you read in a new tree (which is what you do when you update
to somebody elses version), git would throw all the cached information
away, and so you'd end up doing a "checkout-cache -f -a" that re-wrote
every single checked-out file, followed by "update-cache --refresh" that
then re-created the cache for every single file.

With the new read-tree, the same sequence (assuming you have the "-m"  
flag to tell read-tree to merge the cache information) will now only write
out and re-check the files that actually changed due to the update or
merge.

So that last phase should go from minutes to seconds - instead of checking
17,000+ files, you'd end up checking maybe a few hundred for most "normal"
updates.

For example, updating all the way from the git root (ie plain 2.6.12-rc2)  
to the current head, only 577 files have changed, and the rest (16,740)
should never be touched at all.

You can see why doing just the 577 instead of the full 17,317 might speed
things up a bit ;)

		Linus

PS. Of course, right now it probably does make sense to waste some time
occasionally, and run "fsck-cache $(cat .git/HEAD)" every once in a while.
Just in case..
