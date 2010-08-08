From: Elijah Newren <newren@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv3=200/2=5D=20Fix=20spurious=20conflicts=20with=20pull=20--rebase?=
Date: Sun,  8 Aug 2010 14:55:15 -0600
Message-ID: <1281300917-5610-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 08 22:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCmh-00067j-FD
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab0HHUrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 16:47:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39771 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab0HHUrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 16:47:35 -0400
Received: by pvg2 with SMTP id 2so521927pvg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=g+q0PtGLWzABdUvDOM++mQApWD9aXgR3ZtcH0jzIR0Q=;
        b=kvXvrjarTiF1BYsvkfsX13R2upHYr1InrBz2gYJ12gY5V2Txby1FdRCHcgQmgc46GK
         nGP1YAWDe23AUzimcChGwgKhqn0Cfus+8ifuH0Uz8wiZbcC6b9cVDsR/3OwF1mBCXGaI
         sxxMA5mbYV7l1dcyUAr+ClUDb4KeZodtklvJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IXv0FbanLeZxHsUjEb14uOmCLIFmpHkeTjdoTAsHMQGvzFSiq6UAmV8TEpNYeLEBby
         xws0oQ80yju9HTQVsvVavaGoBBiDHKF4A/3cAtuE5uuXLshmifc5oFc7aRHFDSDHa4Cu
         mqt7OvOuQ9bKUpCu8N/EdULFstOXxaoEIJ5hg=
Received: by 10.142.180.1 with SMTP id c1mr12897506wff.25.1281300455022;
        Sun, 08 Aug 2010 13:47:35 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id q27sm5555628wfc.18.2010.08.08.13.47.32
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 13:47:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.28.ga5061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152928>

This patch series fixes spurious conflict issues with git pull
--rebase for the case where the upstream repository is *not* rebased.
(There is no change in the case where the upstream repository is
rebased.)

In c85c79279d and d44e71261f, the call to git-rebase was modified in
an effort to reduce the number of commits being reapplied, by trying
to avoid commits that upstream already had or has.  It was
specifically designed with an upstream that is rebased in mind.
Unfortunately, it had two side effects for the non-rebased upstream
case: (1) it prevented detecting if "local" patches are already
upstream, and (2) it could in some cases cause more patches known to
be upstream to be reapplied rather than less.  This series fixes both
of these issues for the non-rebased upstream case.  See the commit
message of the second patch for details.

It's worth noting that issue (1) above also affects the case where the
upstream repository has been rebased, which this patch series does not
address.  As far as I can tell, fixing it would require changes
(including new syntax) to format-patch to allow it to be told what
'upstream' is, and some changes to git-pull.sh/git-rebase.sh to pass
it this information.

Changes since the last series:
  * Address issues in t5520-pull.sh raised by =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason

Elijah Newren (2):
  t5520-pull: Add testcases showing spurious conflicts from git pull
    --rebase
  pull --rebase: Avoid spurious conflicts and reapplying unnecessary
    patches

 git-pull.sh     |   34 +++++++++++++++++++----------
 t/t5520-pull.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 85 insertions(+), 12 deletions(-)

--=20
1.7.2.1
