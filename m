From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Mon, 22 Jun 2015 17:26:48 +0200
Organization: gmx
Message-ID: <4ae672be6b7ca7727cadc3b94c5f731b7df7abaf.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73ch-0007F6-BM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbbFVP0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:26:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:65270 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbbFVP0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:26:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LjZEm-1YVmzZ0Vrs-00bXrH; Mon, 22 Jun 2015 17:26:49
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:0BaLwSsDn1bQrYupqOsgM1D2JYjN8uS74yttsFAlpRTDnvISzw4
 GtXGdWVIeUtWvwyEynlHDx1kD2n5QlvRza/XsaiZDkhATon0PtZhoeQaOksPozc1T2V4mIC
 1dn3AcFUcI63pPZwtjx6JBHq1CY7EGbULRrhLFoNPSwwukGqQshIlzV5jGj8n8hG6zmM+7O
 7fExiO3U8T4mxkTCQVEaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HBOwc8EfLkU=:nd09B/yn7NWOybmEe8LEUN
 BgKDM/Q+pTc9W2cPOxks2znmddkzCjvykqVnrYdjWAvnYMkFuTrTrgJzUhDOIHdN07EfLgRoF
 0OZxXsLpbd1rphNgVXV2Ov9CIodd5HCynqLLGzyf6yoxgx2Z0fWQ+/olvTDW/KfzlLa41ML8w
 5JUztEVAJCtiJL3culBbVwZuNcHkV8ADz3rR6M3/N+kAJrHkXGCgz0K2JbPYtbCPbOvAz9LWp
 LcnVS9dd29WcxpWt5dMY88iDjTLYcbn23uUfzejntJ4k5IkKtnoB0OgPIa9hArWDpeeTaGiSw
 xVITrzhgjQujaQJLTxyu59CkgcT1uy2ciNh5XgO6wyrzNWWovCa1Mjy6DF/bgXQDG3aiNOkr1
 JdpoYgKB8Y9f4SUnbDD12VQXkcpRp6bOyzAXae74dFvkSxiRmS9cp5KEWzZOZ6RF7qnA9DK4a
 4HSTUpPgjKsh2qBQyqMC3tu9y6c17FqEy/98wO/RZE5a3x/5WmvLtaUElcP4il7WinoiDy/4V
 bdgEwVZHNvcHXVFrcqaARWwOMoRldgvPtYGR6OipfhRAkFEjabEwCfuGpXKxFefZJ3Hq9tv2E
 vBJM7TtwmlQVH0bI1zISeL/+uUfa4RRf+C5Szfx62nEyza6TpfF6Hf9T8+2M6rdES56U1u6pp
 +QX6hqE3L7PG72UTK+SylfLptP8Ag5HoYfJ5HiS8PHP/iBbq7sWz8F4d197EHa9iRP40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272384>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective message type to "ignore".

This change "abuses" the missingEmail=warn test to verify that "ignore"
is also accepted and works correctly. And while at it, it makes sure
that multiple options work, too (they are passed to unpack-objects or
index-pack as a comma-separated list via the --strict=... command-line
option).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 5 +++++
 fsck.h                          | 1 +
 t/t5504-fetch-receive-strict.sh | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 85535b1..cbfff1f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -131,6 +131,8 @@ static int parse_msg_type(const char *str)
 		return FSCK_ERROR;
 	else if (!strcmp(str, "warn"))
 		return FSCK_WARN;
+	else if (!strcmp(str, "ignore"))
+		return FSCK_IGNORE;
 	else
 		die("Unknown fsck message type: '%s'", str);
 }
@@ -221,6 +223,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 
diff --git a/fsck.h b/fsck.h
index 3ef92a3..1dab276 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index f5d6d0d..af373ba 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,7 +133,14 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config \
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missingEmail" act
+	grep "missingEmail" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.missingEmail ignore &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.badDate warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missingEmail" act
 '
 
 test_expect_success \
-- 
2.3.1.windows.1.9.g8c01ab4
