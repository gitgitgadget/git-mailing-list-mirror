From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t5528: do not fail with FreeBSD shell
Date: Sun, 8 Mar 2015 22:19:20 -0700
Message-ID: <211E8F7E-5588-45B1-ACF6-BB7DFB798ABB@gmail.com>
References: <e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c> <20150308175624.GA30399@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 06:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUq6D-0002nB-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 06:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbCIFTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 01:19:25 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44038 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbCIFTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 01:19:24 -0400
Received: by padet14 with SMTP id et14so45886609pad.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 22:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=pNWuTtPmDfC/Xc4zprCmN8mWiWJOhRykOl+iEhv4UxY=;
        b=K3xP6r1u/8HGUuEhm8wgHt5dT06msrUEbxoaS3dXZWiup+jhTjaZDZvPUtXCccS0GK
         7IwCKGh5hLX26p51geggFr96OAHkMsyDg4T6FZx+reBSQokI5jhsmEyLmLRUvMgyPxqS
         5X1jPGn+R2dAcSLaTX0d3glbLHw7CU60sRYNj5Nb/e5RXVueAHqLSQO5bdj4xeRV+yhP
         4BFny/DYRA+32BJvhQ7bxGDcFajsLDW27PAsQSXCHeVYFkN6uZgm60n2b2uB4X7Gs2sP
         MbqrCYq3e2Ve0FaHjLu7Bbf5T3MDCWkbn/cx4pSAPfZSsLrJVWM2TnQJbZKIzcYwUA7O
         9aGg==
X-Received: by 10.66.217.198 with SMTP id pa6mr49836369pac.49.1425878364241;
        Sun, 08 Mar 2015 22:19:24 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fm3sm16958006pab.29.2015.03.08.22.19.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 22:19:23 -0700 (PDT)
In-Reply-To: <20150308175624.GA30399@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265125>

On Mar 8, 2015, at 10:56, Jeff King wrote:
> On Sun, Mar 08, 2015 at 08:37:50AM -0700, Kyle J. McKay wrote:
>
>> The FreeBSD shell converts this expression:
>>
>>  git ${1:+-c push.default="$1"} push
>>
>> to this when "$1" is not empty:
>>
>>  git "-c push.default=$1" push
>>
>> which causes git to fail.
>
> Hmph, just when I thought I knew about all of the weird shell  
> quirks. :)
>
> I am not convinced this isn't a violation of POSIX (which specifies  
> that
> field splitting is done on the results of parameter expansions outside
> of double-quotes). But whether it is or not, we have to live with it.

That's not the only problem the shell has, t5560 had an issue, rebase  
had issues.  They've have been worked around.  It probably also  
affects related BSDs' shells as well (at least older versions that  
didn't change the shell).

> For my own curiosity, what does:
>
>  foo='with space'
>  printf "%s\n" ${foo:+first "$foo"}
>
> print? That is, are the double-quotes even doing anything on such a
> shell? On bash and dash, it prints:
>
>  first
>  with space
>
> which is what I would expect.


$ foo='with space'
$ printf "%s\n" ${foo:+first "$foo"}
first with space

I also happen to have a handy-dandy test program called "showargs".

$ foo='with space'
$ showargs ${foo:+first "$foo"}
uid=1001 euid=1001
gid=1001 egid=1001
umask(octal)=022
stdin=/dev/pts/12 stdout=/dev/pts/12 stderr=/dev/pts/12
pid=5261
$0=showargs
$1=first with space

So no quotes are being passed on.  Of course bash works just fine.

> So does "ash" (0.5.7, packaged for
> Debian), which is what I _thought_ FreeBSD's shell was based on. But
> clearly there is some divergence.

I like to test on FreeBSD 8, which is slightly older, once in a while  
to make sure I catch stuff like this.  :)

Running "ident /bin/sh" shows a bunch of source file names which  
matches up pretty well with the dash distribution so I'm pretty sure  
it's just a much older ancestor of dash/ash.

If I run dash 0.5.6 (installed via FreeBSD ports), it works properly  
too.

> I guess they are getting eaten by your shell, otherwise we would pass
> them along to git in the test script, which would complain.

When I run t5528 with -v -x -d -i this is where it dies (without the  
fix):

+ git '-c push.default=upstream' push
Unknown option: -c push.default=upstream

So yeah, the quotes are gone, but no word-splitting occurred.
