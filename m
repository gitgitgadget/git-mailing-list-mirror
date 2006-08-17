From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 13:17:33 -0400
Message-ID: <9e4733910608171017k628ef754s4fcd075d60aaf062@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <20060817040719.GC18500@spearce.org>
	 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
	 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 19:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDlUw-0007OR-Tt
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWHQRRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWHQRRf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:17:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:39319 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030183AbWHQRRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 13:17:34 -0400
Received: by nz-out-0102.google.com with SMTP id n1so389251nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 10:17:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VehcAN3rgfdpRjd9RLtjG9f6ixJuGIc/XQUrBbei3wuyRqIsgFo6deaFI9a2eLDV2Q7UUAtt8gEv2qcfEqU3KvOy9dEn7Gh06JxGQBypFeBw4yZXGu1We8zixTZ/nSDujyVFU8N2dH+HXzezg/G698o7MjXd9R8pvC/pWLBFxno=
Received: by 10.65.237.1 with SMTP id o1mr2499691qbr;
        Thu, 17 Aug 2006 10:17:33 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Thu, 17 Aug 2006 10:17:32 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25593>

On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 17 Aug 2006, Jon Smirl wrote:
>
> > On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > At least, the delta-chains should be limited by size (_not_ by number of
> > > deltas: you can have huge deltas, and if you have to unpack 5 huge deltas
> > > before getting to the huge delta you really need, it takes really long).
> >
> > This is not an obvious conclusion.
>
> The big win is bought by having _one_ zlib stream for multiple deltas,
> right?
>
> So, everytime you want to access the _last_ delta in the chain, you unpack
> _all_ of them. This quite obvious conclusion is obviously your reason to
> propose two packs, one for the archive of "old" objects, and one for the
> "new" objects.

Do some measurements, the IO vs CPU time trade off is way in favor of
eliminating the IO. It really doesn't take very much CPU to unpack the
delta chain.

The two pack proprosal was not about reducing the delta chain length;
they are reverse deltas, the newest version is always at the front.
Two packs are used to avoid repacking the 280MB pack when you do a
repack command. It takes 2-3 hours to repack 280MB. Even if if you
just copy the old pack to the new it take 30 minutes to do all of the
IO.

> > As for public servers there is an immediate win in shifting to the new
> > pack format.  Three hour downloads vs one hour, plus the bandwidth
> > bills. Are the tools smart enough to say this is a newer pack format,
> > upgrade? It takes far less than two hours to upgrade your git install.
>
> Have you thought about a non-upgraded client? The server has to repack in
> that case, and if the client wants a clone, you might not even have the
> time to kiss your server good-bye before it goes belly up.

Is there a pack format version number built into the server procotol?
If not there needs to be one. When there is a mismatch with the server
pack version the client should simply display an error requesting an
upgrade of the client software.

Git should be designed for forward evolution, not infinite backward
compatibility. It is easy to upgrade your client to support the new
protocol. The protocol just needs to ensure that the client reliably
gets an error about the need to upgrade.

Forward evolution implies that a client is able to work with older
servers, but not the inverse, that new servers have to work with old
clients.

> There is an obvious choice here as to how fast people would upgrade their
> servers.
>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
