From: Jeff King <peff@peff.net>
Subject: Re: [RFC 16/17] object_array_entry: copy name before storing in name
 field
Date: Mon, 20 May 2013 12:44:58 -0400
Message-ID: <20130520164458.GA27788@sigill.intra.peff.net>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
 <1368995232-11042-17-git-send-email-mhagger@alum.mit.edu>
 <CALKQrgeZ3yOogZhumQ6sQ=7B4XoEUDxPNt6Lj7ZAs13oJTOeUA@mail.gmail.com>
 <519A365E.6020807@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 20 18:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeTCy-0000Ai-9A
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 18:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab3ETQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 12:45:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:59785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757475Ab3ETQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 12:45:03 -0400
Received: (qmail 26655 invoked by uid 102); 20 May 2013 16:45:35 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 May 2013 11:45:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 May 2013 12:44:58 -0400
Content-Disposition: inline
In-Reply-To: <519A365E.6020807@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224962>

On Mon, May 20, 2013 at 04:42:38PM +0200, Michael Haggerty wrote:

> >> * Many callers store the empty string ("") as the name; for example,
> >>   most of the entries created during a run of rev-list have "" as
> >>   their name.  This means that lots of needless copies of "" are being
> >>   made.  I think that the best solution to this problem would be to
> >>   store NULL rather than "" for such entries, but I haven't figured
> >>   out all of the places where the name is used.
> > 
> > Use strbufs?
> > 
> > No allocation (except for the strbuf object itself) is needed for
> > empty strings, and string ownership and be transferred to and from it
> > to prevent extra copies.
> 
> That would cost two extra size_t per object_array_entry.  I have the
> feeling that this structure is used often enough that the extra overhead
> would be a disadvantage, but I'm not sure.
> 
> The obvious alternative would be to teach users to deal with NULL and
> either add another constructor alternative that transfers string
> ownership or *always* transfer string ownership and change the callers
> to call xstrdup() if they don't already own the name string.  I think I
> will try that approach first.

You could use the same trick that strbuf does: instead of NULL, point to
a well-known empty string literal. Readers do not have to care about
this optimization at all; only writers need to recognize the well-known
pointer value. And since we do not update in place but only eventually
free, it really is just that anyone calling free() would do "if (name !=
well_known_empty_string)".

-Peff
