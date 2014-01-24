From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 21:26:21 -0500
Message-ID: <20140124022621.GB4521@sigill.intra.peff.net>
References: <52E080C1.4030402@fb.com>
 <20140123225238.GB2567@sigill.intra.peff.net>
 <52E1A99D.6010809@fb.com>
 <CAFFjANQ6JkxqSfQaOXF29ETW9ecMXVQTz3x86h_tDjsRdT80HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Siddharth Agarwal <sid0@fb.com>, git <git@vger.kernel.org>
To: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 03:26:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6WTU-0006Fk-9d
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 03:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbaAXC0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 21:26:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:37969 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751408AbaAXC0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 21:26:23 -0500
Received: (qmail 17120 invoked by uid 102); 24 Jan 2014 02:26:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 20:26:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 21:26:21 -0500
Content-Disposition: inline
In-Reply-To: <CAFFjANQ6JkxqSfQaOXF29ETW9ecMXVQTz3x86h_tDjsRdT80HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240993>

On Fri, Jan 24, 2014 at 12:56:17AM +0100, Vicent Mart=C3=AD wrote:

> On Fri, Jan 24, 2014 at 12:45 AM, Siddharth Agarwal <sid0@fb.com> wro=
te:
> > Yes, we'd prefer to do that too. How do you actually do this, thoug=
h? I
> > don't see a way to pass `--honor-pack-keep` (shouldn't I pass in it=
s
> > inverse?) down to `git-pack-objects`.
>=20
> We run with this patch in production, it may be of use to you:
> https://gist.github.com/vmg/8589317
>=20
> In fact, it may be worth upstreaming too. I'll kindly ask peff to do
> it when he has a moment.

I was actually looking at it earlier when I sent this message. The
tricky thing about the patch is that it turns off --honor-pack-keep, bu=
t
does _not_ teach git-repack to clean up the .keep file.

Which I think is the right and safe thing to do, as otherwise you might
blow away a pack with .keep, even though you did not just pack its
objects (i.e., because it was written by a fetch or push which did not
yet update the refs). So the safe thing is to actually duplicate those
objects, leave the .keep pack around, and then assume it will get
cleaned up on the next repack.

If you _do_ have a stale .keep file, though, then that stale pack will
hang around forever (presumably with its objects duplicated in the
"real" pack).

So I think the patch is doing the right thing, but I was still figuring
out how to explain it (and I hope I just did). I'll post it with a full
commit message tomorrow.

-Peff
