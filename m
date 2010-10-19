From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] run_builtin(): save "-h" detection result for later
 use
Date: Tue, 19 Oct 2010 11:48:26 -0500
Message-ID: <20101019164826.GA25139@burratino>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 18:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8FQ8-000395-8n
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab0JSQwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 12:52:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64042 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0JSQwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 12:52:09 -0400
Received: by wyb28 with SMTP id 28so2699344wyb.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Hj4kpSTlQAO5QLyqR+qWVn4j3BEt6ieozremFgZPYmo=;
        b=eUUdnks/kQDin8IsmtIESOOSQrXfXo3ZlSJMDo9gyFUZ2dkMRzba7t0cDkyyCggJRZ
         xEsdyBK1FkOjoK1KtVyJU9L6FgADlvpCkVThaLA/pGWGU0BYJGERmmTHaw2US8yN4xIM
         79tFHQt2HuNTPKfKyycJI8t2oXsWW59Qx12Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kh+HjDEgov0zryqjW4xT9zL3Zw46V+pIXGa/fYwVwc8dkX4ThEGjVY8/NuSZFtnEce
         46p2lis+lgp8/TBEbVxTqkjMKMDuFJBMN8Xjm6khMG7b/GnFYSXak1IRyzJJfqixP7kQ
         3FXTioVBHCHK8lEUjY15NZhk3RezNraJHd1hw=
Received: by 10.216.11.66 with SMTP id 44mr6393714wew.69.1287507126878;
        Tue, 19 Oct 2010 09:52:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w29sm6833271weq.19.2010.10.19.09.52.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 09:52:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159339>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> When run_builtin() sees "-h" as the first argument, it assumes:
>=20
>  - this is the call for help usage
>  - the real git command will only print help usage then exit
>=20
> So it skips all setup in this case.  Unfortunately, some commands do
> other things before calling parse_options()

and even during parse_options() in some weird cases.

Taking this patch as a cover letter, I wonder about the impact
(because I forgot).  Is this to avoid, e.g., erroring out from a
repository with invalid HEAD when the user just wanted to get help?
Example commands with improved behavior?  It would be nice to be able
to add a test or two. [*]

> --- a/cache.h
> +++ b/cache.h
> @@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_=
errno);
>  /* git.c */
>  struct startup_info {
>  	int have_repository;
> +	int help; /* print help and exit, except git_config(), repo must no=
t be touched */
>  };

Since this is data, not code, I think it is clearer to just explain
what the value represents.  The commit message and access sites can
explain why it matters.  Maybe something like this?

	unsigned have_repository:1;
	unsigned help:1;	/* git <command> -h? */

A better technical writer could probably find a better way to say it.

> --- a/git.c
> +++ b/git.c
> @@ -246,13 +246,13 @@ struct cmd_struct {
> =20
>  static int run_builtin(struct cmd_struct *p, int argc, const char **=
argv)
>  {
> -	int status, help;
> +	int status;
>  	struct stat st;
>  	const char *prefix;
> =20
>  	prefix =3D NULL;
> -	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
> -	if (!help) {
> +	startup_info->help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
> +	if (!startup_info->help) {
[...]

=46or what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[*] The reader might recall a long-term goal of clarifying .git dir
access semantics:
http://thread.gmane.org/gmane.comp.version-control.git/149771/focus=3D1=
52745
Given that, what need is there to ask about the patch's impact?  One
answer: I am asking about side-effects rather than the goal of the
patch.  Positive side-effects would be indicators of a good design.
