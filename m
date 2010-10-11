From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Mon, 11 Oct 2010 17:59:59 +0200
Message-ID: <AANLkTikXMCgC0P-=255SRvqfDSGua7Gcb-jmqS8paUNj@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com>
 <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
 <4CB22FF3.5070503@gmail.com> <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
 <4CB24A43.9090501@gmail.com> <AANLkTi==sd=jm9LZ6p6NLVBMc4wnU0PrYvJY6ezGWiWt@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Kne-00007R-2B
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab0JKQAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 12:00:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40638 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab0JKQAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 12:00:21 -0400
Received: by gxk6 with SMTP id 6so133782gxk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=I50bihKZdUPkaKPGSVjGz0izYivzAuJk70ZB12DQzOc=;
        b=j06dw7i9XXZon5YMLx8iyM0NZ2PExlMTWykkvsWLZbkwarbNtCwXkOeWYFvjFzLBZG
         YiwXdXjCp53cR9imOQz9OvrEmUN8c87gq+OTBK8956rxDdDv+FhfF8cUNA75UZJevjvD
         I3w47TJKMmDZyeteCTK1b1HMWHctePStFIdU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=YzZpbvzD5aUDij07XO80kzRH4lrWJQCvMyxbIOhsv3003W0jsMLiOOdhzF5GF3P2eo
         6SW3zFgA6tqLgY8brZXuKCwjipIwJOBh/wG/Skh5NfYRMUoQCf634qNp8ybmhlGosVY1
         rpy86Yle7uBz5NIRc7k3o17jeDrI3mONB4Fhc=
Received: by 10.42.171.72 with SMTP id i8mr1261217icz.331.1286812820331; Mon,
 11 Oct 2010 09:00:20 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Mon, 11 Oct 2010 08:59:59 -0700 (PDT)
In-Reply-To: <AANLkTi==sd=jm9LZ6p6NLVBMc4wnU0PrYvJY6ezGWiWt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158769>

On Mon, Oct 11, 2010 at 5:28 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Mon, Oct 11, 2010 at 1:20 AM, Eric Sunshine <ericsunshine@gmail.co=
m> wrote:
>> On 10/10/2010 6:16 PM, Erik Faye-Lund wrote:
>>>
>>> On Sun, Oct 10, 2010 at 11:28 PM, Eric Sunshine<ericsunshine@gmail.=
com>
>>> =A0wrote:
>>>> (On the other hand, for the '%s' check above, the code does report=
 a
>>>> warning
>>>> and then exits, so it is not inconceivable that a '%n' could also =
emit a
>>>> warning.)
>>>
>>> I guess I could add something like this:
>>>
>>> if (strstr(arg, "%1"))
>>> =A0 =A0 =A0 =A0warning("arg contains %1, message might be corrupted=
");
>>>
>>> I don't want to return in that case, because I think some output is
>>> better than no output, and it seems to work on Vista.
>>
>> Rather than emitting a warning, it might be reasonable to perform a =
simple
>> transformation on the string if it contains a %1 (or %n generally) i=
n order
>> to avoid ReportEvent()'s shortcoming. Even something as simple as in=
serting
>> a space between '%' and '1' might be sufficiently defensive.
>>
>
> Yes, but I'm tempted to defer fixing this until we see that it's a
> problem in reality. The logic to somehow escape such sequences looks =
a
> bit nasty in my head. But perhaps strbuf_expand() is the right hammer
> for this use...
>
> Then the logical next question becomes what we should expand it to.
> Does "%1" -> "% 1" make sense for IPv6 addresses?
>

Something along these lines? (on top of the previous patch, uhm, with
some local modifications. Sorry, I'm not at home and do not have the
original version at hand. I'm sure you get the picture, though...)

I also added a +1 that was missing and caused the string to be capped.

diff --git a/compat/mingw.c b/compat/mingw.c
index ae6b448..d1444d2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1438,6 +1438,11 @@ void openlog(const char *ident, int logopt, int =
facility)

 void syslog(int priority, const char *fmt, ...)
 {
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] =3D {
+		{"1", "% 1"},
+		{NULL, NULL}
+	};
 	WORD logtype;
 	char *str;
 	int str_len;
@@ -1457,8 +1462,9 @@ void syslog(int priority, const char *fmt, ...)

 	str =3D malloc(str_len + 1);
 	va_start(ap, fmt);
-	vsnprintf(str, str_len, fmt, ap);
+	vsnprintf(str, str_len + 1, fmt, ap);
 	va_end(ap);
+	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);

 	switch (priority) {
 	case LOG_EMERG:
@@ -1480,10 +1486,6 @@ void syslog(int priority, const char *fmt, ...)
 		break;
 	}

-	/*
-	 * FIXME: ReportEvent() doesn't handle strings containing "%1".
-	 * Such events must currently be reformatted by the caller.
-	 */
 	ReportEventA(ms_eventlog,
 	    logtype,
 	    0,
@@ -1491,9 +1493,10 @@ void syslog(int priority, const char *fmt, ...)
 	    NULL,
 	    1,
 	    0,
-	    (const char **)&str,
+	    (const char **)&sb.buf,
 	    NULL);
 	free(str);
+	sb_release(&sb);
 }

 #undef signal
diff --git a/daemon.c b/daemon.c
