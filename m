From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 00/11] alternative unify appending of sob
Date: Sun, 25 Nov 2012 17:45:48 -0800
Message-ID: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcnmW-0006yv-HF
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab2KZBqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 20:46:22 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:49580 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab2KZBqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:46:21 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3473809dak.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=aaCkNGk1GmOlIyJX6Sj8NaWc0CSvkIY8mTeK0nI0RF4=;
        b=NlYbZg1MBs+z52yvsB3l/gyCxW4pJH0hFhD+PrexHxG9tPfigVwxsk/MFYNc4TLPxP
         xL08AYLROIef78uhUl0fhf0dypfPSaEQ/EI2o3D18PixCZVPY5glpiQxd8ZLA+BS7BSt
         Pik2iDH7uSSwI4q2L9Gk/dyAsQwPsp6am+PAwSB+PYPBNAjgp/xIYY8o4/NZusV+jAxC
         WCQ2URBAI2yIN77GRZyCaBRmlAIw1WhTbkPsV7D/cHSyYP84AY0NvVtFxKR6PRvLFNjf
         4+27NahsFp32iJWo66vg/LtRQJtKPvFuRn9D5k1YDJm1r+F1vNfLai/brAgRZ07hqgxu
         1ing==
Received: by 10.68.191.10 with SMTP id gu10mr32597421pbc.115.1353894381408;
        Sun, 25 Nov 2012 17:46:21 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.46.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:46:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210390>

=46rom: Brandon Casey <bcasey@nvidia.com>

I hate to have the battle of the patches, but I kinda prefer the
append_signoff code in sequencer.c over the code in log-tree.c as a
foundation to build on.

So, this series is similar to Duy's "unification" series, but it goes i=
n the
opposite direction and builds on top of sequencer.c and additionally ad=
ds the
elements from my original series to treat the "(cherry picked from..." =
line
added by 'cherry-pick -x' in the same way that other footer elements ar=
e
treated (after addressing Junio's comments about rfc2822 continuation l=
ines
and duplicate s-o-b's).

I've integrated Duy's series with a few minor tweaks.  I added a couple
of additional tests to t4014 and corrected one of the tests which had
incorrect behavior.  I think his sign-off's should still be valid, so I
kept them in.  Sorry that I've been slow, and now the two of us are ste=
pping
on each other's toes, but Duy please take a look and let me know if the=
re's
anything you dislike.

The main difference between this series and Duy's, aside from the chang=
e in
behavior with respect to a "(cherry picked from...)" line, is that the
detection of a s-o-b footer is done in a somewhat more generic way.  Th=
e
log-tree.c code expects to find something that looks like "[-A-Za-z]+:"=
 on
the left-hand side, and something that looks like an email address on t=
he
right-hand side.  The sequencer.c code relaxes this definition so that =
an
email address is not required on the right hand side.  This allows line=
s like
"Change-id: IXXXX" or "Bug: XXX" to be considered valid footer elements=
=2E

So, this series should result in s-o-b and "(cherry picked from...)" be=
ing
appended to commit messages in a more consistent and deterministic way.=
  For
example, the decision about whether to insert a blank line before appen=
ding
a s-o-b.  As discussed, cherry-pick and commit will only refrain from
appending a s-o-b if the committer's s-o-b appears as the last one in a
conforming footer, while format-patch will refrain from appending it if=
 it
appears anywhere within the footer.

-Brandon

Brandon Casey (8):
  sequencer.c: remove broken support for rfc2822 continuation in footer
  t/test-lib-functions.sh: allow to specify the tag name to test_commit
  t/t3511: add some tests of 'cherry-pick -s' functionality
  sequencer.c: recognize "(cherry picked from ..." as part of s-o-b
    footer
  sequencer.c: always separate "(cherry picked from" from commit body
  sequencer.c: teach append_signoff how to detect duplicate s-o-b
  sequencer.c: teach append_signoff to avoid adding a duplicate newline
  Unify appending signoff in format-patch, commit and sequencer

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  t4014: more tests about appending s-o-b lines
  format-patch: stricter S-o-b detection
  format-patch: update append_signoff prototype

 builtin/commit.c         |   2 +-
 builtin/log.c            |  13 +--
 log-tree.c               |  92 ++---------------
 revision.h               |   2 +-
 sequencer.c              | 133 +++++++++++++++---------
 sequencer.h              |   2 +-
 t/t3511-cherry-pick-x.sh | 219 +++++++++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh  | 262 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/test-lib-functions.sh  |   9 +-
 9 files changed, 580 insertions(+), 154 deletions(-)
 create mode 100755 t/t3511-cherry-pick-x.sh

--=20
1.8.0.284.g959048a
