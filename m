From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 10:26:59 -0700
Message-ID: <435D1963.8070205@zytor.com>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org> <86irvmzyq9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org> <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 19:29:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU66s-0004FI-9m
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 19:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJXR1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVJXR1Q
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 13:27:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16559 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751188AbVJXR1O
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 13:27:14 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9OHR3uX011741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 10:27:04 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10550>

Linus Torvalds wrote:
> 
> Side note: "safe in practice" isn't necessarily the same as "safe in 
> theory".
> 
> I think that strictly speaking, if you include <ctype.h>, the "isxxxx()" 
> format is always reserved (where "x" is lowercase letters), and in theory 
> you could have a compiler that recognizes them even before the 
> pre-processor as being something built-in.
> 
> In _practice_, such a compiler would be incredibly broken (it would have 
> to do the recognition after preprocessing too), and I doubt you'd ever see 
> such a thing, but from a pure language-lawyer standpoint it might 
> technically be possible.
> 

A much more likely cause for problems would be system headers that use 
the isxxx() macros as part of other macros.  That would be in violation 
of POSIX, but is reasonably common.

> However, I'm surprised that you see <ctype.h> at all. The OpenBSD headers 
> seem to be including <ctype.h> from <sys/poll.h>, which doesn't make any 
> sense. It may not be strictly against POSIX, but it's definitely strange 
> and bad form to do unnecessary name pollution that the user didn't ask 
> for.

It is strictly against POSIX, but again, fairly common.

> So git actually tries to be pretty good about things. Not only does it try 
> to handle any existing system <ctype.h> by doing the #undef, it actually 
> doesn't include the system ctype.h at _all_ when it includes "cache.h". 
> And OpenBSD is being a bit strange.

I think there is another good reason for doing the renaming bit: we're 
creating new macros with different semantics; in particular, the git 
macros handle signed char input and don't guarantee anything w.r.t. EOF.

	-hpa
