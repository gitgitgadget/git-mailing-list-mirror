From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 05:59:23 -0400
Message-ID: <20160325095923.GB8880@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:59:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOWi-0006ea-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcCYJ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 05:59:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:38111 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbcCYJ70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:59:26 -0400
Received: (qmail 5807 invoked by uid 102); 25 Mar 2016 09:59:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 05:59:26 -0400
Received: (qmail 22315 invoked by uid 107); 25 Mar 2016 09:59:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 05:59:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 05:59:23 -0400
Content-Disposition: inline
In-Reply-To: <1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289870>

On Wed, Mar 23, 2016 at 06:13:22PM +0800, Hui Yiqun wrote:

> +/**
> + * this function does the following:
> + *
> + * 1. if $XDG_RUNTIME_DIR is non-empty, `$XDG_RUNTIME_DIR/git` is used in next
> + * step, otherwise `/tmp/git-$uid` is taken.
> + * 2. ensure that above directory does exist. what's more, it must has correct
> + * permission and ownership.
> + * 3. a newly allocated string consisting of the path of above directory and
> + * $filename is returned.
> + *
> + * Under following situation, NULL will be returned:
> + *
> + * + the directory mentioned in step 1 exists but have wrong permission or
> + * ownership.
> + * + the directory or its parent cannot be created.
> + *
> + * Notice:
> + *
> + * + the caller is responsible for deallocating the returned string.
> + *
> + */
> +extern char *xdg_runtime_dir(const char *filename);

There's a lot of "what" here that the caller doesn't really care about,
and which may go stale with respect to the implementation over time. Can
we make something more succinct like:

  /*
   * Return a path suitable for writing run-time files related to git,
   * or NULL if no such path can be established. The resulting string
   * should be freed by the caller.
   */

?

> --- a/path.c
> +++ b/path.c
> @@ -5,6 +5,7 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "dir.h"
> +#include "git-compat-util.h"

Why do we need this? It should generally be the first file included, as
it sets up defines used by other header files. It looks like we include
"cache.h" in this file, which is enough (it explicitly includes
git-compat-util.h first to cover this case).

> +char *xdg_runtime_dir(const char *filename)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char *runtime_dir;
> +	struct stat st;
> +	uid_t uid = getuid();
> +
> +	assert(filename);
> +	runtime_dir = getenv("XDG_RUNTIME_DIR");
> +	if (runtime_dir && *runtime_dir)
> +		strbuf_mkpath(&sb, "%s/git/", runtime_dir);
> +	else
> +		strbuf_mkpath(&sb, "/tmp/git-%d", uid);
> +
> +	if (!lstat(sb.buf, &st)) {
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

There are some minor English problems here (and elsewhere). E.g., you
probably want "So we just issue a warning and leave it to the user to
solve.".

> +		if ((st.st_mode & 0777) != S_IRWXU) {
> +			warning("permission of runtime directory '%s' "
> +					"MUST be 0700 instead of 0%o\n",
> +					sb.buf, (st.st_mode & 0777));
> +			return NULL;
> +		} else if (st.st_uid != uid) {
> +			warning("owner of runtime directory '%s' "
> +					"MUST be %d instead of %d\n",
> +					sb.buf, uid, st.st_uid);
> +			return NULL;
> +		}

These cases still leak "sb", I think.

> +		/* TODO: check whether st.buf is an directory */

Should we complete this todo? It's should just be S_ISDIR(st.st_mode).

> +	} else {
> +		if (safe_create_leading_directories_const(sb.buf) < 0) {
> +			warning("unable to create directories for '%s'\n",
> +					sb.buf);
> +			return NULL;
> +		}
> +		if (mkdir(sb.buf, 0700) < 0) {
> +			warning("unable to mkdir '%s'\n", sb.buf);
> +			return NULL;
> +		}

These ones leak, too.

-Peff
