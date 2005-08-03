From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 10:23:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031014070.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org> <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org> <7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:24:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Mxl-0007cc-B8
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVHCRXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVHCRXW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:23:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262360AbVHCRXU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 13:23:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73HNFjA006531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 10:23:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73HNEBv029666;
	Wed, 3 Aug 2005 10:23:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Are you sure you have a good git version on master? I've never seen 
> > anything like that, and I push all the time..
> 
> I have been esuspecting that it happens only because I rewind
> and rebase "pu", which you never do.  The thing is, even though
> I rewind "pu" all the time, it happens only occasionally.

Oh, that would do it. 

You need to prune back the remote tree you send to, so that it is a real
subset of what you are sending from (at least as far as the branch you
send is concerned - other branches may be ahead of you, of course). Unlike
"git-fetch-pack", the send-pack interface does not do any common commit
discovery, so if you have state on the other end that isn't on your local
end, that's setting yourself up for problems: you are basically misusing
the interfaces.

I started out to make the "-f" flag to send-file work around it, but I
never finished that, partly because it really ends up being the same thing
as "git-fetch-pack" in reverse, which was against the whole point of
git-send-pack. Send-pack is meant to be an "update remote tree" thing, 
with the assumption that the remote tree is a subset - and exactly that 
assumption is what makes send-pack much cheaper than fetch-pack.

(Actually, to me it's not the "cheaper" that matters, but exactly the fact
that send-pack is so safe - if somebody has changed something at the other 
end that I don't have in mine, I _want_ errors, because that would be a 
serious problem).

		Linus
