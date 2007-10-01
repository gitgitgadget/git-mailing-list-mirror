From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by
	builtin-commit.c.
Date: Mon, 01 Oct 2007 12:26:15 -0400
Message-ID: <1191255975.25093.26.camel@hinata.boston.redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
	 <20070930131133.GA11209@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Oct 01 18:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcOBs-0004YQ-Vo
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 18:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXJAQcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 12:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbXJAQcG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 12:32:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXJAQcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 12:32:03 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l91GQL2J028863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Oct 2007 12:26:21 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l91GQLtr002269;
	Mon, 1 Oct 2007 12:26:21 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l91GQK3G007302;
	Mon, 1 Oct 2007 12:26:20 -0400
In-Reply-To: <20070930131133.GA11209@diku.dk>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59625>

On Sun, 2007-09-30 at 15:11 +0200, Jonas Fonseca wrote:
> Hello Kristian,
>=20
> I have some comments on your patch. Some of the "improvement" might h=
ave
> to wait until after your builtin-commit changes hits git.git. However=
,
> if we could agree on some of the general changes, I could start porti=
ng
> other of the main porcelain commands to use the option parser without
> depending on the state of the remaining builtin-commit series.

Hi Jonas,

That's sounds like a good plan.  In fact, in you want to update the
patch with your changes (they all sound good) and start porting over
some of the other builtins feel free.  I don't have much time follow up
on these comments right now, but I will get to it eventually - unless
you beat me to it of course ;)  I will update builtin-commit.c to work
with whatever changes you introduce once I get around to updating that
patch.

> Kristian H=C3=B8gsberg <krh@redhat.com> wrote Thu, Sep 27, 2007:
> > Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> > ---
> >  Makefile        |    2 +-
> >  parse-options.c |   74 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  parse-options.h |   29 +++++++++++++++++++++
> >  3 files changed, 104 insertions(+), 1 deletions(-)
> >  create mode 100644 parse-options.c
> >  create mode 100644 parse-options.h
> >=20
> > diff --git a/Makefile b/Makefile
> > index 62bdac6..d90e959 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -310,7 +310,7 @@ LIB_OBJS =3D \
> >  	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJ=
S) \
> >  	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o =
\
> >  	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remot=
e.o \
> > -	transport.o bundle.o
> > +	transport.o bundle.o parse-options.o
> > =20
> >  BUILTIN_OBJS =3D \
> >  	builtin-add.o \
> > diff --git a/parse-options.c b/parse-options.c
> > new file mode 100644
> > index 0000000..2fb30cd
> > --- /dev/null
> > +++ b/parse-options.c
> > @@ -0,0 +1,74 @@
> > +#include "git-compat-util.h"
> > +#include "parse-options.h"
> > +
> > +int parse_options(const char ***argv,
> > +		  struct option *options, int count,
> > +		  const char *usage_string)
> > +{
> > +	const char *value, *eq;
> > +	int i;
> > +
> > +	if (**argv =3D=3D NULL)
> > +		return 0;
> > +	if ((**argv)[0] !=3D '-')
> > +		return 0;
> > +	if (!strcmp(**argv, "--"))
> > +		return 0;
>=20
> I don't know if this is a bug, but you do not remove "--" from argv,
> which is later (in the patch that adds builtin-commit.c) passed to
> add_files_to_cache and then get_pathspec where it is not removed or
> detected either.

That's an oversight, good catch.

> > +
> > +	value =3D NULL;
> > +	for (i =3D 0; i < count; i++) {
> > +		if ((**argv)[1] =3D=3D '-') {
> > +			if (!prefixcmp(options[i].long_name, **argv + 2)) {
> > +				if (options[i].type !=3D OPTION_BOOLEAN)
> > +					value =3D *++(*argv);
> > +				goto match;
> > +			}
> > +
> > +			eq =3D strchr(**argv + 2, '=3D');
> > +			if (eq && options[i].type !=3D OPTION_BOOLEAN &&
> > +			    !strncmp(**argv + 2,
> > +				     options[i].long_name, eq - **argv - 2)) {
> > +				value =3D eq + 1;
> > +				goto match;
> > +			}
> > +		}
> > +
> > +		if ((**argv)[1] =3D=3D options[i].short_name) {
> > +			if ((**argv)[2] =3D=3D '\0') {
> > +				if (options[i].type !=3D OPTION_BOOLEAN)
> > +					value =3D *++(*argv);
> > +				goto match;
> > +			}
> > +
> > +			if (options[i].type !=3D OPTION_BOOLEAN) {
> > +				value =3D **argv + 2;
> > +				goto match;
> > +			}
> > +		}
> > +	}
> > +
> > +	usage(usage_string);
> > +
> > + match:
>=20
> I think the goto can be avoided by simply breaking out of the above l=
oop
> when an option has been found and add ...
>=20
> > +	switch (options[i].type) {
> 	case OPTION_LAST
> 		usage(usage_string);
> 		break;
>=20
> > +	case OPTION_BOOLEAN:
> > +		*(int *)options[i].value =3D 1;
> > +		break;

Yeah, that looks nicer.  I think the goto structure is a leftover from
when there was more logic between the loop and the switch.  It's good t=
o
get some fresh eyes on this code.  Junio didn't like the OPTION_LAST
terminator, so I changed the interface to take a count.  We can do

	if (i =3D=3D count)
		usage();
	else switch (options[i].type) {
		...
	}

of course.

> I've been looking at builtin-blame.c which IMO has some of the most
> obscure option parsing and maybe this can be changed to increment in
> order to support stuff like changing the meaning by passing the same =
arg
> multiple times (e.g. "-C -C -C") better.

That would be fine, yes.

> Blame option parsing also sports (enum) flags being masked together,
> this can of course be rewritten to a boolean option followed by
> masking when parse_options is done (to keep it sane).

Yup.

> > +	case OPTION_STRING:
> > +		if (value =3D=3D NULL)
> > +			die("option %s requires a value.", (*argv)[-1]);
>=20
> Maybe change this ...
>=20
> > +		*(const char **)options[i].value =3D value;
> > +		break;
> > +	case OPTION_INTEGER:
> > +		if (value =3D=3D NULL)
> > +			die("option %s requires a value.", (*argv)[-1]);
>=20
> ... and this to:
>=20
> 		if (!value) {
> 			error("option %s requires a value.", (*argv)[-1]);
> 			usage(usage_string);
> 		}

Sure, that's friendlier.

> > +		*(int *)options[i].value =3D atoi(value);
> > +		break;
> > +	default:
> > +		assert(0);
> > +	}
> > +
> > +	(*argv)++;
> > +
> > +	return 1;
> > +}
> > diff --git a/parse-options.h b/parse-options.h
> > new file mode 100644
> > index 0000000..39399c3
> > --- /dev/null
> > +++ b/parse-options.h
> > @@ -0,0 +1,29 @@
> > +#ifndef PARSE_OPTIONS_H
> > +#define PARSE_OPTIONS_H
> > +
> > +enum option_type {
> > +    OPTION_BOOLEAN,
> > +    OPTION_STRING,
> > +    OPTION_INTEGER,
> > +    OPTION_LAST,
> > +};
> > +
> > +struct option {
> > +    enum option_type type;
> > +    const char *long_name;
> > +    char short_name;
> > +    void *value;
> > +};
>=20
> Space vs tab indentation.
>=20
> One of the last things I miss from Cogito is the nice abbreviated hel=
p
> messages that was available via '-h'. I don't know if it would be
> acceptable (at least for the main porcelain commands) to put this
> functionality into the option parser by adding a "description" member=
 to
