From: =?UTF-8?B?RsO8emVzaSBab2x0w6Fu?= <zfuzesi@eaglet.hu>
Subject: Re: [PATCH] submodule: show_submodule_summary: preserve diff queue
Date: Wed, 4 Aug 2010 20:15:42 +0200
Message-ID: <AANLkTi=VPO-KLpA3SnKTxMbSBv3XeMMKjJr6oXNAr-vD@mail.gmail.com>
References: <1280933106-7016-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 20:15:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgiVI-0006RE-7K
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab0HDSPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 14:15:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61349 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0HDSPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 14:15:43 -0400
Received: by gwb20 with SMTP id 20so2098830gwb.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 11:15:42 -0700 (PDT)
Received: by 10.150.69.34 with SMTP id r34mr10807688yba.385.1280945742628; 
	Wed, 04 Aug 2010 11:15:42 -0700 (PDT)
Received: by 10.231.185.92 with HTTP; Wed, 4 Aug 2010 11:15:42 -0700 (PDT)
In-Reply-To: <1280933106-7016-1-git-send-email-zfuzesi@eaglet.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152591>

2010/8/4 Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>:
> git-diff with --submodule option stopped printing diff lines after a =
submodule
> change, because show_submodule_summary reset diff queue.
> ---
> =C2=A0submodule.c | =C2=A0 =C2=A09 +++++++++
> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 61cb6e2..5b57536 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -46,6 +46,12 @@ done:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> +static void diff_q_copy(struct diff_queue_struct *dst,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct diff_queue_struct *src)
> +{
> + =C2=A0 =C2=A0 =C2=A0 memcpy(dst, src, sizeof(struct diff_queue_stru=
ct));
> +}
> +
> =C2=A0void handle_ignore_submodules_arg(struct diff_options *diffopt,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *arg)
> =C2=A0{
> @@ -71,6 +77,7 @@ void show_submodule_summary(FILE *f, const char *pa=
th,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf sb =3D STRBUF_INIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char *format =3D " =C2=A0%m %=
s";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fast_forward =3D 0, fast_backward =3D =
0;
> + =C2=A0 =C2=A0 =C2=A0 struct diff_queue_struct diff_q_backup;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_null_sha1(two))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0message =3D "(=
submodule deleted)";
> @@ -83,6 +90,7 @@ void show_submodule_summary(FILE *f, const char *pa=
th,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0message =3D "(=
commits not present)";
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!message) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_q_copy(&diff_=
q_backup, &diff_queued_diff);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_revisions=
(&rev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setup_revision=
s(0, NULL, &rev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rev.left_right=
 =3D 1;
> @@ -146,6 +154,7 @@ void show_submodule_summary(FILE *f, const char *=
path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_commit_m=
arks(left, ~0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_commit_m=
arks(right, ~0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_q_copy(&diff_=
queued_diff, &diff_q_backup);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_release(&sb);
> =C2=A0}
> --
> 1.7.2.1.22.ge7bdd
>
>

hi, commit ee38d823f74bd8872c1e793f98a5b5523ee04646 makes my patch unne=
cessary.
