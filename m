From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 02:10:49 -0500
Message-ID: <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
References: <20071206071503.GA19504@coredump.intra.peff.net>
	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
	 <20071206173946.GA10845@sigill.intra.peff.net>
	 <20071206.193121.40404287.davem@davemloft.net>
	 <20071207063848.GA13101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Miller" <davem@davemloft.net>, nico@cam.org,
	dberlin@dberlin.org, harvey.harrison@gmail.com,
	ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0XMg-0005yf-8P
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbXLGHKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXLGHKy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:10:54 -0500
Received: from ro-out-1112.google.com ([72.14.202.180]:39613 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbXLGHKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:10:53 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7019435roc
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 23:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oEI0CvVGkfz21IB50Km2ojIR5URQacBJBzuI7hAbEtk=;
        b=US80NljPPHy4UR3VLI6Cl6FhSvVFidAcG3wOfRtIdorVSP96YDYvePq23qYODgc1PzvGsZiYRyHHO/Yfk4pPC++aM1vg6DRxOVduLjzM4dAeXObA/ssoDFMWCa4L3ptizuViB+n7lqSJs/24KNY8apJiKy5RArEiFNDObTNZY1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KiM19/DcXfJF7OjsH5ilBZWcugKJxlrGsqU6xfbtL0+YWDnJJ++FeErC01u+ooh7mjbgpdCsiRrI5ww+UY8HBASAOIQZZXXKeAqed2dLyPvToyk/Bq7gfT9MTRTyKNaikWtqdcRMVb2NHOxUe1DQ0Luy7djPgF+Q2IpQuhNWx9s=
Received: by 10.114.176.1 with SMTP id y1mr2453991wae.1197011450169;
        Thu, 06 Dec 2007 23:10:50 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 23:10:49 -0800 (PST)
In-Reply-To: <20071207063848.GA13101@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67390>

On 12/7/07, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 06, 2007 at 07:31:21PM -0800, David Miller wrote:
>
> > > So it is about 5% bigger. What is really disappointing is that we saved
> > > only about 20% of the time. I didn't sit around watching the stages, but
> > > my guess is that we spent a long time in the single threaded "writing
> > > objects" stage with a thrashing delta cache.
> >
> > If someone can give me a good way to run this test case I can
> > have my 64-cpu Niagara-2 box crunch on this and see how fast
> > it goes and how much larger the resulting pack file is.
>
> That would be fun to see. The procedure I am using is this:
>
> # compile recent git master with threaded delta
> cd git
> echo THREADED_DELTA_SEARCH = 1 >>config.mak
> make install
>
> # get the gcc pack
> mkdir gcc && cd gcc
> git --bare init
> git config remote.gcc.url git://git.infradead.org/gcc.git
> git config remote.gcc.fetch \
>   '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'
> git remote update
>
> # make a copy, so we can run further tests from a known point
> cd ..
> cp -a gcc test
>
> # and test multithreaded large depth/window repacking
> cd test
> git config pack.threads 4

64 threads with 64 CPUs, if they are multicore you want even more.
you need to adjust chunk_size as mentioned in the other mail.


> time git repack -a -d -f --window=250 --depth=250
>
> -Peff
>


-- 
Jon Smirl
jonsmirl@gmail.com
