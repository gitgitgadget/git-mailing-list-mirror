From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Fri, 10 May 2013 19:34:34 +0200
Message-ID: <20130510173434.GA3154@sigill.intra.peff.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
 <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
 <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 19:34:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UarDP-00066v-4X
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 19:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3EJRej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 13:34:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:49789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749Ab3EJRej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 13:34:39 -0400
Received: (qmail 6829 invoked by uid 102); 10 May 2013 17:35:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 May 2013 12:35:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2013 19:34:34 +0200
Content-Disposition: inline
In-Reply-To: <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223884>

On Fri, May 10, 2013 at 10:02:51AM -0700, Junio C Hamano wrote:

> > Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
> > default and "--no-textconv" when given.
> [...]
> So "show" on blobs does show the raw contents by default, but the
> user can explicitly ask to enable textconv with --[no-]textconv.  Is
> the second paragraph in the log message still valid?

Yes, I had the same thought...

> > +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
> > +		die("Not a valid object name %s", obj_name);
> 
> This looks somewhat unfortunate.
> [...]
> I wonder if enriching rev_info->pending with the context information
> might be a clean solution to avoid this redundant but unavoidable
> conversion, but that is a separate and future topic, I think.

It would be, and indeed, that is similar to what the final patch does.
The problem is that it requires an extra allocation (we do not want to
unconditionally put the object_context into the object_array because it
is too big, so we add only a pointer). So having rev_info->pending store
that information would mean that callers would have to know to free it
when freeing the pending array. We would have to either teach each
existing caller to do so, or perhaps enable the behavior only when a
certain flag is set (e.g., rev->keep_object_context or something).

-Peff
