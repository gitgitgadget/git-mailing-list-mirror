From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: convert to parse-options
Date: Thu, 14 Apr 2011 10:08:08 -0700
Message-ID: <7v7hawiww7.fsf@alter.siamese.dyndns.org>
References: <7vlizem9bx.fsf@alter.siamese.dyndns.org>
 <1302791310-19640-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:08:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAQ1p-0001Xk-Di
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 19:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428Ab1DNRIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 13:08:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893Ab1DNRIT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 13:08:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09E975628;
	Thu, 14 Apr 2011 13:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1GrZ4lC6tzDB
	nH7ZxjX7ruhdjVY=; b=LRTTXH+t4cjlGiDXohwO+3nzIrqKiZnAx+sIgMV5YNpV
	vwxMtT9FBBlPkCCNGKATZbiG6pyCSJLQpJkOUodGIjvDcb/3Ngct7OpTWgXWlg/x
	Kn5NnqFJLQPhNGelZhOj2+ojatDPLTHmCNLhnZPw2+NpBNDNoVM2C2LGnITWiLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jksD2s
	qIJSe215Vplxu2sLvjp1lMbZYhKPjIPtW3KqyOw20gxFll4QUKvGLP52/hFEbi1V
	GqSU+3FuNy9sRIgRLQH1AntbXKYM/reNpQKz4A+BpC5afHyjti0+8qdsy66mirLp
	rngaeSAxqx6/qldWlGZEl6f7K6hLydlggUWWw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAC6A5627;
	Thu, 14 Apr 2011 13:10:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F2AF5626; Thu, 14 Apr 2011
 13:10:09 -0400 (EDT)
In-Reply-To: <1302791310-19640-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 14 Apr 2011 16:28:30
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F533E70-66BA-11E0-AA07-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171525>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 9a15d69..5316be3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -25,6 +25,7 @@ static const char *default_date_mode =3D NULL;
> =20
>  static int default_show_root =3D 1;
>  static int decoration_style;
> +static int decoration_given =3D 0;

We prefer to leave zero-initialization of statics to the linker, simila=
rly
to how we initialize decoration_style to zero in the line above.

> +static int decorate_callback(const struct option *opt, const char *a=
rg, int unset)
> +{
> +	if (unset) {
> +		decoration_style =3D 0;
> +		return 0;
> +	}

This is not a new issue, but I do not think the original code did not m=
ean
to keep decoration_given unmodified when --no-decorate was given from t=
he
command line.  The variable is about "did we get any --decorate related
options from the command line to override whatever log.decorate variabl=
e
says?", and when we saw --no-decorate, we did get such an override from
the command line.  We should consistently set _given variable to 1 here=
=2E

It is immaterial that it happens not to matter to the current user of t=
he
variable that sets decoration_style to zero.  The next user of _given m=
ay
want to do other things.

> +	if (arg =3D=3D NULL) {
> +		decoration_style =3D DECORATE_SHORT_REFS;
> +		decoration_given =3D 1;
> +		return 0;
> +	}
> +
> +	/* First arg is irrelevant, as it just tries to parse arg */
> +	decoration_style =3D parse_decoration_style("decorate", arg);

It is used in the error message in git_config_long() in the callchain f=
rom
here, primarily meant to report which configuration variable had a bad
value, so it is in no way irrelevant.  We need to say that a bad value
comes not from a configuration but from the command line; get_color() i=
n
builtin/config.c passes "command line" for this exact reason.

>  static void cmd_log_init(int argc, const char **argv, const char *pr=
efix,
>  			 struct rev_info *rev, struct setup_revision_opt *opt)
>  {
> -	int i;
> -	int decoration_given =3D 0;
>  	struct userformat_want w;
> +	int help, quiet, source;
> +
> +	const struct option builtin_log_options[] =3D {
> +		OPT_BOOLEAN(0, "h", &help, "show help"),
> +		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
> +		OPT_BOOLEAN(0, "source", &source, "show source"),
> +		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
> +		  PARSE_OPT_OPTARG, decorate_callback},
> +		OPT_END()
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, builtin_log_options,
> +						 builtin_log_usage,
> +						 PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
> +						 PARSE_OPT_KEEP_DASHDASH);

The 5th parameter is an array of strings terminated with a NULL element=
=2E

> +	if (help)
> +		usage(builtin_log_usage);

I think parse_options() handles -h and --help itself, so there is no
longer need for this.

How about this fix-up patch on top of your version?

 builtin/log.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5316be3..80766a9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,13 +25,15 @@ static const char *default_date_mode =3D NULL;
=20
 static int default_show_root =3D 1;
 static int decoration_style;
-static int decoration_given =3D 0;
+static int decoration_given;
 static const char *fmt_patch_subject_prefix =3D "PATCH";
 static const char *fmt_pretty;
=20
-static const char * const builtin_log_usage =3D
+static const char * const builtin_log_usage[] =3D {
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-	"   or: git show [options] <object>...";
+	"   or: git show [options] <object>...",
+	NULL
+};
=20
 static int parse_decoration_style(const char *var, const char *value)
 {
@@ -52,19 +54,13 @@ static int parse_decoration_style(const char *var, =
const char *value)
=20
 static int decorate_callback(const struct option *opt, const char *arg=
, int unset)
 {
-	if (unset) {
+	if (unset)
 		decoration_style =3D 0;
-		return 0;
-	}
-
-	if (arg =3D=3D NULL) {
+	else if (arg)
+		decoration_style =3D parse_decoration_style("command line", arg);
+	else
 		decoration_style =3D DECORATE_SHORT_REFS;
-		decoration_given =3D 1;
-		return 0;
-	}
=20
-	/* First arg is irrelevant, as it just tries to parse arg */
-	decoration_style =3D parse_decoration_style("decorate", arg);
 	if (decoration_style < 0)
 		die("invalid --decorate option: %s", arg);
=20
@@ -77,10 +73,9 @@ static void cmd_log_init(int argc, const char **argv=
, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int help, quiet, source;
+	int quiet, source;
=20
 	const struct option builtin_log_options[] =3D {
-		OPT_BOOLEAN(0, "h", &help, "show help"),
 		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
 		OPT_BOOLEAN(0, "source", &source, "show source"),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
@@ -88,13 +83,10 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 		OPT_END()
 	};
=20
-	argc =3D parse_options(argc, argv, prefix, builtin_log_options,
-						 builtin_log_usage,
-						 PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
-						 PARSE_OPT_KEEP_DASHDASH);
-
-	if (help)
-		usage(builtin_log_usage);
+	argc =3D parse_options(argc, argv, prefix,
+			     builtin_log_options, builtin_log_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
=20
 	rev->abbrev =3D DEFAULT_ABBREV;
 	rev->commit_format =3D CMIT_FMT_DEFAULT;
