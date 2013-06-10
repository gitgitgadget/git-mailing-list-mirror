From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH 1/2] rm: better error message on failure for multiple  files
Date: Mon, 10 Jun 2013 14:53:58 +0200
Message-ID: <d0b036b99a012c5c550f76351f0dcbcb@ensibm.imag.fr>
References: <1370868700-27189-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 14:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um1bx-0006eW-HE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 14:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab3FJMyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 08:54:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59470 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab3FJMyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 08:54:08 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5ACruK2029541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 14:53:56 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5ACrwXO014430;
	Mon, 10 Jun 2013 14:53:58 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5ACrwqI022032;
	Mon, 10 Jun 2013 14:53:58 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5ACrwUJ022031;
	Mon, 10 Jun 2013 14:53:58 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <1370868700-27189-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 14:53:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227281>

Please ignore this, manipulation error while in the git send-email=20
command line.

Le 2013-06-10 14:51, Mathieu Lienard--Mayor a =C3=A9crit=C2=A0:
> When 'git rm' fails, it now displays a single message
> with the list of files involved, instead of displaying
> a list of messages with one file each.
>
> As an example, the old message:
> 	error: 'foo.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
> 	error: 'bar.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
>
> would now be displayed as:
> 	error: the following files have changes staged in the index:
> 		foo.txt
> 		bar.txt
> 	(use --cached to keep the file, or -f to force removal)
>
> Signed-off-by: Mathieu Lienard--Mayor=20
> <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia
> <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>  builtin/rm.c |   93=20
> +++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 79 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 7b91d52..1bff656 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -82,6 +82,11 @@ static int check_local_mod(unsigned char *head,
> int index_only)
>  	int i, no_head;
>  	int errs =3D 0;
>
> +	struct string_list files_staged =3D STRING_LIST_INIT_NODUP;
> +	struct string_list files_cached =3D STRING_LIST_INIT_NODUP;
> +	struct string_list files_submodule =3D STRING_LIST_INIT_NODUP;
> +	struct string_list files_local =3D STRING_LIST_INIT_NODUP;
> +
>  	no_head =3D is_null_sha1(head);
>  	for (i =3D 0; i < list.nr; i++) {
>  		struct stat st;
> @@ -171,29 +176,89 @@ static int check_local_mod(unsigned char *head,
> int index_only)
>  		 */
>  		if (local_changes && staged_changes) {
>  			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
> -				errs =3D error(_("'%s' has staged content different "
> -					     "from both the file and the HEAD\n"
> -					     "(use -f to force removal)"), name);
> +				string_list_append(&files_staged, name);
>  		}
>  		else if (!index_only) {
>  			if (staged_changes)
> -				errs =3D error(_("'%s' has changes staged in the index\n"
> -					     "(use --cached to keep the file, "
> -					     "or -f to force removal)"), name);
> +				string_list_append(&files_cached, name);
>  			if (local_changes) {
>  				if (S_ISGITLINK(ce->ce_mode) &&
>  				    !submodule_uses_gitfile(name)) {
> -					errs =3D error(_("submodule '%s' (or one of its nested "
> -						     "submodules) uses a .git directory\n"
> -						     "(use 'rm -rf' if you really want to remove "
> -						     "it including all of its history)"), name);
> -				} else
> -					errs =3D error(_("'%s' has local modifications\n"
> -						     "(use --cached to keep the file, "
> -						     "or -f to force removal)"), name);
> +					string_list_append(&files_submodule,
> +							   name);
> +				} else {
> +					string_list_append(&files_local, name);
> +				}
>  			}
>  		}
>  	}
> +	if (files_staged.nr) {
> +		struct strbuf msg_staged =3D STRBUF_INIT;
> +		int j;
> +		strbuf_addstr(
> +			&msg_staged,
> +			"the following files have staged content different "
> +			"from both the\nfile and the HEAD:");
> +		for (j =3D 0; j < files_staged.nr; j++) {
> +			strbuf_addf(&msg_staged,
> +				    "\n	%s",
> +				    files_staged.items[j].string);
> +		}
> +		strbuf_addstr(&msg_staged,
> +			      "\n(use -f to force removal)");
> +		errs =3D error(_("%s"), msg_staged.buf);
> +	}
> +	if (files_cached.nr) {
> +		struct strbuf msg_cached =3D STRBUF_INIT;
> +		int j;
> +		strbuf_addstr(
> +			&msg_cached,
> +			"the following files have changes staged "
> +			"in the index:");
> +		for (j =3D 0; j < files_cached.nr; j++) {
> +			strbuf_addf(&msg_cached,
> +				    "\n	%s",
> +				    files_cached.items[j].string);
> +		}
> +		strbuf_addstr(&msg_cached,
> +			      "\n(use --cached to keep the file, "
> +			      "or -f to force removal)");
> +		errs =3D error(_("%s"), msg_cached.buf);
> +	}
> +	if (files_submodule.nr) {
> +		struct strbuf msg_sub =3D STRBUF_INIT;
> +		int j;
> +		strbuf_addstr(
> +			&msg_sub,
> +			"the following submodules (or one of its nested "
> +			"submodule) use a .git directory:");
> +		for (j =3D 0; j < files_submodule.nr; j++) {
> +			strbuf_addf(&msg_sub,
> +				    "\n	%s",
> +				    files_submodule.items[j].string);
> +		}
> +		strbuf_addstr(&msg_sub,
> +			      "\n(use 'rm -rf' if you really want "
> +			      "to remove i including all "
> +			      "of its history)");
> +		errs =3D error(_("%s"), msg_sub.buf);
> +	}
> +	if (files_local.nr) {
> +		struct strbuf msg_local =3D STRBUF_INIT;
> +		int j;
> +		strbuf_addstr(&msg_local,
> +			      "the following files have local modifications:");
> +		for (j =3D 0; j < files_local.nr; j++) {
> +			strbuf_addf(&msg_local,
> +				    "\n	%s",
> +				    files_local.items[j].string);
> +		}
> +		strbuf_addstr(&msg_local,
> +			      "\n(use --cached to keep the file, "
> +			      "or -f to force removal)");
> +		errs =3D error(_("%s"), msg_local.buf);
> +	}
> +
>  	return errs;
>  }

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
