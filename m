From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw: avoid using strbuf in syslog
Date: Thu, 6 Oct 2011 19:32:09 +0200
Message-ID: <CABPQNSYUzmHgFO9VzHRX-or8b5h+HEXapBoiQDWRA_4KWi9nAQ@mail.gmail.com>
References: <1317920244-6320-1-git-send-email-kusmabite@gmail.com> <CA+sFfMediaCnzFH6uKfVc_Bb+W+AA1nO+OdvB8vWjjrsD1kh9w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, gitster@pobox.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBroa-0006yh-Vf
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174Ab1JFRcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 13:32:54 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55411 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965106Ab1JFRcx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 13:32:53 -0400
Received: by qyk30 with SMTP id 30so5609248qyk.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=FYIU9ps81JETPNL9Qx4oG1jBRSvIrT5xzAUmSf/k/UQ=;
        b=kuXpyhC8lTO8hDFt8Qc9vEkiw815sNZZNeCEFcrNTzaSP+fwzbs0xuw0pme1IHiw+t
         NvD6KQx2MWjPHrul6Yud0sLy59L0jZOUcHLtWGQkmj9VKowqBBPcyYDdcWsSNOG5fgZ1
         YTkBYYo4FuZnNk8vfc1fduVLE5g8sByur9fu0=
Received: by 10.68.16.65 with SMTP id e1mr7222532pbd.27.1317922371390; Thu, 06
 Oct 2011 10:32:51 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 6 Oct 2011 10:32:09 -0700 (PDT)
In-Reply-To: <CA+sFfMediaCnzFH6uKfVc_Bb+W+AA1nO+OdvB8vWjjrsD1kh9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182997>

On Thu, Oct 6, 2011 at 7:27 PM, Brandon Casey <drafnel@gmail.com> wrote=
:
> On Thu, Oct 6, 2011 at 11:57 AM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> strbuf can call die, which again can call syslog from git-daemon.
>>
>> Endless recursion is no fun; fix it by hand-rolling the logic.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> Fixes the problem Brandon pointed out...
>
> Actually, Johannes should get that credit. =A0He brought up the whole
> recursion issue.
>

OK, I didn't spot that one. But it's not in the commit message,
though. Perhaps it should be?

>> =A0compat/win32/syslog.c | =A0 26 ++++++++++++++------------
>> =A01 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
>> index 42b95a9..3b8e2b7 100644
>> --- a/compat/win32/syslog.c
>> +++ b/compat/win32/syslog.c
>> @@ -1,5 +1,4 @@
>> =A0#include "../../git-compat-util.h"
>> -#include "../../strbuf.h"
>>
>> =A0static HANDLE ms_eventlog;
>>
>> @@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int f=
acility)
>>
>> =A0void syslog(int priority, const char *fmt, ...)
>> =A0{
>> - =A0 =A0 =A0 struct strbuf sb =3D STRBUF_INIT;
>> - =A0 =A0 =A0 struct strbuf_expand_dict_entry dict[] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 {"1", "% 1"},
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 {NULL, NULL}
>> - =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0WORD logtype;
>> - =A0 =A0 =A0 char *str;
>> + =A0 =A0 =A0 char *str, *pos;
>> =A0 =A0 =A0 =A0int str_len;
>> =A0 =A0 =A0 =A0va_list ap;
>>
>> @@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0str =3D malloc(str_len + 1);
>> + =A0 =A0 =A0 if (!str)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return; /* no chance to report error *=
/
>> +
>
> Just above this, warning() is used to at least print a message to
> stderr if vsnprintf() fails. =A0It could be used here, and below when
> realloc fails.
>

Good point, so this should be squashed in:
---

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 3b8e2b7..d015e43 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -33,8 +33,10 @@ void syslog(int priority, const char *fmt, ...)
 	}

 	str =3D malloc(str_len + 1);
-	if (!str)
-		return; /* no chance to report error */
+	if (!str) {
+		warning("malloc failed: '%s'", strerror(errno));
+		return;
+	}

 	va_start(ap, fmt);
 	vsnprintf(str, str_len + 1, fmt, ap);
@@ -42,8 +44,10 @@ void syslog(int priority, const char *fmt, ...)

 	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
 		str =3D realloc(str, ++str_len + 1);
-		if (!str)
+		if (!str) {
+			warning("realloc failed: '%s'", strerror(errno));
 			return;
+		}
 		memmove(pos + 2, pos + 1, strlen(pos));
 		pos[1] =3D ' ';
 	}
