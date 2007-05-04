From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Fri, 04 May 2007 10:13:21 +0200
Message-ID: <20070504081021.14786.77675.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjsva-00083p-Sf
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767717AbXEDIOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 04:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031356AbXEDIOF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:14:05 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:36406 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965730AbXEDIOD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2007 04:14:03 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:34935 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HjsvQ-0001pu-7V; Fri, 04 May 2007 10:14:01 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1Hjsun-0003s5-DG; Fri, 04 May 2007 10:13:21 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HjsvQ-0001pu-7V.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HjsvQ-0001pu-7V bb08d0dad63fb6bd3a4b332782d21feb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46142>

Two new tests for "stg rebase":

  1. Try to rebase to a commit that is ahead of HEAD. This should
     work, and does.

  2. Try to commit a patch, and then rebase. This doesn't work,
     because "stg rebase" aborts if orig-base !=3D base, and "stg
     commit" doesn't update orig-base. (It does work if "stg rebase"
     is given the --force flag.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

(2) shows a bug in "stg rebase"'s safety logic. I'm not sure how to
fix it, because I don't know how it's supposed to work in the first
place. (An obvious fix would be to update it whenever the base
changes, but that'll take some work, and I'm not convinced it can't be
done with les work. Yes, I'm lazy.) Yann, could you explain?

 t/t2200-rebase.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index 52462dd..b48e513 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -30,4 +30,20 @@ test_expect_success \
 	test `stg id base@stack` =3D `git rev-parse master~1`
 	'
=20
+test_expect_success \
+	'Rebase to next commit' \
+	'
+	stg rebase master &&
+	test $(stg id base@stack) =3D $(git rev-parse master)
+	'
+
+test_expect_success \
+	'Commit the patch and rebase again' \
+	'
+	stg commit &&
+	git tag committed-here &&
+	stg rebase master &&
+	test $(stg id base@stack) =3D $(git rev-parse master)
+	'
+
 test_done
