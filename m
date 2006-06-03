From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git reset --hard not removing some files
Date: Sat, 3 Jun 2006 08:11:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606030802560.5498@g5.osdl.org>
References: <20060601160052.GK14325@admingilde.org> <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
 <7vhd33d2q2.fsf@assigned-by-dhcp.cox.net> <7vy7we8w1h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat Jun 03 17:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmXnU-0005sM-Ts
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 17:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWFCPMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFCPMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 11:12:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbWFCPMI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 11:12:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k53FBr2g024875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Jun 2006 08:11:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k53FBq23015581;
	Sat, 3 Jun 2006 08:11:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7we8w1h.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21195>



On Sat, 3 Jun 2006, Junio C Hamano wrote:
> 
> I think this patch fixes the regression.  Comments?

The approach looks fine, but with your changes, the "deleted" flag makes 
no sense any more and looks redundant. It's not actually used for anything 
except deciding if we need to re-write the active_cache[] thing, and you 
migth as well use either "last" or "unmerged" for that.

(yeah, "last" and "unmerged" becomes non-null one entry earlier than 
"deleted", but that's actually just confusing, I think, and now depends on 
the fact that we don't have to re-write the first entry).

The whole "*dst++ = ce" _could_ be unconditional, the only reason I made 
it conditional at all is to avoid dirtying the mmap when not necessary (ie 
it's a performance optimization, and it's not one where that off-by-one 
matters).

So I think you could make it clearer by dropping "deleted" entirely, and 
just making the store be conditional on "last".

			Linus
