From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/9] icase match on non-ascii
Date: Wed, 8 Jul 2015 19:13:27 +0700
Message-ID: <CACsJy8DPVrVBrnmq2SBDkR+TNgaDBgnZGseHwR82ap2+6yR+rw@mail.gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com> <559D0A4F.9040307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 08 14:14:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCoEl-00070x-N1
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 14:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758554AbbGHMN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 08:13:59 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33034 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528AbbGHMN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 08:13:57 -0400
Received: by iggp10 with SMTP id p10so20239720igg.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vDfTmB/NrqFtrIsQ7WK8xbUEE47td8L4aLRzMAsguYY=;
        b=qeUpF+iIE2UoTW3eVgoZIQUfl0M0gjLD/0O2U0WdYpEDSomyqvVQVTbptMRrbdJm85
         3QIO8ItZp3VnYmLOxPpcHWR3BsCjQrImwU7e/Xj6OQKJBdB1tZShV4nRbCkIxwWLiyoo
         X9eubGT/cZjB2NBoO+1H/pbHPgequmIOlNyNYkUwIJLK4XLhiOxR6EksWIeHSzKIEacO
         Ss71Shflb/Qbp9f4/30U7TsHVSiUilFcbthfWjYXB0ZDsBv+WkFh+U7hOKpKZVH7E4W7
         FBNh61517+GuJOvSnnTsPKJ0qEw4JHv9F3XrK6Waa0OJaXYJ7QzUIqo/yYZxX8iPuyiM
         9RCg==
X-Received: by 10.50.7.68 with SMTP id h4mr61654805iga.40.1436357636881; Wed,
 08 Jul 2015 05:13:56 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 8 Jul 2015 05:13:27 -0700 (PDT)
In-Reply-To: <559D0A4F.9040307@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273676>

On Wed, Jul 8, 2015 at 6:32 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2015-07-08 12.38, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Side note, I almost added the third has_non_ascii() function. Maybe =
we
>> should consider merging the two existing has_non_ascii() functions
>> back, or rename one to something else.
>>
> Side question:
>
> has_non_ascii can mean different things:
>  UTF-8, ISO-8859-1, ISO-8859-x...
>
> In short: everything.
> Should we be more critical here ?

=46or the purpose of this series, no. What we need to ask is "can we
optimize this?" and that leads to "ok we can safely optimize for
ascii-only patterns, don't optimize otherwise".

> May be this can be used from commit.c:
> static int verify_utf8(struct strbuf *buf)

Except the pcre/utf8 patch, the rest should work for all single-byte en=
codings..

> Other question:
> Should the "non-ascii" characters in the test scripts be octal-escape=
d ?

I would prefer something readable from a text editor. Even though I
don't speak Icelandic (the strings were copied from gettext test
script) I can see uppercase/lowercase of letters. But I don't know how
many people have fonts covering more than just ascii..

> Third question:
> What happens on systems, which don't have gettext, (for whatever reas=
ons)
> --- a/gettext.c
> +++ b/gettext.c
> @@ -166,12 +166,17 @@ void git_setup_gettext(void)
> textdomain("git");
> }
>
> +int is_utf8_locale(void)
> +{
> + return !strcmp(charset, "UTF-8");
> +}

Hm.. pcre on utf-8 is screwed. I really don't want to go through
nl_langinfo, $LC_ALL, $LC_CTYPE and $LANG to detect utf8 like what's
done in compat/regex/regcomp.c.. But I guess there's no other way,
people can disable gettext and expect git to work properly with utf-8
if their pcre library supports it.

> 4th question:
> What happens on systems which don't have locale support at all ?

I suppose by locale here you do not mean "gettext" any more, then
icase does not work. We simply delegate the work to system regex/pcre.
If they don't support locale, nothing we can do. Git itself does not
know how to fold case outside ascii (except maybe utf8, I don't know
how smart our utf-8 impl is). gettext support does not matter here,
except pcre/utf8 case above.

> As one may suspect, I'm not a friend of being dependent on gettext an=
d/or
> locale, at least not for this kind of business.
>
> Would it make more sense to have a command line option ?

I assume you only care about utf-8 here (and utf8.c knows how to fold
case), you'll need to improve compat regex to take advantage of it
first, maybe make sure it can live side by side with system regex,
also make sure pcre is compiled with utf-8 support if you use pcre.
And if setting LANG to let git know you want to use utf-8 is too
subtle, then yes a command line option makes sense :)
--=20
Duy
