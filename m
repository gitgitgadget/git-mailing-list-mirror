From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC/GSoC 1/3] path.c: implement xdg_runtime_dir()
Date: Wed, 16 Mar 2016 13:06:23 -0400
Message-ID: <20160316170623.GB4039@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:06:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEtz-0002Lg-JA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbcCPRG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:06:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:60671 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753687AbcCPRG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:06:26 -0400
Received: (qmail 7443 invoked by uid 102); 16 Mar 2016 17:06:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:06:25 -0400
Received: (qmail 15561 invoked by uid 107); 16 Mar 2016 17:06:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:06:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 13:06:23 -0400
Content-Disposition: inline
In-Reply-To: <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288994>

On Wed, Mar 16, 2016 at 06:07:43PM +0800, Hui Yiqun wrote:

> +	if (runtime_dir && *runtime_dir)
> +		git_runtime_dir = mkpathdup("%s/git/", runtime_dir);
> +	else
> +		git_runtime_dir = mkpathdup("/tmp/git-%d", uid);

Here we allocate the string, but later we may return NULL on error,
leaking the allocated memory.

> +	if (!lstat(git_runtime_dir, &st)) {
> +		/*
> +		 * As described in XDG base dir spec[1], the subdirectory
> +		 * under $XDG_RUNTIME_DIR or its fallback MUST be owned by
> +		 * the user, and its unix access mode MUST be 0700.
> +		 *
> +		 * Calling chmod or chown silently may cause security
> +		 * problem if somebody chdir to it, sleep, and then, try
> +		 * to open our protected runtime cache or socket.
> +		 * So we just put warning and left it to user to solve.
> +		 *
> +		 * [1]https://specifications.freedesktop.org/basedir-spec/
> +		 * basedir-spec-latest.html
> +		 */

OK. I think these checks should be sufficient to deal with the /tmp race
I mentioned elsewhere in the thread (assuming that an attacker cannot
flip the uid back and forth in the same way, but that should be true on
Unix systems).

> +		if ((st.st_mode & 0777) != S_IRWXU) {
> +			fprintf(stderr,
> +					"permission of runtime directory '%s' "
> +					"MUST be 0700 instead of 0%o\n",
> +					git_runtime_dir, (st.st_mode & 0777));
> +			return NULL;
> +		} else if (st.st_uid != uid) {
> +			fprintf(stderr,
> +					"owner of runtime directory '%s' "
> +					"MUST be %d instead of %d\n",
> +					git_runtime_dir, uid, st.st_uid);
> +			return NULL;
> +		}

Should these be using warning(), rather than a raw fprintf?

> +	} else {
> +		if (safe_create_leading_directories_const(git_runtime_dir) < 0) {
> +			fprintf(stderr,
> +					"unable to create directories for '%s'\n",
> +					git_runtime_dir);
> +			return NULL;
> +		}
> +		if (mkdir(git_runtime_dir, 0700) < 0) {
> +			fprintf(stderr,
> +					"unable to mkdir '%s'\n", git_runtime_dir);
> +			return NULL;
> +		}
> +	}

And this retains the un-racy mkdir(). Good.

> +	free(git_runtime_dir);
> +	return mkpathdup("%s/%s", git_runtime_dir, filename);

This mkpathdup accesses the string we just freed?

It might be easier to just use a strbuf here, and then you can append to
it at the end.

-Peff
