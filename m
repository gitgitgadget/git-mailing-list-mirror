From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFH] zlib gurus out there?
Date: Tue, 7 Mar 2006 18:00:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603071753370.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
 <7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603071658300.32577@g5.osdl.org>
 <7vslptivbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 03:00:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGnys-0006tm-IJ
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 03:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWCHCAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCHCAr
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 21:00:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964879AbWCHCAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 21:00:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2820dDZ028381
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Mar 2006 18:00:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2820Z7X021684;
	Tue, 7 Mar 2006 18:00:38 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslptivbg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17361>



On Tue, 7 Mar 2006, Junio C Hamano wrote:
> >
> > No, I don't think that's good. You're only doing a partial deflate, you 
> > can't ask for a Z_FULL_FLUSH. That only works if you give it the whole 
> > buffer, and you don't.

Actually, I misread what you were trying to do, and thought this was the 
inflate phase, not the deflate. Now that I understand what you want, 

> So, in short there is no way to create:
> 
>     hdr part deflated.
>     flush.
>     data part deflated independently.
> 
> and have the current sha1_read_file() not to notice that flush,

Actually, try the patch you already tried, except you'll need to add a 

	deflateEnd(&stream);
	deflateInit(&stream, Z_BEST_COMPRESSION);
	.. set up output parameters again ..

and you need to change the initial 

	size = deflateBound(&stream, len+hdrlen);

to

	size = deflateBound(&stream, len) + deflateBound(&stream, hdrlen);

and then you might be ok.

That said, I'm not sure I agree with what you're trying to do. 

		Linus
