From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 05:42:59 +0300
Message-ID: <20100214024259.GB9704@dpotapov.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 03:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgUTc-0006V3-Fq
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 03:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab0BNCnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 21:43:10 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:37659 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281Ab0BNCnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 21:43:09 -0500
Received: by fxm27 with SMTP id 27so156467fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/3XGuQjBTw4dsOuP41j60x/UhcVnWbM0VrV5I3efF/M=;
        b=gxeZo4MFRmu8EdrkTerB9EV8BmPAJegtr+YsXGNeDp8zBncJWmiz3Wlh2i5GJy/6EN
         Ql6DSl3jdVidrk/eCBCAxonRy/t1A7RMVAHi++Yiv6UldnMIF+/ttMU9YZqFHU8fYqIc
         nUT2077izTXFc8FlgZaiMk+xFMWaSbfe6u3RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TyaeSkT5RqokAHlhgOohXu3B/C8bgi6/VtNilsSflPkKuFHvpJDXf98a9kbK2ORJ6j
         PeKyeUkLutH8pbyhvBTZcJSmdcWsPgkX//At8/m35747q0wk73DylhqtIXEyDaRZupt0
         gC0F/tUuXnGt+SphA5fKBA4nvGmhiTlYkheMM=
Received: by 10.87.69.26 with SMTP id w26mr6012926fgk.39.1266115381719;
        Sat, 13 Feb 2010 18:43:01 -0800 (PST)
Received: from localhost (ppp91-76-16-167.pppoe.mtu-net.ru [91.76.16.167])
        by mx.google.com with ESMTPS id 12sm4748177fgg.12.2010.02.13.18.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 18:43:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139884>

On Sun, Feb 14, 2010 at 02:53:58AM +0100, Johannes Schindelin wrote:
> On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> 
> > +	if (strbuf_read(&sbuf, fd, 4096) >= 0)
> 
> How certain are you at this point that all of fd's contents fit into your 
> memory?

You can't be sure... In fact, we know mmap() also may fail for huge
files, so can strbuf_read(). Perhaps, mmap() behaves better when you
want to hash a huge file that does not fit in free physical memory, but
I do not think it is an important use case for any VCS, which mostly
stores small text files and a few not so big binary files. Git is not
design to store your video collection. (probably, Git can be improved to
handle big files better but I leave that exercise to those who want to
store their media files in Git).

> 
> And even if you could be certain, a hint is missing that strbuf_read(), 
> its name notwithstanding, does not read NUL-terminated strings. Oh, and 
> the size is just a hint for the initial size, and it reads until EOF. That 
> has to be said in the commit message.

I did not add _any_ new code, including the above line. It was there
before my patch. I only removed a few lines for the case when we used
mmap() and left the code that used strbuf_read() (mmap() was used for
regular files and strbuf_read() for other type of descriptors).

The fact that I re-aligned those lines could not introduce any bug, so
if you think this code incorrect then it was before my patch, but I do
not see why. And, I see no reason to comment on the code that does not
change at all (including that the third parameter of strbuf_read() is
just a hint). I may agree with you that strbuf_read with 'hint' is a bit
confusing, but it has nothing to do with my patch...


Dmitry
