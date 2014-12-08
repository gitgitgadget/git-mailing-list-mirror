From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 06:47:40 -0500
Message-ID: <20141208114740.GA16658@peff.net>
References: <20141208054812.GA30154@peff.net>
 <20141208055706.GA30207@peff.net>
 <20141208112835.GA15919@lanh>
 <alpine.DEB.1.00.1412081232500.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxwn3-0000sC-U5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbaLHLrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 06:47:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:49905 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755148AbaLHLrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:47:41 -0500
Received: (qmail 13306 invoked by uid 102); 8 Dec 2014 11:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 05:47:42 -0600
Received: (qmail 22670 invoked by uid 107); 8 Dec 2014 11:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 06:47:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 06:47:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1412081232500.13845@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261013>

On Mon, Dec 08, 2014 at 12:35:27PM +0100, Johannes Schindelin wrote:

> On Mon, 8 Dec 2014, Duy Nguyen wrote:
> 
> > On Mon, Dec 08, 2014 at 12:57:06AM -0500, Jeff King wrote:
> > > I do admit that I am tempted to teach index-pack to always NUL-terminate
> > > objects in memory that we feed to fsck, just to be on the safe side. It
> > > doesn't cost much, and could prevent a silly mistake (either in the
> > > future, or one that I missed in my analysis).
> > 
> > I think I'm missing a "but.." here.
> 
> The "but..."s I have are:
> 
> 1) we potentially waste space, and

I think this can be ignored. It's 1 byte per object, and only while we
keep the object in RAM. Also, we already do it for buffers read from
read_sha1_file, so when you run "git log" every commit buffer we keep in
RAM is already doing this (and has been since basically day one).

> 2) I would like to make really certain, preferably with static analysis,
>    that fsck_object() only receives buffers that are NUL terminated, and
>    that no call path is missed.

I know this is not as good as a real static analysis, but I was
concerned about this exact thing about a year ago (I think in relation
to commit parsing for pretty-printing) and traced all of the paths
through which you can get an object; they all end up in the same few
code paths that all xmallocz: unpack_sha1_file for loose objects,
unpack_compressed_entry for pack bases, and patch_delta for deltas.

Index-pack and unpack-objects are the odd men out here because they are
processing objects that are not actually in the repository yet. I think
the spots Duy pointed out probably cover index-pack. It looks like
builtin/unpack-objects.c:get_data needs the same treatment.

I know that Duy mentioned a while ago killing off unpack-objects and
rolling its functionality into index-pack. That would be a very nice
thing to do if somebody can find the time. There's a fair bit of
duplication, and index-pack receives a lot more attention (so it's
faster, and probably more robust against weird incoming packs).

-Peff
