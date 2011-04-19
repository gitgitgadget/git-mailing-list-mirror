From: =?us-ascii?B?PT9VVEYtOD9xP0Nhcmxvcz0yME1hcnQ9QzM9QURuPTIwTmlldG8/?=
	 =?us-ascii?Q?=3D?= <cmn@elego.de>
Subject: [PATCH] log: convert to parse-options
Date: Tue, 19 Apr 2011 14:33:31 +0200
Message-ID: <20110419123325.GA10814@bee.lab.cmartin.tk>
References: <7v7hawiww7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 14:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCA7f-0007Gn-Rk
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 14:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab1DSMde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 08:33:34 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:55131 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab1DSMdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 08:33:33 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 1DD3F46132;
	Tue, 19 Apr 2011 14:33:17 +0200 (CEST)
Received: (nullmailer pid 10873 invoked by uid 1000);
	Tue, 19 Apr 2011 12:33:31 -0000
Content-Disposition: inline
In-Reply-To: <7v7hawiww7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171795>

Use parse-options in cmd_log_init instead of manually iterating
through them. This makes the code a bit cleaner but more importantly
allows us to catch the "--quiet" option which causes some of the
log-related commands to misbehave as it would otherwise get passed on
to the diff.

Also take this opportinity to add 'whatchanged' to the help output.

Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
---

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

