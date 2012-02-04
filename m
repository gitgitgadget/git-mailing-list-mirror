From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Breakage in master?
Date: Sat, 4 Feb 2012 22:55:16 +0100
Message-ID: <CABPQNSbj8QKqkdY49Y7tpAOQd53t+z6Gc5U-CS0-TZWyNz1WfQ@mail.gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
 <20120202174601.GB30857@sigill.intra.peff.net> <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtnaU-0002OH-1A
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab2BDVz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 16:55:57 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58321 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab2BDVz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 16:55:56 -0500
Received: by dadp15 with SMTP id p15so3704908dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=h8DNmqY8F2wZkac3gnGl6u90cmUPa5T8v+e0BpuSm6A=;
        b=yBqu96c3AFbZqDthefGWHjT6DUtErkpVkKrrPLe3/+b3ax7GMDis7nAyHEQXIydjgU
         qQypyt7Vh6JMbQrAIGR7Lc6qspZdZWUIKJNkTBtDdGwo53GowEBj/lR4y2IbJRPrZfgn
         5hBA8sGAEzdEx8/bSyxwtKaGxLnk7KlfYwBfY=
Received: by 10.68.218.5 with SMTP id pc5mr31251572pbc.101.1328392556139; Sat,
 04 Feb 2012 13:55:56 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Sat, 4 Feb 2012 13:55:16 -0800 (PST)
In-Reply-To: <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189915>

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

 #if HAVE_SNPRINTF

-# if HAVE_DECL__SNPRINTF
+# if HAVE_DECL__SNPRINTF && !defined(__MINGW32__)
    /* Windows.  */
 #  define system_vsnprintf _vsnprintf
 # else
