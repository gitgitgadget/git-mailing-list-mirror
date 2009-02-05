From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] Questions about binary right shifting
Date: Thu, 5 Feb 2009 21:32:01 +0100
Message-ID: <200902052132.01797.robin.rosenberg.lists@dewire.com>
References: <498AF9B1.1060200@gmail.com> <20090205152108.GE26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAuk-0001ri-0m
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZBEUcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZBEUcG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:32:06 -0500
Received: from mail.dewire.com ([83.140.172.130]:2875 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbZBEUcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:32:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EE093147E880;
	Thu,  5 Feb 2009 21:32:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pIzJA6m7u+39; Thu,  5 Feb 2009 21:32:02 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6247A147E7FF;
	Thu,  5 Feb 2009 21:32:02 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090205152108.GE26880@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108610>

torsdag 05 februari 2009 16:21:08 skrev Shawn O. Pearce:
> Yann Simon <yann.simon.fr@gmail.com> wrote:
> > I can see in the code that the signed right shifting is used.
> > Could it be a problem? Or do we manipulate only positive numbers?
> 
> Heh.  We shouldn't ever be dealing with a case where there are more
> than 1 billion files in the index, and thus we should never see
> the expression "low + high" wrap negative, and then try to divide
> by 2 here.
> 
> Binary search on a 1 billion file index would hurt, badly.  I'm not
Roughly three times the search time in the linux kernel repo. Not
that bad.

> sure what project even has 1 billion source files to checkout
> on disk.  Isn't that easily a 4 TB filesystem just for the ext2
Not even KDE or Eclipse.
> inodes of the working tree files?  :-)

> Oh, and we can't even have an index with 1 billion entries in it
> anyway.  DirCache.readFrom allocates a byte[] of entryCnt * 62.
> So our largest number of files permitted is 34,636,833, due to
> the limit on byte[] maxing out at 2 GB.  Thus high below cannot
> ever be larger than 34 million, and we can't wrap.
Assuming the whole index is in memory. But I guess we can discard
it as most competing systems choke on a lot lot less and for very
large indexes we get other problems with size. Binary search isn't
one of them. Having i packed index is probably the biggest issue
since it has to be completely rewritten when we add or remove
files. But, OK, we won't solve this unless we have a case. I think
our current challenge is dealing with 100k files real smoothly.

Patching this to make findbugs shut up is ok with me.

-- robin
