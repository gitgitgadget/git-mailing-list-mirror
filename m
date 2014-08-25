From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [BUG] resolved deltas
Date: Mon, 25 Aug 2014 18:39:45 +0200
Message-ID: <53FB66D1.709@web.de>
References: <53F5D98F.4040700@redhat.com> <53F79CE3.60803@gmx.net> <53F868F8.9080000@web.de> <20140823105640.GA6881@peff.net> <20140823110459.GA13087@peff.net> <20140823111804.GA17335@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:40:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxJy-0002UV-IW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 18:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbaHYQki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 12:40:38 -0400
Received: from mout.web.de ([212.227.15.14]:56646 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbaHYQki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 12:40:38 -0400
Received: from [192.168.178.27] ([79.253.134.154]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MAvZs-1XEDXg07jY-00A1DD; Mon, 25 Aug 2014 18:40:24
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140823111804.GA17335@peff.net>
X-Provags-ID: V03:K0:IulH9MlR9QRTf2Skvj14skyggCX2QwvgAlNOX3pWLuP70QT0Rsw
 M42y/vSgOR1q8Aesoa5TDJXY3VEIepWPXvtK5TgDf5QAkAp5EMMkGbYMb2/zTYn74l2boOj
 Tx4BNmB7byqLTswY6VO4bnjYn4nhq64VCAahpXYR/JN2co51XMX2+Mxtc6ej0JvdhFILQkg
 TgrPf3gWvlk35YyPVpkEw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255833>

Am 23.08.2014 um 13:18 schrieb Jeff King:
> On Sat, Aug 23, 2014 at 07:04:59AM -0400, Jeff King wrote:
>=20
>> On Sat, Aug 23, 2014 at 06:56:40AM -0400, Jeff King wrote:
>>
>>> So I think your patch is doing the right thing.
>>
>> By the way, if you want to add a test to your patch, there is
>> infrastructure in t5308 to create packs with duplicate objects. If I
>> understand the problem correctly, you could trigger this by having a
>> delta object whose base is duplicated, even without the missing obje=
ct.
>=20
> This actually turned out to be really easy. The test below fails with=
out
> your patch and passes with it. Please feel free to squash it in.
>=20
> diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-=
duplicates.sh
> index 9c5a876..50f7a69 100755
> --- a/t/t5308-pack-detect-duplicates.sh
> +++ b/t/t5308-pack-detect-duplicates.sh
> @@ -77,4 +77,19 @@ test_expect_success 'index-pack can reject packs w=
ith duplicates' '
>   	test_expect_code 1 git cat-file -e $LO_SHA1
>   '
>  =20
> +test_expect_success 'duplicated delta base does not trigger assert' =
'
> +	clear_packs &&
> +	{
> +		A=3D01d7713666f4de822776c7622c10f1b07de280dc &&
> +		B=3De68fe8129b546b101aee9510c5328e7f21ca1d18 &&
> +		pack_header 3 &&
> +		pack_obj $A $B &&
> +		pack_obj $B &&
> +		pack_obj $B
> +	} >dups.pack &&
> +	pack_trailer dups.pack &&
> +	git index-pack --stdin <dups.pack &&
> +	test_must_fail git index-pack --stdin --strict <dups.pack
> +'
> +
>   test_done

Thanks, that looks good.  But while preparing the patch I noticed that
the added test sometimes fails.  Helgrind pointed outet a race
condition.  It is not caused by the patch to turn the asserts into
regular ifs, however -- here's a Helgrind report for the original code
with the new test:

=3D=3D34949=3D=3D Helgrind, a thread error detector
=3D=3D34949=3D=3D Copyright (C) 2007-2013, and GNU GPL'd, by OpenWorks =
LLP et al.
=3D=3D34949=3D=3D Using Valgrind-3.9.0 and LibVEX; rerun with -h for co=
pyright info
=3D=3D34949=3D=3D Command: /home/lsr/src/git/t/../bin-wrappers/git inde=
x-pack --stdin
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D Helgrind, a thread error detector
=3D=3D34949=3D=3D Copyright (C) 2007-2013, and GNU GPL'd, by OpenWorks =
LLP et al.
=3D=3D34949=3D=3D Using Valgrind-3.9.0 and LibVEX; rerun with -h for co=
pyright info
=3D=3D34949=3D=3D Command: /home/lsr/src/git/git index-pack --stdin
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D ---Thread-Announcement-------------------------------=
-----------
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D Thread #3 was created
=3D=3D34949=3D=3D    at 0x594DF7E: clone (clone.S:74)
=3D=3D34949=3D=3D    by 0x544A2B9: do_clone.constprop.3 (createthread.c=
:75)
=3D=3D34949=3D=3D    by 0x544B762: pthread_create@@GLIBC_2.2.5 (createt=
hread.c:245)
=3D=3D34949=3D=3D    by 0x4C2D55D: pthread_create_WRK (hg_intercepts.c:=
269)
=3D=3D34949=3D=3D    by 0x43ABB8: cmd_index_pack (index-pack.c:1097)
=3D=3D34949=3D=3D    by 0x405B6A: handle_builtin (git.c:351)
=3D=3D34949=3D=3D    by 0x404CE8: main (git.c:575)
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D ---Thread-Announcement-------------------------------=
-----------
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D Thread #2 was created
=3D=3D34949=3D=3D    at 0x594DF7E: clone (clone.S:74)
=3D=3D34949=3D=3D    by 0x544A2B9: do_clone.constprop.3 (createthread.c=
:75)
=3D=3D34949=3D=3D    by 0x544B762: pthread_create@@GLIBC_2.2.5 (createt=
hread.c:245)
=3D=3D34949=3D=3D    by 0x4C2D55D: pthread_create_WRK (hg_intercepts.c:=
269)
=3D=3D34949=3D=3D    by 0x43ABB8: cmd_index_pack (index-pack.c:1097)
=3D=3D34949=3D=3D    by 0x405B6A: handle_builtin (git.c:351)
=3D=3D34949=3D=3D    by 0x404CE8: main (git.c:575)
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D -----------------------------------------------------=
-----------
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D Possible data race during read of size 4 at 0x5E15910=
 by thread #3
=3D=3D34949=3D=3D Locks held: none
=3D=3D34949=3D=3D    at 0x439327: find_unresolved_deltas (index-pack.c:=
918)
=3D=3D34949=3D=3D    by 0x439666: threaded_second_pass (index-pack.c:10=
02)
=3D=3D34949=3D=3D    by 0x4C2D6F6: mythread_wrapper (hg_intercepts.c:23=
3)
=3D=3D34949=3D=3D    by 0x544B0A3: start_thread (pthread_create.c:309)
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D This conflicts with a previous write of size 4 by thr=
ead #2
=3D=3D34949=3D=3D Locks held: none
=3D=3D34949=3D=3D    at 0x4390E2: resolve_delta (index-pack.c:865)
=3D=3D34949=3D=3D    by 0x439340: find_unresolved_deltas (index-pack.c:=
919)
=3D=3D34949=3D=3D    by 0x439666: threaded_second_pass (index-pack.c:10=
02)
=3D=3D34949=3D=3D    by 0x4C2D6F6: mythread_wrapper (hg_intercepts.c:23=
3)
=3D=3D34949=3D=3D    by 0x544B0A3: start_thread (pthread_create.c:309)
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D Address 0x5E15910 is 48 bytes inside a block of size =
256 alloc'd
=3D=3D34949=3D=3D    at 0x4C2A7D0: calloc (vg_replace_malloc.c:618)
=3D=3D34949=3D=3D    by 0x50CA83: xcalloc (wrapper.c:119)
=3D=3D34949=3D=3D    by 0x439AF6: cmd_index_pack (index-pack.c:1643)
=3D=3D34949=3D=3D    by 0x405B6A: handle_builtin (git.c:351)
=3D=3D34949=3D=3D    by 0x404CE8: main (git.c:575)
=3D=3D34949=3D=3D
git: builtin/index-pack.c:918: find_unresolved_deltas_1: Assertion `chi=
ld->real_type =3D=3D OBJ_REF_DELTA' failed.
=3D=3D34949=3D=3D
=3D=3D34949=3D=3D For counts of detected and suppressed errors, rerun w=
ith: -v
=3D=3D34949=3D=3D Use --history-level=3Dapprox or =3Dnone to gain incre=
ased speed, at
=3D=3D34949=3D=3D the cost of reduced accuracy of conflicting-access in=
formation
=3D=3D34949=3D=3D ERROR SUMMARY: 1 errors from 1 contexts (suppressed: =
15 from 12)
Killed

It only happens in one of ten cases or so.  The write at index-pack.c
line 865 is in resolve_delta() and sets real_type of a delta object to
the real_type of its base.  It seems that threads can end up with work
items that end up requiring to touch another thread's part of the pie
if there are duplicates.

Ren=C3=A9
