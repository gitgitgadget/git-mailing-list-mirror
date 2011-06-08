From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Wed, 8 Jun 2011 12:45:28 +0200
Message-ID: <BANLkTinTJh9oOTHi5js7n-sy8+pmMa_vtQ@mail.gmail.com>
References: <DAFDEB13CE4944C18AAF3F20994AEF2E@martinic.local>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Theo Niessink <niessink@martinic.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGHJ-0005ZK-TJ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab1FHKqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 06:46:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55293 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1FHKqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 06:46:08 -0400
Received: by pzk9 with SMTP id 9so182912pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wQ8IaoGAKNYzjFGIpH2vhveBSDexamAEH5wTuIPdyLY=;
        b=JustcUcuJhqrW5pP+997ST6EKbbsyNuBiWuGWsRh0ObUGh2H8x0TOYvR+Vzec4JEZH
         XCkeUj1Upv1XlozjQyxrVprRTeaicsKQ4fTsd/bCIy3P0sSi5udgdP0kyVXpvGYTXZCO
         yPY4qRLbc483teHcRYusrBHDWAYQcFh+0QPXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bDe1x+nm532s+s+xqAjeac6W73fxPH8otDhS1egIDsHnEKpOiRLJ79QGLtQ/1K5y+Y
         1PQbWjUZx+hM+ZWcCGxmhVZI7CIXsPntniO7q5krvpT/FaXTegzMCVCbQwY1Us+qQn6B
         eAc9Y5ds3yvoCdYDa+s6iQMH4CMaZHpmzPaFw=
Received: by 10.68.68.106 with SMTP id v10mr699194pbt.115.1307529968090; Wed,
 08 Jun 2011 03:46:08 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Wed, 8 Jun 2011 03:45:28 -0700 (PDT)
In-Reply-To: <DAFDEB13CE4944C18AAF3F20994AEF2E@martinic.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175353>

On Wed, Jun 8, 2011 at 11:55 AM, Theo Niessink <niessink@martinic.com> =
wrote:
> Junio C Hamano wrote:
>> Here is what I queued last night. If it looks Ok then I'll merge it =
down
>> to 'next'.
>
> I have run a couple of quick tests, and everything seems OK, except t=
he
> following backslashed paths, which are verified OK while they should =
be
> rejected:
>
> foo\.\bar
> foo\..\bar
>
> This is caused by verify_dotfile(), which doesn't use is_dir_sep(). S=
o I
> propose this patch on verify_dotfile():
>
> diff --git a/read-cache.c b/read-cache.c
> index 282c0c1..72be7cd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -726,11 +726,12 @@ static int verify_dotfile(const char *rest)
> =A0 =A0 =A0 =A0 * has already been discarded, we now test
> =A0 =A0 =A0 =A0 * the rest.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 switch (*rest) {
> +
> =A0 =A0 =A0 =A0/* "." is not allowed */
> - =A0 =A0 =A0 case '\0': case '/':
> + =A0 =A0 =A0 if (*rest =3D=3D '\0' || is_dir_sep(*rest))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 switch (*rest) {
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * ".git" followed by =A0NUL or slash is bad. This
> =A0 =A0 =A0 =A0 * shares the path end test with the ".." case.
> @@ -743,7 +744,7 @@ static int verify_dotfile(const char *rest)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rest +=3D 2;
> =A0 =A0 =A0 =A0/* fallthrough */
> =A0 =A0 =A0 =A0case '.':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rest[1] =3D=3D '\0' || rest[1] =3D=3D=
 '/')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rest[1] =3D=3D '\0' || is_dir_sep(r=
est[1]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 1;
>
>
>

This looks obviously correct to me. Thanks for spotting the problem.

Would you mind writing up a commit-message and supply a sign-off?
