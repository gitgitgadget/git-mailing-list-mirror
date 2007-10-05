From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 11:33:44 -0400
Message-ID: <1191598424.7117.10.camel@hinata.boston.redhat.com>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
	 <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpQA-0006hP-MI
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762586AbXJEPsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757929AbXJEPsS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:48:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762869AbXJEPsR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:48:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l95FXoGH021667;
	Fri, 5 Oct 2007 11:33:50 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l95FXnLm009818;
	Fri, 5 Oct 2007 11:33:49 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l95FXnHD004694;
	Fri, 5 Oct 2007 11:33:49 -0400
In-Reply-To: <20071005142507.GL19879@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60095>

On Fri, 2007-10-05 at 16:25 +0200, Pierre Habouzit wrote:
> The option parser takes argc, argv, an array of struct option
> and a usage string.  Each of the struct option elements in the array
> describes a valid option, its type and a pointer to the location wher=
e the
> value is written.  The entry point is parse_options(), which scans th=
rough
> the given argv, and matches each option there against the list of val=
id
> options.  During the scan, argv is rewritten to only contain the
> non-option command line arguments and the number of these is returned=
=2E
>=20
> Aggregation of single switches is allowed:
>   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).
>=20
> Boolean switches automatically support the option with the same name,
> prefixed with 'no-' to disable the switch:
>   --no-color / --color only need to have an entry for "color".
>=20
> Long options are supported either with '=3D' or without:
>   --some-option=3Dfoo is the same as --some-option foo

That looks great, works for me.  One comment, though: it looks like
you're not sure whether to call these things "options" or "switches".
We should choose one and stick with it.

Acked-by: Kristian H=C3=B8gsberg <krh@redhat.com>

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>=20
> I'm sorry about the "From" I don't intend to "steal" the patch in any
> sense, it's just an alternate proposal.

No worries, I'm glad to see this move forward.

> oh and I don't grok what OPTION_LAST is for, so I left it apart, but
> it seems unused ?

Oh, kill that.  I used that as the option array terminator before we
switched to ARRAY_SIZE().

>=20
>  Makefile        |    2 +-
>  parse-options.c |  154 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  parse-options.h |   29 ++++++++++
>  3 files changed, 184 insertions(+), 1 deletions(-)
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
> index 0000000..eb3ff40
> --- /dev/null
> +++ b/parse-options.c
> @@ -0,0 +1,154 @@
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +
> +struct optparse_t {
> +	const char **argv;
> +	int argc;
> +	const char *opt;
> +};
> +
> +static inline const char *skippfx(const char *str, const char *prefi=
x)
> +{
> +	size_t len =3D strlen(prefix);
> +	return strncmp(str, prefix, len) ? NULL : str + len;
> +}
> +
> +static int opterror(struct option *opt, const char *reason, int shor=
terr)
> +{
> +	if (shorterr) {
> +		return error("switch `%c' %s", opt->short_name, reason);
> +	} else {
> +		return error("option `%s' %s", opt->long_name, reason);
> +	}
> +}

option/switch?

