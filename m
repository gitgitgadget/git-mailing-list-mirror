From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] gettext: use libcharset when available
Date: Tue, 28 Sep 2010 19:42:31 +0200
Message-ID: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
References: <1285689926-5048-1-git-send-email-kusmabite@gmail.com> <AANLkTin_fu02QN0cUX15+02iO7xJ+tii5aVBqR2V_AVc@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 19:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0eCn-0004EI-6M
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0I1Rm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 13:42:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab0I1Rm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 13:42:57 -0400
Received: by fxm14 with SMTP id 14so188711fxm.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=sxPb99at0YsG2BjKoc7phvZMlys+Bg5mmDva58nNbx8=;
        b=Zr1k2AZ7X4bthwkQTdI0gUiJ9E6LdVnROnTj1d7qB855B/JGGllOgAObz1lYOs0AnQ
         HHyVc5FhAto4fB64KVaUFzb0jdTFXi7d36+mLvPJWKXBgRTe6WsIuibtKmlfz8x1/71G
         elzZblPdTq7+PmaBnnFCmZhTwJ7O69poi6diQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=hJ6blO5HdfPWE+HI+FS5/Bia3Y35P+/fWOM/ujvDUoNCkqeWUHWUVUIDDyxIjR4J3Y
         1T/HNsT9Xe1LHkC56p99dP8W+Hd5+t2Ic7iMQwfsMRT8xdegkRGmBfNXEM2q8MvXwxeb
         mVRmwRYMKAwMHBjeRIsBhoZMbhP43+PsGGEHQ=
Received: by 10.103.218.4 with SMTP id v4mr467860muq.98.1285695772949; Tue, 28
 Sep 2010 10:42:52 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 28 Sep 2010 10:42:31 -0700 (PDT)
In-Reply-To: <AANLkTin_fu02QN0cUX15+02iO7xJ+tii5aVBqR2V_AVc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157448>

On Tue, Sep 28, 2010 at 7:07 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Sep 28, 2010 at 16:05, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> libcharset provides an even more portable way of quering the charset
>> of the current locale.
>>
>> Use that instead of nl_langinfo unless NO_LIBCHARSET is set.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> Windows doesn't have langinfo.h and nl_langinfo(), but libcharset wa=
s
>> invented for this very purpose. With this patch on top, ab/i18n
>> compiles without errors in msysGit.
>>
>> There's still a bunch of lower-level issues on Windows, like gettext
>> ending up overloading our winansi-wrappings for printf and friends,
>> but let's take thinks one step at the time :)
>>
>> =A0configure.ac | =A0 =A06 ++++++
>> =A0gettext.c =A0 =A0| =A0 10 +++++++++-
>> =A02 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 1821d89..d3139cd 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -810,6 +810,12 @@ AC_CHECK_HEADER([libintl.h],
>> =A0[NO_GETTEXT=3DYesPlease])
>> =A0AC_SUBST(NO_GETTEXT)
>> =A0#
>> +# Define NO_LIBCHARSET if you don't have libcharset.h
>> +AC_CHECK_HEADER([libcharset.h],
>> +[NO_LIBCHARSET=3D],
>> +[NO_LIBCHARSET=3DYesPlease])
>> +AC_SUBST(NO_LIBCHARSET)
>> +#
>> =A0# Define NO_STRCASESTR if you don't have strcasestr.
>> =A0GIT_CHECK_FUNC(strcasestr,
>> =A0[NO_STRCASESTR=3D],
>> diff --git a/gettext.c b/gettext.c
>> index 8644098..902268c 100644
>> --- a/gettext.c
>> +++ b/gettext.c
>> @@ -1,13 +1,17 @@
>> =A0#include "exec_cmd.h"
>> =A0#include <locale.h>
>> =A0#include <libintl.h>
>> +#ifndef NO_LIBCHARSET
>> +#include <libcharset.h>
>> +#else
>> =A0#include <langinfo.h>
>> +#endif
>> =A0#include <stdlib.h>
>>
>> =A0extern void git_setup_gettext(void) {
>> =A0 =A0 =A0 =A0char *podir;
>> =A0 =A0 =A0 =A0char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
>> - =A0 =A0 =A0 char *charset;
>> + =A0 =A0 =A0 const char *charset;
>>
>> =A0 =A0 =A0 =A0if (envdir) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void)bindtextdomain("git", envdir);
>> @@ -20,7 +24,11 @@ extern void git_setup_gettext(void) {
>>
>> =A0 =A0 =A0 =A0(void)setlocale(LC_MESSAGES, "");
>> =A0 =A0 =A0 =A0(void)setlocale(LC_CTYPE, "");
>> +#ifndef NO_LIBCHARSET
>> + =A0 =A0 =A0 charset =3D locale_charset();
>> +#else
>> =A0 =A0 =A0 =A0charset =3D nl_langinfo(CODESET);
>> +#endif
>> =A0 =A0 =A0 =A0(void)bind_textdomain_codeset("git", charset);
>> =A0 =A0 =A0 =A0(void)setlocale(LC_CTYPE, "C");
>> =A0 =A0 =A0 =A0(void)textdomain("git");
>
> Thanks for porting it to Windows. Some points:
>
> =A0* Nit: Should be NEEDS_LIBCHARSET instead of NO_LIBCHARSET, all th=
e
> =A0 variables that set library inclusions in the Makefile use the
> =A0 NEED_* names.
>

That's not true, at least NO_OPENSSL, NO_PTHREADS, NO_ICONV,
NO_LIBGEN_H, NO_MMAP and NO_SYS_SELECT_H use the NO_-prefix to include
libraries (as opposed to the NEEDS_-prefix). And to be honest, I think
the NEEDS_-prefix would be a lie in this case; we don't NEED it, we
take advantage of it if it's there.

To be honest, I just mimicked what was done for detection of gettext.
Perhaps HAVE_LIBCHARSET_H would be the appropriate define? It's what
we use for paths.h (HAVE_PATHS_H)...

> =A0* Their patch compiles a program that includes libcharset.h and
> =A0 compiles "const char* charset =3D locale_charset();". I don't kno=
w if
> =A0 this is needed, or whether just checking the header name like
> =A0 you've done will do.
>

I don't think there's any point to it - libcharset.h is pretty much
just about that one function. And if it turns out I'm wrong, we can
add a check like that in the future.

> =A0* They also have a HAVE_LANGINFO_H define and fall back on just
> =A0 returning "", which works on GNU iconv. Maybe we should do this
> =A0 too?
>

Perhaps, but can't that wait until we encounter a system that needs it?

What's interesting there is what you say about GNU iconv handling "".
This means that the minimal fix for Windows could be even smaller -
we're using GNU iconv :)

> I'm not sure about any of this, since I've just been testing on
> Solaris, Linux and FreeBSD.

I think Solaris, Linux, FreeBSD and Windows is a pretty wide selection
of platforms, so I hope it should be pretty painless once this hits
'next'. Sure, there might be some platforms that needs a fix-up, but
there always is with new code. And besides, there's even time to test
more platforms before merging to 'next', no? :)
