From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Sun, 30 Sep 2007 15:11:33 +0200
Message-ID: <20070930131133.GA11209@diku.dk>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 11:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcHmE-0006Uv-Ek
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 11:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbXJAJlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 05:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXJAJlN
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 05:41:13 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34299 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXJAJlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 05:41:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 81FD2600357;
	Mon,  1 Oct 2007 11:41:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P80Z9YR6V72R; Mon,  1 Oct 2007 11:41:08 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 09B00606941;
	Mon,  1 Oct 2007 11:00:34 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BD4426E9A44; Sun, 30 Sep 2007 15:06:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8DBF1632A1; Sun, 30 Sep 2007 15:11:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190868632-29287-1-git-send-email-krh@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59591>

Hello Kristian,

I have some comments on your patch. Some of the "improvement" might hav=
e
to wait until after your builtin-commit changes hits git.git. However,
if we could agree on some of the general changes, I could start porting
other of the main porcelain commands to use the option parser without
depending on the state of the remaining builtin-commit series.

Kristian H=F8gsberg <krh@redhat.com> wrote Thu, Sep 27, 2007:
> Signed-off-by: Kristian H=F8gsberg <krh@redhat.com>
> ---
>  Makefile        |    2 +-
>  parse-options.c |   74 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  parse-options.h |   29 +++++++++++++++++++++
>  3 files changed, 104 insertions(+), 1 deletions(-)
>  create mode 100644 parse-options.c
>  create mode 100644 parse-options.h
>=20
> diff --git a/Makefile b/Makefile
> index 62bdac6..d90e959 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -310,7 +310,7 @@ LIB_OBJS =3D \
>  	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)=
 \
>  	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
>  	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.=
o \
> -	transport.o bundle.o
> +	transport.o bundle.o parse-options.o
> =20
>  BUILTIN_OBJS =3D \
>  	builtin-add.o \
> diff --git a/parse-options.c b/parse-options.c
> new file mode 100644
> index 0000000..2fb30cd
> --- /dev/null
> +++ b/parse-options.c
> @@ -0,0 +1,74 @@
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +
> +int parse_options(const char ***argv,
> +		  struct option *options, int count,
> +		  const char *usage_string)
> +{
> +	const char *value, *eq;
> +	int i;
> +
> +	if (**argv =3D=3D NULL)
> +		return 0;
> +	if ((**argv)[0] !=3D '-')
> +		return 0;
> +	if (!strcmp(**argv, "--"))
> +		return 0;

I don't know if this is a bug, but you do not remove "--" from argv,
which is later (in the patch that adds builtin-commit.c) passed to
add_files_to_cache and then get_pathspec where it is not removed or
detected either.

> +
> +	value =3D NULL;
> +	for (i =3D 0; i < count; i++) {
> +		if ((**argv)[1] =3D=3D '-') {
> +			if (!prefixcmp(options[i].long_name, **argv + 2)) {
> +				if (options[i].type !=3D OPTION_BOOLEAN)
> +					value =3D *++(*argv);
> +				goto match;
> +			}
> +
> +			eq =3D strchr(**argv + 2, '=3D');
> +			if (eq && options[i].type !=3D OPTION_BOOLEAN &&
> +			    !strncmp(**argv + 2,
> +				     options[i].long_name, eq - **argv - 2)) {
> +				value =3D eq + 1;
> +				goto match;
> +			}
> +		}
> +
> +		if ((**argv)[1] =3D=3D options[i].short_name) {
> +			if ((**argv)[2] =3D=3D '\0') {
> +				if (options[i].type !=3D OPTION_BOOLEAN)
> +					value =3D *++(*argv);
> +				goto match;
> +			}
> +
> +			if (options[i].type !=3D OPTION_BOOLEAN) {
> +				value =3D **argv + 2;
> +				goto match;
> +			}
> +		}
> +	}
> +
> +	usage(usage_string);
> +
> + match:

I think the goto can be avoided by simply breaking out of the above loo=
p
when an option has been found and add ...

> +	switch (options[i].type) {
	case OPTION_LAST
		usage(usage_string);
		break;

> +	case OPTION_BOOLEAN:
> +		*(int *)options[i].value =3D 1;
> +		break;

I've been looking at builtin-blame.c which IMO has some of the most
obscure option parsing and maybe this can be changed to increment in
order to support stuff like changing the meaning by passing the same ar=
g
multiple times (e.g. "-C -C -C") better.

Blame option parsing also sports (enum) flags being masked together,
this can of course be rewritten to a boolean option followed by
masking when parse_options is done (to keep it sane).

> +	case OPTION_STRING:
> +		if (value =3D=3D NULL)
> +			die("option %s requires a value.", (*argv)[-1]);

Maybe change this ...

> +		*(const char **)options[i].value =3D value;
> +		break;
> +	case OPTION_INTEGER:
> +		if (value =3D=3D NULL)
> +			die("option %s requires a value.", (*argv)[-1]);

=2E.. and this to:

		if (!value) {
			error("option %s requires a value.", (*argv)[-1]);
			usage(usage_string);
		}

> +		*(int *)options[i].value =3D atoi(value);
> +		break;
> +	default:
> +		assert(0);
> +	}
> +
> +	(*argv)++;
> +
> +	return 1;
> +}
> diff --git a/parse-options.h b/parse-options.h
> new file mode 100644
> index 0000000..39399c3
> --- /dev/null
> +++ b/parse-options.h
> @@ -0,0 +1,29 @@
> +#ifndef PARSE_OPTIONS_H
> +#define PARSE_OPTIONS_H
> +
> +enum option_type {
> +    OPTION_BOOLEAN,
> +    OPTION_STRING,
> +    OPTION_INTEGER,
> +    OPTION_LAST,
> +};
> +
> +struct option {
> +    enum option_type type;
> +    const char *long_name;
> +    char short_name;
> +    void *value;
> +};

