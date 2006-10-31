X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on
 object count.
Date: Tue, 31 Oct 2006 17:06:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610311659310.11384@xanadu.home>
References: <20061031075704.GB7691@spearce.org>
 <Pine.LNX.4.64.0610311447250.11384@xanadu.home>
 <20061031201148.GD23671@spearce.org>
 <Pine.LNX.4.64.0610311559150.11384@xanadu.home>
 <20061031212942.GA24184@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 31 Oct 2006 22:07:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061031212942.GA24184@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30600>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf1lF-0006se-Af for gcvg-git@gmane.org; Tue, 31 Oct
 2006 23:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946053AbWJaWGt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 17:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWJaWGt
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 17:06:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49151 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1946053AbWJaWGs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 17:06:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8000DNFTFB2H40@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Tue,
 31 Oct 2006 17:06:47 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, 31 Oct 2006, Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > I used "pack" <tab> <sha1> so it is easy to pick out of the list of refs 
> > that usually comes over the stream in the fetch case (if I understood 
> > that part right).
> 
> I thought about using a pipe too, but in the case of receive-pack
> it looked like index-pack was sending something back to the push
> end of the connection.  I didn't dig into the code enough to see
> what that was and how to do the same in receive-pack itself.

Well, I think it goes like this:

unpack-objects (and now index-pack --stdin) reads from stdin in 4kb 
chunks.  When the pack has been entirely parsed, it is possible that the 
4kb chunk contains data from the stream past the actual pack data which 
is why the remaining of the buffer is flushed out to stdout for the next 
tool in the chain to pick up.

So if you use a pipe with index-pack to retrieve the pack name, you also 
must consume all extra data from it and pass it on as well.


