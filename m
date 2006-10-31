X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when
 unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 23:08:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610302258400.11384@xanadu.home>
References: <20061030223615.GH5775@spearce.org>
 <7vlkmxtmln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 31 Oct 2006 04:09:09 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vlkmxtmln.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30566>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gekvx-0006g0-Ct for gcvg-git@gmane.org; Tue, 31 Oct
 2006 05:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161608AbWJaEI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 23:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161609AbWJaEI6
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 23:08:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45013 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161608AbWJaEI5
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 23:08:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Z006CGFIWCB10@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Mon,
 30 Oct 2006 23:08:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, 30 Oct 2006, Junio C Hamano wrote:

> One thing you can cheaply do is to tell the number of new
> commits that is coming to receive-pack from send-pack when it
> sends the old..new pairs before it sends the packfile payload.
> It would be just a single internal rev-list call inside
> send-pack, which is reasonably cheap.

Well, it could even be avoided.

> If the receiving end knows how to process that new information
> (invent a "send-count" protocol extension and send it just like
> we already send "report-status" request), send one extra packet
> after flushing the list of old..new from send-pack to
> receive-pack, to tell what the number of commits are, and make a
> matching change in receive-pack.

I don't like this much since a commit can carry along very little or 
very large amount of objects.  You really want to decide on the number 
of objects.

Why not just parse the pack header in receive-pack / fetch-pack, and 
decide on the first-hand information?  Sure the pack header is then 
gone, but then the only thing that is needed is an extra flag to both 
unpack-objects and index-pack to tell them that we've already parsed the 
pack header and that the pack version is x and the number of objects is 
y.  Simply something like --pack_header=x,y.  No protocol extension 
needed, no extra rev-list, no reliance on the remote server providing 
the needed info.


