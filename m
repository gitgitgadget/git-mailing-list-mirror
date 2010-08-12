From: Elijah Newren <newren@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv4=200/2=5D=20Fix=20spurious=20conflicts=20with=20pull=20--rebase?=
Date: Wed, 11 Aug 2010 23:56:07 -0600
Message-ID: <1281592569-740-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, santi@agolina.net, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 07:48:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQeh-0007Fq-6v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab0HLFsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 01:48:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47293 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab0HLFsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 01:48:07 -0400
Received: by qyk5 with SMTP id 5so1136138qyk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=xG05DSDgixZOn1b4czumcI1Jz7ergZ3qEgibwTsPrSw=;
        b=b90sJwMZtcl9XyWha6s0njPo0aTrO6N/YI3CM7qc7zuSZi2iFnaO1GOxsQMZpdo+Uz
         EIetDUf79rzIeekA3/TpnXXsO1JXmIEQAaKZHhwOKc5thhEmBjIsZ2XfXWGicIlfW1t8
         68iPRKvRbExzWcI73Blpc8FHcZfcNkAsrzxK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=T7retbdG7ilwO40u0bbiWa1QjnMiduRiWb+5z5om4hKAU2qZ9Za7d7hYNtUrTeXBpo
         zLB1BOlOZ6CGmhBjns61m67RhQhN0OXtP2lkOzdiq5IQfJWtiz6MaUQ/lakttL8mbeyT
         k7LciYCt9Yv9a+Z0JISj6cAHGHvDA1JTx3iw4=
Received: by 10.229.1.201 with SMTP id 9mr6277776qcg.145.1281592085855;
        Wed, 11 Aug 2010 22:48:05 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t24sm1436480qcs.47.2010.08.11.22.48.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 22:48:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.43.gbae63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153343>

Changes since v1 (since v3, only Junio's testcase style issue was fixed=
):
  * Wording changes in the commit log
  * Address style and format issues for the testcase, raised by =C3=86v=
ar
    Arnfj=C3=B6r=C3=B0 Bjarmason, Junio, and Hannes.

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

Elijah Newren (2):
  t5520-pull: Add testcases showing spurious conflicts from git pull
    --rebase
  pull --rebase: Avoid spurious conflicts and reapplying unnecessary
    patches

 git-pull.sh     |   34 +++++++++++++++++++----------
 t/t5520-pull.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 84 insertions(+), 12 deletions(-)

--=20
1.7.2.1.43.gbae63
