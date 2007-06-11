From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Mon, 11 Jun 2007 02:31:18 -0400
Message-ID: <20070611063118.GF6073@spearce.org>
References: <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com> <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net> <alpine.LFD.0.99.0706102144080.12885@xanadu.home> <466CE998.9000706@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 08:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxdRE-0003eq-9D
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 08:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbXFKGbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 02:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXFKGbd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 02:31:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57380 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbXFKGbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 02:31:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HxdQx-0006bk-1g; Mon, 11 Jun 2007 02:31:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C6DE120FBAE; Mon, 11 Jun 2007 02:31:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <466CE998.9000706@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49823>

Steven Grimm <koreth@midwinter.com> wrote:
> Nicolas Pitre wrote:
> >
> >It won't happen for a simple reason: to be backward compatible with 
> >older GIT clients.  If you have your repo compressed with bzip2 and an 
> >old client pulls it then the server would have to decompress and 
> >recompress everything with gzip.  If instead your repo remains with gzip 
> >and a new client asks for bzip2 then you have to recompress as well 
> >(slow).  So in practice it is best to remain with a single compression 
> >method.
> >  
> 
> Not that I really think this is all that important (my original question 
> was more out of curiosity than anything) but I don't think those are 
> really issues.
...
> And since the hypothetical new client would have support for both 
> compression types, pulling from a gzip-based repo could be accomplished 
> totally transparently; you could, one assumes, even pull from a gzip 
> repo and pack locally using the other scheme if you felt like it.

Right, I agree with Steven here.

Pack v4 (which is rapidly becoming vaporware it seems) uses such
a radically different encoding for its commit and tree objects
that you cannot send them as-is to a client unless that client
also understands pack v4.  Consequently you need to decompress and
recompress those objects when talking to an older peer; this isn't
very different from a switch to bzip2.

That said, I think switching to a different generic compressor isn't
that interesting.  We can probably do a lot better by organizing
files into clusters, where those clusters have large number of
symbols in common, and then compress everything in the same cluster
with the same pack-wide dictionary.

Specifically I'm thinking that you may be able to cluster the *.h/*.c
into one cluster, and the Makefile into another, and the .gitignore
into a third cluster, and then leverage the large commonalities
between those blobs when building a dictionary and compressing them.
No, I haven't prototyped it out yet.

-- 
Shawn.
