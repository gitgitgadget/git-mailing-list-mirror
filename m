From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 00/10] Support writing pack index version 2
Date: Tue, 24 Jun 2008 23:54:09 -0400
Message-ID: <20080625035409.GY11793@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org> <200806250048.29892.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBM6A-0000ql-Jm
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYFYDyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYFYDyO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:54:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34683 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYFYDyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:54:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBM50-0003Wj-AC; Tue, 24 Jun 2008 23:53:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F6DD20FBAE; Tue, 24 Jun 2008 23:54:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806250048.29892.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86212>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> Ocular review looks fine, but nevertheless some tests break.

Dammit.
 
> org.spearce.jgit.lib.PackIndexV2Test
> testIteratorMethodsContract(org.spearce.jgit.lib.PackIndexV2Test)
> java.io.IOException: Unreadable pack index: /home/me/SW/EGIT.contrib/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
> 	at org.spearce.jgit.lib.PackIndex.open(PackIndex.java:95)
...
> 	at org.spearce.jgit.lib.PackIndexV1.<init>(PackIndexV1.java:75)

Yea, OK, I know what that is.  I busted PackIndex.isTOC.

I asked it to compare a 4 byte array (TOC only) to an 8 byte array
(TOC + version) and of course 4 != 8 so it fails.  Thus all V2
index files look like V1 files.  Only they aren't; and then all
hell breaks loose when we start treating parts of the V2 index as
different sections of the V1 index.

I'll post a replacement patch in a minute.

> Together with Marek's packwrite patches the list gets even longer (his patches alone are "green"). I'm
> not including them here.

That's because Marek's branch includes additional tests for features
he added to PackIndexV2.  But all PackIndexV2 reading is busted.

-- 
Shawn.
