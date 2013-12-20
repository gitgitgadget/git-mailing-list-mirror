From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Fri, 20 Dec 2013 09:29:32 +0700
Message-ID: <CACsJy8BqzgC6t_rFJ+Q7MHqEoHjdT8f-XgvRBY1aNjiUvCq=WQ@mail.gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 <52B38213.2070702@web.de> <CACsJy8Bb4+V1DEdEmRwj10Oozi8U430ZHDCj_UhnXZcaR-wQ=g@mail.gmail.com>
 <52B397FF.4050808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 20 03:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtpqv-0000mN-UA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 03:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195Ab3LTCaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 21:30:07 -0500
Received: from mail-qe0-f46.google.com ([209.85.128.46]:64122 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127Ab3LTCaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 21:30:06 -0500
Received: by mail-qe0-f46.google.com with SMTP id a11so1832540qen.19
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 18:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6ICfY3RWUY2S+Xfq2Cgmvz6knbuXa0fnONR6TjMo88I=;
        b=TXpjNHJ+f9Hr/ZWYOfnUQP398hrzFkYQrHCEVKN0K7pNrZe0rlMgFNWyG/+ubsqElZ
         zSVCbBcxIT7n4lJ5yAwr0i7gwhTov3YpfOMZMOUrWHCcxCvkzHpc/yT5ntL83UGkfTcx
         NFH4ZV+llbvCjYziDAtSBZBYZW0PVEWc0T0PcopPILhyylwZnkbOb7qibKF3osA3xChF
         1wc+gQ2KQsAyOoQVUqIHKUEtxYyHWUCRWWyHxpixaIb4+AeTLsAdFF2jH+BZvfGvXIhK
         UtxIVBgOZp8U0hnaaVTK3QpzWQXwuz7JdWc84AufOKJXc0S1Q+9Kcmd/bv07ToIDC7OS
         P3ew==
X-Received: by 10.224.103.129 with SMTP id k1mr9408091qao.77.1387506602438;
 Thu, 19 Dec 2013 18:30:02 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 19 Dec 2013 18:29:32 -0800 (PST)
In-Reply-To: <52B397FF.4050808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239562>

On Fri, Dec 20, 2013 at 8:06 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 20.12.2013 00:50, schrieb Duy Nguyen:
>> On Fri, Dec 20, 2013 at 6:32 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>> Seeing that skip_prefix_defval is mostly used in the form
>>> skip_prefix_defval(foo, prefix, foo) I wonder if it makes sense to
>>> first change skip_prefix to return the full string instead of NULL
>>> if the prefix is not matched.  Would the resulting function cover
>>> most use cases?  And would it still be easily usable?
>>
>> That was skip_prefix_gently() that I forgot to replace in a commit
>> message, before I turned it into _defval variant. The reason for
>> _defval is it could be use to chain expression together without addi=
ng
>> temporary variables, e.g.
>>
>> -       if (starts_with(line->buf, ">From") && isspace(line->buf[5])=
) {
>> +       if (isspace(*skip_prefix_defval(line->buf, ">From", "NOSPACE=
"))) {
>>
>> Without _defval, one would need to do if ((p =3D skip_prefix(..)) &&
>> isspace(*p)). I'm not entirely sure this is a good thing though as i=
t
>> could make it a bit harder to read.
>
> That usage is quite rare compared to occurrences of
> skip_prefix_defval(foo, prefix, foo), no?  Adding a temporary variabl=
e
> for them wouldn't be that bad if we can simplify the API to a single
> function -- if that one is usable, that is.
>
> On the other hand, we could add a special function for that example
> and we'd already have three users in the tree (patch below).  I think
> that's too narrow a use case for a library function, though.  Doing
> the following instead in the three cases doesn't seem to be too bad:
>
>         rest =3D skip_prefix(line->buf, ">From");
>         if (rest !=3D line->buf && isspace(*rest)) {
>

OK I agree it's the minority and probably not even worth a wrapper.
But I disagree on changing the behavior of skip_prefix(). Some
in-flight topics might depend on "old" skip_prefix(). The
"skip_prefix() returns full string if not found" should have a
different name. I'll go with _gently again, unless you suggest another
name.

> ---
>  builtin/apply.c    | 2 +-
>  builtin/mailinfo.c | 4 ++--
>  git-compat-util.h  | 1 +
>  strbuf.c           | 9 +++++++++
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..b96befd 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -433,7 +433,7 @@ static unsigned long linelen(const char *buffer, =
unsigned long size)
>
>  static int is_dev_null(const char *str)
>  {
> -       return !memcmp("/dev/null", str, 9) && isspace(str[9]);
> +       return skip_prefix_and_space(str, "/dev/null") !=3D str;
>  }
>
>  #define TERM_SPACE     1
> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 2c3cd8e..2575989 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -328,11 +328,11 @@ static int check_header(const struct strbuf *li=
ne,
>         }
>
>         /* for inbody stuff */
> -       if (starts_with(line->buf, ">From") && isspace(line->buf[5]))=
 {
> +       if (skip_prefix_and_space(line->buf, ">From") !=3D line->buf)=
 {
>                 ret =3D 1; /* Should this return 0? */
>                 goto check_header_out;
>         }
> -       if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7]=
)) {
> +       if (skip_prefix_and_space(line->buf, "[PATCH]") !=3D line->bu=
f) {
>                 for (i =3D 0; header[i]; i++) {
>                         if (!memcmp("Subject", header[i], 7)) {
>                                 handle_header(&hdr_data[i], line);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index dcb92c4..a083918 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -355,6 +355,7 @@ extern int prefixcmp(const char *str, const char =
*prefix);
>  extern int ends_with(const char *str, const char *suffix);
>  extern int suffixcmp(const char *str, const char *suffix);
>  extern const char *skip_prefix(const char *str, const char *prefix);
> +extern const char *skip_prefix_and_space(const char *str, const char=
 *prefix);
>
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
>
> diff --git a/strbuf.c b/strbuf.c
> index 222df13..768331f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -47,6 +47,15 @@ const char *skip_prefix(const char *str, const cha=
r *prefix)
>                         return str;
>  }
>
> +const char *skip_prefix_and_space(const char *str, const char *prefi=
x)
> +{
> +       const char *p =3D skip_prefix(str, prefix);
> +       if (((p !=3D str) || !*prefix) && isspace(*p))
> +               return p + 1;
> +       else
> +               return str;
> +}
> +
>  /*
>   * Used as the default ->buf value, so that people can always assume
>   * buf is non NULL and ->buf is NUL terminated even for a freshly
> --
> 1.8.5.2



--=20
Duy
