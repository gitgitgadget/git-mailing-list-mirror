From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util.h: move extension stripping from
 handle_builtin()
Date: Sat, 20 Feb 2016 03:48:04 -0500
Message-ID: <20160220084804.GB17171@sigill.intra.peff.net>
References: <1455955858-30081-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git @ vger . kernel . org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX3D2-0008G2-NR
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949403AbcBTIsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:48:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:45990 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1948978AbcBTIsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:48:07 -0500
Received: (qmail 11546 invoked by uid 102); 20 Feb 2016 08:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:48:07 -0500
Received: (qmail 4397 invoked by uid 107); 20 Feb 2016 08:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 Feb 2016 03:48:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Feb 2016 03:48:04 -0500
Content-Disposition: inline
In-Reply-To: <1455955858-30081-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286772>

On Sat, Feb 20, 2016 at 02:10:58PM +0600, Alexander Kuleshov wrote:

> The handle_builtin() starts from striping of command extension if
> STRIP_EXTENSION is enabled. As this is an OS dependent, let's move
> to the git-compat-util.h as all similar functions to do handle_builtin()
> more cleaner.

I'm not convinced that moving the functions inline into git-compat-util
is actually cleaner. We've expanded the interface that is visible to the
whole code base, warts at all.

One wart I see is that the caller cannot know whether the return value
was newly allocated or not, and therefore cannot free it, creating a
potential memory leak. Another is that the return value is not really
necessary at all; we always munge argv[0].

Does any other part of the code actually care about this
extension-stripping?

Perhaps instead, could we do this:

>  git-compat-util.h | 18 ++++++++++++++++++
>  git.c             | 13 +------------
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 658d03b..57f2fda 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -323,6 +323,24 @@ extern char *gitbasename(char *);
>  
>  #ifndef STRIP_EXTENSION
>  #define STRIP_EXTENSION ""
> +static inline const char *strip_extension(const char **argv)
> +{
> +	return argv[0];
> +}
> +#else
> +static inline const char *strip_extension(const char **argv)
> +{
> +	static const char ext[] = STRIP_EXTENSION;
> +	int ext_len = strlen(argv[0]) - strlen(ext);
> +
> +	if (ext_len > 0 && !strcmp(argv[0] + ext_len, ext)) {
> +		char *argv0 = xstrdup(argv[0]);
> +		argv[0] = argv0;
> +		argv0[ext_len] = '\0';
> +	}
> +
> +	return argv[0];
> +}
>  #endif

If we drop this default-to-empty value of STRIP_EXTENSION entirely, then
we can do our #ifdef local to git.c, where it does not bother anybody
else. Like:

  #ifdef STRIP_EXTENSION
  static void strip_extension(const char **argv)
  {
	/* Do the thing */
  }
  #else
  #define strip_extension(x)
  #endif

(Note that I also simplified the return value).

In the case that we do have STRIP_EXTENSION, I don't think we need to
handle the empty-string case. It would be a regression for somebody
passing -DSTRIP_EXTENSION="", but I don't think that's worth worrying
about. That macro is defined totally internally.

I suspect you could also use strip_suffix here. So something like:

  size_t len;

  if (strip_suffix(str, STRIP_EXTENSION, &len))
	argv[0] = xmemdupz(argv[0], len);

would probably work, but that's totally untested.

-Peff
