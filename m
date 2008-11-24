From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/4] Refactor builtin-verify-tag.c
Date: Mon, 24 Nov 2008 12:04:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811241147490.30769@pacific.mpi-cbg.de>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <1227497000-8684-2-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Z8u-0005xD-Kb
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 11:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYKXK45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 05:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYKXK44
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 05:56:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:39190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752869AbYKXK4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 05:56:54 -0500
Received: (qmail invoked by alias); 24 Nov 2008 10:56:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 24 Nov 2008 11:56:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vLncm49HvPghI6zDuAFc/E5l0muLotZbv+Q+Ux6
	T1AjfydR1df4im
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227497000-8684-2-git-send-email-deskinm@umich.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101599>

Hi,

On Sun, 23 Nov 2008, Deskin Miller wrote:

> builtin-verify-tag.c didn't expose any of its functionality to be used
> internally.  Refactor some of it into new verify-tag.c and expose
> verify_tag_sha1 able to be called from elsewhere in git.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>
> ---
>  Makefile             |    2 +
>  builtin-verify-tag.c |   61 ++-------------------------------------
>  verify-tag.c         |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  verify-tag.h         |   10 ++++++
>  4 files changed, 93 insertions(+), 57 deletions(-)
>  create mode 100644 verify-tag.c
>  create mode 100644 verify-tag.h

I'll comment on the output of "format-patch -n -C -C" instead, as that 
makes it much easier to see what you actually did:

>  Makefile                             |    2 +
>  builtin-verify-tag.c                 |   61 ++-------------------------------
>  builtin-verify-tag.c => verify-tag.c |   48 ++++-----------------------
>  verify-tag.h                         |   10 +++++
>  4 files changed, 23 insertions(+), 98 deletions(-)
>  copy builtin-verify-tag.c => verify-tag.c (56%)
>  create mode 100644 verify-tag.h
>
> [...] 
> diff --git a/builtin-verify-tag.c b/verify-tag.c
> similarity index 56%
> copy from builtin-verify-tag.c
> copy to verify-tag.c
> index 729a159..c9be331 100644
> --- a/builtin-verify-tag.c
> +++ b/verify-tag.c
> @@ -1,18 +1,12 @@
>  /*
> - * Builtin "git verify-tag"
> + * Internals for "git verify-tag"

Agree.

>   *
> - * Copyright (c) 2007 Carlos Rica <jasampler@gmail.com>
> + * Copyright (c) 2008 Deskin Miller <deskinm@umich.edu>

Disagree.

Even if Carlos seemed to stop his work on Git entirely, which I find 
disappointing, you are _not_ free to pretend his work is yours.  And given 
this diff:

>   *
> - * Based on git-verify-tag.sh
>   */
>  #include "cache.h"
> -#include "builtin.h"
> -#include "tag.h"
> +#include "object.h"
>  #include "run-command.h"
> -#include <signal.h>
> -
> -static const char builtin_verify_tag_usage[] =
> -		"git verify-tag [-v|--verbose] <tag>...";
>  
>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>  
> @@ -60,52 +54,24 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
>  	return ret;
>  }
>  
> -static int verify_tag(const char *name, int verbose)
> +int verify_tag_sha1(const unsigned char *sha1, int verbose)
>  {
>  	enum object_type type;
> -	unsigned char sha1[20];
>  	char *buf;
>  	unsigned long size;
>  	int ret;
>  
> -	if (get_sha1(name, sha1))
> -		return error("tag '%s' not found.", name);
> -
>  	type = sha1_object_info(sha1, NULL);
>  	if (type != OBJ_TAG)
> -		return error("%s: cannot verify a non-tag object of type %s.",
> -				name, typename(type));
> +		return error("Cannot verify a non-tag object of type %s.",
> +				typename(type));
>  
>  	buf = read_sha1_file(sha1, &type, &size);
>  	if (!buf)
> -		return error("%s: unable to read file.", name);
> +		return error("Cnable to read file.");
>  
>  	ret = run_gpg_verify(buf, size, verbose);
>  
>  	free(buf);
>  	return ret;
>  }
> -
> -int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> -{
> -	int i = 1, verbose = 0, had_error = 0;
> -
> -	git_config(git_default_config, NULL);
> -
> -	if (argc > 1 &&
> -	    (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose"))) {
> -		verbose = 1;
> -		i++;
> -	}
> -
> -	if (argc <= i)
> -		usage(builtin_verify_tag_usage);
> -
> -	/* sometimes the program was terminated because this signal
> -	 * was received in the process of writing the gpg input: */
> -	signal(SIGPIPE, SIG_IGN);
> -	while (i < argc)
> -		if (verify_tag(argv[i++], verbose))
> -			had_error = 1;
> -	return had_error;
> -}

I think pretty much all you did was deleting (and thereby you do not gain 
any copyright).

Except for one change: why on earth did you think it a good idea to 
suppress telling the user the _name_ of the tag when an error occurs?

I, for one, would find it way less than helpful to read

	Cannot verify a non-tag object of type blob.

than to read

	refs/tags/dscho-key: cannot verify a non-tag object of type blob.

Besides, I do not see where you warn that "tag <name> not found."  Changes 
like this one need to be justified (by saying in the commit message where 
the warning is already issued, and not letting the reviewer/reader leave 
wondering).

Please, next time you submit a patch like this, do the -C -C yourself.  
Letting all the reviewers do it looks lousy on the overall time balance 
sheet, and it may also lead to a potential reviewer preferring to do 
something else instead.

Now, Junio already said that he is not (yet) convinced that this change 
should be in Git proper, rather than a hook, so it is up to you to decide 
if you deem it important enough to try harder to convince people.

I, for one, would think that it may be a good change: AFAIK only hard-core 
gits use hooks, everybody else avoids them.  So if we deem verifying 
signatures important enough, we might want to have better support for it 
than some example hooks.

So color me half-convinced.

Ciao,
Dscho
