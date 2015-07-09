From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2] clone: Simplify string handling in guess_dir_name()
Date: Thu, 9 Jul 2015 17:23:17 +0000
Message-ID: <0000014e73d7c3d8-413991dd-3907-430c-ab99-a0a3d93dcab0-000000@eu-west-1.amazonses.com>
References: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8_836493213.1436462597065"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 19:35:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDFjW-0007uU-4i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 19:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbbGIRff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 13:35:35 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:48647
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbbGIRfd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 13:35:33 -0400
X-Greylist: delayed 733 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2015 13:35:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1436462597;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=M9vjEn5MQzC4m101ttzxC0X8xU8+Cy+7NER5Bnbw9Nk=;
	b=iP7EWQncoxqlrv4hhXBWKfefpi27uJC4ZkPBIj7zPAhu0BFF4VgDcnghn1/DEzN3
	O8pudpUvJvn8+IAmuV+UibL1/FuEECuph6H+6Ziy2w9Zn/YW84y2D64erBWcQCNFVx5
	Q552OW9AOYIG1+im1+jo2jYm/qZZNXyaiOqFlCGU=
In-Reply-To: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
X-SES-Outgoing: 2015.07.09-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273762>

------=_Part_8_836493213.1436462597065
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/clone.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 00535d0..afdc004 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -147,6 +147,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	size_t len;
 	char *dir;
 
 	/*
@@ -173,20 +174,9 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
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
-		dir = xstrndup(start, end - start);
+	dir = is_bare ? xstrfmt("%.*s.git", (int)len, start) : xstrndup(start, len);
 	/*
 	 * Replace sequences of 'control' characters and whitespace
 	 * with one ascii space, remove leading and trailing spaces.

---
https://github.com/git/git/pull/160
------=_Part_8_836493213.1436462597065--
