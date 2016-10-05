Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACF420986
	for <e@80x24.org>; Wed,  5 Oct 2016 03:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbcJEDGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 23:06:02 -0400
Received: from p3plsmtp15-04-2.prod.phx3.secureserver.net ([173.201.193.40]:35959
        "EHLO p3plwbeout15-04.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbcJEDGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 23:06:01 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Oct 2016 23:06:01 EDT
Received: from localhost ([173.201.193.8])
        by p3plwbeout15-04.prod.phx3.secureserver.net with bizsmtp
        id rf0y1t0010BLAW501f0yiM; Tue, 04 Oct 2016 20:00:58 -0700
X-SID:  rf0y1t0010BLAW501
Received: (qmail 1812 invoked by uid 99); 5 Oct 2016 03:00:58 -0000
Content-Type: multipart/mixed;
        boundary="=_d79da263f1d494114b7e6a3b99b153b0"
X-Originating-IP: 71.206.170.124
User-Agent: Workspace Webmail 6.5.1
Message-Id: <20161004200057.dc30d64f61e5ec441c34ffd4f788e58e.efa66ead67.wbe@email15.godaddy.com>
From:   <writeonce@midipix.org>
To:     musl@lists.openwall.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        "Jeff King" <peff@peff.net>
Subject: RE: [musl] Re: Regression: git no longer works with musl libc's regex impl
Date:   Tue, 04 Oct 2016 20:00:57 -0700
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=_d79da263f1d494114b7e6a3b99b153b0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=0A< =0A< =0A< -------- Original Message --------=0A< Subject: [musl] Re: R=
egression: git no longer works with musl libc's=0A< regex impl=0A< From: Jo=
hannes Schindelin <Johannes.Schindelin@gmx.de>=0A< Date: Tue, October 04, 2=
016 9:08 am=0A< To: Rich Felker <dalias@libc.org>=0A< Cc: Jeff King <peff@p=
eff.net>, git@vger.kernel.org,=0A< musl@lists.openwall.com=0A< =0A< Hi Rich=
,=0A< =0A< On Tue, 4 Oct 2016, Rich Felker wrote:=0A< =0A< > On Tue, Oct 04=
, 2016 at 11:27:22AM -0400, Jeff King wrote:=0A< > > On Tue, Oct 04, 2016 a=
t 11:08:48AM -0400, Rich Felker wrote:=0A< > > =0A< > > > 1. is nonzero mod=
 page size, it just works; the remainder of the=0Alast=0A< > > > page reads=
 as zero bytes when mmapped.=0A< > > =0A< > > Is that a portable assumption=
?=0A< > =0A< > Yes.=0A< =0A< No, it is not. You quote POSIX, but the matter=
 of the fact is that we=0Ause=0A< a subset of POSIX in order to be able to =
keep things running on=0AWindows.=0A< =0A=0AAs far as I can tell (and as th=
e attached program may help demonstrate),=0Athe above assumption has been v=
alid on all versions of Windows since at=0Aleast Windows 2000. In this cont=
ext, one thing to remember is that the=0Apage-size for the mod operation is=
 4096, whereas the POSIX page-size=0A(for the purpose of mmap and mremap) i=
s 65536. Note also that in the=0Acase of file-backed mapped sections, using=
 kernel32.dll or msvcrt.dll or=0Acygwin/newlib or midipix/musl is of little=
 significance, specifically=0Asince all invoke ZwCreateSection and ZwMapVie=
wOfSection under the hood.=0A=0AHTH,=0Amidipix=0A=0A< And quite honestly, t=
here are lots of reasons to keep things running=0Aon=0A< Windows, and even =
to favor Windows support over musl support. Over=0Afour=0A< million reasons=
: the Git for Windows users.=0A< =0A< So rather than getting into an ideolo=
gical discussion about "broken"=0A< systems, it would be good to keep thing=
s practical, realizing that=0Athose=0A< users make up a very real chunk of =
all of Git's users.=0A< =0A< As to making NO_REGEX conditional on REG_START=
END: you are talking=0Aabout=0A< apples and oranges here. NO_REGEX is a Mak=
efile flag, while=0AREG_STARTEND=0A< is a C preprocessor macro.=0A< =0A< Un=
less you can convince the rest of the Git developers (you would not=0A< con=
vince me) to simulate autoconf by compiling an executable every=0Atime=0A< =
`make` is run, to determine whether REG_STARTEND is defined, this is a=0A< =
no-go.=0A< =0A< However, you *can* use autoconf directly, and come up with =
a patch to=0Aour=0A< configure.ac that detects the absence of REG_STARTEND =
and sets=0ANO_REGEX=3D1.=0A< =0A< Alternatively, you can set NO_REGEX=3D1 i=
n your config.mak.=0A< =0A< Or, if you use one of the auto-detected cases i=
n config.mak.uname, you=0A< could patch it to set NO_REGEX=3D1.=0A< =0A< An=
d lastly, the best alternative would be to teach musl about=0A< REG_STARTEN=
D, as it is rather useful a feature.=0A< =0A< Ciao,=0A< Johannes=0A< =0A=0A
--=_d79da263f1d494114b7e6a3b99b153b0
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
 name="mmap_file.c"; 
Content-Disposition: attachment;
 filename="mmap_file.c"; 

I2RlZmluZSBfWE9QRU5fU09VUkNFICAgICAgICAgICAgNTAwDQojZGVmaW5lIE5UX0ZJTEVfQkFD
S0VEX1BBR0VfU0laRSA0MDk2DQoNCiNpbmNsdWRlIDx1bmlzdGQuaD4NCiNpbmNsdWRlIDxmY250
bC5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxz
eXMvbW1hbi5oPg0KDQpzdGF0aWMgaW50IHRlc3RfZmlsZV9iYWNrZWRfbW1hcChpbnQgc2l6ZSkN
CnsNCglpbnQgICAgIGZkOw0KCWludCAgICAgZXhzaXplOw0KCXZvaWQgKiAgYWRkcjsNCgljaGFy
ICogIHRlc3Q7DQoJY2hhciAqICBjYXA7DQoJY2hhciAgICBuYW1lWzEyXTsNCg0KCS8qIGNyZWF0
ZSB0ZXN0IGZpbGUgb2YgZGVzaXJlZCBzaXplICovDQoJc3ByaW50ZihuYW1lLCIlZC50bXAiLHNp
emUpOw0KDQoJaWYgKChmZCA9IGNyZWF0KG5hbWUsMDc1NSkpIDwgMCkNCgkJcmV0dXJuIC0xOw0K
DQoJaWYgKGZ0cnVuY2F0ZShmZCxzaXplKSkNCgkJcmV0dXJuIC0xOw0KDQoJY2xvc2UoZmQpOw0K
DQoJLyogd3JpdGUgJ1cnIHRvIGFsbCBieXRlcyBvZiB0ZXN0IGZpbGUgKi8NCglpZiAoKGZkID0g
b3BlbihuYW1lLE9fUkRXUiwwKSkgPCAwKQ0KCQlyZXR1cm4gLTE7DQoNCglpZiAoKGFkZHIgPSBt
bWFwKDAsc2l6ZSxQUk9UX1dSSVRFLE1BUF9TSEFSRUQsZmQsMCkpID09IE1BUF9GQUlMRUQpDQoJ
CXJldHVybiAtMTsNCg0KCWNsb3NlKGZkKTsNCg0KCXRlc3QgPSAoY2hhciAqKWFkZHI7DQoJY2Fw
ICA9IChjaGFyICopYWRkciArIHNpemU7DQoNCglmb3IgKDsgdGVzdDxjYXA7IHRlc3QrKykNCgkJ
KnRlc3QgPSAnVyc7DQoNCgltdW5tYXAoYWRkcixzaXplKTsNCg0KCS8qIG1hcCBmaWxlIGZvciBy
ZWFkIGFjY2VzcyAqLw0KCWlmICgoZmQgPSBvcGVuKG5hbWUsT19SRE9OTFksMCkpIDwgMCkNCgkJ
cmV0dXJuIC0xOw0KDQoJaWYgKChhZGRyID0gbW1hcCgwLHNpemUsUFJPVF9SRUFELE1BUF9QUklW
QVRFLGZkLDApKSA9PSBNQVBfRkFJTEVEKQ0KCQlyZXR1cm4gLTE7DQoNCgljbG9zZShmZCk7DQoN
CgkvKiB0ZXN0ICovDQoJZXhzaXplID0gc2l6ZSArIE5UX0ZJTEVfQkFDS0VEX1BBR0VfU0laRTsN
CglleHNpemUgJj0gfihOVF9GSUxFX0JBQ0tFRF9QQUdFX1NJWkUgLSAxKTsNCg0KCXRlc3QgPSAo
Y2hhciAqKWFkZHIgKyBzaXplOw0KCWNhcCAgPSAoY2hhciAqKWFkZHIgKyBleHNpemU7DQoNCglm
b3IgKDsgdGVzdDxjYXA7IHRlc3QrKykNCgkJaWYgKCp0ZXN0KQ0KCQkJcmV0dXJuIC0xOw0KDQoJ
LyogY2xlYW4tdXAgKi8NCgltdW5tYXAoYWRkcixzaXplKTsNCgl1bmxpbmsobmFtZSk7DQoNCgly
ZXR1cm4gMDsNCg0KfQ0KDQppbnQgbWFpbih2b2lkKQ0Kew0KCWludCBpOw0KDQoJZm9yIChpPTE7
IGk8NjU1MzY7IGkrKykNCgkJaWYgKGkgJSBOVF9GSUxFX0JBQ0tFRF9QQUdFX1NJWkUpDQoJCQlp
ZiAodGVzdF9maWxlX2JhY2tlZF9tbWFwKGkpKQ0KCQkJCXJldHVybiAyOw0KDQoJcmV0dXJuIDA7
DQp9DQo=
--=_d79da263f1d494114b7e6a3b99b153b0--

