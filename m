From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 22/44] fetch.c: clear errno before calling functions
 that might set it
Date: Fri, 16 May 2014 19:04:50 -0400
Message-ID: <20140516230450.GB3988@sigill.intra.peff.net>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-23-git-send-email-sahlberg@google.com>
 <20140516183348.GC12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 01:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlRBQ-000495-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 01:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbaEPXEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 19:04:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:53466 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756446AbaEPXEw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 19:04:52 -0400
Received: (qmail 19322 invoked by uid 102); 16 May 2014 23:04:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 18:04:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 19:04:50 -0400
Content-Disposition: inline
In-Reply-To: <20140516183348.GC12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249431>

On Fri, May 16, 2014 at 11:33:48AM -0700, Jonathan Nieder wrote:

> (cc-ing peff, who may remember this STORE_REF_ERROR_DF_CONFLICT case
>  from long ago)

No, but I have very good tools for searching the list archive. ;)

> > In s_update_ref there are two calls that when they fail we return an error
> > based on the errno value. In particular we want to return a specific error
> > if ENOTDIR happened. Both these functions do have failure modes where they
> > may return an error without updating errno
> 
> That's a bug.  Any function for which errno is supposed to be
> meaningful when it returns an error should always set errno.
> Otherwise errno may be set to ENOTDIR within the function by an
> unrelated system call.

I'd agree. It's OK for a function not to set errno if it is
_successful_. But if setting errno on error is part of the interface for
lock_any_ref_for_update, it should do so consistently.

We have not been very good about documenting which functions use errno,
or using it consistently (e.g., in my original patch, we are explicitly
converting errno into a numeric return value!), so I can definitely see
how it is confusing.

> That should cover the cases affecting the code path in fetch.c you
> mentioned (I haven't checked the others).
> 
> How about something like this?
> [...]

Yeah, I think this is a better direction.

> diff --git i/refs.c w/refs.c
> index 82a8d4e..f98acf0 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -1333,8 +1333,10 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
>  	if (flag)
>  		*flag = 0;
>  
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +		errno = EINVAL;
>  		return NULL;
> +	}

check_refname_format comes up in a few places. I wonder if it should set
EINVAL itself.

Other than that, I just skimmed through your list. All looked
reasonable to me, though I was not thorough enough to be sure we got
call cases (OTOH, we can add them later on top).

-Peff
