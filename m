From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Add init-serve, the remote side of "git init
	--remote=host:path"
Date: Sat, 28 Feb 2009 22:16:09 -0500
Message-ID: <20090301031609.GA30384@coredump.intra.peff.net>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdcBR-0003iJ-QS
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbZCADQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbZCADQP
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:16:15 -0500
Received: from peff.net ([208.65.91.99]:36034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbZCADQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 22:16:14 -0500
Received: (qmail 28432 invoked by uid 107); 1 Mar 2009 03:16:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 22:16:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 22:16:09 -0500
Content-Disposition: inline
In-Reply-To: <1235865822-14625-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111809>

On Sat, Feb 28, 2009 at 04:03:41PM -0800, Junio C Hamano wrote:

> +/*
> + * Notice any command line argument that we may not want to invoke
> + * "git init" with when we are doing this remotely, and reject the
> + * request.
> + */
> +static int forbidden_arg(const char *arg)
> +{
> +	if (!prefixcmp(arg, "--shared=") ||
> +	    !strcmp(arg, "--shared") ||
> +	    !strcmp(arg, "--bare"))
> +		return 0;
> +	return 1;
> +}

I started this mail to complain that this function was "disallow known
bad" instead of "allow known good". But then after reading it carefully
three times, I see that it is in fact "not allow known good". Can we
make it "allowed_arg" to prevent double negation?

> +		/*
> +		 * NEEDSWORK: I do not currently think it is worth it,
> +		 * but this might want to set up and use the sideband
> +		 * to capture and send output from the child back to
> +		 * the requestor.  At least this comment needs to be removed
> +		 * once we make the decision.
> +		 */
> +		child.stdout_to_stderr = 1;

I guess there is a potential information leak to say "directory does not
exist" versus "permission denied". Stopping such leaks often ends up
creating more harm (in confused users who don't know why it failed) than
good, but I think the fetch protocol is intentionally quiet here.

...

Actually, I just checked. Over ssh, you get:

  $ git fetch host:/nonexistent
  fatal: '/foo': unable to chdir or not a git archive
  fatal: The remote end hung up unexpectedly

But over git://, you get:

  $ git fetch git://host/nonexistent
  fatal: The remote end hung up unexpectedly

which I think is just because ssh relays stderr but the git daemon does
not.

So we are leaking the information to people authenticated via ssh (who
still might not be trusted or have full shell access, but are more
likely to be), but not to the whole world.

> +		/*
> +		 * NEEDSWORK: we might want to distinguish various
> +		 * error codes from run_command() and return different
> +		 * messages back.  I am too lazy to be bothered.
> +		 */
> +		if (run_command(&child))
> +			errmsg = "bad";

I think this somewhat falls into the same category as above (though
perhaps the information is less interesting).

-Peff
