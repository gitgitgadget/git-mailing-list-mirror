From: Thomas Rast <trast@student.ethz.ch>
Subject: Test failures in pu: 4046, 950[012]
Date: Thu, 4 Nov 2010 22:37:01 +0100
Message-ID: <201011042237.01801.trast@student.ethz.ch>
References: <201010201148.51551.trast@student.ethz.ch> <7vvd4wvmv6.fsf@alter.siamese.dyndns.org> <201010201856.54756.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:36:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7UJ-0000AL-9T
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0KDVgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 17:36:45 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:16024 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab0KDVgo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:36:44 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 4 Nov
 2010 22:36:43 +0100
Received: from pctrast.inf.ethz.ch (129.132.208.43) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 4 Nov
 2010 22:36:41 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201010201856.54756.trast@student.ethz.ch>
X-Originating-IP: [129.132.208.43]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160775>

=46ailures as of yesterday (it alternates between next and pu, so today
was next which was clean):

* 4046 has this valgrind failure:

  =3D=3D24237=3D=3D Source and destination overlap in mempcpy(0x7feffed=
50, 0x7feffed50, 2)
  =3D=3D24237=3D=3D    at 0x4C228DB: mempcpy (mc_replace_strmem.c:802)
  =3D=3D24237=3D=3D    by 0x511AD6: copy_dirname (diffcore-rename.c:573=
)
  =3D=3D24237=3D=3D    by 0x512071: check_one_bulk_move (diffcore-renam=
e.c:744)
  =3D=3D24237=3D=3D    by 0x5120C0: diffcore_bulk_moves (diffcore-renam=
e.c:756)
  =3D=3D24237=3D=3D    by 0x512988: diffcore_rename (diffcore-rename.c:=
961)
  =3D=3D24237=3D=3D    by 0x4A48EF: diffcore_std (diff.c:4252)
  =3D=3D24237=3D=3D    by 0x4974B5: run_diff_index (diff-lib.c:475)
  =3D=3D24237=3D=3D    by 0x4267CD: cmd_diff_index (diff-index.c:50)
  =3D=3D24237=3D=3D    by 0x404963: run_builtin (git.c:276)
  =3D=3D24237=3D=3D    by 0x404AEE: handle_internal_command (git.c:435)
  =3D=3D24237=3D=3D    by 0x404BD9: run_argv (git.c:479)
  =3D=3D24237=3D=3D    by 0x404D3A: main (git.c:554)
  =3D=3D24237=3D=3D=20
  [snip suppression template]
  not ok - 14 diff-index --detect-bulk-moves on a move including a subd=
ir.


* 950[012]: these are very strange.

Running them interactively appears to work ok, so maybe it is some
environment bug.  They appear to be "can't happen" style failures
though, since they all look like (this one is from 9502)

  Initialized empty Git repository in /local/home/trast/git/t/trash dir=
ectory.t9502-gitweb-standalone-parse-output/.git/
  expecting success:=20
          test_commit first foo &&
          git branch xx/test &&
          FULL_ID=3D$(git rev-parse --verify HEAD) &&
          SHORT_ID=3D$(git rev-parse --verify --short=3D7 HEAD)

  fatal: This operation must be run in a work tree
  not ok - 1 setup

They are the only ones failing with this problem, though.  They all
bisect to

  commit e60cb38c7c4e0bdb8f9542f9925ba5cafd4cd33b
  Author: Nguy=C3=A1=C2=BB=E2=80=A6n Th=C3=83=C2=A1i Ng=C3=A1=C2=BB=C2=8D=
c Duy <pclouds@gmail.com>
  Date:   Fri Oct 29 13:48:50 2010 +0700

      Remove all logic from get_git_work_tree()
     =20
      This helps break things some more. Eventually all repo setup logi=
c
      should be centralized in setup_* functions. This helps push all t=
he
      bugs back to setup_* functions.
     =20
      Signed-off-by: Nguy=C3=A1=C2=BB=E2=80=A6n Th=C3=83=C2=A1i Ng=C3=A1=
=C2=BB=C2=8Dc Duy <pclouds@gmail.com>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

(Sorry, the UTF was garbled in cron-email transit...)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
