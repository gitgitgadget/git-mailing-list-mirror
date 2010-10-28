From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Minimum git commit abbrev length (Was Re: -tip: origin tree build
 failure (was: [GIT PULL] ext4 update) for 2.6.37)
Date: Thu, 28 Oct 2010 11:28:04 -0700
Message-ID: <AANLkTi=8tq1zu_RWjmk5rLOWvP_KPH5UQioQ6wEkc0Ob@mail.gmail.com>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu> <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <20101028171701.GA18368@elte.hu> <20101028172725.GA6814@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf301d3a20038f050493b182c9
To: "Ted Ts'o" <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 20:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXDv-0008Ua-RD
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934100Ab0J1S3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:29:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60932 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934045Ab0J1S3F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 14:29:05 -0400
Received: from mail-yx0-f174.google.com (mail-yx0-f174.google.com [209.85.213.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o9SISYbK023717
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL);
	Thu, 28 Oct 2010 11:28:35 -0700
Received: by yxk8 with SMTP id 8so1131610yxk.19
        for <multiple recipients>; Thu, 28 Oct 2010 11:28:26 -0700 (PDT)
Received: by 10.42.215.68 with SMTP id hd4mr8511883icb.372.1288290506608; Thu,
 28 Oct 2010 11:28:26 -0700 (PDT)
Received: by 10.231.14.134 with HTTP; Thu, 28 Oct 2010 11:28:04 -0700 (PDT)
In-Reply-To: <20101028172725.GA6814@thunk.org>
X-Spam-Status: No, hits=-2.911 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160202>

--20cf301d3a20038f050493b182c9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 28, 2010 at 10:27 AM, Ted Ts'o <tytso@mit.edu> wrote:
> On Thu, Oct 28, 2010 at 07:17:01PM +0200, Ingo Molnar wrote:
>> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > Yes. Except for the kernel the default git commit abbreviation is
>> > borderline too short. Seven hex-chars can easily alias with a few
>> > more pulls from me: git will not give aliases at the time it gives
>> > a shorthand, but a month or two later the abbreviated commit may
>> > no longer be unique.
>> >
>> > So I suggest using --abbrev=3D12 or similar.
>>
>> ok. A helper script i use does this:
>>
>> =A0 =A0git log --pretty=3Dformat:"%h: %s" $@
>>
>> I have added --abbrev=3D12. Might make sense to lengthen the %h
>> default in upstream Git as well?
>
> Maybe the right thing to do is add a git config option which allows
> for a configurable minimum git commit abbreviation length?

Yes. The default of 7 (I think) comes from fairly early in git
development, when seven hex digits was a lot (it covers about 250+
million hash values). Back then I thought that 65k revisions was a lot
(it was what we were about to hit in BK), and each revision tends to
be about 5-10 new objects or so, so a million objects was a big
number.

These days, the kernel isn't even the largest git project, and even
the kernel has about 220k revisions (_much_ bigger than the BK tree
ever was) and we are approaching two million objects. At that point,
seven hex digits is still unique for a lot of them, but when we're
talking about just two orders of magnitude difference between number
of objects and the hash size, there _will_ be hash collisions. It's no
longer even close to unrealistic - it happens all the time.

So I suspect we should both increase the default abbrev that was
unrealistically small, _and_ add a way for people to set their own
default per-project in the git config file.

Maybe something like the attached (not necessarily well-thought-out or
well-tested: I also didn't actually change the default, although I
suspect we should up it from 7 to at least 10).

                        Linus

--20cf301d3a20038f050493b182c9
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gftyvcrf0

IGJ1aWx0aW4vZGVzY3JpYmUuYyB8ICAgIDIgKy0KIGNhY2hlLmggICAgICAgICAgICB8ICAgIDUg
KysrLS0KIGNvbmZpZy5jICAgICAgICAgICB8ICAgIDggKysrKysrKysKIGVudmlyb25tZW50LmMg
ICAgICB8ICAgIDEgKwogNCBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4vZGVzY3JpYmUuYyBiL2J1aWx0aW4vZGVzY3Jp
YmUuYwppbmRleCA0M2NhZmYyLi4yZDk4NzAyIDEwMDY0NAotLS0gYS9idWlsdGluL2Rlc2NyaWJl
LmMKKysrIGIvYnVpbHRpbi9kZXNjcmliZS5jCkBAIC0yMCw3ICsyMCw3IEBAIHN0YXRpYyBpbnQg
ZGVidWc7CS8qIERpc3BsYXkgbG90cyBvZiB2ZXJib3NlIGluZm8gKi8KIHN0YXRpYyBpbnQgYWxs
OwkvKiBBbnkgdmFsaWQgcmVmIGNhbiBiZSB1c2VkICovCiBzdGF0aWMgaW50IHRhZ3M7CS8qIEFs
bG93IGxpZ2h0d2VpZ2h0IHRhZ3MgKi8KIHN0YXRpYyBpbnQgbG9uZ2Zvcm1hdDsKLXN0YXRpYyBp
bnQgYWJicmV2ID0gREVGQVVMVF9BQkJSRVY7CitzdGF0aWMgaW50IGFiYnJldiA9IDc7CS8qIE5P
VEUhIE5vdCBERUZBVUxUX0FCQlJFViAqLwogc3RhdGljIGludCBtYXhfY2FuZGlkYXRlcyA9IDEw
Owogc3RhdGljIGludCBmb3VuZF9uYW1lczsKIHN0YXRpYyBjb25zdCBjaGFyICpwYXR0ZXJuOwpk
aWZmIC0tZ2l0IGEvY2FjaGUuaCBiL2NhY2hlLmgKaW5kZXggMzNkZWNkOS4uNmMyOGE4MSAxMDA2
NDQKLS0tIGEvY2FjaGUuaAorKysgYi9jYWNoZS5oCkBAIC01NDAsNiArNTQwLDcgQEAgZXh0ZXJu
IGludCB0cnVzdF9leGVjdXRhYmxlX2JpdDsKIGV4dGVybiBpbnQgdHJ1c3RfY3RpbWU7CiBleHRl
cm4gaW50IHF1b3RlX3BhdGhfZnVsbHk7CiBleHRlcm4gaW50IGhhc19zeW1saW5rczsKK2V4dGVy
biBpbnQgbWluaW11bV9hYmJyZXYsIGRlZmF1bHRfYWJicmV2OwogZXh0ZXJuIGludCBpZ25vcmVf
Y2FzZTsKIGV4dGVybiBpbnQgYXNzdW1lX3VuY2hhbmdlZDsKIGV4dGVybiBpbnQgcHJlZmVyX3N5
bWxpbmtfcmVmczsKQEAgLTc1Nyw4ICs3NTgsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGlu
dCBoZXh2YWwodW5zaWduZWQgY2hhciBjKQogfQogCiAvKiBDb252ZXJ0IHRvL2Zyb20gaGV4L3No
YTEgcmVwcmVzZW50YXRpb24gKi8KLSNkZWZpbmUgTUlOSU1VTV9BQkJSRVYgNAotI2RlZmluZSBE
RUZBVUxUX0FCQlJFViA3CisjZGVmaW5lIE1JTklNVU1fQUJCUkVWIG1pbmltdW1fYWJicmV2Cisj
ZGVmaW5lIERFRkFVTFRfQUJCUkVWIGRlZmF1bHRfYWJicmV2CiAKIHN0cnVjdCBvYmplY3RfY29u
dGV4dCB7CiAJdW5zaWduZWQgY2hhciB0cmVlWzIwXTsKZGlmZiAtLWdpdCBhL2NvbmZpZy5jIGIv
Y29uZmlnLmMKaW5kZXggNGIwYTgyMC4uNDc0MzYxYyAxMDA2NDQKLS0tIGEvY29uZmlnLmMKKysr
IGIvY29uZmlnLmMKQEAgLTUxNCw2ICs1MTQsMTQgQEAgc3RhdGljIGludCBnaXRfZGVmYXVsdF9j
b3JlX2NvbmZpZyhjb25zdCBjaGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlKQogCQlyZXR1cm4g
MDsKIAl9CiAKKwlpZiAoIXN0cmNtcCh2YXIsICJjb3JlLmFiYnJldiIpKSB7CisJCWludCBhYmJy
ZXYgPSBnaXRfY29uZmlnX2ludCh2YXIsIHZhbHVlKTsKKwkJaWYgKGFiYnJldiA8IG1pbmltdW1f
YWJicmV2IHx8IGFiYnJldiA+IDQwKQorCQkJcmV0dXJuIC0xOworCQlkZWZhdWx0X2FiYnJldiA9
IGFiYnJldjsKKwkJcmV0dXJuIDA7CisJfQorCiAJaWYgKCFzdHJjbXAodmFyLCAiY29yZS5sb29z
ZWNvbXByZXNzaW9uIikpIHsKIAkJaW50IGxldmVsID0gZ2l0X2NvbmZpZ19pbnQodmFyLCB2YWx1
ZSk7CiAJCWlmIChsZXZlbCA9PSAtMSkKZGlmZiAtLWdpdCBhL2Vudmlyb25tZW50LmMgYi9lbnZp
cm9ubWVudC5jCmluZGV4IGRlNTU4MWYuLmI5ODAwM2MgMTAwNjQ0Ci0tLSBhL2Vudmlyb25tZW50
LmMKKysrIGIvZW52aXJvbm1lbnQuYwpAQCAtMTUsNiArMTUsNyBAQCBpbnQgdXNlcl9pZGVudF9l
eHBsaWNpdGx5X2dpdmVuOwogaW50IHRydXN0X2V4ZWN1dGFibGVfYml0ID0gMTsKIGludCB0cnVz
dF9jdGltZSA9IDE7CiBpbnQgaGFzX3N5bWxpbmtzID0gMTsKK2ludCBtaW5pbXVtX2FiYnJldiA9
IDQsIGRlZmF1bHRfYWJicmV2ID0gNzsKIGludCBpZ25vcmVfY2FzZTsKIGludCBhc3N1bWVfdW5j
aGFuZ2VkOwogaW50IHByZWZlcl9zeW1saW5rX3JlZnM7Cg==
--20cf301d3a20038f050493b182c9--
