From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 13:44:19 -0400
Message-ID: <20160426174418.GC7609@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
 <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
 <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com>
 <20160426171238.GA7609@sigill.intra.peff.net>
 <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:44:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av72J-00037p-1o
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcDZRoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:44:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:56659 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbcDZRoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:44:22 -0400
Received: (qmail 6534 invoked by uid 102); 26 Apr 2016 17:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:44:21 -0400
Received: (qmail 16192 invoked by uid 107); 26 Apr 2016 17:44:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:44:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 13:44:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292626>

On Tue, Apr 26, 2016 at 10:20:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I think this block (even before my patch) also needs to handle the
> > case where "value" is NULL (presumably by complaining with
> > config_error_nonbool).
> 
> OK, so squashes found to be necessary so far amounts to the attached
> patch.  I still haven't figured out the best way to rephrase the "by
> default" in the proposed log message that made me stutter while
> reading it, though.

I think that part is just trying to explain the implementation hackery.
Maybe something like:

  Note that `curl_easy_setopt(..., CURLOPT_HTTPHEADER, ...)` takes only
  a single list, overriding any previous call. This means we have to
  collect _all_ of the headers we want to use into a single list, and
  feed it to curl in one shot. Since we already unconditionally set a
  "pragma" header when initializing the curl handles, we can add our new
  headers to that list.

  For callers which override the default header list (like probe_rpc),
  we provide `http_copy_default_headers()` so they can do the same
  trick.

-Peff
