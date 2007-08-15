From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 15:42:51 -0400
Message-ID: <9e4733910708151242q5ba020adkbe5d207f93be0f4c@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
	 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
	 <20070815171152.GA15155@auto.tuwien.ac.at>
	 <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
	 <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILOln-0006nR-Qi
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXHOTmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764500AbXHOTmz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:42:55 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:30594 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760882AbXHOTmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:42:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so26921rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 12:42:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HO+jmHeEZllRFhtTeCCRbXG4paId5cAGyQcVsVNSqOiNubdfgaXgDj2sXSzzewiV6mLFEu4h2q7ll9rD+ESlaCPsYENsQvapPiBzuzFbI+rsG4zUhVpsUNX43mSzSJKznm2iXSyNDSKKwMShdLRbdtaCFRH5LqUIqbhofMKK/0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mu0kE66WHzSLvHPCOntfl8KJutuDRopye9qWg/islAbTXoigPZGbGp50BcCLmjBLiY4GCYkkTK35BB3ixsyFp7p2yABDVlfUnhurwAGubHUztUGyeqU9aGK6RPTcOeJ1Zf81+ex8J/qin9/UuvPWDVPAGfTKhAPUCAPdglXoGfg=
Received: by 10.114.106.1 with SMTP id e1mr978054wac.1187206971897;
        Wed, 15 Aug 2007 12:42:51 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 15 Aug 2007 12:42:51 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55942>

On 8/15/07, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 15 Aug 2007, Jon Smirl wrote:
>
> > On 8/15/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > > git-pack-objects knows the order, in which it will use the objects.  A
> > > seperate thread could pre-read the next object and wait until the main
> > > thread starts processing it. After the read is complete, another
> > > thread could start computing the delta index.
> >
> > The hope is that the new adaptive read ahead code in the kernel will
> > get this right and you won't need the second thread. Letting the
> > kernel handle the read ahead will dynamically scale as other demands
> > are made on the host. There's effectively only one read ahead cache in
> > the system, only the kernel really knows how to divide it up between
> > competing apps.
>
> No read ahead will ever help the delta search phase.  Objects listed for
> deltification against each other are sorted in a way that results in
> reads from completely random location in the object store.
>
> Normally the delta search phase is so compute intensive that the read
> shouldn't matter much.

I agree, I am compute bound for 20 min, disk light occasionally dimly flickers.

Besides, the main thread that is preparing the queue effectively
functions as a read ahead thread. It will overlap with the compute
bound delta searches.

>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
