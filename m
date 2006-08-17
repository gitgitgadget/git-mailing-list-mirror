From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 10:36:29 -0400
Message-ID: <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
	 <20060817040719.GC18500@spearce.org>
	 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 16:36:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDizA-000898-Hk
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 16:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWHQOgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWHQOgd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 10:36:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:46662 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932503AbWHQOga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 10:36:30 -0400
Received: by nz-out-0102.google.com with SMTP id n1so346247nzf
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 07:36:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GUDwv2doq7/pmL3Cy+5CNmP4NanWdwdwHaZTRfJPEtF5NYTC/NiLtWckmOc9+Qhlnk8NyKtIOkxF03jlRtiBHekUm1dlY40h2OBTNti/yUrvpPygkXpzgc0ldjbYxxX7TxBnXi5jwceIzSL+VHnoxU+gO/byy4UcyLWIBdIIBUw=
Received: by 10.65.237.15 with SMTP id o15mr2267597qbr;
        Thu, 17 Aug 2006 07:36:29 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Thu, 17 Aug 2006 07:36:29 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25586>

On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> At least, the delta-chains should be limited by size (_not_ by number of
> deltas: you can have huge deltas, and if you have to unpack 5 huge deltas
> before getting to the huge delta you really need, it takes really long).

This is not an obvious conclusion. Reducing our pack from 845MB to
292MB eliminates a huge amount of IO. All of the work I am doing with
this pack has been totally IO bound. The CPU time to get from one
delta to another is minor compared to the IO time increase if you
break the chains up. Each time you break the chain you have to store a
full copy of the file, the IO increase from doing this out weighs the
CPU time reduction.

I would use a two pack model. One pack holds the 292MB archive and the
second pack is made from recent changes. They can both be the same
format since the chains in the second pack won't be very long. We
might want to put a flag into an archive pack that tells git-repack
not to touch it by default.

As for public servers there is an immediate win in shifting to the new
pack format.  Three hour downloads vs one hour, plus the bandwidth
bills. Are the tools smart enough to say this is a newer pack format,
upgrade? It takes far less than two hours to upgrade your git install.

-- 
Jon Smirl
jonsmirl@gmail.com
