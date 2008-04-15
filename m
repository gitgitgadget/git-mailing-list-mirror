From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Re* [PATCH] builtin-apply.c: use git_config_string() to get apply_default_whitespace
Date: Tue, 15 Apr 2008 06:19:34 +0200
Message-ID: <200804150619.34775.chriscool@tuxfamily.org>
References: <20080408084233.GA7785@leksak.fem-net> <200804130556.45141.chriscool@tuxfamily.org> <7vskxqe0db.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 06:15:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlcZa-0000xM-Nd
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 06:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYDOEOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 00:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYDOEOX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 00:14:23 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37787 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYDOEOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 00:14:22 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 84FBE1AB2B5;
	Tue, 15 Apr 2008 06:14:18 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 61DC61AB2B2;
	Tue, 15 Apr 2008 06:14:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vskxqe0db.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79565>

Le dimanche 13 avril 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Le mardi 8 avril 2008, Stephan Beyer a =C3=A9crit :
> >> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> >> ---
> >> Hi,
> >>
> >> a simple `Janitor patch'.
> >
> > Thanks.
> > ...
> > Tested-by: Christian Couder <chriscool@tuxfamily.org>
> >
> > Junio, please apply.
>
> Hmmmm.
>
> $ git grep -A1 config_error_nonbool | grep -B1 '^[^ ]*-.* =3D xstrdup=
'
>
> shows these 13:

Yes, there are many potential places.

> Among these, obviously the one in config.c cannot be replaced (it is =
the
> implementation of git_config_string() itself ;-), and the one in remo=
te.c
> has a different pattern (it does not return immediately after that, b=
ut
> everything else can be mechanically replaced.

I think that each case should be looked at closely. But as it's not ver=
y=20
difficult either in many cases, I think it's a good thing to let newbie=
s=20
try their skills at it. That's why I set up the Janitor page on the wik=
i:

http://git.or.cz/gitwiki/Janitor

describing this task.

>
> diff --git a/alias.c b/alias.c
> index 116cac8..1513681 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -4,12 +4,8 @@ static const char *alias_key;
>  static char *alias_val;
>  static int alias_lookup_cb(const char *k, const char *v)
>  {
> -	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		alias_val =3D xstrdup(v);
> -		return 0;
> -	}
> +	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
> +		return git_config_string((const char **)&alias_val, k, v);
>  	return 0;
>  }

That's also the patch that Stephan sent to the list before, see:

http://thread.gmane.org/gmane.comp.version-control.git/78845

And I told him that casting to (const char **) was ugly, and it was bet=
ter=20
to leave this file as it is.

> diff --git a/builtin-apply.c b/builtin-apply.c
> index abe73a0..c8ca41b 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2981,12 +2981,8 @@ static int apply_patch(int fd, const char
> *filename, int inaccurate_eof)
>
>  static int git_apply_config(const char *var, const char *value)
>  {
> -	if (!strcmp(var, "apply.whitespace")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		apply_default_whitespace =3D xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp(var, "apply.whitespace"))
> +		return git_config_string(&apply_default_whitespace, var, value);
>  	return git_default_config(var, value);
>  }

That's the next patch Stephan sent, and it is indeed good, so please ap=
ply=20
Stephan's. Thanks.

About other files, I don't care much. That's also why I left it to Jani=
tors.

If I see that you fixed everything I will just remove the Janitor page =
on=20
the wiki.

Regards,
Christian.