>> diff --git a/builtin/log.c b/builtin/log.c
>> index 9a15d69..5316be3 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -25,6 +25,7 @@ static const char *default_date_mode =3D3D3D NULL;
>>
>>  static int default_show_root =3D3D3D 1;
>>  static int decoration_style;
>> +static int decoration_given =3D3D3D 0;
>
>We prefer to leave zero-initialization of statics to the linker, simil=
arly
>to how we initialize decoration_style to zero in the line above.
>
>> +static int decorate_callback(const struct option *opt, const char *=
arg, int unset)
>> +{
>> +     if (unset) {
>> +             decoration_style =3D 0;
>> +             return 0;
>>+     }

> This is not a new issue, but I do not think the original code did not
> mean to keep decoration_given unmodified when --no-decorate was given
> from the command line.  The variable is about "did we get any
> --decorate related options from the command line to override whatever
> log.decorate variable says?", and when we saw --no-decorate, we did
> get such an override from the command line.  We should consistently
> set _given variable to 1 here.

> It is immaterial that it happens not to matter to the current user of=
 the
> variable that sets decoration_style to zero.  The next user of _given=
 may
> want to do other things.

Ok, I've changed this to use the version in your fixup patch.

> +     if (arg =3D=3D NULL) {
> +             decoration_style =3D DECORATE_SHORT_REFS;
> +             decoration_given =3D 1;
> +             return 0;
> +     }
> +
> +     /* First arg is irrelevant, as it just tries to parse arg */
> +     decoration_style =3D parse_decoration_style("decorate", arg);

> It is used in the error message in git_config_long() in the callchain=
 from
> here, primarily meant to report which configuration variable had a ba=
d
> value, so it is in no way irrelevant.  We need to say that a bad valu=
e
> comes not from a configuration but from the command line; get_color()=
 in
> builtin/config.c passes "command line" for this exact reason.
>=20

git_config_long doesn't die with an error (though git_config_int does,
if git_config_long isn't successful) but returns 0 if it can't parse
the value. git_config_maybe_bool notices this and returns -1, which
parse_decoration_style interprets as "was not boolean" and tries to
match "short" or "full". If it can't, then it returns -1 and
decoration_callback dies with the error message.

Be it as it may, gt_config_long doesn't output any error message at
all, so what we pass is irrelevant, unless we want to future-proof it
because we don't trust the git_config_maybe_bool call to let us handle
the error ourselves in the future.

>>  static void cmd_log_init(int argc, const char **argv, const char *p=
refix,
>>                        struct rev_info *rev, struct setup_revision_o=
pt *opt)
>>  {
>> -     int i;
>> -     int decoration_given =3D 0;
>>       struct userformat_want w;
>> +     int help, quiet, source;
>> +
>> +     const struct option builtin_log_options[] =3D {
>> +             OPT_BOOLEAN(0, "h", &help, "show help"),
>> +             OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output")=
,
>> +             OPT_BOOLEAN(0, "source", &source, "show source"),
>> +             { OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorat=
e options",
>> +               PARSE_OPT_OPTARG, decorate_callback},
>> +             OPT_END()
>> +     };
>> +
>> +     argc =3D parse_options(argc, argv, prefix, builtin_log_options=
,
>> +                                              builtin_log_usage,
>> +                                              PARSE_OPT_KEEP_ARGV0 =
| PARSE_OPT_KEEP_UNKNOWN |
>> +                                              PARSE_OPT_KEEP_DASHDA=
SH);

> The 5th parameter is an array of strings terminated with a NULL eleme=
nt.

Done.

>> +     if (help)
>> +             usage(builtin_log_usage);

> I think parse_options() handles -h and --help itself, so there is no
> longer need for this.

Indeed, removed.

As the help is generated from the option struct, I've changed the
comment a bit to me more helpful and I've added 'whatchanged' to the
usage message, as it looks bad if 'git whatchanged -h' doesn't tell
you about itself.

I'm not completely sure what "show source" is meant to be, I think
it's the source of merges, which could be added to that explanation, I =
guess.

 Documentation/git-format-patch.txt |    5 ++-
 builtin/log.c                      |   77 ++++++++++++++++++++++------=
--------
 2 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9a15d69..d1b0861 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,12 +25,16 @@ static const char *default_date_mode =3D NULL;
=20
 static int default_show_root =3D 1;
 static int decoration_style;
+static int decoration_given;
 static const char *fmt_patch_subject_prefix =3D "PATCH";
 static const char *fmt_pretty;
=20
-static const char * const builtin_log_usage =3D
+static const char * const builtin_log_usage[] =3D {
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-	"   or: git show [options] <object>...";
+	"   or: git show [options] <object>...\n"
+	"   or: git whatchanged [options] <object>...",
+	NULL
+};
=20
 static int parse_decoration_style(const char *var, const char *value)
 {
@@ -49,12 +53,44 @@ static int parse_decoration_style(const char *var, =
const char *value)
 	return -1;
 }
=20
+static int decorate_callback(const struct option *opt, const char *arg=
, int unset)
+{
+	if (unset)
+		decoration_style =3D 0;
+	else if (arg)
+		decoration_style =3D parse_decoration_style("decorate", arg);
+	else
+		decoration_style =3D DECORATE_SHORT_REFS;
+
+	if (decoration_style < 0)
+		die("invalid --decorate option: %s", arg);
+
+	decoration_given =3D 1;
+
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *pref=
ix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	int i;
-	int decoration_given =3D 0;
 	struct userformat_want w;
+	int dummy, source;
+
+	/*
+	 * The 'quiet' option is a dummy no-op to stop it from propagating
+	 * to the diff option parsing.
+	 */
+	const struct option builtin_log_options[] =3D {
+		OPT_BOOLEAN(0, "quiet", &dummy, "no-op, provided for compatability")=
,
+		OPT_BOOLEAN(0, "source", &source, "show source"),
+		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decoration options (d=
efault: short)",
+		  PARSE_OPT_OPTARG, decorate_callback},
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, prefix, builtin_log_options, built=
in_log_usage,
+						 PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+						 PARSE_OPT_KEEP_DASHDASH);
=20
 	rev->abbrev =3D DEFAULT_ABBREV;
 	rev->commit_format =3D CMIT_FMT_DEFAULT;
@@ -69,14 +105,12 @@ static void cmd_log_init(int argc, const char **ar=
gv, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode =3D parse_date_format(default_date_mode);
=20
-	/*
-	 * Check for -h before setup_revisions(), or "git log -h" will
-	 * fail when run without a git directory.
-	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_log_usage);
 	argc =3D setup_revisions(argc, argv, rev, opt);
=20
+	/* Any arguments at this point are not recognized */
+	if (argc > 1)
+		die("unrecognized argument: %s", argv[1]);
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
=20
@@ -92,26 +126,9 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 		if (rev->diffopt.nr_paths !=3D 1)
 			usage("git logs can only follow renames on one pathname at a time")=
;
 	}
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-		if (!strcmp(arg, "--decorate")) {
-			decoration_style =3D DECORATE_SHORT_REFS;
-			decoration_given =3D 1;
-		} else if (!prefixcmp(arg, "--decorate=3D")) {
-			const char *v =3D skip_prefix(arg, "--decorate=3D");
-			decoration_style =3D parse_decoration_style(arg, v);
-			if (decoration_style < 0)
-				die("invalid --decorate option: %s", arg);
-			decoration_given =3D 1;
-		} else if (!strcmp(arg, "--no-decorate")) {
-			decoration_style =3D 0;
-		} else if (!strcmp(arg, "--source")) {
-			rev->show_source =3D 1;
-		} else if (!strcmp(arg, "-h")) {
-			usage(builtin_log_usage);
-		} else
-			die("unrecognized argument: %s", arg);
-	}
+
+	if (source)
+		rev->show_source =3D 1;
=20
 	/*
 	 * defeat log.decorate configuration interacting with --pretty=3Draw
--=20
1.7.4.2.437.g4fc7e.dirty
