From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-push.c: make CURLOPT_IOCTLDATA a usable pointer
Date: Sat, 12 Jul 2014 00:46:46 -0400
Message-ID: <20140712044646.GA20675@sigill.intra.peff.net>
References: <53b8918c.ca6d320a.7df8.18ac@mx.google.com>
 <53b89d7a.030d320a.0760.206f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Abbaad Haider <abbaad@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 06:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pD2-0001e1-A0
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbaGLEqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:46:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:60611 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751259AbaGLEqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:46:48 -0400
Received: (qmail 18882 invoked by uid 102); 12 Jul 2014 04:46:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 23:46:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 00:46:46 -0400
Content-Disposition: inline
In-Reply-To: <53b89d7a.030d320a.0760.206f@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253380>

On Sat, Jul 05, 2014 at 08:43:48PM -0400, Abbaad Haider wrote:

> Fixes a small bug affecting push to remotes which use some sort of
> multi-pass authentication. In particular the bug affected SabreDAV as
> configured by Box.com [1].

Thanks. This looks like it was caused by the refactor in ebaaf31
(http-push: refactor curl_easy_setup madness, 2011-05-03), which moved
the curl_easy call into a sub-function which took the buffer as a
pointer, rather than accessing it as a local variable.

> It must be a weird server configuration for the bug to have survived
> this long. Someone should write a test for it.

I think both dumb-http push-over-DAV and multi-pass authentication are
rare, so finding a combination of the two took a while. I do not know
enough about the server setup to know whether we could replicate this in
our test apache setup (and nor do I particularly want to spend a lot of
time figuring it out for the sake of testing push-over-DAV).

> diff --git a/http-push.c b/http-push.c
> index f2c56c8..bd42895 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -199,7 +199,7 @@ static void curl_setup_http(CURL *curl, const char *url,
>  	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
>  #ifndef NO_CURL_IOCTL
>  	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> -	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, &buffer);
> +	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);

Patch looks obviously correct.
