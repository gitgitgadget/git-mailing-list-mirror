From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 08:31:57 +0100
Message-ID: <81b0412b0511222331tc43057aqfd942afdebea052c@mail.gmail.com>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com>
	 <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
	 <20051122230011.GA2916@steel.home> <4383A66D.2030201@etek.chalmers.se>
	 <20051122233845.GC2916@steel.home> <4383AFDB.90907@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 08:34:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eep7r-0003BL-Pm
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVKWHdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 23 Nov 2005 02:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVKWHdE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:33:04 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:7565 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1030346AbVKWHdB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 02:33:01 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.202])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id jAN7WxxP006944
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 23:32:59 -0800
Received: by nproxy.gmail.com with SMTP id l37so210406nfc
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 23:31:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUcizC6E9VWv3xTShifl4C3RssgGrI/ewksCm6Y/LkmxCYSR4GWpiT3KqtRuQAU6Kd+HbhMstuk+lNr0Q7Uo4dWeJbRTWdQcCUxP+gkXY7jScXuT3tTM7W6N1MiJhf2HgIfP+YCg/KDQ3ydSHaztg65nSyRNOVApyqWfHLUu+RI=
Received: by 10.48.30.4 with SMTP id d4mr1354nfd;
        Tue, 22 Nov 2005 23:31:57 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 22 Nov 2005 23:31:57 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <4383AFDB.90907@etek.chalmers.se>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12610>

On 11/23/05, Lukas Sandstr=F6m <lukass@etek.chalmers.se> wrote:
> >>>>I think making allocation/deallocation to the central place is a
> >>>>good cleanup, but I am not sure about the free-nodes reusing.
> >>>>Does this make difference in real life?
> >>>
> >>>It definitely does, though nor very much. I have no real numbers a=
t
> >>>hand (being home now), but I remember it was 1 min with against 3 =
min
> >>>without the patch on cygwin+fat32, which is already bad enough all=
 by
> >>>itself. Very big repository with no redundant packs in it.
> >>
> >>Would you mind sharing the .idx files?
> >
> > this time I probably would (they're not here)... But for a perfoman=
ce
> > testing any big repository will do, linux kernel, for example.
> >
> The problem is that the large repository I have contains lots of
> redundant packs, which makes quite fast to find a complete set
> and end the search. If you don't have any redundant packs, the
> complete set search really is 2**n (n =3D the number of packs).
>
> I did some quick experiments with slab allocation and got a 4.4%
> improvement on the redundant repo, so that might be worth persuing.
> (Concept patch below)
>

I don't have the old packs anymore, but I benchmarked all three
allocation types anyway:

malloc/free:

$ time git-pack-redundant --all --alt-odb
real    0m0.092s
user    0m0.108s
sys     0m0.015s

simple node reuse (the patch in official tree):

$ time git-pack-redundant --all --alt-odb
real    0m0.074s
user    0m0.093s
sys     0m0.015s

slab node allocation (your concept patch):

$ time git-pack-redundant --all --alt-odb
real    0m0.031s
user    0m0.046s
sys     0m0.015s

This repository has one pack and 17758 files.
