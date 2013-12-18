From: Jeff King <peff@peff.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 14:17:02 -0500
Message-ID: <20131218191702.GA9083@sigill.intra.peff.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtMcM-0002Z0-0i
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab3LRTRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:17:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:46818 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755766Ab3LRTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:17:04 -0500
Received: (qmail 368 invoked by uid 102); 18 Dec 2013 19:17:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 13:17:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 14:17:02 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239470>

On Wed, Dec 18, 2013 at 10:00:35AM -0800, Junio C Hamano wrote:

> Joey Hess <joey@kitenet.net> writes:
> 
> > In sha1_file.c, when git is built on linux, it will use 
> > getrlimit(RLIMIT_NOFILE). I've been deploying git binaries to some
> > unusual systems, like embedded NAS devices, and it seems some with older
> > kernels like 2.6.33 fail with "fatal: cannot get RLIMIT_NOFILE: Bad address".
> >
> > I could work around this by building git without RLIMIT_NOFILE defined,
> > but perhaps it would make sense to improve the code to fall back
> > to one of the other methods for getting the limit, and/or return the
> > hardcoded 1 as a fallback. This would make git binaries more robust
> > against old/broken/misconfigured kernels.
> 
> Hmph, perhaps you are right.  Like this?
> 
>  sha1_file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index daacc0c..a3a0014 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -809,8 +809,12 @@ static unsigned int get_max_fd_limit(void)
>  #ifdef RLIMIT_NOFILE
>  	struct rlimit lim;
>  
> -	if (getrlimit(RLIMIT_NOFILE, &lim))
> -		die_errno("cannot get RLIMIT_NOFILE");
> +	if (getrlimit(RLIMIT_NOFILE, &lim)) {
> +		static int warn_only_once;
> +		if (!warn_only_once++)
> +			warning("cannot get RLIMIT_NOFILE: %s", strerror(errno));
> +		return 1; /* see the caller ;-) */
> +	}

I wish we understood why getrlimit was failing. Returning EFAULT seems
like an odd choice if it is not implemented for the system. On such a
system, do the other fallbacks actually work? Would it work to do:

diff --git a/sha1_file.c b/sha1_file.c
index daacc0c..ab38795 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -809,11 +809,11 @@ static unsigned int get_max_fd_limit(void)
 #ifdef RLIMIT_NOFILE
 	struct rlimit lim;
 
-	if (getrlimit(RLIMIT_NOFILE, &lim))
-		die_errno("cannot get RLIMIT_NOFILE");
+	if (!getrlimit(RLIMIT_NOFILE, &lim))
+		return lim.rlim_cur;
+#endif
 
-	return lim.rlim_cur;
-#elif defined(_SC_OPEN_MAX)
+#if defined(_SC_OPEN_MAX)
 	return sysconf(_SC_OPEN_MAX);
 #elif defined(OPEN_MAX)
 	return OPEN_MAX;

That is, does sysconf actually work on such a system (or does it need a
similar run-time fallback)? And either way, we should try falling back
to OPEN_MAX rather than 1 if we have it.

As far as the warning, I am not sure I see a point. The user does not
have any useful recourse, and git should continue to operate as normal.
Having every single git invocation print "by the way, RLIMIT_NOFILE does
not work on your system" seems like it would get annoying.

-Peff
