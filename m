From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Tue, 31 Mar 2009 11:23:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311117400.10279@pacific.mpi-cbg.de>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <200903300526.12978.chriscool@tuxfamily.org> <alpine.DEB.1.00.0903300951460.7534@intel-tinevez-2-302> <200903310845.23674.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1778000052-1238491398=:10279"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaB3-00071K-Uq
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbZCaJVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbZCaJVE
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:21:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:35877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751150AbZCaJVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:21:02 -0400
Received: (qmail invoked by alias); 31 Mar 2009 09:20:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 31 Mar 2009 11:20:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TuNQRIXbTlDc7zaaZFh6c1ioUhuq2dOGFQY0WG8
	ojvS4vMC6lfe67
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903310845.23674.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115235>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1778000052-1238491398=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 31 Mar 2009, Christian Couder wrote:

> Le lundi 30 mars 2009, Johannes Schindelin a écrit :
>
> > On Mon, 30 Mar 2009, Christian Couder wrote:
> > > Le jeudi 26 mars 2009, Junio C Hamano a écrit :
> > > >
> > > > I've learned to suspect without reading a qsort() callback that 
> > > > does not derefence its arguments.  Is this doing the right thing?
> > >
> > > I think so.
> >
> > I suspect something much worse: you are trying to build a list of 
> > sha1s of commits that need to be skipped, later to look up every 
> > commit via binary search.
> >
> > But it has been proven a lot of times that using a hash set is 
> > superior to that approach, and even better: we already have the 
> > framework in place in the form of struct decorate.
> 
> I had a look, and "struct decorate" can be used to store objects, but I 
> want to store only sha1s.

No, you want to _look up_ sha1s.  And struct decorate is not about storing 
objects, but to attach things to objects.  From decorate.h:

	struct object_decoration {
	        const struct object *base;
	        void *decoration;
	};

So, if you just do

	struct decoration all_the_sha1s;

	...

		add_decoration(&all_the_sha1s, &commit->object, sha1);

you can look up the sha1 much more efficiently than with binary searches 
like this:

		unsigned char *sha1 = lookup_decoration(&all_the_sha1s,
			&commit->object);

Ciao,
Dscho

--8323328-1778000052-1238491398=:10279--
