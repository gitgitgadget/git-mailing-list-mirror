From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Expand ~ and ~user in core.excludesfile,
	commit.template
Date: Sat, 30 Aug 2008 02:02:00 -0400
Message-ID: <20080830060159.GA6826@coredump.intra.peff.net>
References: <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu> <20080827002506.GB7347@coredump.intra.peff.net> <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu> <7vy72jrr00.fsf@gitster.siamese.dyndns.org> <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu> <20080829032630.GA7024@coredump.intra.peff.net> <7vod3ca2ey.fsf@gitster.siamese.dyndns.org> <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sat Aug 30 08:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZJYe-0003lh-Vu
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 08:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYH3GCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 02:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbYH3GCE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 02:02:04 -0400
Received: from peff.net ([208.65.91.99]:2116 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbYH3GCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 02:02:03 -0400
Received: (qmail 19500 invoked by uid 111); 30 Aug 2008 06:02:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 30 Aug 2008 02:02:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2008 02:02:00 -0400
Content-Disposition: inline
In-Reply-To: <quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94358>

On Fri, Aug 29, 2008 at 02:29:00AM -0700, Karl Chen wrote:

>  core.excludesfile::
>  	In addition to '.gitignore' (per-directory) and
>  	'.git/info/exclude', git looks into this file for patterns
> -	of files which are not meant to be tracked.  See
> +	of files which are not meant to be tracked.  "~" and "~user"
> +	are expanded to the user's home directory.  See
>  	linkgit:gitignore[5].

How about:

  A leading "~" or "~user" is expanded to the home directory of the
  current user or "user", as in the shell.

Specifically:

  1. We obviously handle only leading cases, so /path/to/~file~with~tildes
     is ok.

  2. It was a little unclear to me whether both "~" and "~user" expande
     to the same thing. I.e., can one use this for arbitrary "user" (and
     the answer of course is yes).

> +char *expand_user_path(char *buf, const char *path, int bufsz)
> +{
> +	if (path == NULL)
> +		return NULL;
> +
> +	if (path[0] != '~')
> +		return concatstr(buf, path, NULL, bufsz);
> +
> +	const char *username = path + 1;
> +	size_t username_len = strchrnul(username, '/') - username;
> +	struct passwd *pw = getpw_str(username, username_len);

Declaration after statement (we try to remain portable to non-C99
systems).

Other than that, I think the patch is fine (though I am not opposed to
the improvements Junio has mentioned).

-Peff
