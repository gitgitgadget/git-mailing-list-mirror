From: John Keeping <john@keeping.me.uk>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 20:30:46 +0100
Message-ID: <20130530193046.GG17475@serenity.lan>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
 <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
 <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
 <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <kernel-hacker@bennee.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 21:31:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui8Yx-0007l1-1p
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759583Ab3E3Ta7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 15:30:59 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48034 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759374Ab3E3Ta6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 15:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BE0C0CDA595;
	Thu, 30 May 2013 20:30:57 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPRR8+Vhc1Xg; Thu, 30 May 2013 20:30:54 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B1FF2CDA5D1;
	Thu, 30 May 2013 20:30:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226032>

On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
> Alex Benn=E9e <kernel-hacker@bennee.com> writes:
>=20
> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
> >> Alex Benn=E9e <kernel-hacker@bennee.com> writes:
> >>
> >>>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse=
3
> >>>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
> >>>  10.39%   git  libz.so.1.2.3.4     [.] adler32
> >>>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
> >>
> >> Do you have any large blobs in the repo that are referenced direct=
ly by
> >> a tag?
> >
> > Most probably. I've certainly done a bunch of releases (which are t=
agged) were
> > the last thing that was updated was an FPGA image.
> [...]
> >> git-describe should probably be fixed to avoid loading blobs, thou=
gh I'm
> >> not sure off hand if we have any infrastructure to infer the type =
of a
> >> loose object without inflating it.  (This could probably be added =
by
> >> inflating only the first block.)  We do have this for packed objec=
ts, so
> >> at least for packed repos there's a speedup to be had.
> >
> > Will it be loading the blob for every commit it traverses or just o=
nes that hit
> > a tag? Why does it need to load the blob at all? Surely the commit
> > tree state doesn't
> > need to be walked down?
>=20
> No, my theory is that you tagged *the blobs*.  Git supports this.

You can see if that is the case by doing something like this:

    eval $(git for-each-ref --shell --format '
        test $(git cat-file -t %(objectname)^{}) =3D commit ||
        echo %(refname);')

That will print out the name of any ref that doesn't point at a commit.
