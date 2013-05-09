From: Filipe Cabecinhas <filcab@gmail.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Thu, 9 May 2013 15:58:25 -0700
Message-ID: <CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0442881af3d8ca04dc50fc43
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 00:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZng-00041p-4q
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab3EIW6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:58:54 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:50893 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757685Ab3EIW61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:58:27 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so62550wiv.7
        for <git@vger.kernel.org>; Thu, 09 May 2013 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Qgo5GMnc6hEmV5qeT+KYqGQLUq7wcGbwEd4dpdrjGD4=;
        b=hcGWI7VUxG/KHjC1AGUUZqWsCULwjCph3K9YfZRnTA46I54jNceG6vXlrot/eQkHK+
         K5Mb9JGyW/X5s4da+TkLk+K59MHI0e5ZtcWN2UIfI178p7MHslHsV6J30b6WhS4zDvHy
         wQCrqylH1HvebCULsOkXNkw1Wd+J06mvTg0NqVs2InPEPpnLiMfJxVTNoqSkmNmLg+gs
         SLO72i4kzS5BTncXcPZwRLWPg0PF9+TW7G+jmrIrYWtalhGlLkthMauFld6IEFfnHQxi
         MyZbPVEMOraBLHaBBLxF1xFWoEpJZZqEjwMCpjq94Jqca3mpNtVCDmLwqSmqg5TCzX+K
         nSgg==
X-Received: by 10.180.105.231 with SMTP id gp7mr149377wib.23.1368140306174;
 Thu, 09 May 2013 15:58:26 -0700 (PDT)
Received: by 10.194.38.233 with HTTP; Thu, 9 May 2013 15:58:25 -0700 (PDT)
In-Reply-To: <7v4nffpbct.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223795>

--f46d0442881af3d8ca04dc50fc43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Sorry for the delay. I've updated the patch to work as you suggested (I thi=
nk).
It's attached.

Thank you,

  Filipe
  F


