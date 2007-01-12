From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 12 Jan 2007 01:18:27 +0100
Message-ID: <20070112001827.GE6058@steel.home>
References: <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com> <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org> <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com> <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org> <7vfyah48j2.fsf@assigned-by-dhcp.cox.net> <20070111221053.GD6058@steel.home> <Pine.LNX.4.64.0701111424400.3594@woody.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:18:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5A7y-0001u0-KN
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXALASg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbXALASg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:18:36 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:45538 "EHLO
	mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519AbXALASf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 19:18:35 -0500
Received: from fwd30.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1H5A7p-0003HA-01; Fri, 12 Jan 2007 01:18:29 +0100
Received: from tigra.home (bLhq8EZBoe44jBlOn4YWzqfurjXudoC2FKjWvL8A66clF3nNqca2ga@[84.163.96.128]) by fwd30.sul.t-online.de
	with esmtp id 1H5A7o-2FKqTQ0; Fri, 12 Jan 2007 01:18:28 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id ABC42277B6;
	Fri, 12 Jan 2007 01:18:27 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 8013CC166; Fri, 12 Jan 2007 01:18:27 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111424400.3594@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: bLhq8EZBoe44jBlOn4YWzqfurjXudoC2FKjWvL8A66clF3nNqca2ga
X-TOI-MSGID: 97e1212b-c8f9-4461-836a-bff0ca4c9bbc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36642>

Linus Torvalds, Thu, Jan 11, 2007 23:28:21 +0100:
> > 
> > It must have been large leak, as I really have seen the memory usage
> > dropping down significantly.
> 
> I really think it was about 6MB (or whatever your index file size was) per 
> every single resolved file. I think merge-recursive used to flush the 
> index file every time it resolved something, and every flush would 
> basically leak the whole buffer used to write the index.

Looks like. Resulting merge has about 10 files changed, all the other
files are same, just got different ways on the branches to be merged.

> Anyway, 40-50 sec on a fairly weak laptop for a 44k-file merge sounds like 
> git doesn't have to be totally embarrassed. I'm not saying we shouldn't be 
> able to do it faster, but it's at least _possible_ that a lot of the time 
> spent is now spent doing real work (ie maybe you actually have a fair 
> amount of file-level merging? Maybe it's 40-50 sec because there's some 
> amount of real IO going on, and a fair amount of real work done too?)

Some work, definitely: git diff-tree branch1 branch2 lists 9042
differences, among them some on the same files.