Space vs tab indentation.

One of the last things I miss from Cogito is the nice abbreviated help
messages that was available via '-h'. I don't know if it would be
acceptable (at least for the main porcelain commands) to put this
functionality into the option parser by adding a "description" member t=
o
struct option and have parse_options print a nice:

	<error message if any>
	<usage string>
	<option summary>

on failure, or, if that is regarded as too verbose, simply when -h is
detected.

> +
> +/* Parse the given options against the list of known options.  The
> + * order of the option structs matters, in that ambiguous
> + * abbreviations (eg, --in could be short for --include or
> + * --interactive) are matched by the first option that share the
> + * prefix.
> + */

This prefix aware option parsing has not been ported over to the other
builtins when they were lifted from shell code. It might be nice to hav=
e
of course. Is it really needed?

> +
> +extern int parse_options(const char ***argv,
> +			 struct option *options, int count,
> +			 const char *usage_string);

I think the interface could be improved a bit. For example, it doesn't
need to count argument since the last entry in the options array is
OPTION_LAST and thus the size can be detected that way.

Also, I think for this to be more usable for other built-in programs it
shouldn't modify argv, but instead take both argc and argv (so we don't
need to have code like "*++(*argv)" ;), parse _all_ options in one go,
and return the index (of argv) for any remaining options.

Then the following:

	while (parse_options(argv, commit_options, ARRAY_SIZE(commit_options),
		builtin_commit_usage))
		;

becomes:

	int i;
	...
	i =3D parse_options(argc, argv, commit_options, builtin_commit_usage);

This fits better with how option parsing is currently done. Take
builtin-add for example:

	for (i =3D 1 ; i < argc ; i++) {
		const char *arg =3D argv[i];
		/* ... */
	}
	if (argc <=3D i)
		usage(builtin_rm_usage);

[ BTW, blame option parsing actually wants to know if "--" has been see=
n,
  but I think that can be worked around by simply checking argv[i - 1]
  after calling the option parser. ]

> +
> +#endif

OK, I will stop these ramblings here. I hope the fact that I read your
patch both back and forth and added comments in the process didn't make
it too confusing.

--=20
Jonas Fonseca
