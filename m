From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/4] Demonstrate a Windows file locking issue with `git
 clone --dissociate`
Date: Mon, 05 Oct 2015 22:29:59 +0200
Organization: gmx
Message-ID: <499e9d3bdd4e975eb6339e6469966f1e0cb2079f.1444076827.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:30:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCOi-0007lm-MU
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbbJEUaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:30:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:49207 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbbJEUaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:30:05 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LhfN3-1aMwwL3SxF-00mq94; Mon, 05 Oct 2015 22:30:00
 +0200
In-Reply-To: <cover.1444076827.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:YGctweG6eU2LrvDYK2g7y1f4Ltzy9DuYADTv8jiwlUg3eM4pnrj
 t02e+r659obZOfF31BUe5Mzgk2tOH0sksF1yivNxbWyEoo5z690EeWm8a3YB9CCBJ7IE7fA
 UtZ+rLFysGqlbSosSAbDQ7eq/ozSRyk0hatdldODtU3JOrUfLOz9Ur10WUo/UUUjhH97eL1
 adUxlZIIygobUd4x+Pgvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I55nifyZ0Qo=:StD+bsFvH2enrMLK6rdI/c
 EpTPVxqY086zDBDphz9IL8fK1cHbbWiEy2jQpRwpkKb+w6SrJpfwle6OWUhhvNKOgKCc7s+59
 nzINrBwsh6/bB/KESaopPR0af3NY6pKo4PR9Y8TiOEPUUFd/JWjWfURgsSR1XtJoUo4A0g3gF
 wCzfpUuVMLBd41yqWwOHppx7Hf6cl8VcFhkKAQk+I42CfWO2wupL8lRtzxlw+CNzfu34GdPNa
 9ytYt7bvuiu8MBhZABOLH6YfHUoZO3Zhi/2+owOPy7ZecikGKuToHxYL1y2B3SETNQERyQ2TC
 XR0GuDTM9disUAIS6EkAQWwlKECcm/LFvScjyhO+LIAyfrjdnSQ4m87pTLh9JLqYhIPToT4R5
 LjRZC8lcBo9eY4v9SxDNwzpKjs+uYl/tNQut8I5ouVzC+/UTbZhPCdervvYGxKZyA0C+xBdI9
 DFl+6Jj5HduM4tTo17HQdiVKPVexIaAryvwNtE7Fxe5TLOSVvfv6S0CQN5zIgV2gvpXE0VJaJ
 ILjO/FiW6bIzv/Fdyqu9CuJJya0V9CrtjoH1vLblfuUjvxCivtlv9ByUJzvu9bj5cLc3wCg42
 08Ucj8APbKVNHUzxxYe0e7vmanc5S3GQyKFo7jFtr51DpQRn2lXH7QauZ+SwmiZh6KzgjTrMU
 AwBRWUAbGN9eBNcTAKmSNCKKDwMJ+yIxeLkWhAL142B7drRrzI4o6HaTJ+spoYV5psOO5b4lp
 okqCCpJ9/BiMEt0eqV/NB+3ZE/8oGK5USFYiy7IgTMDAwVY7laIg7ZJJ39rSNkXlNonj7iXa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279081>

On Windows, dissociating from a reference can fail very easily due to
pack files that are still in use when they want to be removed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5700-clone-reference.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index ef1779f..f7cec85 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -188,5 +188,26 @@ test_expect_success 'clone and dissociate from reference' '
 	test_must_fail git -C R fsck &&
 	git -C S fsck
 '
+test_expect_failure MINGW 'clone, dissociate from partial reference and repack' '
+	rm -fr P Q R &&
+	git init P &&
+	(
+		cd P &&
+		test_commit one &&
+		git repack &&
+		test_commit two &&
+		git repack
+	) &&
+	git clone --bare P Q &&
+	(
+		cd P &&
+		git checkout -b second &&
+		test_commit three &&
+		git repack
+	) &&
+	git clone --bare --dissociate --reference=P Q R &&
+	ls R/objects/pack/*.pack >packs.txt &&
+	test_line_count = 1 packs.txt
+'
 
 test_done
-- 
2.5.3.windows.1.3.gc322723
