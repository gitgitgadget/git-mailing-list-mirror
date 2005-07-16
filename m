From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git daemon"
Date: Fri, 15 Jul 2005 20:04:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507151945370.19183@g5.osdl.org>
References: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org> <42D86B92.7010303@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 05:25:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtdIm-0008G1-MM
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 05:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVGPDHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 23:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGPDEm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 23:04:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262063AbVGPDER (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2005 23:04:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6G34AjA020203
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Jul 2005 20:04:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6G343wM015822;
	Fri, 15 Jul 2005 20:04:07 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42D86B92.7010303@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Jul 2005, H. Peter Anvin wrote:
> 
> Since it can be run as a sequestered user, and we now have plenty of CPU 
> horsepower on the download servers, it seems like it should be an 
> entirely sane thing to do.

Goodie.

> Is this thing meant to be run from inetd, or is it a "listen and fork" 
> daemon?

It can do both, now (since earlier today). Use the "--inetd" flag if you
run it from something like inetd that will have done the accept/fork for
it. In that case the "--port=xxx" argument obviously doesn't make any
sense.

There are "git-core-0.99.1" rpm (src, x86, ppc64 as usual) at

	http://www.kernel.org/pub/software/scm/git/

which are new enough that they already have the --inetd flag support.

> 		Especially the latter case, it absolutely *have* to have 
> protections for:
> 
> - "SYN and run" DoS attacks;
> - Too many connections from the same IP;
> - Too many processes running total.

Do you prefer just relying on inetd, or should I extend the server? inetd 
obviously involves an extra execve(), but on the other hand, it's a very 
very small program, so it's not like it's a huge expense (it does some 
very trivial parsing, and then it ends up executing "git-upload-pack").

Right now you're right - you definitely want to use inetd. I just realized
that my built-in server leaves zombies around, for example.

On the security front:

I've still not audited the full source and quite frankly I'd like somebody
else to do that since it's not only boring, but it's all my code, so I'm
blind to any bugs anyway.

But I _have_ straced a full sequence of the daemon side of a "git pull"  
and grepped every "open()", and they were all O_RDONLY, and every read()
from the incoming file descriptor was using the "packet-line" interface
which is designed to be safe too (ie there are no possibilities of
overflows there that I can see). 

			Linus
