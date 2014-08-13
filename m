From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 1/2] git_default_config() rewritten using the config-set API
Date: Wed, 13 Aug 2014 18:16:44 +0200
Message-ID: <vpqa978qs9f.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com>
	<vpq4mxgtu07.fsf@anie.imag.fr> <53EB6914.2030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHbEN-0005el-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 18:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbaHMQQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 12:16:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34655 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbaHMQQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 12:16:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DGGhp7016774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 18:16:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DGGiM8026033;
	Wed, 13 Aug 2014 18:16:44 +0200
In-Reply-To: <53EB6914.2030807@gmail.com> (Tanay Abhra's message of "Wed, 13
	Aug 2014 19:03:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 18:16:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DGGhp7016774
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408551405.99259@TZsqsviKRtnBqsyEMi6lIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255214>

Tanay Abhra <tanayabh@gmail.com> writes:

> git_default_config() now uses config-set API functions to query for
> values.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Sorry, for the short log message, I will explain why.
> The git_default_config() rewrite is 100% complete, the only
> problem remains is the call sites; there are too many of them.
> Some are called from callback functions which pass the remaining
> variables to git_default_config() which they do not have any use for.
> Those call sites can remain as they are, because git_default_config()
> is a single call function now, and is guarded by a sentinel value.

They can remain as they are, but it would also be relatively easy to
turn them into non-callback style by doing something like this on each
call:

--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -37,7 +37,7 @@ static int commit_tree_config(const char *var, const =
char *value, void *cb)
                sign_commit =3D git_config_bool(var, value) ? "" : NULL=
;
                return 0;
        }
-       return git_default_config(var, value, cb);
+       return 0
 }
=20
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
@@ -49,6 +49,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
        struct strbuf buffer =3D STRBUF_INIT;
=20
        git_config(commit_tree_config, NULL);
+       git_default_config();
=20
        if (argc < 2 || !strcmp(argv[1], "-h"))
                usage(commit_tree_usage);

> -int git_default_config(const char *var, const char *value, void *dum=
my)
> +int git_default_config(const char *unused, const char *unused2, void=
 *dummy)

By having these dummy arguments, you force callers to pass dummy actual
parameters.

Actually, you don't pass anything in PATCH 2, hence the result is not
compilable:

http-fetch.c:70:2: error: too few arguments to function =E2=80=98git_de=
fault_config=E2=80=99
  git_default_config();
  ^
In file included from http-fetch.c:1:0:
cache.h:1299:12: note: declared here
 extern int git_default_config(const char *, const char *, void *);

After your patch, there are two things git_default_config do:

1) normal callers want to call git_default_config();

2) callback-style callers want to write
   return git_default_config(var, value, cb);

I think this deserves two functions, calling each others:

/* For 1) */
void git_load_default_config(void)
{
	do the actual stuff
}

/* For 2) */
int git_default_config(const char *unused, const char *unused2, void *d=
ummy)
{
	if (default_config_loaded)
		return;
	git_load_default_config(NULL, NULL, NULL);
	default_config_loaded =3D 1;
	return 0;
}

In an ideal world, git_default_config would disappear after the rewrite
is completed. In practice, it may stay if needed, it doesn't harm
anyone.

PATCH 2 would turn git_config(git_default_config, NULL); into
git_load_default_config().

> @@ -2082,6 +1977,7 @@ int git_config_set_multivar_in_file(const char =
*config_filename,
>
>  	/* Invalidate the config cache */
>  	git_config_clear();
> +	default_config_loaded =3D 0;

What about the other callsite in setup.c? We may have left the
configuration half-loaded, and if anyone calls git_load_default_config(=
)
again after that, we do want to reload it, don't we?

Which leads to another question: why not put this default_config_loaded
=3D 0; inside git_config_clear(), to avoid forgetting?

> index 1d9b6e7..0db595f 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -392,29 +392,26 @@ int author_ident_sufficiently_given(void)
>  	return ident_is_sufficient(author_ident_explicitly_given);
>  }
>
> -int git_ident_config(const char *var, const char *value, void *data)
> +void git_ident_config(void)
>  {
> -	if (!strcmp(var, "user.name")) {
> +	const char *value =3D NULL;
> +
> +	if (!git_config_get_value("user.name", &value)) {
>  		if (!value)
> -			return config_error_nonbool(var);
> +			git_die_config("user.name", "Missing value for 'user.name'");

I'd rather have git_config_get_string() and a free() afterwards to avoi=
d
duplicating this "Missing value for 'user.name'" (which should be _()-e=
d
if it stays).

> -
> -	if (!strcmp(var, "user.email")) {
> +	if (!git_config_get_value("user.email", &value)) {
>  		if (!value)
> -			return config_error_nonbool(var);
> +			git_die_config("user.email", "Missing value for 'user.email'");

Likewise.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
