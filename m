From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 14/22] lockfile: use strbufs when handling (most) paths
Date: Tue, 1 Apr 2014 16:28:11 -0400
Message-ID: <20140401202811.GH21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:28:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV5I9-0007gL-Vr
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaDAU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:28:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:52075 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751707AbaDAU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:28:13 -0400
Received: (qmail 22755 invoked by uid 102); 1 Apr 2014 20:28:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:28:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:28:11 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-15-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245656>

On Tue, Apr 01, 2014 at 05:58:22PM +0200, Michael Haggerty wrote:

>  /*
> - * p = path that may be a symlink
> - * s = full size of p
> - *
> - * If p is a symlink, attempt to overwrite p with a path to the real
> - * file or directory (which may or may not exist), following a chain of
> - * symlinks if necessary.  Otherwise, leave p unmodified.
> + * path contains a path that may be a symlink
>   *
> - * This is a best-effort routine.  If an error occurs, p will either be
> - * left unmodified or will name a different symlink in a symlink chain
> - * that started with p's initial contents.
> + * If path is a symlink, attempt to overwrite it with a path to the
> + * real file or directory (which may or may not exist), following a
> + * chain of symlinks if necessary.  Otherwise, leave path unmodified.
>   *
> - * Always returns p.
> + * This is a best-effort routine.  If an error occurs, path will
> + * either be left unmodified or will name a different symlink in a
> + * symlink chain that started with path's initial contents.
>   */
> -
> -static char *resolve_symlink(char *p, size_t s)
> +static void resolve_symlink(struct strbuf *path)
> [...]

This is not a problem you are introducing, but do we really want
resolve_symlink to be best-effort here?

What happens if "a" is a symlink to "b", and two processes try to lock
"a" simultaneously? If one succeeds, it will take "b.lock". But the
other will take "a.lock", and both will think they have the target
locked.

I suspect we need to recognize ENOENT for cases where we are creating
the file for the first time, but it seems like we should bail on locking
from any other transient errors.

-Peff
