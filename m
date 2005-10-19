From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 17:43:55 -0700
Message-ID: <435596CB.6070401@zytor.com>
References: <435560F7.4080006@zytor.com> <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org> <435591A3.7030708@zytor.com> <Pine.LNX.4.64.0510181728490.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES23y-0007Ho-Qh
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVJSAoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVJSAoL
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:44:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51099 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932334AbVJSAoJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 20:44:09 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9J0i0V7012449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 17:44:01 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181728490.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10248>

Linus Torvalds wrote:
> And just appending ".git" is _not_ badly designed/specified. I did think 
> about the boundary cases, and it's entirely safe:
> 
>  - it can't result in "surprises": if the original pathname doesn't exist, 
>    then even if there is a race and it got created in between the two 
>    chdir's as a directory and the name had a slash at the end, adding 
>    ".git" is actually safe even if it succeeds: it won't take us anywhere 
>    surprising. At worst it will take us to the ".git" directory of a newly 
>    added git archive, but that's what we wanted anyway, so..
> 
>  - you can't create ".." with it - even if the passed-in filename ended 
>    with "xyz/.", you'll end up with a perfectly safe "xyz/..git", so any 
>    safety checks that were done on the original pathname are still valid 
>    when appending ".git" to it.
> 
>  - and exactly because we don't append slashes or anything like that, the 
>    end result won't even have anything ambiguous like "//" in it.
> 
> So it really doesn't have any downsides that I can see.
> 

Consider the whitelist/blacklist scenario I described in the previous 
email.  You have:

whitelist:	/pub/scm
blacklist:	/pub/scm/foo/bar.git

If you can bypass the blacklist by using the pathname /pub/scm/foo/bar, 
that's bad.

> 
>>The DWIM aspect is fine, of course, but it has to be done up front: instead of
>>doing just chdir(), each path should be validated through path_ok() before
>>even being considered for chdir().  Perhaps the right thing to do is to
>>combine the two functions.
> 
> Sure, you could do that, and just replace path_ok + chdir with a 
> "safe_chdir()". I don't really see the point, unless you want to walk the 
> path one component at a time, though (which is really quite expensive).
> 

The only reason to do that is to make it less likely that a future 
programmer would screw it up.

	-hpa
