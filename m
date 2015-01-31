From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Sat, 31 Jan 2015 22:06:36 +0100
Organization: gmx
Message-ID: <3723b0f57ade97234ff8709f70b2922a0fd4d016.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfFd-000530-40
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbbAaVGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:06:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:50148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:40 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdpZX-1Xri2A0K9b-00j02j; Sat, 31 Jan 2015 22:06:37
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:FEh2WLABq/Rdk+xzFInZHWwxJqVIJ7VYwb3h3A3vLdAJjabk5PR
 RTH/RUvsrd+NLs+D/6dB/FXPWyDoMWdvl567w8Abqk7NUHcTE5Xd4MctM2enC2dpqZSds3w
 4VKD5f+1/vFLGBj4S+OOTrbnFx1EtHDQt0igUvYl5Oo/FTfndbdhrUGLE7XQNFZYZEiUXSG
 wUVKc6d47oCxnDS/UFiHw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263225>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective error to "ignore".

This change "abuses" the missing-email=warn test to verify that "ignore"
is also accepted and works correctly. And while at it, it makes sure
that multiple options work, too (they are passed to unpack-objects or
index-pack as a comma-separated list via the --strict=... command-line
option).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 5 +++++
 fsck.h                          | 1 +
 t/t5504-fetch-receive-strict.sh | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index e126320..03ec945 100644
--- a/fsck.c
+++ b/fsck.c
@@ -161,6 +161,8 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 				severity = FSCK_ERROR;
 			else if (!substrcmp(p, len2, "warn"))
 				severity = FSCK_WARN;
+			else if (!substrcmp(p, len2, "ignore"))
+				severity = FSCK_IGNORE;
 			else
 				die("Unknown fsck message severity: '%.*s'",
 					len2, p);
@@ -199,6 +201,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_severity = fsck_msg_severity(id, options), result;
 
+	if (msg_severity == FSCK_IGNORE)
+		return 0;
+
 	if (msg_severity == FSCK_FATAL)
 		msg_severity = FSCK_ERROR;
 
diff --git a/fsck.h b/fsck.h
index 4349860..7be6c50 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 0b6af82..9e4e77b 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,7 +133,12 @@ test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
 	git --git-dir=dst/.git config \
 		receive.fsck.severity missing-email=warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missing-email" act
+	grep "missing-email" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.severity missing-email=ignore,bad-date=warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missing-email" act
 '
 
 test_expect_success \
-- 
2.2.0.33.gc18b867
