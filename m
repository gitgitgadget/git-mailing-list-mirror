From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] Make hash-object more robust against malformed objects
Date: Sat, 12 Feb 2011 12:42:21 +0100
Message-ID: <201102121242.21339.trast@student.ethz.ch>
References: <1296903141-27075-1-git-send-email-pclouds@gmail.com> <1296903141-27075-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 12:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoDs5-0004Ge-V7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 12:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab1BLLma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 06:42:30 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16091 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab1BLLm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 06:42:27 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Sat, 12 Feb
 2011 12:42:15 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Sat, 12 Feb
 2011 12:42:21 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1296903141-27075-2-git-send-email-pclouds@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166608>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Commits, trees and tags have structure. Don't let users feed git
> with malformed ones. Sooner or later git will die() when
> encountering them.
>=20
> Note that this patch does not check semantics. A tree that points
> to non-existent objects is perfectly OK (and should be so, users
> may choose to add commit first, then its associated tree for example)
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

This patch makes t9350 fail under valgrind:

expecting success:=20

        TAG=3D$(git hash-object -t tag -w tag-content) &&
        git update-ref refs/tags/sonnenschein $TAG &&
        git fast-export -C -C --signed-tags=3Dstrip --all > output &&
        test $(grep -c "^tag " output) =3D 4 &&
        ! grep "Unspecified Tagger" output &&
        git fast-export -C -C --signed-tags=3Dstrip --all \
                --fake-missing-tagger > output &&
        test $(grep -c "^tag " output) =3D 4 &&
        grep "Unspecified Tagger" output


=3D=3D2862=3D=3D Invalid read of size 1
=3D=3D2862=3D=3D    at 0x4F0C34: prefixcmp (strbuf.c:9)
=3D=3D2862=3D=3D    by 0x4F4FB3: parse_tag_buffer (tag.c:109)
=3D=3D2862=3D=3D    by 0x4EC686: check_tag (sha1_file.c:2499)
=3D=3D2862=3D=3D    by 0x4EC77F: index_mem (sha1_file.c:2529)
=3D=3D2862=3D=3D    by 0x4EC934: index_fd (sha1_file.c:2563)
=3D=3D2862=3D=3D    by 0x4379C9: hash_fd (hash-object.c:17)
=3D=3D2862=3D=3D    by 0x437A86: hash_object (hash-object.c:33)
=3D=3D2862=3D=3D    by 0x437E82: cmd_hash_object (hash-object.c:126)
=3D=3D2862=3D=3D    by 0x404771: run_builtin (git.c:290)
=3D=3D2862=3D=3D    by 0x4048FC: handle_internal_command (git.c:448)
=3D=3D2862=3D=3D    by 0x4049E7: run_argv (git.c:492)
=3D=3D2862=3D=3D    by 0x404B43: main (git.c:565)
=3D=3D2862=3D=3D  Address 0x55abb77 is 0 bytes after a block of size 71=
 alloc'd
=3D=3D2862=3D=3D    at 0x4C20E1C: malloc (vg_replace_malloc.c:195)
=3D=3D2862=3D=3D    by 0x504A7C: xmalloc (wrapper.c:35)
=3D=3D2862=3D=3D    by 0x4EC8E8: index_fd (sha1_file.c:2561)
=3D=3D2862=3D=3D    by 0x4379C9: hash_fd (hash-object.c:17)
=3D=3D2862=3D=3D    by 0x437A86: hash_object (hash-object.c:33)
=3D=3D2862=3D=3D    by 0x437E82: cmd_hash_object (hash-object.c:126)
=3D=3D2862=3D=3D    by 0x404771: run_builtin (git.c:290)
=3D=3D2862=3D=3D    by 0x4048FC: handle_internal_command (git.c:448)
=3D=3D2862=3D=3D    by 0x4049E7: run_argv (git.c:492)
=3D=3D2862=3D=3D    by 0x404B43: main (git.c:565)
=3D=3D2862=3D=3D=20
=3D=3D2862=3D=3D Invalid read of size 1
=3D=3D2862=3D=3D    at 0x4F0C50: prefixcmp (strbuf.c:10)
=3D=3D2862=3D=3D    by 0x4F4FB3: parse_tag_buffer (tag.c:109)
=3D=3D2862=3D=3D    by 0x4EC686: check_tag (sha1_file.c:2499)
=3D=3D2862=3D=3D    by 0x4EC77F: index_mem (sha1_file.c:2529)
=3D=3D2862=3D=3D    by 0x4EC934: index_fd (sha1_file.c:2563)
=3D=3D2862=3D=3D    by 0x4379C9: hash_fd (hash-object.c:17)
=3D=3D2862=3D=3D    by 0x437A86: hash_object (hash-object.c:33)
=3D=3D2862=3D=3D    by 0x437E82: cmd_hash_object (hash-object.c:126)
=3D=3D2862=3D=3D    by 0x404771: run_builtin (git.c:290)
=3D=3D2862=3D=3D    by 0x4048FC: handle_internal_command (git.c:448)
=3D=3D2862=3D=3D    by 0x4049E7: run_argv (git.c:492)
=3D=3D2862=3D=3D    by 0x404B43: main (git.c:565)
=3D=3D2862=3D=3D  Address 0x55abb77 is 0 bytes after a block of size 71=
 alloc'd
=3D=3D2862=3D=3D    at 0x4C20E1C: malloc (vg_replace_malloc.c:195)
=3D=3D2862=3D=3D    by 0x504A7C: xmalloc (wrapper.c:35)
=3D=3D2862=3D=3D    by 0x4EC8E8: index_fd (sha1_file.c:2561)
=3D=3D2862=3D=3D    by 0x4379C9: hash_fd (hash-object.c:17)
=3D=3D2862=3D=3D    by 0x437A86: hash_object (hash-object.c:33)
=3D=3D2862=3D=3D    by 0x437E82: cmd_hash_object (hash-object.c:126)
=3D=3D2862=3D=3D    by 0x404771: run_builtin (git.c:290)
=3D=3D2862=3D=3D    by 0x4048FC: handle_internal_command (git.c:448)
=3D=3D2862=3D=3D    by 0x4049E7: run_argv (git.c:492)
=3D=3D2862=3D=3D    by 0x404B43: main (git.c:565)
=3D=3D2862=3D=3D=20
not ok - 15 cope with tagger-less tags
#      =20
#      =20
#               TAG=3D$(git hash-object -t tag -w tag-content) &&
#               git update-ref refs/tags/sonnenschein $TAG &&
#               git fast-export -C -C --signed-tags=3Dstrip --all > out=
put &&
#               test $(grep -c "^tag " output) =3D 4 &&
#               ! grep "Unspecified Tagger" output &&
#               git fast-export -C -C --signed-tags=3Dstrip --all \
#                       --fake-missing-tagger > output &&
#               test $(grep -c "^tag " output) =3D 4 &&
#               grep "Unspecified Tagger" output
#      =20
#      =20

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
