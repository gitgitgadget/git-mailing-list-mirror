From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Breakage in master?
Date: Fri, 3 Feb 2012 13:28:29 +0100
Message-ID: <CABPQNSZfKCTsuusPpHa2djEOeGVN9z5s_Fr+S3EaHiv7Q4Re9w@mail.gmail.com>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
 <20120202174601.GB30857@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtIGR-0001s2-LN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab2BCM3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 07:29:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33835 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab2BCM3J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 07:29:09 -0500
Received: by dadp15 with SMTP id p15so2699308dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Yp7R+1kcr/jQmv9dokQWLmmhHU02wCSS4rgK/Ji3mv0=;
        b=NBIMTpvxBTmcMg5jesXiJ6aUjRdYRH6Ef2cv6GWFIq9v3PNNrh3VH7kQSCj1nOva3l
         aBtdLQy0bLKpKd68rOiziKJVDfcj57pDWOGnSw31QDWVjXccTF635uzLHnHOHV0TCIUv
         Iz4pWRxRYm1BLf+26c1NWwgzYbB9t5px/NHHM=
Received: by 10.68.73.196 with SMTP id n4mr17322366pbv.33.1328272149233; Fri,
 03 Feb 2012 04:29:09 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Fri, 3 Feb 2012 04:28:29 -0800 (PST)
In-Reply-To: <20120202174601.GB30857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189754>

On Thu, Feb 2, 2012 at 6:46 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2012 at 01:14:19PM +0100, Erik Faye-Lund wrote:
>
>> But here's the REALLY puzzling part: If I add a simple, unused
>> function to diff-lib.c, like this:
>> [...]
>> "git status" starts to error out with that same vsnprintf complaint!
>>
>> ---8<---
>> $ git status
>> # On branch master
>> # Changes not staged for commit:
>> # =A0 (use "git add <file>..." to update what will be committed)
>> fatal: BUG: your vsnprintf is broken (returned -1)
>> ---8<---
>
> OK, that's definitely odd.
>
> At the moment of the die() in strbuf_vaddf, what does errno say?

If I apply this patch:
---8<---
diff --git a/strbuf.c b/strbuf.c
index ff0b96b..52dfdd6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -218,7 +218,7 @@ void strbuf_vaddf(struct strbuf *sb, const char
*fmt, va_list ap)
 	len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, cp);
 	va_end(cp);
 	if (len < 0)
-		die("BUG: your vsnprintf is broken (returned %d)", len);
+		die_errno("BUG: your vsnprintf is broken (returned %d)", len);
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
 		len =3D vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
---8<---

Then I get "fatal: BUG: your vsnprintf is broken (returned -1): Result
too large". This goes both for both failure cases I described. I
assume this means errno=3DERANGE.

> vsnprintf should generally never be returning -1 (it should return th=
e
> number of characters that would have been written). Since you're on
> Windows, I assume you're using the replacement version in
> compat/snprintf.c.

No. SNPRINTF_RETURNS_BOGUS is only set for the MSVC target, not for
the MinGW target. I'm assuming that means MinGW-runtime has a sane
vsnprintf implementation. But even if I enable SNPRINTF_RETURNS_BOGUS,
the problem occurs. And it's still "Result too large".

So I decided to do a bit of stepping, and it seems libintl takes over
vsnprintf, directing us to libintl_vsnprintf instead. I guess this is
so it can ensure we support reordering the parameters with $1 etc...
And aparently this vsnprintf implementation calls the system vnsprintf
if the format string does not contain '$', and it's using _vsnprintf
rather than vsnprintf on Windows. _vsnprintf is the MSVCRT-version,
and not the MinGW-runtime, which needs SNPRINTF_RETURNS_BOGUS.

So I guess I can patch libintl to call vsnprintf from MinGW-runtime ins=
tead.

> All of that would make sense to me, _except_ for your weird "if I add=
 a
> random function, the problem is more reproducible" bit. Which does se=
em
> like something is invoking undefined behavior (of course, it could be
> that undefined behavior or stack-smashing that is causing vsnprintf t=
o
> report an error). Lacking any better leads, it might be worth pursuin=
g.

Well, now at least I have some better leads, but I'm still not able to
explain the "if I add a random function, the problem is more
reproducible" bit. :(

>> I've bisected the issues down to 5e9637c (i18n: add infrastructure f=
or
>> translating Git with gettext). Trying to apply my unused-function
>> patch on top of this commit starts giving the same "fatal: BUG: your
>> vsnprintf is broken (returned -1)" error. It's ancestor, bc1bbe0(Git
>> 1.7.8-rc2), does not yield any of the issues.
>
> I've looked at 5e9637c, and it really doesn't do anything that looks
> bad. I wonder if your gettext library is buggy. Does compiling with
> NO_GETTEXT help?

Compiling with NO_GETTEXT does make the symptoms go away, but that's
not curing the problem ;)

But, I have a lead now. I'll see if I can find out *why* libintl calls
_vsnprintf on MinGW. I expect it's so the MSVC and the MinGW versions
behave similarly, MSVC doesn't have a sane vsnprintf. Perhaps I should
back-port SNPRINTF_RETURNS_BOGUS-workaround to libintl, so our MSVC
builds doesn't break also?
