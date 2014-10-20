From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 08:25:59 -0700
Message-ID: <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
References: <20141020115943.GA27144@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0160c2e6ef31ae0505dc54e4
Cc: infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:26:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgEqU-0002jh-9q
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 17:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbaJTP0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 11:26:02 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:52069 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaJTP0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 11:26:00 -0400
Received: by mail-vc0-f171.google.com with SMTP id hy10so3715531vcb.16
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WrGVElEZUAD6/R3ZwyigZhlwGOCi2uDa7Ob0/UXiiuE=;
        b=rHmvUkw9BvlK5Eq7C3ohAtQl085YplmO16NojEfvI7ZBWB4c3vlij0bY22SpfwECgd
         p2q/DtWx5tul6IiPFcsWBtuxt9q0sYYsKHd59nF4+qUZ7O9ZRy/1eAEoibzTHZRbpi63
         iAMhaobi83X1nC/8fhKyNDPFQmlwdg4C3UXOqpy99iCrU4RqZpOhNuLhAkFeSuOOLJXB
         1Q5mF/SgKMldtcbgI4pGrPeCTO+CfHbsXtcu7H/ajTfddmOIRHDSNDj1LXMN4FjbBMN3
         HDrzI6ZHkf5hZu+75a/fnqxfKk2PcE0zquMK0a2Enu8aRU/FzSc/LLaZIhhyutR9whuw
         tZQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WrGVElEZUAD6/R3ZwyigZhlwGOCi2uDa7Ob0/UXiiuE=;
        b=EzCB9c+vnH/uvYz8v/ErB2omM4fDq551FRyB+3aGPOJDBvSBj/ebFq2nEKRodPrDdj
         QpykgOSo99iPcn+UYlhVJZeawhiyOWX+B650FbU/Rsj2LaCxBtfTgjXhkCwjWoAgCphJ
         d/QXR+Irq8CxMY8kRpiPVyDlOVkN1K7AgyzJs=
X-Received: by 10.52.167.195 with SMTP id zq3mr15307944vdb.44.1413818759439;
 Mon, 20 Oct 2014 08:25:59 -0700 (PDT)
Received: by 10.220.3.148 with HTTP; Mon, 20 Oct 2014 08:25:59 -0700 (PDT)
In-Reply-To: <20141020115943.GA27144@gmail.com>
X-Google-Sender-Auth: V0im0ayLxMnSY2prva3QxTFDh10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--089e0160c2e6ef31ae0505dc54e4
Content-Type: text/plain; charset=UTF-8

Junio, Brian,

  it seems that the stability of the "git tar" output is broken.

On Mon, Oct 20, 2014 at 4:59 AM, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Looks like 3.18-rc1 upload didn't work:
>
> This is why the front page still lists 3.17 as the latest mainline. Want
> to try again?

Ok, tried again, and failed again.

> If that still doesn't work, you may have to use version 1.7 of git when
> generating the tarball and signature -- I recall Greg having a similar
> problem in the past.

Ugh, yes, that seems to be it. Current git generates different
tar-files than older releases do:

   tar-1.7.9.7 tar-cur differ: byte 107, line 1

and a quick bisection shows that it is due to commit 10f343ea814f
("archive: honor tar.umask even for pax headers") in the current git
development version.

Junio, quite frankly, I don't think that that fix was a good idea. I'd
suggest having a *separate* umask for the pax headers, so that we do
not  break this long-lasting stability of "git archive" output in ways
that are unfixable and not compatible. kernel.org has relied (for a
*long* time) on being able to just upload the signature of the
resulting tar-file, because both sides can generate the same tar-fiel
bit-for-bit.

So instead of using "tar_umask", please make it use "tar_pax_umask",
and have that default to 000. Ok?

Something like the attached patch.

Or just revert 10f343ea814f entirely.

                       Linus

--089e0160c2e6ef31ae0505dc54e4
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Don-t-use-the-default-tar.umask-for-pax-headers.patch"
Content-Disposition: attachment; 
	filename="0001-Don-t-use-the-default-tar.umask-for-pax-headers.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i1hz4dd41

