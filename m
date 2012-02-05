From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Fwd: Breakage in master?
Date: Sun, 5 Feb 2012 15:46:04 +0100
Message-ID: <CABPQNSbPA3jicuPiaHuSBY_qEy1Pmy1uWnLBWt=7O0dETbKZ3g@mail.gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
 <20120202174601.GB30857@sigill.intra.peff.net> <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
 <CABPQNSbj8QKqkdY49Y7tpAOQd53t+z6Gc5U-CS0-TZWyNz1WfQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: bug-gnu-gettext@gnu.org
X-From: git-owner@vger.kernel.org Sun Feb 05 15:47:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru3N7-0002ua-37
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 15:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2BEOqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 09:46:46 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45919 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab2BEOqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 09:46:45 -0500
Received: by pbdu11 with SMTP id u11so4244195pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 06:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=tcNf/xYEHwU8rwc/FvrkDwC2iPcqDAYQRx4BYSmgVq8=;
        b=IPlFg1pAnnLZP8aBfF/9dN4ANKsqTXo5DkIP29RNM0BQdo/Av6wQt5T71fZxDT8V90
         u+vCRmMLzzBZoKa7I3oJ6SMtoBmvYO24k1Yut0SOINeWmw9kY4MpR/mgR70CZLhlcpXA
         VYmOZ0dfsBiAPjVaLNah6txzi9QgHmIx8agpg=
Received: by 10.68.218.5 with SMTP id pc5mr38082493pbc.101.1328453204239; Sun,
 05 Feb 2012 06:46:44 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Sun, 5 Feb 2012 06:46:04 -0800 (PST)
In-Reply-To: <CABPQNSbj8QKqkdY49Y7tpAOQd53t+z6Gc5U-CS0-TZWyNz1WfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189941>

Git has recently switched to using gettext for translations, and I
have observed a breakage on Windows due to the way gettext handles
vsnprintf.

On MinGW, vsnprintf and _vsnprintf are two different implementations;
vsnprintf is from MinGW-runtime, and provides a reasonably sane
implementation. _vnsprintf on the other hand is from MSVCRT.dll, and
has some issues with it's return value. Before using gettext, the
MinGW-built version of Git called the version from mingw-runtime, and
everything worked fine. When built with MSVC, a shim was used to fixup
the bogus return value. This shim was injected through a define,
similar to what gettext does.

The shim in gettext lead to issues for Git, both on MinGW and on MSVC.

=46or MinGW, the problem is that libintl_vsnprintf calls _vsnprintf
rather than vsnprintf, giving us the same, broken return value that we
tried to prevent. This means that our code intended to call the
MinGW-runtime version, but gettext ended up calling the MSVCRT.dll
version. I don't find this very reasonable; a call to vsnprintf ends
up as a call to _vsnprintf.

On MSVC the problem is a bit easier to spot; libgnuintl.h.in contains
the following:

---8<---
#if !(defined vsnprintf && defined _GL_STDIO_H) /* don't override gnuli=
b */
#undef vsnprintf
#define vsnprintf libintl_vsnprintf
extern int vsnprintf (char *, size_t, const char *, va_list);
#endif
---8<---

Uhm, what? Unless we're using Gnulib, our definition of vsnprintf
should simply be ignored?

I'm not saying figuring out what to do here is exactly trivial; but I
think undefining any definitions of vsnprintf that aren't exactly
"_vsnprintf" is dangerous. The forwarded mail below contains a
quick-fix I did locally that seems to side-step the problem for me, by
not using _vsnprintf on MinGW. But perhaps there's something better we
can do?

---------- Forwarded message ----------
=46rom: Erik Faye-Lund <kusmabite@gmail.com>
Date: Sat, Feb 4, 2012 at 10:55 PM
Subject: Re: Breakage in master?
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>, msysGit
<msysgit@googlegroups.com>, =C6var Arnfj=F6r=F0 <avarab@gmail.com>


On Fri, Feb 3, 2012 at 1:28 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Thu, Feb 2, 2012 at 6:46 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Feb 02, 2012 at 01:14:19PM +0100, Erik Faye-Lund wrote:
>>
>>> But here's the REALLY puzzling part: If I add a simple, unused
>>> function to diff-lib.c, like this:
>>> [...]
>>> "git status" starts to error out with that same vsnprintf complaint=
!
>>>
>>> ---8<---
>>> $ git status
>>> # On branch master
>>> # Changes not staged for commit:
>>> # =A0 (use "git add <file>..." to update what will be committed)
>>> fatal: BUG: your vsnprintf is broken (returned -1)
>>> ---8<---
>>
>> OK, that's definitely odd.
>>
>> At the moment of the die() in strbuf_vaddf, what does errno say?
>
> If I apply this patch:
> ---8<---
> diff --git a/strbuf.c b/strbuf.c
> index ff0b96b..52dfdd6 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -218,7 +218,7 @@ void strbuf_vaddf(struct strbuf *sb, const char
> *fmt, va_list ap)
> =A0 =A0 =A0 =A0len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->l=
en, fmt, cp);
> =A0 =A0 =A0 =A0va_end(cp);
> =A0 =A0 =A0 =A0if (len < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("BUG: your vsnprintf is broken (ret=
urned %d)", len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("BUG: your vsnprintf is broke=
n (returned %d)", len);
> =A0 =A0 =A0 =A0if (len > strbuf_avail(sb)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_grow(sb, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D vsnprintf(sb->buf + sb->len, s=
b->alloc - sb->len, fmt, ap);
> ---8<---
>
> Then I get "fatal: BUG: your vsnprintf is broken (returned -1): Resul=
t
> too large". This goes both for both failure cases I described. I
> assume this means errno=3DERANGE.
>
>> vsnprintf should generally never be returning -1 (it should return t=
he
>> number of characters that would have been written). Since you're on
>> Windows, I assume you're using the replacement version in
>> compat/snprintf.c.
>
> No. SNPRINTF_RETURNS_BOGUS is only set for the MSVC target, not for
> the MinGW target. I'm assuming that means MinGW-runtime has a sane
> vsnprintf implementation. But even if I enable SNPRINTF_RETURNS_BOGUS=
,
> the problem occurs. And it's still "Result too large".
>
> So I decided to do a bit of stepping, and it seems libintl takes over
> vsnprintf, directing us to libintl_vsnprintf instead. I guess this is
> so it can ensure we support reordering the parameters with $1 etc...
> And aparently this vsnprintf implementation calls the system vnsprint=
f
> if the format string does not contain '$', and it's using _vsnprintf
> rather than vsnprintf on Windows. _vsnprintf is the MSVCRT-version,
> and not the MinGW-runtime, which needs SNPRINTF_RETURNS_BOGUS.
>
> So I guess I can patch libintl to call vsnprintf from MinGW-runtime i=
nstead.
>

Indeed, I just got around to testing this, and doing this on top of
gettext seems to fix the problem for me. For the MSVC, a more
elaborate fix is needed, as it doesn't have a sane vsnprintf.

---

diff --git a/gettext-runtime/intl/printf.c b/gettext-runtime/intl/print=
f.c
index b7cdc5d..f55023e 100644
--- a/gettext-runtime/intl/printf.c
+++ b/gettext-runtime/intl/printf.c
@@ -192,7 +192,7 @@ libintl_sprintf (char *resultbuf, const char *forma=
t, ...)

=A0#if HAVE_SNPRINTF

-# if HAVE_DECL__SNPRINTF
+# if HAVE_DECL__SNPRINTF && !defined(__MINGW32__)
=A0 =A0/* Windows. =A0*/
=A0# =A0define system_vsnprintf _vsnprintf
=A0# else
