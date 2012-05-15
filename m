From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] pack-objects: use streaming interface for reading
 large loose blobs
Date: Tue, 15 May 2012 18:18:42 +0700
Message-ID: <CACsJy8Bk5=X8hQAHKXCArfq57o2tLBv0RN641N3-ws69S3GghQ@mail.gmail.com>
References: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
 <1336883862-9013-1-git-send-email-pclouds@gmail.com> <7v62byh7l4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 13:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUFmh-0007CU-FO
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 13:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab2EOLTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 07:19:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57256 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab2EOLTO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 07:19:14 -0400
Received: by wibhj8 with SMTP id hj8so2682939wib.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xkh9Jdrca3qUXqxH81LL3UBhszwCbvty63G3dMS/MeI=;
        b=ujZlH2inbaq2Y9CXGgmSFat57hysHQbHmNFmg05AiM1xyd86NRpyMesqyz4TsjoHwb
         xW+5yr8qy/1xLQ7NbN9zMgcM2E+5JfqDvbjSzOSxEmUh7LISGKDXw/26sCIIo52k4bK7
         fxEmm3AO2T32az+xEJE6xaK3T4D1KtbhfEb7RrTiDREij9X80mhYXOEFheBufvv4pMY1
         gEWNTK85J224t2xEfFT3no6UiqMZzDS2yyzMN7Eid3H/gJRFfFSCERFfty9QBk0HH4Jj
         YCGgDx3IQ+eleslgchqVbd6LhREYHYYhUlw3mMsWBO0vUH+S78CPnInEBLHqFCJd1aMT
         gHRw==
Received: by 10.216.142.38 with SMTP id h38mr7516246wej.54.1337080753221; Tue,
 15 May 2012 04:19:13 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 15 May 2012 04:18:42 -0700 (PDT)
In-Reply-To: <7v62byh7l4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197826>

On Tue, May 15, 2012 at 2:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> git usually streams large blobs directly to packs. But there are cas=
es
>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>> index 55ed955..7fbd2e1 100755
>> --- a/t/t1050-large.sh
>> +++ b/t/t1050-large.sh
>> @@ -134,6 +134,22 @@ test_expect_success 'repack' '
>> =C2=A0 =C2=A0 =C2=A0 git repack -ad
>> =C2=A0'
>>
>> +test_expect_success 'pack-objects with large loose object' '
>> + =C2=A0 =C2=A0 echo Z | dd of=3Dlarge4 bs=3D1k seek=3D2000 &&
>> + =C2=A0 =C2=A0 OBJ=3D9f36d94e145816ec642592c09cc8e601d83af157 &&
>> + =C2=A0 =C2=A0 P=3D.git/objects/9f/36d94e145816ec642592c09cc8e601d8=
3af157 &&
>
> I do not think you need these hardcoded constants; you will run
> hash-object later, no?
>
> Also, relying on $P to exist after hash-object -w returns is somewhat
> flaky, no?

I need it to be a loose object to test this code path. Maybe this inste=
ad?

test_expect_success 'pack-objects with large loose object' '
	SHA1=3D`git hash-object huge` &&
	test_create_repo loose &&
	echo $SHA1 | git pack-objects --stdout |
		GIT_ALLOC_LIMIT=3D0 GIT_DIR=3Dloose/.git git unpack-objects &&
	echo $SHA1 | GIT_DIR=3Dloose/.git git pack-objects pack  &&
	test_create_repo packed &&
	mv pack-* packed/.git/objects/pack &&
	GIT_DIR=3Dpacked/.git git cat-file blob $SHA1 >actual &&
	cmp huge actual
'

>> + =C2=A0 =C2=A0 rm $P &&
>> + =C2=A0 =C2=A0 git cat-file blob $OBJ >actual &&
>> + =C2=A0 =C2=A0 cmp large4 actual
>> +'
>
> In any case, the patch when applied on top of cd07cc5 (Update draft
> release notes to 1.7.11 (11th batch), 2012-05-11) does not pass this =
part
> of the test on my box.

Interesting. It passes for me (same base). I assume rm failed?
--=20
Duy
