From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Tue, 16 Oct 2012 13:25:02 -0400
Message-ID: <20121016172502.GC27243@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
 <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net>
 <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
 <20121016053750.GA22281@sigill.intra.peff.net>
 <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
 <7vtxtus58h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:25:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAtM-0004kt-2c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab2JPRZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:25:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55132 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab2JPRZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:25:06 -0400
Received: (qmail 17757 invoked by uid 107); 16 Oct 2012 17:25:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 13:25:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 13:25:02 -0400
Content-Disposition: inline
In-Reply-To: <7vtxtus58h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207857>

On Tue, Oct 16, 2012 at 10:21:02AM -0700, Junio C Hamano wrote:

> > I suppose we could do the way unpack-objects does: prefer present
> > objects and drop the new identical ones, no memcmp. Objects that are
> > not bases, or are ref-delta bases, can be safely dropped. ofs-delta
> > bases may lead to rewriting the pack. Do-able but not sure it's worth
> > the effort.
> 
> Until you read all the incoming pack data, you won't know what
> objects are used as bases for others, so unless you are keeping
> everything in core, you would have to spool the incoming data to a
> file and then rewrite the final pack file to "drop" these "can be
> safely dropped" objects, with or without offset delta encoding.

By definition, you know that you have another copy of these objects
(that is why you are dropping them). So you could treat later delta
references to them the same as thin-pack references, and re-add your
existing on-disk copy of the object to the end of the pack.

But still...the complexity is ugly, and we do not even have a measured
problem in the real world. This is not worth thinking about. :)

-Peff
