From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/4] tests: notice valgrind error in test_must_fail
Date: Sun, 31 Mar 2013 10:37:25 +0200
Message-ID: <9a01760dc54167047b17a1fdbb456055c3a9b1cd.1364718866.git.trast@inf.ethz.ch>
References: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:38:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDmV-0001ke-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab3CaIh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 04:37:58 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:58180 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab3CaIh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 04:37:56 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:37:48 +0200
Received: from linux-k42r.v.cablecom.net (129.132.209.40) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:37:46 +0200
X-Mailer: git-send-email 1.8.2.467.gedf93a5
In-Reply-To: <cover.1364716452.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.209.40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219608>

We tell valgrind to return 126 if it notices that something is wrong,
but we did not actually handle this in test_must_fail, leading to
false negatives.  Catch and report it.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Just noticed this issue when tracking down the failure in t7612.  It
might still be a bit too fragile; when running the entire suite under
valgrind, I usually just

  cd test-results
  egrep '^==[0-9]+==' *.out| less -S


 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa62d01..6766553 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -536,6 +536,9 @@ test_must_fail () {
 	elif test $exit_code = 127; then
 		echo >&2 "test_must_fail: command not found: $*"
 		return 1
+	elif test $exit_code = 126; then
+		echo >&2 "test_must_fail: valgrind error: $*"
+		return 1
 	fi
 	return 0
 }
-- 
1.8.2.467.gedf93a5
