From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 21:04:27 -0500
Message-ID: <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 03:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0p3i-0007WC-VT
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbXLHCEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXLHCE3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:04:29 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:34332 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbXLHCE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:04:29 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7390748roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 18:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Hc398VoHrIQ04rJ149wThstpsAqsa3UpCSadd2Dn6LI=;
        b=Wb1oAto42sgLMDkb2mXcvTXa4CVneCqlTqqsVTS5D+PkNDQ2+HEZhcdE3Y+ARASjCBkA2IC0xDr8YzxaM70mkNP6FbDwQE2OTR1MB7Eb7FPeF/FxGuY5yyKwpUfXk1LVFHeWN3sfc9NghmEAyu5mzF6aqAePu8buqd2lKgte3oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oewbdh5fuRdkFLVlVCyihCUPZayM8IpluArNPhrnUXcWoMtuEjtrCbSbGnV+adwm28Vc5tEYvm0HxL2nT8cIPVBDR4JGy0a3C8koFR48EnF6f9hsfg+RPSSq+MHTvoSrGMGnBlbmreZ+Z98K4vvUA3bhqQePMUF7mvMJqVAu/V4=
Received: by 10.114.120.1 with SMTP id s1mr3952473wac.1197079467870;
        Fri, 07 Dec 2007 18:04:27 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 18:04:27 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67496>

On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 7 Dec 2007, Jon Smirl wrote:
>
> > Using this config:
> > [pack]
> >         threads = 4
> >         deltacachesize = 256M
> >         deltacachelimit = 0
>
> Since you have a different result according to the source pack used then
> those cache settings, even if there was a bug with them, are not
> significant.
>
> > And the 330MB gcc pack for input
> >  git repack -a -d -f  --depth=250 --window=250
> >
> > complete seconds RAM
> > 10%  47 1GB
> > 20%  29 1Gb
> > 30%  24 1Gb
> > 40%  18 1GB
> > 50%  110 1.2GB
> > 60%  85 1.4GB
> > 70%  195 1.5GB
> > 80%  186 2.5GB
> > 90%  489 3.8GB
> > 95%  800 4.8GB
> > I killed it because it started swapping
> >
> > The mmaps are only about 400MB in this case.
> > At the end the git process had 4.4GB of physical RAM allocated.
>
> That's really bad.
>
> > Starting from a highly compressed pack greatly aggravates the problem.
>
> That is really interesting though.
>
> > Starting with a 2GB pack of the same data my process size only grew to
> > 3GB with 2GB of mmaps.
>
> Which is quite reasonable, even if the same issue might still be there.
>
> So the problem seems to be related to the pack access code and not the
> repack code.  And it must have something to do with the number of deltas
> being replayed.  And because the repack is attempting delta compression
> roughly from newest to oldest, and because old objects are typically in
> a deeper delta chain, then this might explain the logarithmic slowdown.
>
> So something must be wrong with the delta cache in sha1_file.c somehow.

I applied the delta accounting patch. It took about 200MB of from the
memory use but that doesn't make a dent in 4GB of allocations.


-- 
Jon Smirl
jonsmirl@gmail.com
