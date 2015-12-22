From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] create_symref: use existing ref-lock code
Date: Mon, 21 Dec 2015 19:58:24 -0500
Message-ID: <20151222005824.GB6901@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
 <20151220073414.GD30662@sigill.intra.peff.net>
 <xmqq8u4nfrvv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 01:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBBHd-0003rA-5q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 01:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbbLVA62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 19:58:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:45085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932162AbbLVA61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 19:58:27 -0500
Received: (qmail 16704 invoked by uid 102); 22 Dec 2015 00:58:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 18:58:26 -0600
Received: (qmail 25557 invoked by uid 107); 22 Dec 2015 00:58:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 19:58:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2015 19:58:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8u4nfrvv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282826>

On Mon, Dec 21, 2015 at 12:50:28PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  #ifndef NO_SYMLINK_HEAD
> > -	if (prefer_symlink_refs) {
> > -		unlink(ref_path);
> > -		if (!symlink(target, ref_path))
> > -			goto done;
> 
> I see that the original was sloppy (most certainly my bad) ...
> 
> > +	char *ref_path = get_locked_file_path(lock->lk);
> > +	unlink(ref_path);
> 
> ... and you inherited that.  I see a few seemingly related helpers
> in wrapper.c, but none looks useful in this context X-<.
> 
>     if (unlink_or_warn(ref_path))
>     	return -1;
> 
> is close enough, but it still lets the caller fallback to textual
> symref.

I don't think the original is _wrong_; it's meant to be "unlink if
needed", and the symlink call is what we really care about (if our
unlink failed for anything but ENOENT, the symlink will, too). But I
agree unlink_or_warn should do that and give us a nice warning (and
cover up ENOENT). To fall through, I think we just want (in the
original):

  if (!unlink_or_warn(ref_path) && !symlink(target, ref_path))
	goto done;

and in mine that becomes:

  int ret = -1;
  ...
  if (!unlink_or_warn(ref_path) && !symlink(target, ref_path))
	ret = 0;

I must confess I considered a follow-on patch to drop the
prefer_symlink_refs code path completely. I'm surprised it all still
works with packed-refs, etc, but resolve_ref does take special care to
use readlink().

-Peff
