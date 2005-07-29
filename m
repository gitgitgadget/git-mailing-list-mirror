From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] mmap error handling
Date: Thu, 28 Jul 2005 17:30:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507281725440.3307@g5.osdl.org>
References: <1122586842.17837.9.camel@dv> <118833cc05072816294f80a829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 02:32:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyInI-0007GE-3J
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 02:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVG2Abu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 20:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVG2Abu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 20:31:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262217AbVG2Aag (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 20:30:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6T0UUjA016260
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Jul 2005 17:30:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6T0UTGm031221;
	Thu, 28 Jul 2005 17:30:29 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc05072816294f80a829@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Jul 2005, Morten Welinder wrote:
>
> > I have verified that successful close() after failed mmap() won't reset
> > the output of perror() to "Success".
> 
> Does $standard guarantee that?
> 
> In general, successful libc calls can set errno to whatever they
> please, except zero.  And they sometimes do.  This follows from
> C99.

Indeed. 

_always_ save the value of errno before doing any other calls. Even 
successful calls are perfectly allowed to change errno.

"close()" may not _normally_ change errno, but the fact is, not only can 
close sometimes return an error, but it could validly have some debugging 
wrapper that does logging, and change errno because of that.

Yeah, we'd be better off if UNIX had always used the linux kernel practice
of hiding errno as a negative return value (and the "IS_ERR()" test for
pointers), but hey, crud happens to the best of us.

		Linus
