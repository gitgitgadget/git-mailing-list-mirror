From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 21:48:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com>
 <20050416183023.0b27b3a4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:43:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1dC-0004zA-SS
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDQErW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVDQErW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:47:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:23195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVDQErQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 00:47:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3H4l2s4007153
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 21:47:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3H4l128007539;
	Sat, 16 Apr 2005 21:47:02 -0700
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416183023.0b27b3a4.pj@sgi.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Paul Jackson wrote:
>
> Morten wrote:
> > It makes some sense in principle, but without storing what they mean
> > (i.e., group==?) it certainly makes no sense. 
> 
> There's no "they" there.
> 
> I think Martin's proposal, to which I agreed, was to store a _single_
> bit.  If any of the execute permissions of the incoming file are set,
> then the bit is stored ON, else it is stored OFF.  On 'checkout', if the
> bit is ON, then the file permission is set mode 0777 (modulo umask),
> else it is set mode 0666 (modulo umask).

I think I agree.

Anybody willing to send me a patch? One issue is that if done the obvious
way it's an incompatible change, and old tree objects won't be valid any
more. It might be ok to just change the "compare cache" check to only care
about a few bits, though: S_IXUSR and S_IFDIR. And then always write new 
"tree" objects out with mode set to one of
 - 040000: we already do this for directories
 - 100644: normal files without S_IXUSR set
 - 100755: normal files _with_ S_IXUSR set

Then, at compare time, we only look at S_IXUSR matching for files (we
never compare directory modes anyway). And at file create time, we create
them with 0666 and 0777 respectively, and let the users umask sort it out
(and if the user has 0100 set in his umask, he can damn well blame
himself).

This would pretty much match the existing kernel tree, for example. We'd 
end up with some new trees there (and in git), but not a lot of 
incompatibility. And old trees would still work fine, they'd just get 
written out differently.

Anybody want to send a patch to do this?

		Linus
