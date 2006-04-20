From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 09:07:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 18:07:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWbgv-000428-Fu
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 18:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWDTQHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWDTQHe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 12:07:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751029AbWDTQHd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 12:07:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3KG7MtH018512
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Apr 2006 09:07:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3KG7LMP031332;
	Thu, 20 Apr 2006 09:07:22 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060420150315.GB31198@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18976>



On Thu, 20 Apr 2006, Shawn Pearce wrote:
> 
> So with 1.3.0.g56c1 "git repack -a -d -f" did worse:
> 
>   Total 46391, written 46391 (delta 6649), reused 39742 (delta 0)
>   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
> I just tried -f on v1.2.3 and it did slightly better then before:
> 
>   Total 46391, written 46391 (delta 6847), reused 38012 (delta 0)
>    59M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Interesting. The bigger packs do generate fewer deltas, but they don't 
seem to be _that_ much fewer. And the deltas themselves certainly 
shouldn't be bigger.

It almost sounds like there's a problem with choosing what to delta 
against, not necessarily a delta algorithm problem. Although that sounds a 
bit strange, because I wouldn't have thought we actually changed the 
packing algorithm noticeably since 1.2.3.

Hmm. Doing "gitk v1.2.3.. -- pack-objects.c" shows that I was wrong. Junio 
did the "hash basename and direname a bit differently" thing, which would 
appear to change the "find objects to delta against" a lot. That could be 
it. 

You could try to revert that change:

	git revert eeef7135fed9b8784627c4c96e125241c06c65e1

which needs a trivial manual fixup (remove the conflict entirely: 
everything between the "<<<<" and ">>>>>" lines should go), and see if 
that's it.

You can also try to see if

	git repack -a -d -f --window=50

makes for a better pack (at the cost of a much slower repack). It makes 
git try more objects to delta against, and can thus hide a bad sort order.

Junio, any other suggestions?

		Linus