> +static int get_value(struct optparse_t *p, struct option *opt,
> +					 int boolean, int shorterr)
> +{
> +	switch (opt->type) {
> +		const char *s;
> +		int v;
> +
> +	  case OPTION_BOOLEAN:
> +		*(int *)opt->value =3D boolean;
> +		return 0;
> +
> +	  case OPTION_STRING:
> +		if (p->opt && *p->opt) {
> +			*(const char **)opt->value =3D p->opt;
> +			p->opt =3D NULL;
> +		} else {
> +			if (p->argc < 1)
> +				return opterror(opt, "requires a value", shorterr);
> +			*(const char **)opt->value =3D *++p->argv;
> +			p->argc--;
> +		}
> +		return 0;
> +
> +	  case OPTION_INTEGER:
> +		if (p->opt && *p->opt) {
> +			v =3D strtol(p->opt, (char **)&s, 10);
> +			p->opt =3D NULL;
> +		} else {
> +			if (p->argc < 1)
> +				return opterror(opt, "requires a value", shorterr);
> +			v =3D strtol(*++p->argv, (char **)&s, 10);
> +			p->argc--;
> +		}
> +		if (*s)
> +			return opterror(opt, "expects a numerical value", shorterr);
> +		*(int *)opt->value =3D v;
> +		return 0;
> +	}
> +
> +	abort();
> +}
> +
> +static int parse_short_opt(struct optparse_t *p, struct option *opti=
ons, int count)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (options[i].short_name =3D=3D *p->opt) {
> +			p->opt++;
> +			return get_value(p, options + i, 1, 1);
> +		}
> +	}
> +	return error("unknown switch `%c'", *p->opt);
> +}
> +
> +static int parse_long_opt(struct optparse_t *p, const char *arg,
> +                          struct option *options, int count)
> +{
> +	int boolean =3D 1;
> +	int i;
> +
> +	for (i =3D 0; i < count; i++) {
> +		const char *rest;
> +	=09
> +		if (!options[i].long_name)
> +			continue;
> +
> +		rest =3D skippfx(arg, options[i].long_name);
> +		if (!rest && options[i].type =3D=3D OPTION_BOOLEAN) {
> +			if (!rest && skippfx(arg, "no-")) {
> +				rest =3D skippfx(arg + 3, options[i].long_name);
> +				boolean =3D 0;
> +			}
> +			if (rest && *rest =3D=3D '=3D')
> +				return opterror(options + i, "takes no value", 0);
> +		}
> +		if (!rest || (*rest && *rest !=3D '=3D'))
> +			continue;
> +		if (*rest) {
> +			p->opt =3D rest;
> +		}
> +		return get_value(p, options + i, boolean, 0);
> +	}
> +	return error("unknown option `%s'", arg);
> +}
> +
> +int parse_options(int argc, const char **argv,
> +		  struct option *options, int count,
> +		  const char *usage_string)
> +{
> +	struct optparse_t optp =3D { argv + 1, argc - 1, NULL };
> +	int j =3D 0;
> +
> +	while (optp.argc) {
> +		const char *arg =3D optp.argv[0];
> +
> +		if (*arg !=3D '-' || !arg[1]) {
> +			argv[j++] =3D *optp.argv++;
> +			optp.argc--;
> +			continue;
> +		}
> +
> +		if (arg[1] !=3D '-') {
> +			optp.opt =3D arg + 1;
> +			while (*optp.opt) {
> +				if (parse_short_opt(&optp, options, count) < 0) {
> +					usage(usage_string);
> +					return -1;
> +				}
> +			}
> +			optp.argc--;
> +			optp.argv++;
> +			continue;
> +		}
> +
> +		if (!arg[2]) /* "--" */
> +			break;
> +
> +		if (parse_long_opt(&optp, arg + 2, options, count)) {
> +			usage(usage_string);
> +			return -1;
> +		}
> +		optp.argc--;
> +		optp.argv++;
> +	}
> +
> +	memmove(argv + j, optp.argv, optp.argc * sizeof(argv));
> +	argv[j + optp.argc] =3D NULL;
> +	return j + optp.argc;
> +}
> diff --git a/parse-options.h b/parse-options.h
> new file mode 100644
> index 0000000..e4749d0
> --- /dev/null
> +++ b/parse-options.h
> @@ -0,0 +1,29 @@
> +#ifndef PARSE_OPTIONS_H
> +#define PARSE_OPTIONS_H
> +
> +enum option_type {
> +	OPTION_BOOLEAN,
> +	OPTION_STRING,
> +	OPTION_INTEGER,
> +#if 0
> +	OPTION_LAST,
> +#endif
> +};
> +
> +struct option {
> +	enum option_type type;
> +	const char *long_name;
> +	char short_name;
> +	void *value;
> +};
> +
> +/* parse_options() will filter out the processed options and leave t=
he
> + * non-option argments in argv[].  The return value is the number of
> + * arguments left in argv[].
> + */
> +
> +extern int parse_options(int argc, const char **argv,
> +			 struct option *options, int count,
> +			 const char *usage_string);
> +
> +#endif
