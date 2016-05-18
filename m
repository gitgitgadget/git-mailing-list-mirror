From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack.c: use of parse-options API
Date: Wed, 18 May 2016 14:08:00 -0400
Message-ID: <20160518180800.GC5796@sigill.intra.peff.net>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr,
	Antoine Queru <antoine.queru@grenoble-inp.fr>
To: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 18 20:08:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35tB-00016l-SY
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 20:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbcERSIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 14:08:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752658AbcERSIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 14:08:04 -0400
Received: (qmail 16475 invoked by uid 102); 18 May 2016 18:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 14:08:02 -0400
Received: (qmail 24953 invoked by uid 107); 18 May 2016 18:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 14:08:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 14:08:00 -0400
Content-Disposition: inline
In-Reply-To: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294984>

On Wed, May 18, 2016 at 06:40:19PM +0200, Antoine Queru wrote:

> Option parsing now uses the parser API instead of a local parser.
> Code is now more compact.

Sounds like a good goal.

> -static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
> +static const char * const upload_pack_usage[] = {
> +	N_("git upload-pack [--strict] [--timeout=<n>] <dir>"),
> +	NULL
> +};

Do we need to enumerate the options here now? The usage message should
list the options from "struct options", which make these redundant.

Something like:

  git -upload-pack [options] <dir>

probably makes more sense.

Of course, it's hard to read the usage message because...

> +	struct option options[] = {
> +		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
> +		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
> +		OPT_BOOL(0, "strict", &strict, NULL),
> +		OPT_INTEGER(0, "timeout", &timeout, NULL),
> +		OPT_END()
> +	};

You've left the description text for each of these options as NULL, so
running "git-upload-pack -h" segfaults.

I'm not sure whether it is worth hiding the first two options. We
typically hide "internal" options like this for user-facing programs, so
as not to clutter the "-h" output. But upload-pack isn't a user-facing
program. Anybody who is calling it directly with "-h" may be interested
in even its more esoteric options.

> -	for (i = 1; i < argc; i++) {
> -		char *arg = argv[i];
> -
> -		if (arg[0] != '-')
> -			break;
> -		if (!strcmp(arg, "--advertise-refs")) {
> -			advertise_refs = 1;
> -			continue;
> -		}
> -		if (!strcmp(arg, "--stateless-rpc")) {
> -			stateless_rpc = 1;
> -			continue;
> -		}
> -		if (!strcmp(arg, "--strict")) {
> -			strict = 1;
> -			continue;
> -		}
> -		if (starts_with(arg, "--timeout=")) {
> -			timeout = atoi(arg+10);
> -			daemon_mode = 1;
> -			continue;
> -		}
> -		if (!strcmp(arg, "--")) {
> -			i++;
> -			break;
> -		}
> -	}

A common pitfall in converting a for-loop to parse-options is when there
is anything stateful in the parsing loop. But I don't see anything here.
The trickiest thing is that --timeout implies daemon_mode. You've
handled that below as:

> +	if (timeout != 0)
> +		daemon_mode = 1;

I think that is OK. It would not be correct if, for example, some other
code set "timeout" to a non-zero value (e.g., a config option), but I
don't see that here.

As a style nit, we usually spell comparison-with-zero as just:

  if (timeout)
	daemon_mode = 1;

Looking at at daemon_mode, though, it appears that it cannot be set in
any other way except here. And it does nothing except to disable
progress in some cases. Weird. There may be some opportunities for
refactoring or simplification there, but I that is outside the scope of
your patch.

> +	argc = parse_options(argc, (const char **)argv, NULL, options, upload_pack_usage, 0);

Perhaps this is a good opportunity to use "const" in the declaration of
main(), as most other git programs do. Then you can drop this cast.

>  	setup_path();
>  
> -	dir = argv[i];
> +	dir = argv[0];
>  
>  	if (!enter_repo(dir, strict))
>  		die("'%s' does not appear to be a git repository", dir);

Prior to your patch, we used to check:

  -       if (i != argc-1)
  -               usage(upload_pack_usage);

which ensured that "dir" was non-NULL. But with your patch, we may pass
NULL to enter_repo. It fortunately catches this, but then we pass the
NULL to die, which can segfault (though on glibc systems, stdio is kind
enough to replace it with the "(null)").

Related, we silently accept extra arguments after your patch (whereas
before we showed the usage message). You probably want to check "argc ==
1", and otherwise show the usage message.

-Peff
