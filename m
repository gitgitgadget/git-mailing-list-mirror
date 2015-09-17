From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/10] run-command: factor out return value computation
Date: Thu, 17 Sep 2015 06:33:10 -0400
Message-ID: <20150917103310.GC20086@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 12:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcWVH-0006La-SY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 12:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbIQKdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 06:33:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:60710 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751160AbbIQKdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 06:33:13 -0400
Received: (qmail 18814 invoked by uid 102); 17 Sep 2015 10:33:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 05:33:13 -0500
Received: (qmail 28964 invoked by uid 107); 17 Sep 2015 10:33:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 06:33:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 06:33:10 -0400
Content-Disposition: inline
In-Reply-To: <1442453948-9885-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278106>

On Wed, Sep 16, 2015 at 06:39:00PM -0700, Stefan Beller wrote:

> +static int determine_return_value(int wait_status,
> +				  int *result,
> +				  int *error_code,
> +				  const char *argv0)
> +{
> +	if (WIFSIGNALED(wait_status)) {
> +		*result = WTERMSIG(wait_status);
> +		if (*result != SIGINT && *result != SIGQUIT)
> +			error("%s died of signal %d", argv0, *result);
> +		/*
> +		 * This return value is chosen so that code & 0xff
> +		 * mimics the exit code that a POSIX shell would report for
> +		 * a program that died from this signal.
> +		 */
> +		*result += 128;
> +	} else if (WIFEXITED(wait_status)) {
> +		*result = WEXITSTATUS(wait_status);
> +		/*
> +		 * Convert special exit code when execvp failed.
> +		 */
> +		if (*result == 127) {
> +			*result = -1;
> +			*error_code = ENOENT;
> +		}
> +	} else
> +		return 1;
> +	return 0;
> +}

Looks like we can return "0" or "1" here, and the exit code goes into
"result". But our caller:

>  static int wait_or_whine(pid_t pid, const char *argv0)
>  {
>  	int status, code = -1;
> @@ -244,29 +273,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>  	if (waiting < 0) {
>  		failed_errno = errno;
>  		error("waitpid for %s failed: %s", argv0, strerror(errno));
> -	} else if (waiting != pid) {
> -		error("waitpid is confused (%s)", argv0);
> -	} else if (WIFSIGNALED(status)) {
> -		code = WTERMSIG(status);
> -		if (code != SIGINT && code != SIGQUIT)
> -			error("%s died of signal %d", argv0, code);
> -		/*
> -		 * This return value is chosen so that code & 0xff
> -		 * mimics the exit code that a POSIX shell would report for
> -		 * a program that died from this signal.
> -		 */
> -		code += 128;
> -	} else if (WIFEXITED(status)) {
> -		code = WEXITSTATUS(status);
> -		/*
> -		 * Convert special exit code when execvp failed.
> -		 */
> -		if (code == 127) {
> -			code = -1;
> -			failed_errno = ENOENT;
> -		}
>  	} else {
> -		error("waitpid is confused (%s)", argv0);
> +		if (waiting != pid
> +		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))
> +			error("waitpid is confused (%s)", argv0);
>  	}

...is looking for "< 0", which will never happen. Should the "1" above
have been "-1"?

I also wondered what happened to "code" and "failed_errno" in that case.
They are OK to access because wait_or_whine() has set them to defaults,
but I wonder if determine_return_value should do so in every branch (so
it is is clear that the values are always defined when it returns).

-Peff
