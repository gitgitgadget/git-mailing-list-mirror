From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: avoid excessive re-reading of pack directory
Date: Tue, 9 Jun 2015 13:41:06 -0400
Message-ID: <20150609174106.GB32034@peff.net>
References: <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net>
 <20150605122921.GA7586@peff.net>
 <20150609172436.GA32034@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Tue Jun 09 19:41:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NWX-0007zP-2W
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbbFIRlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:41:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:43509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752304AbbFIRlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 13:41:10 -0400
Received: (qmail 17638 invoked by uid 102); 9 Jun 2015 17:41:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 12:41:10 -0500
Received: (qmail 17486 invoked by uid 107); 9 Jun 2015 17:41:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 13:41:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2015 13:41:06 -0400
Content-Disposition: inline
In-Reply-To: <20150609172436.GA32034@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271206>

On Tue, Jun 09, 2015 at 01:24:36PM -0400, Jeff King wrote:

> I tested this on my system, and confirmed that for a "git clone
> --no-local --bare git.git":
> 
>   1. It cuts the number of openat/getdents/close syscalls by several
>      orders of magnitude.
> 
>   2. The overall time drops from ~11.4s to ~10.5s. I suppose if I timed
>      only the `index-pack` process, it would be even higher (as a
>      percentage improvement).

Just for fun, I did a "git pack-objects --all --stdout" from linux.git,
and then timed "git index-pack --stdin" on it in an empty repo. With a
configured alternate pointing to another empty repo, just to make it
more unfair. And then I stored it all on a ramdisk to emphasize the cost
of the syscalls versus hitting the disk. The numbers I got were:

  [before]
  real    2m13.093s
  user    3m31.884s
  sys     0m55.208s

  [after]
  real    1m40.389s
  user    3m10.776s
  sys     0m26.012s

That's sort of a ridiculous test, but it does show that this was having
some impact even on "normal" systems without insane syscall latencies.

-Peff
