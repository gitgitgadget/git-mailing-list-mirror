From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] commit: fix memory-leak
Date: Mon, 7 Feb 2011 22:31:14 +0100
Message-ID: <AANLkTimvgDjiLon-2BAwxcYOQGVE9UZPNr637o93-9HQ@mail.gmail.com>
References: <AANLkTikKZ+2qUMF1T5pP60cUd9Ya3n2mfhTkX6L32zmn@mail.gmail.com>
 <1297110111-7620-1-git-send-email-kusmabite@gmail.com> <AANLkTikr2+OVRU6n+0tA752_x80ir9dQh65RjUp3BxPR@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: matthieu.moy@grenoble-inp.fr, msysgit@googlegroups.com,
	blees@dcon.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 22:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYgU-00014c-F2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab1BGVbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 16:31:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50066 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1BGVbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 16:31:36 -0500
Received: by fxm20 with SMTP id 20so5370802fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AzRZBN6o5cQj414/sKcOosSYdH7E3GEwhsY9NlNQHGw=;
        b=kGJ7vxTiffLHjHDLRQwtRRd/7EAuLrNAML/q2C0udwkaMZB6si4lHxJkyb5wtYfCSg
         1vVPyV1jEvppljWNtwRQK64hkeoyeWp4fJITlEapnKD7XfNQ2weLqB0SdXDJAPi8U/L2
         p4CeqYmvAP31233ewwzsQfGIaJgw+PVzXlnrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=nVm2sickRcxQFBn/rGeLhBkwVdWG9RsXCycOtwaswv7KoNcOtf6EcQLwT+2rlEi6IG
         UUvuGVcSf3s7sHjQKFGxmDrBxAPsq8Q4RXg44cJEchN/zewsU0Nn+iAzjcR0q2wdLgY5
         bWhet8dMSP1Ok7/viU9659HR1A5U3GdMkuFVs=
Received: by 10.223.96.68 with SMTP id g4mr1744094fan.33.1297114294627; Mon,
 07 Feb 2011 13:31:34 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 13:31:14 -0800 (PST)
In-Reply-To: <AANLkTikr2+OVRU6n+0tA752_x80ir9dQh65RjUp3BxPR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166299>

On Mon, Feb 7, 2011 at 10:12 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Mon, Feb 7, 2011 at 9:21 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>> The name, email and date strings are some times allocated on the
>> heap, but not free'd. Fix this by making sure they are allways
>> heap-allocated, so we can safely free the memory.
>>
>> At the same time, this fixes a problem with strict-POSIX getenv
>> implementations. POSIX says "The return value from getenv() may
>> point to static data which may be overwritten by subsequent calls
>> to getenv()", so not duplicating the strings is a potential bug.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> Fixed typo in commit message, as pointed out by Matthieu Moy.
>>
>> =A0builtin/commit.c =A0| =A0 =A09 ++++++---
>> =A0git-compat-util.h | =A0 =A01 +
>> =A0wrapper.c =A0 =A0 =A0 =A0 | =A0 =A06 ++++++
>> =A03 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 03cff5a..e5a649e 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -465,9 +465,9 @@ static void determine_author_info(struct strbuf =
*author_ident)
>> =A0{
>> =A0 =A0 =A0 =A0char *name, *email, *date;
>>
>> - =A0 =A0 =A0 name =3D getenv("GIT_AUTHOR_NAME");
>> - =A0 =A0 =A0 email =3D getenv("GIT_AUTHOR_EMAIL");
>> - =A0 =A0 =A0 date =3D getenv("GIT_AUTHOR_DATE");
>> + =A0 =A0 =A0 name =3D xgetenv("GIT_AUTHOR_NAME");
>> + =A0 =A0 =A0 email =3D xgetenv("GIT_AUTHOR_EMAIL");
>> + =A0 =A0 =A0 date =3D xgetenv("GIT_AUTHOR_DATE");
>>
>> =A0 =A0 =A0 =A0if (use_message && !renew_authorship) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *a, *lb, *rb, *eol;
>> @@ -507,6 +507,9 @@ static void determine_author_info(struct strbuf =
*author_ident)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0date =3D force_date;
>> =A0 =A0 =A0 =A0strbuf_addstr(author_ident, fmt_ident(name, email, da=
te,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0IDENT_ERROR_ON_NO_NAME));
>> + =A0 =A0 =A0 free(name);
>> + =A0 =A0 =A0 free(email);
>> + =A0 =A0 =A0 free(date);
>
> Hmm, but I'm getting a crash here on Linux. Guess I need to debug a b=
it...
>

Ah, it was the force_date-assignment:
---8<---
diff --git a/builtin/commit.c b/builtin/commit.c
index e5a649e..1416c13 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -504,7 +504,7 @@ static void determine_author_info(struct strbuf
*author_ident)
 	}

 	if (force_date)
-		date =3D force_date;
+		date =3D xstrdup(force_date);
 	strbuf_addstr(author_ident, fmt_ident(name, email, date,
 					      IDENT_ERROR_ON_NO_NAME));
 	free(name);

---8<---

But now I see that I was temporarily(?) struck with insanity:
overwriting a heap-allocated pointer with another heap-allocated
pointer doesn't fix a memory-leak. So let's add some more calls to
free:

diff --git a/builtin/commit.c b/builtin/commit.c
index e5a649e..bdd0cfb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -482,6 +482,10 @@ static void determine_author_info(struct strbuf
*author_ident)
 		if (!*lb || !*rb || !*eol)
 			die("invalid commit: %s", use_message);

+		free(name);
+		free(email);
+		free(date);
+
 		if (lb =3D=3D a + strlen("\nauthor "))
 			/* \nauthor <foo@example.com> */
 			name =3D xcalloc(1, 1);
@@ -497,14 +501,19 @@ static void determine_author_info(struct strbuf
*author_ident)
 		const char *lb =3D strstr(force_author, " <");
 		const char *rb =3D strchr(force_author, '>');

+		free(name);
+		free(email);
+
 		if (!lb || !rb)
 			die("malformed --author parameter");
 		name =3D xstrndup(force_author, lb - force_author);
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
 	}

-	if (force_date)
-		date =3D force_date;
+	if (force_date) {
+		free(date);
+		date =3D xstrdup(force_date);
+	}
 	strbuf_addstr(author_ident, fmt_ident(name, email, date,
 					      IDENT_ERROR_ON_NO_NAME));
 	free(name);
