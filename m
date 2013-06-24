From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 20:04:19 +0200
Message-ID: <20130624180419.GC26287@paksenarrion.iveqy.com>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrB7w-00087m-3k
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab3FXSE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 14:04:28 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:53708 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab3FXSE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:04:27 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so10835771lab.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yj5vOLf41KVYYSXVECMU74dLwZWhzyOdFnYq7gQ1GM0=;
        b=gSyW9VrAqdxGHkZLgjKhAdPwNFASGbu08F2c43E1AG3o946a/Si5SKztDkXxTL7kma
         Wj1VuYXQVqxeVPT3j4CfcPgUvV7wvLdPkobE55JIgwZ0rTtsGmlxZjrgEqzUfadoJ8G2
         lhGSxqk/VRhGTep34Hp482sboBCNnarlBLoFyvQBocd9y4jod8uZykAv48lM9y9Y9bVg
         qiHxJciyFL8g5Rto+vvMphsTLeUNUeg5jyTUhVP1jfe94f24SJTmmF5RL7vIi8EduVvd
         p+Y1q4XfrRMPG7jbbPYWUAhSIFy+CYvei3nvsiKmez5mRE1LCxY5UX+guo3j0O4M7GRn
         Tu5g==
X-Received: by 10.152.4.232 with SMTP id n8mr12058713lan.29.1372097065684;
        Mon, 24 Jun 2013 11:04:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id x8sm7223230lae.10.2013.06.24.11.04.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 11:04:25 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UrB7j-0007ca-6T; Mon, 24 Jun 2013 20:04:19 +0200
Content-Disposition: inline
In-Reply-To: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228885>

On Mon, Jun 24, 2013 at 11:11:02PM +0530, Ramkumar Ramachandra wrote:
> There are many configuration variables that determine exactly what a
> push does.  Give the user early feedback so that she has a chance to
> abort if she doesn't mean to push those refspecs to that destination
> like:
>=20
>   $ git push
>   # pushing refspecs 'master next' to ram (^C to abort)
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Goes without saying: this is an early preview.
>=20
>  builtin/push.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/builtin/push.c b/builtin/push.c
> index 2d84d10..085d5ab 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -330,6 +330,7 @@ static int do_push(const char *repo, int flags)
>  {
>  	int i, errs;
>  	struct remote *remote =3D pushremote_get(repo);
> +	struct strbuf sb =3D STRBUF_INIT;
>  	const char **url;
>  	int url_nr;
> =20
> @@ -375,6 +376,11 @@ static int do_push(const char *repo, int flags)
>  	}
>  	errs =3D 0;
>  	url_nr =3D push_url_of_remote(remote, &url);
> +
> +	for (i =3D 0; i < refspec_nr; i++)
> +		strbuf_addf(&sb, "%s%s", refspec[i], i =3D=3D refspec_nr - 1 ? "":=
 " ");
> +	printf("# pushing refspecs '%s' to %s (^C to abort)\n", sb.buf, rem=
ote->name);
> +

How about a strbuf_release here?

Can you really be sure that refspec_nr is set here?

>  	if (url_nr) {
>  		for (i =3D 0; i < url_nr; i++) {
>  			struct transport *transport =3D
> --=20
> 1.8.3.1.549.g1f3a412.dirty

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