On Tue, Apr 9, 2013 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Filipe Cabecinhas <filcab@gmail.com> writes:
>
>>
>> Testing with dd bs=3DINT_MAX+1 count=3D1 also gets me an =E2=80=9CInvali=
d
>> argument=E2=80=9D error, while bs=3DINT_MAX will do what's expected.
>>
>> I have a preliminary patch that fixes it, but it may not be the
>> preferred way. The code is not ifdef'ed out and I'm doing the fix in
>> write_in_full(), while it may be preferred to do the fix in xwrite().
>>
>> A radar bug has been submitted to Apple about this, but I think git
>> could tolerate the bug while it isn't fixed, by working around it.
>>
>> Thank you,
>>
>>   Filipe
>>
>> diff --git a/wrapper.c b/wrapper.c
>> index bac59d2..474d760 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -187,7 +187,12 @@ ssize_t write_in_full(int fd, const void *buf, size=
_t count)
>>       ssize_t total =3D 0;
>>
>>       while (count > 0) {
>> -             ssize_t written =3D xwrite(fd, p, count);
>> +             ssize_t written =3D 0;
>> +        if (count >=3D INT_MAX)
>> +                     written =3D xwrite(fd, p, INT_MAX-1);
>> +        else
>> +                     written =3D xwrite(fd, p, count);
>
> I think it is better to fix it in much lower level of the stack, as
> other codepaths would call write(2), either thru xwrite() or
> directly.
>
> Ideally the fix should go to the lowest level, i.e. the write(2).  I
> do not care if it is done in the kernel or in the libc wrapping
> code; the above does not belong to our code (in an ideal world, that
> is).
>
> Otherwise you would have to patch everything in /usr/bin, no?
>
> But you do not live in an ideal world and neither do we.  I think
> the least ugly way may be to add compat/clipped-write.c that
> implements a loop like the above in a helper function:
>
>         ssize_t clipped_write(int, const void *, size_t);
>
> and have a
>
>         #ifdef NEED_CLIPPED_WRITE
>         #define write(x,y,z) clipped_write((x),(y),(z))
>         #endif
>
> in git-compat-util.h, or something.  Makefile needs to get adjusted
> to link with compat/clipped-write.o when NEED_CLIPPED_WRITE is
> defined as well.

--f46d0442881af3d8ca04dc50fc43
Content-Type: application/octet-stream; name="git-big-write-darwin.patch"
Content-Disposition: attachment; filename="git-big-write-darwin.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgijeqf80

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggMGY5MzFhMi4uZTZhZmY4NSAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTE0NjYsNiArMTQ2NiwxMSBA
QCBpZm5kZWYgTk9fTVNHRk1UX0VYVEVOREVEX09QVElPTlMKIAlNU0dGTVQgKz0gLS1jaGVjayAt
LXN0YXRpc3RpY3MKIGVuZGlmCiAKK2lmZGVmIE5FRURTX0NMSVBQRURfV1JJVEUKKwlCQVNJQ19D
RkxBR1MgKz0gLURORUVEU19DTElQUEVEX1dSSVRFCisJQ09NUEFUX09CSlMgKz0gY29tcGF0L3dy
aXRlLm8KK2VuZGlmCisKIGlmbmVxICgsJChYRExfRkFTVF9IQVNIKSkKIAlCQVNJQ19DRkxBR1Mg
Kz0gLURYRExfRkFTVF9IQVNICiBlbmRpZgpkaWZmIC0tZ2l0IGEvY29tcGF0L3dyaXRlLmMgYi9j
b21wYXQvd3JpdGUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4xZTg5MGFh
Ci0tLSAvZGV2L251bGwKKysrIGIvY29tcGF0L3dyaXRlLmMKQEAgLTAsMCArMSwxMSBAQAorI2lu
Y2x1ZGUgPGxpbWl0cy5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgorCisvKiBWZXJzaW9uIG9mIHdy
aXRlIHRoYXQgd2lsbCB3cml0ZSBhdCBtb3N0IElOVF9NQVggYnl0ZXMuCisgKiBXb3JrYXJvdW5k
IGEgeG51IGJ1ZyBvbiBNYWMgT1MgWCAqLworc3NpemVfdCBjbGlwcGVkX3dyaXRlKGludCBmaWxk
ZXMsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IG5ieXRlKSB7CisgIGlmIChuYnl0ZSA+IElOVF9N
QVgpCisgICAgcmV0dXJuIHdyaXRlKGZpbGRlcywgYnVmLCBJTlRfTUFYKTsKKyAgZWxzZQorICAg
IHJldHVybiB3cml0ZShmaWxkZXMsIGJ1ZiwgbmJ5dGUpOworfQpkaWZmIC0tZ2l0IGEvY29uZmln
Lm1hay51bmFtZSBiL2NvbmZpZy5tYWsudW5hbWUKaW5kZXggZDc4ZmQzZC4uMTc0NzAzYiAxMDA2
NDQKLS0tIGEvY29uZmlnLm1hay51bmFtZQorKysgYi9jb25maWcubWFrLnVuYW1lCkBAIC05NSw2
ICs5NSw3IEBAIGlmZXEgKCQodW5hbWVfUyksRGFyd2luKQogCU5PX01FTU1FTSA9IFllc1BsZWFz
ZQogCVVTRV9TVF9USU1FU1BFQyA9IFllc1BsZWFzZQogCUhBVkVfREVWX1RUWSA9IFllc1BsZWFz
ZQorCU5FRURTX0NMSVBQRURfV1JJVEUgPSBZZXNQbGVhc2UKIAlDT01QQVRfT0JKUyArPSBjb21w
YXQvcHJlY29tcG9zZV91dGY4Lm8KIAlCQVNJQ19DRkxBR1MgKz0gLURQUkVDT01QT1NFX1VOSUNP
REUKIGVuZGlmCmRpZmYgLS1naXQgYS9naXQtY29tcGF0LXV0aWwuaCBiL2dpdC1jb21wYXQtdXRp
bC5oCmluZGV4IGU5NTViYjUuLmE5NmRiMjMgMTAwNjQ0Ci0tLSBhL2dpdC1jb21wYXQtdXRpbC5o
CisrKyBiL2dpdC1jb21wYXQtdXRpbC5oCkBAIC0xODUsNiArMTg1LDExIEBAIGludCBnZXRfc3Rf
bW9kZV9iaXRzKGNvbnN0IGNoYXIgKnBhdGgsIGludCAqbW9kZSk7CiAjZGVmaW5lIHByb2JlX3V0
ZjhfcGF0aG5hbWVfY29tcG9zaXRpb24oYSxiKQogI2VuZGlmCiAKKyNpZmRlZiBORUVEU19DTElQ
UEVEX1dSSVRFCitzc2l6ZV90IGNsaXBwZWRfd3JpdGUoaW50IGZpbGRlcywgY29uc3Qgdm9pZCAq
YnVmLCBzaXplX3QgbmJ5dGUpOworI2RlZmluZSB3cml0ZSh4LCB5LCB6KSBjbGlwcGVkX3dyaXRl
KCh4KSwgKHkpLCAoeikpCisjZW5kaWYKKwogI2lmZGVmIE1LRElSX1dPX1RSQUlMSU5HX1NMQVNI
CiAjZGVmaW5lIG1rZGlyKGEsYikgY29tcGF0X21rZGlyX3dvX3RyYWlsaW5nX3NsYXNoKChhKSwo
YikpCiBleHRlcm4gaW50IGNvbXBhdF9ta2Rpcl93b190cmFpbGluZ19zbGFzaChjb25zdCBjaGFy
KiwgbW9kZV90KTsK
--f46d0442881af3d8ca04dc50fc43--
