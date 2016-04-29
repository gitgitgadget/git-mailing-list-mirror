From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 08:12:28 -0400
Message-ID: <20160429121228.GA27952@sigill.intra.peff.net>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
 <57230F71.2020401@alum.mit.edu>
 <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
 <57233E19.4000200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7Hl-0003x4-AQ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbcD2MMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:12:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753281AbcD2MMc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:12:32 -0400
Received: (qmail 1866 invoked by uid 102); 29 Apr 2016 12:12:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 08:12:31 -0400
Received: (qmail 20457 invoked by uid 107); 29 Apr 2016 12:12:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 08:12:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 08:12:28 -0400
Content-Disposition: inline
In-Reply-To: <57233E19.4000200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292986>

On Fri, Apr 29, 2016 at 12:57:29PM +0200, Michael Haggerty wrote:

> Remember, we're talking about rename_ref() only, not reference deletion
> in general. rename_ref() is not very robust anyway--it doesn't happen in
> a single transaction, and it is vulnerable to being defeated by
> simultaneous reference updates by other processes. It *does* wrap the
> deletion of newrefname in a transaction; the only question is whether an
> old_sha1 is supplied to that transaction.
> 
> So, suppose that newrefname starts at value A, and there are two updates
> running simultaneously:
> 
> 1. An update of reference newrefname from A -> B
> 
> 2. A rename of reference oldrefname to newrefname, which includes
>    a. read_ref_full("newrefname") and
>    b. delete_ref("newrefname").

I wondered at first if you meant "oldrefname" in 2b. That is, a rename
would involve writing to "newrefname" and then deleting "oldrefname",
and not doing the old_sha1 and normal locking on the deletion of
oldrefname would be bad (in case somebody else updated it while we were
operating).

But reading the patch again, that's not what's going on. You're talking
just about the case where we force-overwrite an existing newrefname, and
delete it first to do so. But what I don't understand is:

  1. Why do we read_ref_full() at all? Since it is not done under lock
     anyway, it is useless for helping with race conditions, and I think
     that is what you are arguing (that we should just be deleting
     regardless). But then why not just call delete_ref(), and handle
     the ENOENT case as a noop (which closes another race if somebody
     deletes it between your 2a and 2b).

  2. Why delete it at all? The point is to overwrite, so I guess it is
     trying to make room. But we could just rename the loose ref file
     and reflog overtop the old, couldn't we?

Or am I totally misreading the purpose of this code?

-Peff
