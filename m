From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Wed, 29 Oct 2014 13:21:09 -0400
Message-ID: <20141029172109.GA32234@peff.net>
References: <54500212.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjWvw-00048d-1e
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 18:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934672AbaJ2RVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 13:21:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:34908 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934130AbaJ2RVM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 13:21:12 -0400
Received: (qmail 26385 invoked by uid 102); 29 Oct 2014 17:21:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 12:21:11 -0500
Received: (qmail 1531 invoked by uid 107); 29 Oct 2014 17:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 13:21:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2014 13:21:09 -0400
Content-Disposition: inline
In-Reply-To: <54500212.7040603@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 28, 2014 at 09:52:34PM +0100, Ren=C3=A9 Scharfe wrote:

> --- a/bundle.c
> +++ b/bundle.c
> @@ -381,7 +381,7 @@ int create_bundle(struct bundle_header *header, c=
onst char *path,
>  	write_or_die(bundle_fd, "\n", 1);
> =20
>  	/* write pack */
> -	memset(&rls, 0, sizeof(rls));
> +	child_process_init(&rls);
>  	argv_array_pushl(&rls.args,
>  			 "pack-objects", "--all-progress-implied",
>  			 "--stdout", "--thin", "--delta-base-offset",

I wondered if this one could use CHILD_PROCESS_INIT in the declaration
instead. And indeed, we _do_ use CHILD_PROCESS_INIT there, but we use
the same variable twice for two different child processes in the same
function. Besides variable reuse being slightly confusing, the name
"rls" (which presumably stands for "rev-list" for the first child) mean=
s
nothing here, where we are calling "pack-objects". Maybe it would be
cleaner to introduce a second variable?

I also suspect the function would be a lot more readable broken into tw=
o
sub-functions (reading from rev-list and writing to pack-objects), but =
I
did not look closely enough to see whether there were any complicating
factors.

> diff --git a/column.c b/column.c
> index 8082a94..786abe6 100644
> --- a/column.c
> +++ b/column.c
> @@ -374,7 +374,7 @@ int run_column_filter(int colopts, const struct c=
olumn_options *opts)
>  	if (fd_out !=3D -1)
>  		return -1;
> =20
> -	memset(&column_process, 0, sizeof(column_process));
> +	child_process_init(&column_process);
>  	argv =3D &column_process.args;
> =20
>  	argv_array_push(argv, "column");

This one uses a static child_process which needs to be reinitialized on
each run of the function. So it definitely needs child_process_init.

> diff --git a/trailer.c b/trailer.c
> index 8514566..7ff036c 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -237,7 +237,7 @@ static const char *apply_command(const char *comm=
and, const char *arg)
>  		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> =20
>  	argv[0] =3D cmd.buf;
> -	memset(&cp, 0, sizeof(cp));
> +	child_process_init(&cp);
>  	cp.argv =3D argv;
>  	cp.env =3D local_repo_env;
>  	cp.no_stdin =3D 1;

I think this one can use CHILD_PROCESS_INIT in the declaration. I guess
it is debatable whether that is actually preferable, but I tend to thin=
k
it is cleaner and less error-prone.

-Peff
