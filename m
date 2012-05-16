From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] pack-objects: use streaming interface for reading
 large loose blobs
Date: Wed, 16 May 2012 14:09:32 +0700
Message-ID: <CACsJy8DzdFORUMy7p_eVotr=HdkMX10uXy25H=05TBDjOmi4yw@mail.gmail.com>
References: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
 <1336883862-9013-1-git-send-email-pclouds@gmail.com> <7v62byh7l4.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bk5=X8hQAHKXCArfq57o2tLBv0RN641N3-ws69S3GghQ@mail.gmail.com> <7vhavhforl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 09:10:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUYNE-0001nr-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 09:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419Ab2EPHKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 03:10:05 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53497 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759272Ab2EPHKE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 03:10:04 -0400
Received: by wibhj8 with SMTP id hj8so3616275wib.1
        for <git@vger.kernel.org>; Wed, 16 May 2012 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NBdSFwqedQGl9B0Xf/6BHiVOTN9mzINAJaU+uMy2Jig=;
        b=DEA8EToFyxMyhq1vAFws1p/M6OG59F+hTLfRuS7yaFalz6kRxS2cvcWsdMIE4XAvpC
         RQB4vUKUPjS5QiCVGplWbBLwUqna6zBg0JCE57jO/RqiOqCr/SX4k/V6QtPEZ3IgMWRl
         zN/eIgXLmVvP85L+D9Kwy6y6Jb3rbrloTz+kJMjRS+UI88IoQwfgn97BWkQd1JH/fR5F
         YxKjmWu1GJdTrM20PqqYqdgSDgvQ3aIuSbl2OG+ocvhjdomT69bXYK/kvFyNaBAI9DRJ
         Sn4QbmxBhTdXEWmMqlVZJeD43WTeyUHSAQN/q7JCBEqg/zCJuG3QSDDDvaIQbHNVwgZv
         irQA==
Received: by 10.180.77.4 with SMTP id o4mr5013699wiw.17.1337152202949; Wed, 16
 May 2012 00:10:02 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Wed, 16 May 2012 00:09:32 -0700 (PDT)
In-Reply-To: <7vhavhforl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197867>

On Tue, May 15, 2012 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Tue, May 15, 2012 at 2:43 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com>=
 writes:
>>>
>>>> git usually streams large blobs directly to packs. But there are c=
ases
>>>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>>>> index 55ed955..7fbd2e1 100755
>>>> --- a/t/t1050-large.sh
>>>> +++ b/t/t1050-large.sh
>>>> @@ -134,6 +134,22 @@ test_expect_success 'repack' '
>>>> =C2=A0 =C2=A0 =C2=A0 git repack -ad
>>>> =C2=A0'
>>>>
>>>> +test_expect_success 'pack-objects with large loose object' '
>>>> + =C2=A0 =C2=A0 echo Z | dd of=3Dlarge4 bs=3D1k seek=3D2000 &&
>>>> + =C2=A0 =C2=A0 OBJ=3D9f36d94e145816ec642592c09cc8e601d83af157 &&
>>>> + =C2=A0 =C2=A0 P=3D.git/objects/9f/36d94e145816ec642592c09cc8e601=
d83af157 &&
>>>
>>> I do not think you need these hardcoded constants; you will run
>>> hash-object later, no?
>>>
>>> Also, relying on $P to exist after hash-object -w returns is somewh=
at
>>> flaky, no?
>>
>> I need it to be a loose object to test this code path.
>
> No you don't. =C2=A0You only need it to be something istream_read() w=
ill read
> from, iow, it could come from a base representation in a packfile.

No, an in-pack object will set to_reuse to 1, which goes a completely
different code path. write_large_blob_data() is only called when
to_reuse =3D=3D 0.

>>> In any case, the patch when applied on top of cd07cc5 (Update draft
>>> release notes to 1.7.11 (11th batch), 2012-05-11) does not pass thi=
s part
>>> of the test on my box.
>>
>> Interesting. It passes for me (same base). I assume rm failed?
>
> No, reading the resulting pack dies with an error message that says t=
he
> object could not be read at offset 12, implying that the pack writer =
wrote
> something bogus.

I'm still unable to reproduce that. But I think I found the problem.
In streaming code path, I set datalen =3D <uncompressed size> but
write_object() returns "hdrlen + (wrong) datalen". Patches will come a
couple of hours from now.
--=20
Duy
