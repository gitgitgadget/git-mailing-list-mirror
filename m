From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCHv4 2/4] commit: Show author if different from committer
Date: Tue, 06 May 2008 16:34:52 -0700
Message-ID: <7vej8fgg6b.fsf@gitster.siamese.dyndns.org>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
 <1209917092-12146-3-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 01:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtWhn-0003wH-Nl
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 01:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbYEFXfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 19:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbYEFXfI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 19:35:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYEFXfG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 19:35:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB3751632;
	Tue,  6 May 2008 19:35:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E80C41630; Tue,  6 May 2008 19:35:01 -0400 (EDT)
In-Reply-To: <1209917092-12146-3-git-send-email-sbejar@gmail.com> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Sun, 4 May 2008 18:04:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DFD6692-1BC5-11DD-9DAE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81387>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> That would help reassure anybody while committing other's changes.
>
> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> ---
>  builtin-commit.c  |   25 ++++++++++++++++++++++---
>  t/t7502-commit.sh |   12 ++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index a37d8c3..d03b6b2 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -47,6 +47,7 @@ static enum {
> =20
>  static char *logfile, *force_author, *template_file;
>  static char *edit_message, *use_message;
> +static char *author_name, *author_email, *author_date;
>  static int all, edit_flag, also, interactive, only, amend, signoff;
>  static int quiet, verbose, untracked_files, no_verify, allow_empty;
>  /*
> @@ -395,7 +396,7 @@ static int is_a_merge(const unsigned char *sha1)
> =20
>  static const char sign_off_header[] =3D "Signed-off-by: ";
> =20
> -static void determine_author_info(struct strbuf *sb)
> +static void determine_author_info(void)
>  {
>  	char *name, *email, *date;
> =20

The parameter list here should be "(void)" like the above (I've already
touched up).

> @@ -545,6 +552,17 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix)
>  		if (only_include_assumed)
>  			fprintf(fp, "# %s\n", only_include_assumed);
> =20
> +		author_ident =3D xstrdup(fmt_name(author_name, author_email));
> +		committer_ident =3D
> +			xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
> +					 getenv("GIT_COMMITTER_EMAIL")));

The lifetime of these two variables are inside "if (use_editor)" so it
would be better to move the decl inside it.  Then it would become more
obvious that these two leaks and are safe to free at the end of the
scope.