> struct option and have parse_options print a nice:
>=20
> 	<error message if any>
> 	<usage string>
> 	<option summary>
>=20
> on failure, or, if that is regarded as too verbose, simply when -h is
> detected.

Yeah, that might be nice.  We can add it in a follow-on patch, if the
list agrees that it's a good thing, I guess.

> > +
> > +/* Parse the given options against the list of known options.  The
> > + * order of the option structs matters, in that ambiguous
> > + * abbreviations (eg, --in could be short for --include or
> > + * --interactive) are matched by the first option that share the
> > + * prefix.
> > + */
>=20
> This prefix aware option parsing has not been ported over to the othe=
r
> builtins when they were lifted from shell code. It might be nice to h=
ave
> of course. Is it really needed?

I don't ever use it myself and I think it's more confusing than helpful=
=2E
I only added it to avoid introducing behavior changes in the port.  I
don't have strong feelings either way.

> > +
> > +extern int parse_options(const char ***argv,
> > +			 struct option *options, int count,
> > +			 const char *usage_string);
>=20
> I think the interface could be improved a bit. For example, it doesn'=
t
> need to count argument since the last entry in the options array is
> OPTION_LAST and thus the size can be detected that way.

Hehe, yeah, that's how I did it first.  I don't have a strong preferenc=
e
for terminator elements vs. ARRAY_SIZE(), but Junio prefers the
ARRAY_SIZE() approach, I guess.  At this point I'm just trying the get
the patches upstream...

> Also, I think for this to be more usable for other built-in programs =
it
> shouldn't modify argv, but instead take both argc and argv (so we don=
't
> need to have code like "*++(*argv)" ;), parse _all_ options in one go=
,
> and return the index (of argv) for any remaining options.
>=20
> Then the following:
>=20
> 	while (parse_options(argv, commit_options, ARRAY_SIZE(commit_options=
),
> 		builtin_commit_usage))
> 		;
>=20
> becomes:
>=20
> 	int i;
> 	...
> 	i =3D parse_options(argc, argv, commit_options, builtin_commit_usage=
);
>=20
> This fits better with how option parsing is currently done. Take
> builtin-add for example:
>=20
> 	for (i =3D 1 ; i < argc ; i++) {
> 		const char *arg =3D argv[i];
> 		/* ... */
> 	}
> 	if (argc <=3D i)
> 		usage(builtin_rm_usage);

No objections, I think that looks better too.

> [ BTW, blame option parsing actually wants to know if "--" has been s=
een,
>   but I think that can be worked around by simply checking argv[i - 1=
]
>   after calling the option parser. ]
>=20
> > +
> > +#endif
>=20
> OK, I will stop these ramblings here. I hope the fact that I read you=
r
> patch both back and forth and added comments in the process didn't ma=
ke
> it too confusing.

Heh, that's what I do myself :)

thanks for the comments,
Kristian
