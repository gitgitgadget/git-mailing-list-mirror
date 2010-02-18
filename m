From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [RFC/PATCH 1/3] apply: Allow blank context lines to match beyond 
	EOF
Date: Thu, 18 Feb 2010 09:45:25 +0100
Message-ID: <6672d0161002180045q7a42ae49la7831dc0431d474a@mail.gmail.com>
References: <4B7B94A8.5000102@gmail.com>
	 <7vbpfo5le0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni20q-0007nl-Rz
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 09:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab0BRIp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 03:45:28 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:12832 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0BRIp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 03:45:27 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1974834eyd.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 00:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xo4DOYmfdJa6paq1dMftLAMkkiU2jaIX8aSBqFgeQSQ=;
        b=xhQrv00iechvQlsGlPBfVEYiOz8aKV5NCQbc+ReaIqox9s+CZqGET/LoMU5asHKtNT
         F/xjsoCKYjLGvSn+4OkgcHe3KYff6Oa7HTPzph7ucGbnOJo+R91dEHY6irl/Ofef7buj
         MXXjmpK1d9dQo6JnrD9TOuZO2ocZlO6l6kEXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tyl1G7f+Wf+F9Qgp7bOhtCkIEaNVFq6N2BrKQ0P2QA3BY+/wSa896eG8pXZmXGIBXe
         ODop4p04c4Etv17WMQCqBBut6XM49ptWjUNPI14yANk1SnLOQG9FJS63KGV82H09soaF
         dntS/La0SxdDo7qFuKxtMsPjln/PEPdy+vOvw=
Received: by 10.216.163.207 with SMTP id a57mr3180600wel.220.1266482725974; 
	Thu, 18 Feb 2010 00:45:25 -0800 (PST)
In-Reply-To: <7vbpfo5le0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140303>

2010/2/17 Junio C Hamano <gitster@pobox.com>:

>> @@ -2002,11 +2071,17 @@ static int find_pos(struct image *img,
>> =C2=A0 =C2=A0 =C2=A0 unsigned long backwards, forwards, try;
>> =C2=A0 =C2=A0 =C2=A0 int backwards_lno, forwards_lno, try_lno;
>>
>> - =C2=A0 =C2=A0 if (preimage->nr > img->nr)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* There used to be a quick reject here in case=
 preimage
>> + =C2=A0 =C2=A0 =C2=A0* had more lines than img. We must let match_f=
ragment()
>> + =C2=A0 =C2=A0 =C2=A0* handle that case because a hunk is now allow=
ed to
>> + =C2=A0 =C2=A0 =C2=A0* extend beyond the end of img when --whitespa=
ce=3Dfix
>> + =C2=A0 =C2=A0 =C2=A0* has been given (and core.whitespace.blanks-a=
t-eof is
>> + =C2=A0 =C2=A0 =C2=A0* enabled).
>> + =C2=A0 =C2=A0 =C2=A0*/
>
> Is it worth to keep the quick-reject if we are not running under
> blank-at-eof mode?

Good point.

As far as I can understand, the quick reject could only make
a difference if there is a huge preimage applied to a big file
and it will only make "git apply" reject the patch faster.

So I created a text file containing one million lines. I deleted
about 60% of the lines and generated a diff.

Applying that diff on the file where the lines had already
been deleted (which would be the same as trying to
apply the patch twice on the original file), "git apply"
without my branch (standard 1.7.0) needed 0.076s
to reject the patch. With my branch (i.e. without the quick
reject), "git apply" rejected the patch in 0.087s.

So unless there is some other real-world use case I haven't
thought of, it does not seem worthwhile to keep
the quick rejection test for performance reasons.

I think I'll factor out the removal of the quick reject
into a separate commit in my next revision of the patch
series, including information from this email in the
commit message.

Another thing is whether the rejection test is actually
needed for correctness reasons. As far I understand
it, is is not not. There is one test that should be changed,
though, to make it clearer why it works. I intend to include
one of the following changes in my next revision of the patch
series.

Either this one:

diff --git a/builtin-apply.c b/builtin-apply.c
index 75c04f0..d58c1ea 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2090,7 +2090,11 @@ static int find_pos(struct image *img,
        else if (match_end)
                line =3D img->nr - preimage->nr;

-       if (line > img->nr)
+       /*
+        * Because the comparison is unsigned, the following test
+        * will also take care of a negative line number.
+        */
+       if ((size_t) line > img->nr)
                line =3D img->nr;

        try =3D 0;

Or this one:

diff --git a/builtin-apply.c b/builtin-apply.c
index 75c04f0..8ca0e32 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2090,7 +2090,9 @@ static int find_pos(struct image *img,
        else if (match_end)
                line =3D img->nr - preimage->nr;

-       if (line > img->nr)
+       if (line < 0)
+               line =3D 0;
+       else if (line > img->nr)
                line =3D img->nr;

        try =3D 0;

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
