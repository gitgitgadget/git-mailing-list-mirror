From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: Show committer if automatic
Date: Sat, 03 May 2008 11:33:05 -0700
Message-ID: <7vmyn7tezi.fsf@gitster.siamese.dyndns.org>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
 <1209752541-19111-2-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsMYw-0004ml-OK
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488AbYECSdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 May 2008 14:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbYECSdS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:33:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYECSdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2008 14:33:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7011518C4;
	Sat,  3 May 2008 14:33:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 768B218C3; Sat,  3 May 2008 14:33:11 -0400 (EDT)
In-Reply-To: <1209752541-19111-2-git-send-email-sbejar@gmail.com> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 2 May 2008 20:22:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6551B4DA-193F-11DD-A5DB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81112>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> To remind the committer ident in case it is not what you want
> (taken from the gecos field, want to use different ident in
> different repositories).

That's not the only thing this patch does.

> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> ---
>  builtin-commit.c  |   40 +++++++++++++++++++++++++++++++++++++---
>  cache.h           |    1 +
>  config.c          |    4 ++++
>  environment.c     |    1 +
>  ident.c           |    3 +++
>  t/t7502-commit.sh |   13 +++++++++++++
>  6 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 057749b..b7cc382 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -437,6 +437,29 @@ static void determine_author_info()
>  	author_date =3D date;
>  }
> =20
> +const char *get_parent_ident()
> +{
> +	unsigned char sha1[20];
> +	struct commit *commit;
> +	const char *a, *lb, *rb, *eol;
> +
> +
> +	get_sha1("HEAD", sha1);
> +	commit =3D lookup_commit_reference(sha1);
> +	if (!commit)
> +		return NULL;
> +
> +	a =3D strstr(commit->buffer, "\ncommitter ");
> +
> +	lb =3D strstr(a + 11, " <");
> +	rb =3D strstr(a + 11, "> ");
> +	eol =3D strchr(a + 11, '\n');
> +	if (!lb || !rb || !eol)
> +		return NULL;
> +
> +	return xstrndup(a + 11, rb + 1 - (a + 11));
> +}
> +

Drop this hunk; nobody uses it after applying this patch, and "the same
committer as the HEAD commit" is not a good heuristic.

>  static int prepare_to_commit(const char *index_file, const char *pre=
fix)
>  {
>  	struct stat statbuf;
> @@ -448,6 +471,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix)
>  	const char *hook_arg2 =3D NULL;
>  	const char *author_ident;
>  	const char *committer_ident;
> +	int showed_ident =3D 0;
> =20
>  	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
>  		return 0;
> @@ -528,6 +552,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix)
>  	strbuf_release(&sb);
> =20
>  	determine_author_info();
> +	git_committer_info(0);

This call needs a comment to justify it, as it feels wrong to call a
function that usually is used for its return string and discard the ret=
urn
value.

> @@ -558,11 +583,20 @@ static int prepare_to_commit(const char *index_=
file, const char *prefix)
>  					 getenv("GIT_COMMITTER_EMAIL")));
>  		if (strcmp(author_ident, committer_ident))
>  			fprintf(fp,
> -				"#\n"
> -				"# Author:    %s\n"
> -				"#\n",
> +				"%s"
> +				"# Author:    %s\n",
> +				showed_ident++ ? "" : "#\n",
>  				fmt_name(author_name, author_email));

This part should have been [0/2] as it has been agreed it is a good ide=
a.
