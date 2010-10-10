From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Mon, 11 Oct 2010 00:16:56 +0200
Message-ID: <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com>
 <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com> <4CB22FF3.5070503@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 00:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P54Cr-0001a8-FQ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 00:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab0JJWRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 18:17:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58530 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJWRS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 18:17:18 -0400
Received: by ywi6 with SMTP id 6so432647ywi.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Bg68I1f0yROPZ5Hm0dG3tias6JBhd9LK7otMnmEwiow=;
        b=nG2+gOuZ6yMTuVC8H70pQ7OABflzpBnsruHpaLA1NIrfMfI4wQ6TgPnu2u6t9yJwIZ
         X4QNcAlPxXgyifoQthccleTD5tLifkSuDqhzVA/HqHtybnn/ZXcB9Ce5GHWyoxl+Uktw
         dM58DJj0vC2bp5m2TXzO+tWxEcqmnR/fdL36Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=RBcVGRAUezhTyz6Te1oM3aJ+GN+ZuqM+SUKViz/7V/Pl4RToDnaMcHRT/FZIJCAh8T
         NIKagczfc56o3FHwPY04dcF8pKbYOjp7vThKGGCHuIZm0yeJajwVA6ufutjzN9EFUJG0
         1Tikuw94t4T750h0XVhz5MVN4mNDYRgVT15cY=
Received: by 10.151.84.1 with SMTP id m1mr5227741ybl.413.1286749037470; Sun,
 10 Oct 2010 15:17:17 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 15:16:56 -0700 (PDT)
In-Reply-To: <4CB22FF3.5070503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158726>

On Sun, Oct 10, 2010 at 11:28 PM, Eric Sunshine <ericsunshine@gmail.com=
> wrote:
> On 10/10/2010 4:37 PM, Erik Faye-Lund wrote:
>>
>> On Sun, Oct 10, 2010 at 9:50 PM, Eric Sunshine<ericsunshine@gmail.co=
m>
>> =A0wrote:
>>>
>>> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>>>
>>>> From: Mike Pape<dotzenlabs@gmail.com>
>>>>
>>>> Syslog does not usually exist on Windows, so we implement our own
>>>> using Window's ReportEvent mechanism.
>>>>
>>>> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
>>>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>>>> ---
>>>> +void syslog(int priority, const char *fmt, const char *arg)
>>>> +{
>>>> + =A0 =A0 =A0 WORD logtype;
>>>> +
>>>> + =A0 =A0 =A0 if (!ms_eventlog)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 if (strcmp(fmt, "%s")) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("format string of syslog() n=
ot implemented");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> + =A0 =A0 =A0 }
>>>
>>> It is not exactly clear what the intention is here. Is this trying =
to say
>>> that no formatting directives are allowed in 'fmt' or what? The sim=
ple
>>> case
>>> it is actually checking (where 'fmt' is solely '%s') could easily b=
e
>>> handled
>>> manually, as could more complex formats.
>>>
>>
>> This is the result of the feed-back in v1, where we tried to impleme=
nt
>> all format strings.
>
> In retrospect, when thinking more carefully about the conditional
> expression, I suppose the code is self-documenting, though perhaps a =
comment
> in code or in commit message would help.
>
>> But that turned out to be very complex (due to the
>> lack of a portable va_copy()) and since we control all call-sites fo=
r
>> syslog and already only use "%s" as the format, it should be OK.
>
> Do you mean vsnprintf() rather than va_copy()?
>

OK, I had to read some old discussions to figure out what the issue was=
 :)

The problem was lack of portable va_copy, because I tried to add a
non-variadic version of strbuf_addf(), namely strbuf_vaddf() to do the
work.

I guess it could be implemented pretty easily with vsnprintf(),
though. I was afraid of doing that originally because I know there's
portability issues with the return value of snprintf. Luckily it seems
that we have a fix for that in compat/sprintf.c, and we rely on the
return value being correct in strbuf_addf() so it would probably be
safe.

Something like this (on top)

---8<---
diff --git a/compat/mingw.c b/compat/mingw.c
index bbe45d0..e3f3f92 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1435,17 +1435,24 @@ void openlog(const char *ident, int logopt,
int facility)
 		warning("RegisterEventSource() failed: %lu", GetLastError());
 }

-void syslog(int priority, const char *fmt, const char *arg)
+void syslog(int priority, const char *fmt, ...)
 {
 	WORD logtype;
+	char *str;
+	int str_len;
+	va_list ap;

 	if (!ms_eventlog)
 		return;

-	if (strcmp(fmt, "%s")) {
-		warning("format string of syslog() not implemented");
-		return;
-	}
+	va_start(ap, fmt);
+	str_len =3D vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	str =3D malloc(str_len + 1);
+	va_start(ap, fmt);
+	vsnprintf(str, str_len, fmt, ap);
+	va_end(ap);

 	switch (priority) {
 	case LOG_EMERG:
@@ -1478,8 +1485,9 @@ void syslog(int priority, const char *fmt, const
char *arg)
 	    NULL,
 	    1,
 	    0,
-	    (const char **)&arg,
+	    (const char **)&str,
 	    NULL);
+	free(str);
 }

 #undef signal
diff --git a/compat/mingw.h b/compat/mingw.h
index aed49d8..45a63a0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -186,7 +186,7 @@ int setitimer(int type, struct itimerval *in,
struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 void openlog(const char *ident, int logopt, int facility);
-void syslog(int priority, const char *fmt, const char *arg);
+void syslog(int priority, const char *fmt, ...);

 /*
  * replacements of existing functions
---8<---

>> Are you suggesting that we report an error when we can't report the
>> string correctly? We could do that, but I'm not sure how the end-use=
r
>> would benefit from that. ReportEvent is used to report errors (unles=
s
>> the --verbose flag has been specified), and reporting that we can't
>> present an error message strike me as a bit confusing... Even the
>> corrupted error message is probably better :P
>
> I am not suggesting reporting an error. As a first-time reader of the=
 code,
> I was trying to understand the presence of the comment which did not =
really
> seem to relate to the code. Perhaps adding a "FIXME" to the comment s=
aying
> that the condition should perhaps be handled in the future would help=
 to
> explain the comments presence.
>

A FIXME would certainly a good idea, if I don't just end up supporting
varargs here.

> (On the other hand, for the '%s' check above, the code does report a =
warning
> and then exits, so it is not inconceivable that a '%n' could also emi=
t a
> warning.)
>

I guess I could add something like this:

if (strstr(arg, "%1"))
	warning("arg contains %1, message might be corrupted");

I don't want to return in that case, because I think some output is
better than no output, and it seems to work on Vista. In fact, working
on Vista is kind of demotivating me to add such a warning in the first
place...
