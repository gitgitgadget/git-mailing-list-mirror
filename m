From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix -B "very-different" logic.
Date: Thu, 2 Jun 2005 17:21:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
 <7vmzqau3es.fsf@assigned-by-dhcp.cox.net> <7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 02:17:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddzrp-0000fy-Ni
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 02:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFCATw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFCATw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 20:19:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:49892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261462AbVFCATo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 20:19:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j530JdjA000915
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 17:19:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j530JcgN028438;
	Thu, 2 Jun 2005 17:19:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Junio C Hamano wrote:
> 
> However I think the diffcore-break algorithm itself was basing
> its "very_different" computation on numbers somewhat bogus.  It
> was counting newly inserted bytes into account, but amount of
> those bytes should not make any difference when determining if
> the change is a complete rewrite.

Careful. 

I think the amount of new code _should_ matter. Otherwise, an old empty
file would always be considered the source of a new file, since the diff 
doesn't remove anything. Similarly, just because we have a boilerplate 
file shouldn't make that always be considered a "wonderful source", when 
people add the real meat to it.

So I think you're on the right track, but I don't think you should
entirely dismiss "lots of stuff added" as a reason for a "break". I think
that if the new stuff is _much_ larger than the old stuff, it might as
well be considered a rewrite.

In particular, let's say that I used to have two files:

	a.c - small helper functions
	b.c - the "meat" of the thing

and I end up deciding that I might as well collapse it all into one file, 
a.c. What happens? There's almost no deletes from a.c, but there's a lot 
of new code in it. 

Wouldn't it be _better_ if you considered the new "a.c" a new file, so 
that you might notice that it's actually _closer_ to the old removed "b.c" 
than the old "a.c"?

See what I'm saying?

		Linus
