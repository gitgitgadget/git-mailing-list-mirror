From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Wed, 27 Aug 2008 21:42:05 -0700
Message-ID: <20080828044205.GB10238@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <48B62B6F.7010103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 06:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYZLl-00050K-5C
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 06:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYH1EmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 00:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYH1EmI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 00:42:08 -0400
Received: from george.spearce.org ([209.20.77.23]:52334 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYH1EmH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 00:42:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 80A9E38375; Thu, 28 Aug 2008 04:42:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B62B6F.7010103@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94035>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> So this is what may be the final draft of the HTTP protocol.
>
> It looks good to me.  I *really* like the option of combining a redirect  
> with a refs list in one reply; this will make things substantially  
> easier do deploy on kernel.org, and saves a round trip to boot.

Yea, I had a draft that didn't combine these and I realized how
stupid that was.  So I allowed them to appear together if the
server operator wants to do that.

> Just an implementation detail for the server, however: for an *empty*  
> repository (one which has no refs at all), the server needs to *not*  
> transmit the redirect, or there will be a loop :)  It is unnecessary,  
> anyway, since there is inherently nothing to do.

Actually that's not true.  A correct client won't loop.

An empty repository is required to send "refs" section header.
So the client will see the "refs" header and know that the complete
set of refs is following.  Only nothing follows, so it knows the
complete set is the empty set.

A redirect with no ref data won't have the "refs" section header.
So the client knows that it cannot conclude anything from that
exchange and must follow the redirect.

An empty repository sending a redirect will send both "redirect"
and "refs", but no refs follow the "refs" section header.  So the
client knows that it is empty and it does not need to follow the
redirect it received.

Now if the server is stupid and keeps sending a redirect with no
refs header, yea, the client can loop.  So the clients should have
a maximum recursion limit configured into them, just like a good
browser would, so you can't get stuck in an A->B->C->A loop.

-- 
Shawn.
