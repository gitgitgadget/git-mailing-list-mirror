From: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Subject: [patch] Out of bounds read in git apply on malformed input in
 gitdiff_verify_name()
Date: Tue, 14 Jun 2016 12:52:18 +0200
Message-ID: <20160614125218.18e08566@pc1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-13255-1465901541-0001-2"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 12:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCm2D-000371-TG
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 12:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbcFNK5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 06:57:25 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:37228 "EHLO
	zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcFNK5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 06:57:24 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 06:57:23 EDT
Received: from pc1 ([2001:2012:10f:ad00:a50c:3ed:8906:7e81])
  (AUTH: LOGIN hanno-default@schokokeks.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 14 Jun 2016 12:52:20 +0200
  id 00000000000000B3.00000000575FE1E5.000033C7
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297282>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-13255-1465901541-0001-2
Content-Type: multipart/mixed; boundary="MP_/vb58aGSLwwdHi5VDugSvo7g"

--MP_/vb58aGSLwwdHi5VDugSvo7g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The attached sample file will cause an out of bounds heap read in the
function gitdiff_verify_name() when passed to git apply.

To reproduce:
* Build git with address sanitizer (-fsanitize=3Daddress in cflags)
* git apply --check [path_to_file]

I have pasted the full address sanitizer error trace below.

The code where this happens is here (builtin/apply.c):
                if (!another || memcmp(another, orig_name, len + 1))

The problem seems to be that there is no guarantee that another and
orig_name have the same length, len is set to strlen(orig_name) a few
lines earlier. Thus if orig_name is more than 1 byte shorter than
another it causes an invalid memory read.

Changing memcmp to strncmp should fix this, patch attached.

Found with the help of american fuzzy lop and address sanitizer.


=3D=3D7717=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0x=
60200000ed30 at pc 0x41d3ab bp 0x7ffd00ad61d0 sp 0x7ffd00ad61c0
READ of size 3 at 0x60200000ed30 thread T0
    #0 0x41d3aa in gitdiff_verify_name builtin/apply.c:940
    #1 0x41d687 in gitdiff_oldname builtin/apply.c:956
    #2 0x41f387 in parse_git_header builtin/apply.c:1309
    #3 0x42014b in find_header builtin/apply.c:1475
    #4 0x422bc5 in parse_chunk builtin/apply.c:1988
    #5 0x432c24 in apply_patch builtin/apply.c:4373
    #6 0x433df8 in cmd_apply builtin/apply.c:4626
    #7 0x407dcd in run_builtin /f/git/plain/git-2.9.0/git.c:352
    #8 0x40818c in handle_builtin /f/git/plain/git-2.9.0/git.c:539
    #9 0x4084db in run_argv /f/git/plain/git-2.9.0/git.c:593
    #10 0x408934 in main /f/git/plain/git-2.9.0/git.c:698
    #11 0x7fddbf96c78f in __libc_start_main (/lib64/libc.so.6+0x2078f)
    #12 0x405308 in _start (/f/git/plain/git-2.9.0/git+0x405308)

0x60200000ed32 is located 0 bytes to the right of 2-byte region [0x60200000=
ed30,0x60200000ed32)
allocated by thread T0 here:
    #0 0x7fddc07b9707 in malloc (/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/lib=
asan.so.1+0x57707)
    #1 0x790768 in do_xmalloc /f/git/plain/git-2.9.0/wrapper.c:59
    #2 0x79089e in do_xmallocz /f/git/plain/git-2.9.0/wrapper.c:99
    #3 0x79090f in xmallocz /f/git/plain/git-2.9.0/wrapper.c:107
    #4 0x79094c in xmemdupz /f/git/plain/git-2.9.0/wrapper.c:123
    #5 0x41c1f7 in find_name_common builtin/apply.c:704
    #6 0x41c29b in find_name builtin/apply.c:715
    #7 0x41d31b in gitdiff_verify_name builtin/apply.c:939
    #8 0x41d687 in gitdiff_oldname builtin/apply.c:956
    #9 0x41f387 in parse_git_header builtin/apply.c:1309
    #10 0x42014b in find_header builtin/apply.c:1475
    #11 0x422bc5 in parse_chunk builtin/apply.c:1988
    #12 0x432c24 in apply_patch builtin/apply.c:4373
    #13 0x433df8 in cmd_apply builtin/apply.c:4626
    #14 0x407dcd in run_builtin /f/git/plain/git-2.9.0/git.c:352
    #15 0x40818c in handle_builtin /f/git/plain/git-2.9.0/git.c:539
    #16 0x4084db in run_argv /f/git/plain/git-2.9.0/git.c:593
    #17 0x408934 in main /f/git/plain/git-2.9.0/git.c:698
    #18 0x7fddbf96c78f in __libc_start_main (/lib64/libc.so.6+0x2078f)

