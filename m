From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v4 4/6] Emit a whole line once a time
Date: Sat, 29 May 2010 22:19:14 +0800
Message-ID: <AANLkTin5KJs-3rEbPgLWRnEsTtlkmq7QTb-t0qEKAg78@mail.gmail.com>
References: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
	<1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
	<7vocfz5x80.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 16:19:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIMsk-0000e5-3h
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 16:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab0E2OTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 10:19:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58280 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0E2OTQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 May 2010 10:19:16 -0400
Received: by vws11 with SMTP id 11so164482vws.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f88ODBVQ39/3cTZsEjCkWCuLKP7xWpzg71VtTuclr3Y=;
        b=fiaJuqWT8UinPIP02WhUgt3KrbIUB5aDGL4LLIlIGk0ZDtY1Q0NAWR/c8Kbq+yxN+B
         Tbbld1J34yVABsHnYzr36fHn3JznzxVeF2yh5q7/7FeqUqJ6sp1bTMH53XHlO8s7/m/a
         eR4zFPMxIqhFCLlzqeKwCzayLjTLLNM7SJuto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MlYJFyrGNWIFjPDIFHXTX1JhjAvB+QtVspEYZF+ysXd/9zhMTMYM3FzGtFX5uU61eu
         +FKYsqv7jfcaz2j8A9UT2svh9QetUQ5bgSB1MewMY0GlNex2v8eDa8i7XwpxRvtI1XbB
         fMw6fo/xq5u1ojW7DpR/bw4/w9QeMN67RFTm8=
Received: by 10.224.126.220 with SMTP id d28mr831576qas.312.1275142754932; 
	Sat, 29 May 2010 07:19:14 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Sat, 29 May 2010 07:19:14 -0700 (PDT)
In-Reply-To: <7vocfz5x80.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147967>

On Sat, May 29, 2010 at 9:10 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Bo Yang <struggleyb.nku@gmail.com> writes:
>
>> Since the graph prefix will be printed when calling
>> emit_line, so the functions should be used to emit a
>> complete line out once a time. No one should call
>> emit_line to just output some strings instead of a
>> complete line.
>> Use a strbuf to compose the whole line, and then
>> call emit_line to output it once.
>
> "once a time" in your title doesn't sound quite right. =A0I would say=
 "in
> one go" instead.
>
>> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
>> ---
>> =A0diff.c | =A0 34 +++++++++++++++++++++++++++++-----
>> =A01 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 7f2538d..bffaedc 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -370,6 +370,18 @@ static void emit_hunk_header(struct emit_callba=
ck *ecbdata,
>> =A0 =A0 =A0 const char *reset =3D diff_get_color(ecbdata->color_diff=
, DIFF_RESET);
>> =A0 =A0 =A0 static const char atat[2] =3D { '@', '@' };
>> =A0 =A0 =A0 const char *cp, *ep;
>> + =A0 =A0 struct strbuf msgbuf =3D STRBUF_INIT;
>> + =A0 =A0 int org_len =3D len;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* trailing \r\n
>> + =A0 =A0 =A0*/
>> + =A0 =A0 int i =3D 1;
>> + =A0 =A0 for (; i < 3; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (line[len - i] =3D=3D '\r' || line[len =
- i] =3D=3D '\n') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len --;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> I am not very happy with this logic. =A0The existing code (just outsi=
de the
> post-context of this hunk) is being defensive and returns early when =
len
> is shorter than what we expect, but this new code blindly assumes tha=
t len
> is at least 2 bytes long, and also it would eat a line that ends with=
 \r\r.

Hmm, yes, I will move the defensive code upper this check.

> Can the partial line at the end be on this line? =A0IOW, can line[len=
-1] be
> different from '\n' in some cases?

I think a line in Macintosh will end with '\r'.

> What's the reason to strip trailing "\r" at the end of the line to be=
gin
> with?

Both '\r' and '\n' will be added back to the strbuf, what I do is
finding the len and make sure the '\r' and \n will not be surround by
the color escape sequence.

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
