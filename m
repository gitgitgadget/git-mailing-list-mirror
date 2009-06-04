From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] add strerror(errno) to die() calls where applicable
Date: Thu, 4 Jun 2009 05:58:14 +0400
Message-ID: <2325a7950906031858oed495d0x406ea375ff08eb28@mail.gmail.com>
References: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch>
	 <20090603015503.GA14166@coredump.intra.peff.net>
	 <2325a7950906031855t1977448lbb1c8aa671c72f3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 04 04:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC2Lh-0006wp-SC
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 04:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbZFDCGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 22:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbZFDCGX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 22:06:23 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:54830 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbZFDCGX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 22:06:23 -0400
Received: by fxm9 with SMTP id 9so415250fxm.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eEjcCJ8tLoAum5fI5ExSPv9tear2lSI5rlgWGreydGc=;
        b=GnvCvHRTSa6+Uzrci1xltTYfkWjCeO3xuBLCP0tdgNvg7RmXgB8OHEsoUNitl8wpq4
         lJlveZnhW4XEESQMo1uvJUPYDcffeId8qt+1NrneGozaUH6C663KFzMX/z2FIGQHJM0M
         P8ENEelwO0ok6VhMPD07da/ay+ukgzwXf4/c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ngu16UiJ1vIoPJNcJ4WeL5PuUQkA9hYZBr0HPgSujJ0+Y9XWWZQsRLy3vVeh9LgdMc
         yGG9790FTi6osipNpXJTTOOQVUB2ziqJLRGScdrg+6dxQpt9Pe1su0FXCzsvVyqyiZk0
         cvVpqKmKMPchrzdHzkMgo6Hwah5ktcrNJUyDk=
Received: by 10.223.106.15 with SMTP id v15mr921901fao.15.1244080694753; Wed, 
	03 Jun 2009 18:58:14 -0700 (PDT)
In-Reply-To: <2325a7950906031855t1977448lbb1c8aa671c72f3d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120673>

Hi Jeff,
I was also thinking (about 1 month ago) about a helper function
similar to your 'diesys', but I never thought that adding yet another
"backend" function (diesys_routine) is reasonable.

=46ollowing your approach, you will need to add 'set_diesys_routine' an=
d
call it along with 'set_die_routine' (however, if you want to use
'diesys', but there are several places in 'daemon.c' and
'fast-import.c' where 'die' is being used to write 'strerror(errno)').

I think, we should just keep the backend interface as is and implement
'diesys' through 'die_routine'.


Alexander


2009/6/3 Jeff King <peff@peff.net>:
> On Tue, Jun 02, 2009 at 11:34:33PM +0200, Thomas Rast wrote:
>
>> Lots of die() calls did not actually report the kind of error, which
>> can leave the user confused as to the real problem. =C2=A0Add a
>> strerror(errno) where the die() is immediately preceded by a
>> system/library call that sets errno on failure, or by one of the
>> following that wrap such calls:
>
> I like this, as I remember being frustrated in the past by "cannot $f=
oo"
> messages with no indication of the cause of the error. My only questi=
ons
> or concerns with such a patch would be:
>
> =C2=A01. How did you determine the set of callsites? Did you check th=
at each
> =C2=A0 =C2=A0 non-syscall function always sets errno? Are there are f=
unctions
> =C2=A0 =C2=A0 which are setting errno which could also be included?
>
> =C2=A02. Extra error conditions may leak information about the filesy=
stem to
> =C2=A0 =C2=A0 people feeding bogus paths to upload-pack. I didn't see=
 anything
