From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 14:46:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412081431540.13845@s15462909.onlinehome-server.info>
References: <20141208054812.GA30154@peff.net> <20141208055706.GA30207@peff.net> <20141208112835.GA15919@lanh> <alpine.DEB.1.00.1412081232500.13845@s15462909.onlinehome-server.info> <20141208114740.GA16658@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxye9-0007bx-RB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbaLHNqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 08:46:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:52480 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaLHNqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:46:35 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LbPza-1Xa94p2M5i-00kvhy;
 Mon, 08 Dec 2014 14:46:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141208114740.GA16658@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:z2cnMFU6eB5eiAX5Rs5VVc/4ifmtPLzbUaE+LMuYd0on/LyihpM
 AB02NBJkX7LKL9EjB2liwF9DU8SVE/7Yav/mjbKLBWGQDjXm2Ni67iLn3jgvTOxN0UDOWMK
 d5udqYMF9qq+oF48CY15SHBgoR9dhOpQ004rs83133FK02/aczH3GOC59FUOAkphYh0/HbE
 yPXO656kEElkoYOn0Wx8A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261016>

Hi Peff,

On Mon, 8 Dec 2014, Jeff King wrote:

> On Mon, Dec 08, 2014 at 12:35:27PM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 8 Dec 2014, Duy Nguyen wrote:
> > 
> > > On Mon, Dec 08, 2014 at 12:57:06AM -0500, Jeff King wrote:
> > > > I do admit that I am tempted to teach index-pack to always NUL-terminate
> > > > objects in memory that we feed to fsck, just to be on the safe side. It
> > > > doesn't cost much, and could prevent a silly mistake (either in the
> > > > future, or one that I missed in my analysis).
> > > 
> > > I think I'm missing a "but.." here.
> > 
> > The "but..."s I have are:
> > 
> > 1) we potentially waste space, and
> 
> I think this can be ignored. It's 1 byte per object, and only while we
> keep the object in RAM. Also, we already do it for buffers read from
> read_sha1_file, so when you run "git log" every commit buffer we keep in
> RAM is already doing this (and has been since basically day one).

Fine with me.

> > 2) I would like to make really certain, preferably with static analysis,
> >    that fsck_object() only receives buffers that are NUL terminated, and
> >    that no call path is missed.
> 
> I know this is not as good as a real static analysis, but I was
> concerned about this exact thing about a year ago (I think in relation
> to commit parsing for pretty-printing) and traced all of the paths
> through which you can get an object; they all end up in the same few
> code paths that all xmallocz: unpack_sha1_file for loose objects,
> unpack_compressed_entry for pack bases, and patch_delta for deltas.

Thank you for sharing the analysis. This is exactly what I was looking
for.

> Index-pack and unpack-objects are the odd men out here because they are
> processing objects that are not actually in the repository yet. I think
> the spots Duy pointed out probably cover index-pack. It looks like
> builtin/unpack-objects.c:get_data needs the same treatment.

I just started working on that. To see the progress, please have a look
here:

	https://github.com/dscho/git/pull/5

Ciao,
Dscho
