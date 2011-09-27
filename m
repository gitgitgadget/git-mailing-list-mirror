From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add --progress to git-gc and git-repack
Date: Tue, 27 Sep 2011 17:29:10 -0400
Message-ID: <20110927212910.GA5176@sigill.intra.peff.net>
References: <9F9C752E-6B3C-401B-9E01-8B1F5544A82F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Oleg Andreev <oleganza@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fDK-0006iD-Je
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1I0V3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 17:29:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45495
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab1I0V3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:29:12 -0400
Received: (qmail 28589 invoked by uid 107); 27 Sep 2011 21:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 17:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 17:29:10 -0400
Content-Disposition: inline
In-Reply-To: <9F9C752E-6B3C-401B-9E01-8B1F5544A82F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182264>

On Tue, Sep 27, 2011 at 10:32:45PM +0200, Oleg Andreev wrote:

> From 1f261e13e72770deabd77087e354f304be850efc Mon Sep 17 00:00:00 2001
> From: Oleg Andreev <oleganza@gmail.com>
> Date: Tue, 27 Sep 2011 08:24:25 +0200
> Subject: [PATCH 1/2] git-repack: pass --progress down to git-pack-objects

Please follow Documentation/SubmittingPatches.  This should be part of
the actual email headers. And there should be one patch per email.

My first thought was "doesn't git-repack already show progress?".
There's no motivation in the commit message, so I have to guess why you
want this. I assume you want to override the isatty(2) decision that
pack-objects uses?

> diff --git a/git-repack.sh b/git-repack.sh
> index 624feec..b86d60e 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> [...]
> @@ -35,6 +36,7 @@ do
>  		unpack_unreachable=--unpack-unreachable ;;
>  	-d)	remove_redundant=t ;;
>  	-q)	GIT_QUIET=t ;;
> +	--progress) progress=--progress ;;
>  	-f)	no_reuse=--no-reuse-delta ;;
>  	-F)	no_reuse=--no-reuse-object ;;
>  	-l)	local=--local ;;

Should this also handle --no-progress? Maybe it is not a big deal, as
"-q" will also suppress progress, but it would be consistent with other
git commands that take --progress.

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 815afcb..b65fa3e 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> [...]
>  --quiet::
> -	Suppress all progress reports.
> +	Suppress all progress reports. Progress is not reported to
> +	the standard error stream.

This just seems redundant to me.

> +--progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal, unless -q
> +	is specified. This flag forces progress status even if the
> +	standard error stream is not directed to a terminal.

Though this is a nice description.

> --- a/builtin/gc.c
> +++ b/builtin/gc.c
>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, "suppress progress reporting"),
> +		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),

This will handle --no-progress for us automatically, which is good.

> diff --git a/contrib/examples/git-gc.sh b/contrib/examples/git-gc.sh
> index 1597e9f..52ea808 100755
> --- a/contrib/examples/git-gc.sh
> +++ b/contrib/examples/git-gc.sh
> [...]
>  while test $# != 0
>  do
>  	case "$1" in
>  	--prune)
>  		no_prune=
>  		;;
> +	--progress)
> +		progress=--progress
> +		;;

This won't, but I think this whole hunk is unnecessary. The files in
contrib/examples are kept around for people to see how git commands can
be composed of plumbing building blocks. But they don't need to gain new
features as their C counterparts do. I think we can just leave them
frozen in time as of when each script was rewritten in C.

-Peff
