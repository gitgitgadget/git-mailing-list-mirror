From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 04:09:59 -0400
Message-ID: <20080325080959.GG4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <47E8889E.6090403@intelinet.com.br> <20080325053649.GE4759@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Mar 25 09:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je4F8-0001tC-0B
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 09:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbYCYIKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 04:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYCYIKH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 04:10:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52016 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYCYIKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 04:10:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Je4EJ-0003Ai-Sv; Tue, 25 Mar 2008 04:09:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 014E020FBAE; Tue, 25 Mar 2008 04:09:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080325053649.GE4759@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78160>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> "Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> 
> > But it wasn't that fast, it took some minutes to finish building the 
> > whole tree. Also, changing projects (different git repos) makes the cpu 
> > go very high, and what opened fast the first time takes minutes after...

Something else I noticed - the core.packedGit* settings make a
difference on performance.  On Windows XP with Java 6 I am getting
much better performance (200 ms lower running time) by using a much
smaller window size and disabling mmap:

	[core]
		packedGitWindowSize = 8k
		packedGitLimit = 10m
		packedGitMMAP = false

by default jgit is using mmap, as Robin has reported it runs faster
that way for him.  But I have never been able to reproduce that on
Mac OS 10.4/Java 5 or Windows XP/Java 6.  In both systems setting
mmap to false has performed better, even on the initial first set
of hits to the cache where we have to read in the blocks vs. mmap
them.  The ByteBuffer API is just that much slower than accessing
a byte[] directly when shoving it through inflate.  We spend at
least 30% of our time in inflate.

-- 
Shawn.