RnJvbSBkNWNhN2FlMGEzNGUzMWM0ODM5N2Y1OWIwM2VjYWJkYTdjNWM0MGIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgMjAgT2N0IDIwMTQgMDg6MjE6MzggLTA3MDAKU3ViamVjdDog
W1BBVENIXSBEb24ndCB1c2UgdGhlIGRlZmF1bHQgJ3Rhci51bWFzaycgZm9yIHBheCBoZWFkZXJz
CgpUaGF0IHdhc24ndCB0aGUgb3JpZ2luYWwgYmVoYXZpb3IsIGFuZCBkb2luZyBzbyBicmVha3Mg
dGhlIGZhY3QgdGhhdAp0YXItZmlsZXMgYXJlIGJpdC1mb3ItYml0IGNvbXBhdGlibGUgYWNyb3Nz
IGdpdCB2ZXJzaW9ucy4KCklmIHlvdSByZWFsbHkgd2FudCB0byB3b3JrIGFyb3VuZCBicm9rZW4g
cmVjZWl2aW5nIHRhciBpbXBsZW1lbnRhdGlvbnMKKGR1YmlvdXMsIHdlJ3ZlIG5vdCBuZWVkZWQg
dG8gZG8gc28gYmVmb3JlKSwgdXNlICJbdGFyXSBwYXh1bWFzayIgaW4gdGhlCmdpdCBjb25maWcg
ZmlsZS4gIE9yIG1heWJlIHdlIGNvdWxkIGV4cG9zZSBzb21lIGNvbW1hbmQgbGluZSBmbGFnIHRv
IGRvCnNvLiAgQnV0IGRvbid0IGJyZWFrIGV4aXN0aW5nIGZvcm1hdCBjb21wYXRpYmlsaXR5IGZv
ciBkdWJpb3VzIGdhaW5zLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGFyY2hpdmUtdGFyLmMgfCAxNCArKysrKysrKysr
KystLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaGl2ZS10YXIuYyBiL2FyY2hpdmUtdGFyLmMKaW5kZXggZGYyZjRjOGE2
NDM3Li40MDEzOWVhNGVlNGUgMTAwNjQ0Ci0tLSBhL2FyY2hpdmUtdGFyLmMKKysrIGIvYXJjaGl2
ZS10YXIuYwpAQCAtMTQsNiArMTQsNyBAQCBzdGF0aWMgY2hhciBibG9ja1tCTE9DS1NJWkVdOwog
c3RhdGljIHVuc2lnbmVkIGxvbmcgb2Zmc2V0OwogCiBzdGF0aWMgaW50IHRhcl91bWFzayA9IDAw
MjsKK3N0YXRpYyBpbnQgdGFyX3BheF91bWFzayA9IDAwMDsKIAogc3RhdGljIGludCB3cml0ZV90
YXJfZmlsdGVyX2FyY2hpdmUoY29uc3Qgc3RydWN0IGFyY2hpdmVyICphciwKIAkJCQkgICAgc3Ry
dWN0IGFyY2hpdmVyX2FyZ3MgKmFyZ3MpOwpAQCAtMTkyLDcgKzE5Myw3IEBAIHN0YXRpYyBpbnQg
d3JpdGVfZXh0ZW5kZWRfaGVhZGVyKHN0cnVjdCBhcmNoaXZlcl9hcmdzICphcmdzLAogCXVuc2ln
bmVkIGludCBtb2RlOwogCW1lbXNldCgmaGVhZGVyLCAwLCBzaXplb2YoaGVhZGVyKSk7CiAJKmhl
YWRlci50eXBlZmxhZyA9IFRZUEVGTEFHX0VYVF9IRUFERVI7Ci0JbW9kZSA9IDAxMDA2NjYgJiB+
dGFyX3VtYXNrOworCW1vZGUgPSAwMTAwNjY2ICYgfnRhcl9wYXhfdW1hc2s7CiAJc3ByaW50Ziho
ZWFkZXIubmFtZSwgIiVzLnBheGhlYWRlciIsIHNoYTFfdG9faGV4KHNoYTEpKTsKIAlwcmVwYXJl
X2hlYWRlcihhcmdzLCAmaGVhZGVyLCBtb2RlLCBzaXplKTsKIAl3cml0ZV9ibG9ja2VkKCZoZWFk
ZXIsIHNpemVvZihoZWFkZXIpKTsKQEAgLTMwMCw3ICszMDEsNyBAQCBzdGF0aWMgaW50IHdyaXRl
X2dsb2JhbF9leHRlbmRlZF9oZWFkZXIoc3RydWN0IGFyY2hpdmVyX2FyZ3MgKmFyZ3MpCiAJc3Ry
YnVmX2FwcGVuZF9leHRfaGVhZGVyKCZleHRfaGVhZGVyLCAiY29tbWVudCIsIHNoYTFfdG9faGV4
KHNoYTEpLCA0MCk7CiAJbWVtc2V0KCZoZWFkZXIsIDAsIHNpemVvZihoZWFkZXIpKTsKIAkqaGVh
ZGVyLnR5cGVmbGFnID0gVFlQRUZMQUdfR0xPQkFMX0hFQURFUjsKLQltb2RlID0gMDEwMDY2NiAm
IH50YXJfdW1hc2s7CisJbW9kZSA9IDAxMDA2NjYgJiB+dGFyX3BheF91bWFzazsKIAlzdHJjcHko
aGVhZGVyLm5hbWUsICJwYXhfZ2xvYmFsX2hlYWRlciIpOwogCXByZXBhcmVfaGVhZGVyKGFyZ3Ms
ICZoZWFkZXIsIG1vZGUsIGV4dF9oZWFkZXIubGVuKTsKIAl3cml0ZV9ibG9ja2VkKCZoZWFkZXIs
IHNpemVvZihoZWFkZXIpKTsKQEAgLTM3NCw2ICszNzUsMTUgQEAgc3RhdGljIGludCBnaXRfdGFy
X2NvbmZpZyhjb25zdCBjaGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlLCB2b2lkICpjYikKIAkJ
cmV0dXJuIDA7CiAJfQogCisJaWYgKCFzdHJjbXAodmFyLCAidGFyLnBheHVtYXNrIikpIHsKKwkJ
aWYgKHZhbHVlICYmICFzdHJjbXAodmFsdWUsICJ1c2VyIikpIHsKKwkJCXRhcl9wYXhfdW1hc2sg
PSB1bWFzaygwKTsKKwkJfSBlbHNlIHsKKwkJCXRhcl9wYXhfdW1hc2sgPSBnaXRfY29uZmlnX2lu
dCh2YXIsIHZhbHVlKTsKKwkJfQorCQlyZXR1cm4gMDsKKwl9CisKIAlyZXR1cm4gdGFyX2ZpbHRl
cl9jb25maWcodmFyLCB2YWx1ZSwgY2IpOwogfQogCi0tIAoyLjEuMi4zMzAuZzU2NTMwMWUKCg==
--089e0160c2e6ef31ae0505dc54e4--
