From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 18:51:05 +0200
Message-ID: <81b0412b0707260951h57fc91dbsd5a0a126f0e16fee@mail.gmail.com>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
	 <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
	 <200707260115.13234.robin.rosenberg.lists@dewire.com>
	 <alpine.LFD.0.999.0707251636490.3607@woody.linux-foundation.org>
	 <81b0412b0707260542o58fcb73bu81ae09aa1df84c81@mail.gmail.com>
	 <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Michal Rokos" <michal.rokos@gmail.com>, GIT <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE6YW-0004wz-SN
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 18:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762995AbXGZQvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762609AbXGZQvJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 12:51:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49888 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXGZQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 12:51:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so564361ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 09:51:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gbrr//mTbjxpZlAOx2zuie6fQTV2jgYK5hEeXU/TtcHqAInkjaIcNFx2n0ASh3Ztc464w6wYgRClXwm7CY/ylNaw8X3EyHwBWIb7Td3W6K5dcu+DtLKwhIBpNvkzorc7uIi3HzoC1K6IUPjqkA33hriDBP/RfZcSCrxGTLM9Bd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pEuW+72ms4LNFL4+kgBs2+uMHwVDTrwaHU9m3J/TO8heG6jGpAXfAEXu2NBJ3S08egV/E+8ys/72ZPq8Ws+H5MWf3LfQOwb5GqUzJuAuTZ+Rc9YIPiN8ULR5ndpJxm2iYB2nQpBWZ8XfMkmDBTn7GXqMKa3DXwXsGbzpshS1AMU=
Received: by 10.78.170.6 with SMTP id s6mr478294hue.1185468665616;
        Thu, 26 Jul 2007 09:51:05 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 26 Jul 2007 09:51:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707260911040.3442@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53843>

On 7/26/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 26 Jul 2007, Alex Riesen wrote:
> > >
> > > It's true that pread() is used much less than normal reads, and maybe the
> > > cygwin pread() is indeed broken. But it's intriguing how apparently both
> > > HP-UX and Cygwin are showing the same breakage.
> >
> > Maybe because neither _has_ POSIX pread?
>
> HP-UX? No pread()? It wouldn't link if it didn't have pread(). So it
> clearly has pread(), it's just somehow broken.

I remember it didn't and was emulated with lseek.

> > This is cygwin's pread, I believe:
> >
> > http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_disk_file.cc?rev=1.225&content-type=text/x-cvsweb-markup&cvsroot=src
>
> I'm not saying that's great programming, but the "git_pread()" that git
> will use in the absense of a real pread() is actually even *less* of a
> POSIX pread, since it doesn't even try to save/restore the old position
> (it knows that git doesn't care).

Not that. I meant the value read returned wasn't checked nor returned.
Suppose read failed (on Windows it happens all the time, especially if you
stress it a bit) - you'll never know it did and the buffer will contain either
garbage or previous data. Now imagine we _did_ have a past-eof
condition or bleeding into sign-bit (because of some 64-bit confusion)...

> So I don't think that explains why git doesn't like cygwin's pread. I
> suspect an earlier version of cygwin had an even more broken version of
> pread at some point.

Yep, that could be another reason.