SUMMARY: AddressSanitizer: heap-buffer-overflow builtin/apply.c:940 gitdiff=
_verify_name
Shadow bytes around the buggy address:
  0x0c047fff9d50: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d60: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d70: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff9d90: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=3D>0x0c047fff9da0: fa fa fa fa fa fa[02]fa fa fa 03 fa fa fa fd fd
  0x0c047fff9db0: fa fa 03 fa fa fa 00 02 fa fa fd fd fa fa 00 00
  0x0c047fff9dc0: fa fa 04 fa fa fa 00 03 fa fa fd fd fa fa 00 00
  0x0c047fff9dd0: fa fa 01 fa fa fa 00 06 fa fa 05 fa fa fa 00 04
  0x0c047fff9de0: fa fa 04 fa fa fa 06 fa fa fa 00 04 fa fa 00 04
  0x0c047fff9df0: fa fa 00 04 fa fa 00 04 fa fa fd fa fa fa 02 fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Contiguous container OOB:fc
  ASan internal:           fe
=3D=3D7717=3D=3DABORTING

--=20
Hanno B=C3=B6ck
https://hboeck.de/

mail/jabber: hanno@hboeck.de
GPG: BBB51E42

--MP_/vb58aGSLwwdHi5VDugSvo7g
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=git-fix-oob-memcmp-strncmp.diff

diff -Naur git-2.9.0/builtin/apply.c git-2.9.0-1/builtin/apply.c
--- git-2.9.0/builtin/apply.c	2016-06-13 21:07:49.000000000 +0200
+++ git-2.9.0-1/builtin/apply.c	2016-06-14 11:38:19.940588382 +0200
@@ -937,7 +937,7 @@
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"=
),
 			    orig_name, linenr);
 		another =3D find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, orig_name, len + 1))
+		if (!another || strncmp(another, orig_name, len + 1))
 			die((side =3D=3D DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d")=
 :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d")=
, linenr);

--MP_/vb58aGSLwwdHi5VDugSvo7g
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=git-out-of-bounds-gitdiff_verify_name.patch

diff --git=20
--- /00
--- /0

--MP_/vb58aGSLwwdHi5VDugSvo7g--

--=_zucker.schokokeks.org-13255-1465901541-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXX+HiAAoJEKWIAHK7tR5CoO0QAKlkOt1TJlzt1RBUBNK+gnZv
kzpD0m4990mC3Q8s1ZlILLVSitvTymTWznwppA1MPH7d/0sNZXOfJth6Gl0pXYPi
r2/OxIPs+7IIHjmxZRK4spFTu7ypMoorhJNPRvR0owpcq+x0Cpt6f9j6/w6Y95zu
QoAyGLLucGYYc+QvyT1vHlRRQFY7Z9h+j1+IgQxY4/gVbs8nR3ET+9BoWngE4/zs
fIeSNXBY9kAf58t5tFhp3z+JSzCjkIqErvb8orIUiQHkQ5I3Um4fckCe0ZPT+vOn
Lck1UaBZNOqQnjQPUpm23L0OOwFN5936okSqOK9MqP0fWU2xP1Foop9ia84nyCFX
pdbOXJCtJWzfsAsOFMX37Ie5pil2WYAey/ZX4Zk3BPz5WhrNa+GcYF8K+N6u5S2c
1oE/4atiP6hnQSIloqcnC53gs86fYScAto1Uw8RJiNHV0c2NyXDNRbbIIwqbQdoy
UjxIaIqWSIm7Gq0WYMQBKuHzY07U61O6uJ0WGAB2aCetP944ffXUD3Ae+y+tzZD1
5YXj3IejJ0fve1FndZ6CtaquDs4RnQJ4nwD7ET2ztGxW2IReaP3QEfVLS64CbR86
ljNLloQYyNjzIjw6U1JGSrsdmYTYzWCrNrumNJbTKGRpjv23wFQJ1Jx/X48fRANH
BsebJsqIp9MTAL9w1uGc
=gi1z
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-13255-1465901541-0001-2--