> =C2=A0 =C2=A0 obvious in your patch that would cause this, but it is =
something to
> =C2=A0 =C2=A0 consider.
>
> =C2=A03. This is such a common thing to do, I wonder if we would be b=
etter
> =C2=A0 =C2=A0 off adding a "diesys" function that appends ": strerror=
(errno)"
> =C2=A0 =C2=A0 to the emitted error. Something like the (totally untes=
ted) patch
> =C2=A0 =C2=A0 below.
>
> And a few comments on the patch itself:
>
>> @@ -109,7 +113,8 @@ int is_directory(const char *path)
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *cwd =3D=
 get_pwd_cwd();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cwd)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("Cannot determine the current working directory");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("Cannot determine the current working directory",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strerror(errno));
>
> Missing ": %s" here?
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("closing file %s: %s=
", path, strerror(errno));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("closing file '%s': =
%s", path, strerror(errno));
>
> This one is actually just a style change, though I think it is
> worthwhile (and there are a few others like it).
>
>
> The diesys patch is below.
>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4236647..410ac87 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -155,6 +155,7 @@
> =C2=A0/* General helper functions */
> =C2=A0extern void usage(const char *err) NORETURN;
> =C2=A0extern void die(const char *err, ...) NORETURN __attribute__((f=
ormat (printf, 1, 2)));
> +extern void diesys(const char *err, ...) NORETURN __attribute__((for=
mat (printf, 1, 2)));
> =C2=A0extern int error(const char *err, ...) __attribute__((format (p=
rintf, 1, 2)));
> =C2=A0extern void warning(const char *err, ...) __attribute__((format=
 (printf, 1, 2)));
>
> diff --git a/usage.c b/usage.c
> index 820d09f..da5e58e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -12,6 +12,14 @@ static void report(const char *prefix, const char =
*err, va_list params)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "%s%s\n", prefix, msg);
> =C2=A0}
>
> +static void report_sys(int err, const char *prefix, const char *fmt,=
 va_list
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char msg[1024];
> + =C2=A0 =C2=A0 =C2=A0 vsnprintf(msg, sizeof(msg), fmt, params);
> + =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "%s%s: %s\n", prefix, msg, hst=
rerror(err));
> +}
> +
> =C2=A0static NORETURN void usage_builtin(const char *err)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "usage: %s\n", err);
> @@ -24,6 +32,12 @@ static NORETURN void die_builtin(const char *err, =
va_list params)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(128);
> =C2=A0}
>
> +static NORETURN void diesys_builtin(int err, const char *fmt, va_lis=
t params)
> +{
> + =C2=A0 =C2=A0 =C2=A0 report_sys(err, "fatal: ", fmt, params);
> + =C2=A0 =C2=A0 =C2=A0 exit(128);
> +}
> +
> =C2=A0static void error_builtin(const char *err, va_list params)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0report("error: ", err, params);
> @@ -38,6 +52,7 @@ static void warn_builtin(const char *warn, va_list =
params)
> =C2=A0* (ugh), so keep things static. */
> =C2=A0static void (*usage_routine)(const char *err) NORETURN =3D usag=
e_builtin;
> =C2=A0static void (*die_routine)(const char *err, va_list params) NOR=
ETURN =3D die_builtin;
> +static void (*diesys_routine)(int err, const char *fmt, va_list para=
ms) NORETURN =3D diesys_builtin;
> =C2=A0static void (*error_routine)(const char *err, va_list params) =3D=
 error_builtin;
> =C2=A0static void (*warn_routine)(const char *err, va_list params) =3D=
 warn_builtin;
>
> @@ -60,6 +75,16 @@ void die(const char *err, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(params);
> =C2=A0}
>
> +void diesys(const char *fmt, ...)
> +{
> + =C2=A0 =C2=A0 =C2=A0 va_list params;
> + =C2=A0 =C2=A0 =C2=A0 int err =3D errno;
> +
> + =C2=A0 =C2=A0 =C2=A0 va_start(params, fmt);
> + =C2=A0 =C2=A0 =C2=A0 diesys_routine(err, fmt, params);
> + =C2=A0 =C2=A0 =C2=A0 va_end(params);
> +}
> +
> =C2=A0int error(const char *err, ...)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_list params;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
