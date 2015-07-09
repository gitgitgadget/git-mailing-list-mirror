From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v3] clone: Simplify string handling in guess_dir_name()
Date: Thu, 9 Jul 2015 18:20:20 +0000
Message-ID: <0000014e740bffe3-3193405e-55b1-4526-96d2-fd059a75f6e8-000000@eu-west-1.amazonses.com>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12_1539718233.1436466020270"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 20:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGm3-0000rD-NW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbGISmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:42:16 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:60274
	"EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbbGISmO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 14:42:14 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2015 14:42:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1436466020;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=B6TW3SW7dMqc9OFKU+m2wG6A+KIT5+oUjGHLN1Tq0Ts=;
	b=EUFWU1OILWh7FpGzJamOkJA3fZbUzq1By7bqQLLo+UqgZWCPR7AUC/c8jSPTekdH
	kiuX4Xnbf3xGJkvJ0jQ+ODXnukqm80dpvv55kKq1gaNzCKg5hlyjJCEqQmp2rdhktg7
	1eyOf7/SShv/uWbJ6vJ2BZ/uWlzYYc1d/gbfTJkM=
In-Reply-To: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
X-SES-Outgoing: 2015.07.09-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273771>

------=_Part_12_1539718233.1436466020270
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/clone.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 00535d0..ebcb849 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -147,6 +147,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	size_t len;
 	char *dir;
 
 	/*
@@ -173,19 +174,11 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	/*
 	 * Strip .{bundle,git}.
 	 */
-	if (is_bundle) {
-		if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
-			end -= 7;
-	} else {
-		if (end - start > 4 && !strncmp(end - 4, ".git", 4))
-			end -= 4;
-	}
+	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
 
-	if (is_bare) {
-		struct strbuf result = STRBUF_INIT;
-		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
-		dir = strbuf_detach(&result, NULL);
-	} else
+	if (is_bare)
+		dir = xstrfmt("%.*s.git", (int)len, start);
+	else
 		dir = xstrndup(start, end - start);
 	/*
 	 * Replace sequences of 'control' characters and whitespace

---
https://github.com/git/git/pull/160
------=_Part_12_1539718233.1436466020270--
