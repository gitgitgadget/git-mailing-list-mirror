From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 15/16] config: add core.noshallow to prevent turning a repo into a shallow one
Date: Mon, 22 Jul 2013 20:23:10 +0100
Organization: OPDS
Message-ID: <BF5D998BFA5241938531635E1D8B79DF@PhilipOakley>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com> <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-16-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 22 21:23:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1LhC-0003dH-9X
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 21:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180Ab3GVTWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 15:22:53 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61440 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933169Ab3GVTWw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 15:22:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQOAGOG7VFZ8YYB/2dsb2JhbABbgwY1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZDwEFEQUIAQEhCwIDBQIBAxEDAQIDAgUhAgIUAQQIEAIGBw8IBgEHCwgCAQIDAQwEh10DCQoIplyIVQ2IXoEojAKBTwYtag2CVzNuA459hneDEop+hSaBMyaBOjs
X-IPAS-Result: AjQOAGOG7VFZ8YYB/2dsb2JhbABbgwY1g1qFPrdlAQMBgRUXdIIfBQEBBAEIAQEZDwEFEQUIAQEhCwIDBQIBAxEDAQIDAgUhAgIUAQQIEAIGBw8IBgEHCwgCAQIDAQwEh10DCQoIplyIVQ2IXoEojAKBTwYtag2CVzNuA459hneDEop+hSaBMyaBOjs
X-IronPort-AV: E=Sophos;i="4.89,720,1367967600"; 
   d="scan'208";a="436286778"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip01ir2.opaltelecom.net with SMTP; 22 Jul 2013 20:22:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230987>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
Subject: [PATCH v2 15/16] config: add core.noshallow to prevent turning=
=20
a repo into a shallow one

Surely this should be the default now that it is possible to corrupt a=20
golden repo by pushing/fetching a shallow repository to it and it then=20
becomes shallow, and all the followers become shallow as well, with=20
consequent problems (IIUC) [PATCH v2 05/16].

It would be just as easy to change the config to core.allowshallow whic=
h=20
then must be enabled by the user, and can be mentioned in the shallow=20
clone option's documentation.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Documentation/config.txt | 5 +++++
> builtin/receive-pack.c   | 9 ++++++++-
> cache.h                  | 1 +
> config.c                 | 5 +++++
> environment.c            | 1 +
> fetch-pack.c             | 9 ++++++++-
> t/t5536-fetch-shallow.sh | 9 +++++++++
> t/t5537-push-shallow.sh  | 6 ++++++
> 8 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 81856dd..e811180 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -655,6 +655,11 @@ core.abbrev::
>  for abbreviated object names to stay unique for sufficiently long
>  time.
>
> +core.noshallow::
> + If true, reject any pushes or fetches that may turn the
> + repository into a shallow one. This setting is ignored if the
> + repository is already shallow.
> +
> add.ignore-errors::
> add.ignoreErrors::
>  Tells 'git add' to continue adding files when some files cannot be
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 54bf6b2..95ea481 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -936,7 +936,14 @@ static const char *unpack(int err_fd)
>  &shallow,
>  WRITE_SHALLOW_NO_CUT |
>  WRITE_SHALLOW_REWRITE);
> - commit_lock_file(&shallow_lock);
> + if (*alternate_shallow_file =3D=3D '\0') {
> + unlink_or_warn(git_path("shallow"));
> + rollback_lock_file(&shallow_lock);
> + } else {
> + if (!is_repository_shallow() && cannot_be_shallow)
> + die("not allowed to turn this repository into a shallow one");
> + commit_lock_file(&shallow_lock);
> + }
>  }
>  return NULL;
> }
> diff --git a/cache.h b/cache.h
> index 7f17228..3a52b08 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -592,6 +592,7 @@ extern int fsync_object_files;
> extern int core_preload_index;
> extern int core_apply_sparse_checkout;
> extern int precomposed_unicode;
> +extern int cannot_be_shallow;
>
> /*
>  * The character that begins a commented line in user-editable file
> diff --git a/config.c b/config.c
> index d04e815..31f5a57 100644
> --- a/config.c
> +++ b/config.c
> @@ -784,6 +784,11 @@ static int git_default_core_config(const char=20
> *var, const char *value)
>  return 0;
>  }
>
> + if (!strcmp(var, "core.noshallow")) {
> + cannot_be_shallow =3D git_config_bool(var, value);
> + return 0;
> + }
> +
>  /* Add other config variables here and to Documentation/config.txt.=20
> */
>  return 0;
> }
> diff --git a/environment.c b/environment.c
> index 0cb67b2..14c8005 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -61,6 +61,7 @@ int merge_log_config =3D -1;
> int precomposed_unicode =3D -1; /* see probe_utf8_pathname_compositio=
n()=20
> */
> struct startup_info *startup_info;
> unsigned long pack_size_limit_cfg;
> +int cannot_be_shallow;
>
> /*
>  * The character that begins a commented line in user-editable file
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f337526..40e7aa2 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -960,7 +960,14 @@ struct ref *fetch_pack(struct fetch_pack_args=20
> *args,
>  WRITE_SHALLOW_NO_CUT |
>  WRITE_SHALLOW_REWRITE);
>  }
> - commit_lock_file(&shallow_lock);
> + if (*alternate_shallow_file =3D=3D '\0') {
> + unlink_or_warn(git_path("shallow"));
> + rollback_lock_file(&shallow_lock);
> + } else {
> + if (!is_repository_shallow() && cannot_be_shallow)
> + die("not allowed to turn this repository into a shallow one");
> + commit_lock_file(&shallow_lock);
> + }
>  }
>  }
>
> diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
> index 6ea6347..b7f89b1 100755
> --- a/t/t5536-fetch-shallow.sh
> +++ b/t/t5536-fetch-shallow.sh
> @@ -102,6 +102,15 @@ EOF
>
> '
>
> +test_expect_success 'core.noshallow' '
> + git init clean &&
> + (
> + cd clean &&
> + git config core.noshallow true &&
> + test_must_fail git fetch ../shallow/.git
> + )
> +'
> +
> if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
>  say 'skipping remaining tests, git built without http support'
>  test_done
> diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
> index 8bea496..0edd51f 100755
> --- a/t/t5537-push-shallow.sh
> +++ b/t/t5537-push-shallow.sh
> @@ -108,6 +108,12 @@ EOF
>  )
> '
>
> +test_expect_success 'core.noshallow' '
> + git init clean &&
> + git --git-dir=3Dclean/.git config core.noshallow true &&
> + test_must_fail git --git-dir=3Dshallow/.git push clean=20
> master:refs/remotes/shallow/master
> +'
> +
> if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
>  say 'skipping remaining tests, git built without http support'
>  test_done
> --=20
> 1.8.2.83.gc99314b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3349 / Virus Database: 3204/6504 - Release Date:=20
> 07/19/13
>=20
