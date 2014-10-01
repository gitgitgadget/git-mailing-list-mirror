From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] fdopen_lock_file(): access a lockfile using stdio
Date: Wed, 1 Oct 2014 08:48:47 -0400
Message-ID: <20141001124847.GB10772@peff.net>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
 <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 01 14:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZJL2-0004uX-70
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 14:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbaJAMst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 08:48:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:53654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbaJAMss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 08:48:48 -0400
Received: (qmail 22205 invoked by uid 102); 1 Oct 2014 12:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 07:48:48 -0500
Received: (qmail 26501 invoked by uid 107); 1 Oct 2014 12:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 08:48:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 08:48:47 -0400
Content-Disposition: inline
In-Reply-To: <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257747>

On Wed, Oct 01, 2014 at 01:14:47PM +0200, Michael Haggerty wrote:

> I thought about adding second stdio-oriented entrance points analogous
> to hold_lock_file_for_update(), hold_lock_file_for_append(), and
> reopen_lock_file(), but it seemed simpler to add just the one new
> function instead of three or four. If using stdio on lockfiles becomes
> more popular, we might want to add some helper functions to make it a
> bit more convenient.

I think it makes sense to wait until we see more potential callers crop
up.

> In close_lock_file(), if ferror() returns an error, then errno is not
> necessarily still set in a way that reflects the original error. I
> don't see a way to ensure that errno is set correctly in this
> situation. But hopefully, callers are monitoring their calls to
> fwrite()/fprintf() etc and will have noticed write errors on their own
> already. If anybody can suggest an improvement here, please let me
> know.

I was careful in the packed-refs stdio caller to check all of my fprintf
calls (because I was using fclose myself). I wonder if it would be nicer
to back off from that and just depend on the ferror() call at
commit-time. The exact value of errno is not usually that important
after the open() has succeeded.

> -static void remove_lock_files(void)
> +static void remove_lock_files(int skip_fclose)
>  {
>  	pid_t me = getpid();
>  
>  	while (lock_file_list) {
> -		if (lock_file_list->owner == me)
> +		if (lock_file_list->owner == me) {
> +			/* fclose() is not safe to call in a signal handler */
> +			if (skip_fclose)
> +				lock_file_list->fp = NULL;

I wondered when reading the commit message if it should mention this
signal-handling case (which you brought up in the cover letter). This
comment is probably enough, though.

> +FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
> +{
> +	if (!lk->active)
> +		die("BUG: fdopen_lock_file() called for unlocked object");
> +	if (lk->fp)
> +		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);

I would have expected calling this twice to be a noop (i.e., make the
function more "give me the associated filehandle, and create one if
necessary"). But I don't think any current callers should need that, so
it probably makes sense to play it safe and die("BUG"), at least for
now.

> +	if (fp) {
> +		lk->fp = NULL;
> +
> +		/*
> +		 * Note: no short-circuiting here; we want to fclose()
> +		 * in any case!
> +		 */
> +		err = ferror(fp) | fclose(fp);

Would this be more clear as:

	err = ferror(fp);
	err |= fclose(fp);

-Peff
