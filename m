From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-log: allow --decorate[=short|full]
Date: Sat, 15 Aug 2009 08:28:12 -0400
Message-ID: <20090815122812.GB30630@coredump.intra.peff.net>
References: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 14:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McIOk-0000f1-7p
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 14:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZHOM2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbZHOM2O
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 08:28:14 -0400
Received: from peff.net ([208.65.91.99]:49026 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbZHOM2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 08:28:14 -0400
Received: (qmail 19918 invoked by uid 107); 15 Aug 2009 12:28:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 15 Aug 2009 08:28:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Aug 2009 08:28:12 -0400
Content-Disposition: inline
In-Reply-To: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126001>

On Sat, Aug 15, 2009 at 11:50:25AM +0200, Lars Hjemli wrote:

> This extension to --decorate makes it possible to generate decorations
> similar to pre-1.6.4 git, which is nice when the output from git-log
> is used by external tools.

This commit message really lacks context.  When I read it, I thought to
myself "what happened to decorations in 1.6.4?" It really needs to say:

  - exactly what changed
  - why did it change
  - why the change has drawbacks

After reading the patch and digging through the history, I think you
want something more like:

-- >8 --
Commit de435ac0 changed the behavior of --decorate from printing the
full ref (e.g., "refs/heads/master") to a shorter, more human-readable
version (e.g., just "master"). While this is nice for human readers,
external tools using the output from "git log" may prefer the full
version.

This patch introduces an extension to --decorate to allow the caller to
specify either the short or the full versions.
-- 8< --

As for the patch, it mostly looks good, but a few comments:

> +		} else if (!strncmp(arg, "--decorate=", 11)) {
> +			if (!strcmp(arg + 11, "full"))
> +				rev->show_decorations = DECORATE_FULL_REFS;
> +			else if (!strcmp(arg + 11, "short"))
> +				rev->show_decorations = DECORATE_SHORT_REFS;
> +			else
> +				die("invalid --decorate option: %s", arg + 11);

To avoid the magic 11's, we have a few helpers:

  if (!prefixcmp(arg, "--decorate=")) {
          const char *v = skip_prefix(arg, "--decorate=");
          ...

though arguably that is just as bad because you have to repeat the
"--decorate=".

> --- a/revision.h
> +++ b/revision.h
> @@ -15,6 +15,10 @@
>  #define SYMMETRIC_LEFT	(1u<<8)
>  #define ALL_REV_FLAGS	((1u<<9)-1)
> 
> +
> +#define DECORATE_SHORT_REFS	1
> +#define DECORATE_FULL_REFS	2
> +

Style nit: extra blank line?

> @@ -56,7 +60,7 @@ struct rev_info {
>  			rewrite_parents:1,
>  			print_parents:1,
>  			show_source:1,
> -			show_decorations:1,
> +			show_decorations:2,
>  			reverse:1,
>  			reverse_output_stage:1,
>  			cherry_pick:1,

Should we perhaps just turn show_decorations into its own variable? It
just seems like a trap for future maintainers to want to add more
DECORATE_* flags but not realize they have to keep bumping up the size
of the bitfield.

And rev_info is not a struct that we are particularly trying to optimize
the memory on.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 8b33321..8e3694e 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -207,6 +207,7 @@ log --root --cc --patch-with-stat --summary master
>  log -SF master
>  log -SF -p master
>  log --decorate --all
> +log --decorate=full --all

Yay, tests.

-Peff
