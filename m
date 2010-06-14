From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revert: add --stdin option to read commits from stdin
Date: Mon, 14 Jun 2010 00:20:27 -0500
Message-ID: <20100614052027.GA1509@burratino>
References: <20100614032251.20121.83253.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:20:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO26L-0004Tq-Rv
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab0FNFUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 01:20:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38563 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0FNFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:20:42 -0400
Received: by iwn9 with SMTP id 9so2905927iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zi61kud/jqCK8eKFJYdM3QiQ9nBkTN5UTmPvI7809sI=;
        b=pNPUm98Em2Kz2x/cjJRWReLw08QuiEQWJ4SfR7sRFVyxt+SyFm4uLTSYN3XfFyhB17
         P8fdJqiFaHm7f6PPn/iP68re7PwJZnbd2YUQjnTI6c770jb9yubBL3UIAOmgMrnZdXV/
         iojgpOZTyT7RV3l22AdmyjVGg+VmWZCzJ2ipc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sj2undZx2jleSDh48dU6CoOEbJMINXtpqAQSRcP0kVVniKs05XiC/b0IL305OB022r
         U/VlCglQLX8Yud9r5hLqCeNZz51R3RyE6gaC117RSASTUTpOD7ZcwjgefvyB4Y1Pl7cf
         F+MyXXJu79alcrAJK7JjyJVTrqbN2zA8GAdV4=
Received: by 10.231.193.209 with SMTP id dv17mr5355822ibb.134.1276492840580;
        Sun, 13 Jun 2010 22:20:40 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm18931029ibl.22.2010.06.13.22.20.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 22:20:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100614032251.20121.83253.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149069>

Christian Couder wrote:

> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -92,4 +92,14 @@ test_expect_failure 'cherry-pick -3 fourth works' =
'
>  	test "$(git rev-parse --verify HEAD)" !=3D "$(git rev-parse --verif=
y fourth)"
>  '
> =20
> +test_expect_success 'cherry-pick --stdin works' '
> +	git checkout master &&
> +	git reset --hard first &&
[...]

This test fails for me as written, since the previous test leaves some
files in an unmerged state.  Patch 1 below works around that.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -79,7 +80,7 @@ static void parse_args(int argc, const char **argv)
>  	}
> =20
>  	commit_argc =3D parse_options(argc, argv, NULL, options, usage_str,=
 0);
[...]
> @@ -527,10 +528,12 @@ static void prepare_revs(struct rev_info *revs)
>  {
>  	int argc =3D 0;
>  	int i;
> -	const char **argv =3D xmalloc((commit_argc + 4) * sizeof(*argv));
> +	const char **argv =3D xmalloc((commit_argc + 5) * sizeof(*argv));
> =20
>  	argv[argc++] =3D NULL;
>  	argv[argc++] =3D "--no-walk";
> +	if (read_stdin)
> +		argv[argc++] =3D "--stdin";

Ah, I see the problem now.  But it would be even nicer to allow arbitra=
ry
rev-list options, so a person could =E2=80=98git cherry-pick --reverse =
a..b=E2=80=99,
for example.

In other words, how about something like patch 2 below?

Patch 3 is a small cleanup, as a bonus.

Christian Couder (1):
  revert: accept arbitrary rev-list options

Jonathan Nieder (2):
  t3508 (cherry-pick): futureproof against unmerged files
  revert: do not rebuild argv on heap

 Documentation/git-cherry-pick.txt   |    7 ++++++
 builtin/revert.c                    |   37 ++++++++++++++++++---------=
--------
 t/t3501-revert-cherry-pick.sh       |   18 +++++++++++++++++
 t/t3508-cherry-pick-many-commits.sh |   24 ++++++++++++++++------
 4 files changed, 61 insertions(+), 25 deletions(-)
