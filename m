From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as for "ln" / "cp"
Date: Thu, 5 Feb 2015 12:41:00 -0800
Message-ID: <4CF52072-713F-4456-B894-B874B0EFFC6B@gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com> <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com> <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com> <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com> <20150205195143.GB15326@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTEj-0008Jy-Fq
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbbBEUlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:41:06 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39008 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbbBEUlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:41:04 -0500
Received: by pdbfl12 with SMTP id fl12so9905322pdb.6
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=9gXntw6wtaZoCPTc510T7hQ29Vdb44Oy19LN89gWxYU=;
        b=MvSRBMAkIXSc01oJ47OmRF5MtDVdKJbe9+JaGSEy9PVNtGMhia7SV7P02Cr3UweiSU
         iIC99jV6fCzyByHq3XKEcF0TR8GxNSAnUSDFYve+L2VrHq2oGA1W3JSuzX4g6Wpq1rN3
         tqwGWUfywfz2Lga4ZKkDP/G2yQ0p71U5UEDus+DnVdaT4TsNmUCRyipD/MPFdIxGwclw
         eIjkyeagtHGyQNRmT7sm7o5sRPTMdoYpZbAbZenk+g3J+8SOKcXh4Dws8u9TToq/9MlX
         pg1A2UuBZmQe9qF9XUsFUQG6KepG4Y5gILH+4hqwXgQSe9KKyUPzc0TwOE53P5bgXKqH
         nKeQ==
X-Received: by 10.68.68.168 with SMTP id x8mr5314pbt.154.1423168863612;
        Thu, 05 Feb 2015 12:41:03 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id di10sm5952305pad.41.2015.02.05.12.41.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Feb 2015 12:41:03 -0800 (PST)
In-Reply-To: <20150205195143.GB15326@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263400>

On Feb 5, 2015, at 11:51, Jeff King wrote:
> On Thu, Feb 05, 2015 at 08:26:08PM +0100, Sebastian Schuberth wrote:
>
>>> It is not even correct, is it?
>>>
>>> When DESTDIR is set to allow you to install into a temporary place
>>> only so that you can "tar" up the resulting filesystem tree, bindir
>>> points at the location we need to "cp" the built programs into, i.e.
>>> inside DESTDIR.
>>
>> Agreed folks, please disregard this as well as 2/2 of this series.
>
> We would still want an equivalent to 2/2 to set up a relative symlink
> for $(ALL_PROGRAMS), though, right?

It's this line here:

>                 ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \

But since bindir and execdir can be configured to be arbitrary paths  
you must compute the relative path between them in order to create a  
relative symlink.  In principle you just remove the common directory  
prefix, remove the non-directory part from the destination, change any  
remaining directories in the destination to '..' and then append  
what's left of the source to get the new source.

So if you have

   bindir=/usr/local/bin
   execdir=/usr/local/libexec/git-core

And the ln line would be:

   ln /usr/local/bin/git /usr/local/libexec/git-core/git

1) Strip the common prefix which is /usr/local/

   source = bin/git
   dest = libexec/git-core/git

2) remove non-directory part of dest (the basename part) and replace  
remaining dirs with '..'

   source = bin/git
   dest = ../../

3) append source to dest and you get

   ../../bin/git

So the symlink line becomes:

   ln -s ../../bin/git /usr/local/libexec/git-core/git

Now, can you do that easily in a Makefile? ;)

And lastly there's the issue of which should be the symlink and which  
should be the binary?

Should /usr/local/bin/git be the symlink or the binary?

If it's the binary, then /usr/local/libexec/git-core/git will be a  
symlink to it.  But we're already installing several other symlinks to  
'git' in /usr/local/libexec/git-core so they will need to traverse two  
symlinks to get to the binary rather than just the one.

That seems suboptimal.

On the other hand if /usr/local/bin/git becomes the symlink then we  
have a user-facing binary that's a symlink.  As generally it's the  
bindir that ends up in the PATH.

I'm not sure exactly why, but I think:

On Jan 30, 2015, at 13:10, Junio C Hamano wrote:
> That would make me feel dirty.


Having a user-facing binary that is actually a symlink can potentially  
cause problems on OS X if the binary it refers to locates its  
libraries using a relative path.  Not sure if that's the case on other  
systems or not.

Neither of these is probably a show-stopper (two-symlinks-to-binary or  
user-facing-symlink-binary) assuming the magic relative symlink  
computation can be worked out.

But it does not surprise me that those items were allowed to skip  
making a symlink and just go directly to cp.

-Kyle
