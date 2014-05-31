From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH v2 2/2] connect.c: replace signal() with sigaction()
Date: Sat, 31 May 2014 22:39:39 +1200
Message-ID: <5389B16B.6070004@gmail.com>
References: <cover.1401482787.git.jmmahler@gmail.com> <1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat May 31 12:40:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqghl-0005bB-I7
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 12:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbaEaKjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2014 06:39:45 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44039 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbaEaKjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 06:39:44 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so1795903pdj.26
        for <git@vger.kernel.org>; Sat, 31 May 2014 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9evRCr0yPIdexZeohaXZxEwMWD/RrvZhCsNPjXgsEc4=;
        b=vWKFjTJdPSuRqngsuutC1C+EEyvo5XPvpNOY+rhqZkLK5MS/p2nLWwMmg4wRs4Ahbd
         +i2kCq4NYryL1k1HB9AIs3g1sbi4+YPWwybesDoP1cFpX4tIXnce6bkfAL8aPM14Muy4
         m3tXoqXhIv6uaZs4VD65jIJMlxUAB+IeOUsA1l9OZfm2UtA+SIxh37geD/7J5qv70SJw
         lcWELib5WLJBjl9AyrfgXSxihlRQUWOv3Oje74QsZwL4WUR+amNQyauzU+FPaWr1Bzij
         yAtLIvI4z1TZJCW/3lT2/Pc4kwwrhOjCDOW1QZkjAp2pulbt03hMxrLPyb6Go/0LRLo/
         E5rA==
X-Received: by 10.68.178.131 with SMTP id cy3mr26237842pbc.146.1401532783616;
        Sat, 31 May 2014 03:39:43 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id yl9sm32216715pac.25.2014.05.31.03.39.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 31 May 2014 03:39:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1d11d5da7ebc3a6e0d4ab64802b601526c19113c.1401482787.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250504>

On 31/05/14 08:58, Jeremiah Mahler wrote:
> From signal(2) man page:
>=20
>   The behavior of signal() varies across UNIX versions, and has also =
var=E2=80=90
>   ied historically across different versions of Linux.   Avoid  its  =
use:
>   use sigaction(2) instead.
>=20
> Replaced signal() with sigaction() in connect.c
>=20
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  connect.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/connect.c b/connect.c
> index a983d06..b2a33c9 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -665,11 +665,14 @@ struct child_process *git_connect(int fd[2], co=
nst char *url,
>  	enum protocol protocol;
>  	const char **arg;
>  	struct strbuf cmd =3D STRBUF_INIT;
> +	struct sigaction sa;
> =20
>  	/* Without this we cannot rely on waitpid() to tell
>  	 * what happened to our children.
>  	 */
> -	signal(SIGCHLD, SIG_DFL);
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler =3D SIG_DFL;
> +	sigaction(SIGCHLD, &sa, 0);

I think this got lost in the wash with v1 but
Documentation/CodingGuidelines says to use NULL here instead of 0.

> =20
>  	protocol =3D parse_connect_url(url, &hostandport, &path);
>  	if (flags & CONNECT_DIAG_URL) {
>=20
