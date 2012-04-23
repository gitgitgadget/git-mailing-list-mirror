From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] i18n: help: mark strings for translation
Date: Mon, 23 Apr 2012 11:30:32 -0500
Message-ID: <20120423163032.GF4832@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMA3-00009z-5R
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab2DWQam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 12:30:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62803 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab2DWQal convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 12:30:41 -0400
Received: by obbta14 with SMTP id ta14so12876441obb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wWmTt/NEBMEI7wPNLQLdOwrCoeNfeuC1YoPqGgMpvtY=;
        b=N1vYV8Vf5hiw/FNI7zGXuno3I5KG5q+/LTTEvfRukOiFi+L5bABX0T7QlrdHChrNj7
         RLfNa+LSz1cV73Mv6PfPJa2XyFvchAKJqDmjo9iil3VIoaS1DnY0nZ3iNnnY7+ZB9MbR
         fpnMx/RfR4Gttpu98tTZ73GvFP7ovowljK0PgQ3KHVV2t1djAsRU6+MKMAqhZ6555zgU
         gH3EPXGHphWH1ZA/vdL8a5ASLHxgNPFgBSjEnABlbRVnaBLjBHnX/fl7AXnkB/sakinf
         vBgtTyecXRBoHiyhCGj3DUEJz566K71fboZtBdCe48Yt9eyQ+vW/wktM/phPD+2cx27C
         N0hg==
Received: by 10.182.183.73 with SMTP id ek9mr15888725obc.15.1335198641011;
        Mon, 23 Apr 2012 09:30:41 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gf8sm7212005obc.3.2012.04.23.09.30.36
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 09:30:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335184230-8870-5-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196140>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/help.c
> +++ b/help.c
> @@ -217,8 +217,9 @@ void list_commands(const char *title, struct cmdn=
ames *main_cmds,
> =20
>  	if (main_cmds->cnt) {
>  		const char *exec_path =3D git_exec_path();
> -		printf("available %s in '%s'\n", title, exec_path);
> -		printf("----------------");
> +		printf_ln(_("available %s in '%s'"), title, exec_path);
> +		/* TRANSLATORS: this must align with "available %s in '%s'" */
> +		printf(_("----------------"));
>  		mput_char('-', strlen(title) + strlen(exec_path));

Yuck. :)

I would be tempted to do:

	static int strbuf_utf8_width(const struct strbuf *sb)
	{
		char char *p =3D sb->buf;
		size_t remainder =3D sb->len;
		int width;

		width =3D utf8_width(&p, &remainder);
		if (!p || remainder)
			return sb->len;
		return width;
	}
	...

		struct strbuf sb =3D STRBUF_INIT;
		const char *p;

		strbuf_addf(&sb, _("available %s in '%s'"), title, exec_path);
		fwrite(sb.buf, sb.len, 1, stdout);
		putchar('\n');

		/* NEEDSWORK: handle non-UTF8 locales? */
		mput_char('-', strbuf_utf8_width(&sb));

		strbuf_release(&sb);
