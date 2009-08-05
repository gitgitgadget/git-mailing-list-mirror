From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 5 Aug 2009 11:49:37 +0200
Message-ID: <200908051149.40980.trast@student.ethz.ch>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2185682.PEb6JhAha6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYd8c-0003SJ-M9
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbZHEJuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933096AbZHEJuQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:50:16 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:6617 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933063AbZHEJuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:50:14 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 11:50:13 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 11:49:52 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <1249463746-21538-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124884>

--nextPart2185682.PEb6JhAha6
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>=20
> Junio C Hamano (5):
>   diff-index: report unmerged new entries
>   diff-index: keep the original index intact
>   wt-status.c: rework the way changes to the index and work tree are
>     summarized
>   status: show worktree status of conflicted paths separately
>   shortstatus: a new command

I was quite eager to try this, mainly for 4/5, and I still had the
testing repository from the last thread around:

  $ git ls-files -s
  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo
  100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 2       foo

Here we go!

  $ git status
  # On branch master                           =20
  Segmentation fault

Uh oh.  So gdb it is then...

# On branch master                                                         =
 =20

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7353844 in strcmp () from /lib64/libc.so.6
  (gdb) bt                                            =20
  #0  0x00007ffff7353844 in strcmp () from /lib64/libc.so.6
  #1  0x00000000004cc577 in unmerged_mask (path=3DCannot access memory at a=
ddress 0xfffff070                                                          =
             =20
  ) at wt-status.c:241                                                     =
      =20
  Backtrace stopped: previous frame inner to this frame (corrupt stack?)

=2E.. or maybe not.  valgrind is slightly more helpful:

  =3D=3D29421=3D=3D Invalid read of size 1
  =3D=3D29421=3D=3D    at 0x4C26101: strcmp (in /usr/lib64/valgrind/amd64-l=
inux/vgpreload_memcheck.so)
  =3D=3D29421=3D=3D    by 0x4CC576: unmerged_mask (wt-status.c:241)
  =3D=3D29421=3D=3D    by 0x4CC6AA: wt_status_collect_updated_cb (wt-status=
=2Ec:275)
  =3D=3D29421=3D=3D    by 0x484172: diff_flush (diff.c:3337)
  =3D=3D29421=3D=3D    by 0x47A0E5: run_diff_index (diff-lib.c:445)
  =3D=3D29421=3D=3D    by 0x4CC804: wt_status_collect_changes_index (wt-sta=
tus.c:306)
  =3D=3D29421=3D=3D    by 0x4CC922: wt_status_collect_changes (wt-status.c:=
340)
  =3D=3D29421=3D=3D    by 0x4CD1A0: wt_status_print (wt-status.c:561)
  =3D=3D29421=3D=3D    by 0x41BFBD: run_status (builtin-commit.c:369)
  =3D=3D29421=3D=3D    by 0x41D97F: cmd_status (builtin-commit.c:927)
  =3D=3D29421=3D=3D    by 0x4048C2: run_builtin (git.c:246)
  =3D=3D29421=3D=3D    by 0x404A4D: handle_internal_command (git.c:394)
  =3D=3D29421=3D=3D  Address 0x48 is not stack'd, malloc'd or (recently) fr=
ee'd
  =3D=3D29421=3D=3D
  =3D=3D29421=3D=3D Process terminating with default action of signal 11 (S=
IGSEGV)
  =3D=3D29421=3D=3D  Access not within mapped region at address 0x48
  =3D=3D29421=3D=3D    at 0x4C26101: strcmp (in /usr/lib64/valgrind/amd64-l=
inux/vgpreload_memcheck.so)
  =3D=3D29421=3D=3D    by 0x4CC576: unmerged_mask (wt-status.c:241)
  =3D=3D29421=3D=3D    by 0x4CC6AA: wt_status_collect_updated_cb (wt-status=
=2Ec:275)
  =3D=3D29421=3D=3D    by 0x484172: diff_flush (diff.c:3337)
  =3D=3D29421=3D=3D    by 0x47A0E5: run_diff_index (diff-lib.c:445)
  =3D=3D29421=3D=3D    by 0x4CC804: wt_status_collect_changes_index (wt-sta=
tus.c:306)
  =3D=3D29421=3D=3D    by 0x4CC922: wt_status_collect_changes (wt-status.c:=
340)
  =3D=3D29421=3D=3D    by 0x4CD1A0: wt_status_print (wt-status.c:561)
  =3D=3D29421=3D=3D    by 0x41BFBD: run_status (builtin-commit.c:369)
  =3D=3D29421=3D=3D    by 0x41D97F: cmd_status (builtin-commit.c:927)
  =3D=3D29421=3D=3D    by 0x4048C2: run_builtin (git.c:246)
  =3D=3D29421=3D=3D    by 0x404A4D: handle_internal_command (git.c:394)

I also tried finding out which exact commit was causing this, but 4/5
still segfaults and 1-3 don't even compile:

  builtin-commit.c: In function =E2=80=98show_unmerged=E2=80=99:           =
                      =20
  builtin-commit.c:827: error: dereferencing pointer to incomplete type    =
      =20
  builtin-commit.c: In function =E2=80=98show_status=E2=80=99:             =
                      =20
  builtin-commit.c:854: error: dereferencing pointer to incomplete type
  [etc]

These are referring to use of a 'struct wt_status_change_data *', but
the struct declaration is only in 4/5.  Am I missing something?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2185682.PEb6JhAha6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkp5VbQACgkQqUud07tmzP0h5ACePCm4DHsC+PLYc1ucShHB6Reg
XxAAniBuJ47qJmZN1U+6yr+rqGEV6PRK
=RC1C
-----END PGP SIGNATURE-----

--nextPart2185682.PEb6JhAha6--
