From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Fix memory leak in submodule.c
Date: Sun, 31 Jan 2010 17:43:49 +0100
Message-ID: <4B65B345.1090907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 17:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbd1W-0003uA-Rt
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 17:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0AaQro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 11:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306Ab0AaQro
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 11:47:44 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:46280 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0AaQro (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 11:47:44 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8688214CE3E4F;
	Sun, 31 Jan 2010 17:47:42 +0100 (CET)
Received: from [80.128.101.121] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nbctp-0004CN-00; Sun, 31 Jan 2010 17:43:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138546>

The strbuf used in add_submodule_odb() was never released. So for every
submodule - populated or not - we leaked its object directory name when
using "git diff*" with the --submodule option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7c210..7d70c4f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,17 +10,19 @@ static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
+	int ret = 0;

 	strbuf_addf(&objects_directory, "%s/.git/objects/", path);
-	if (!is_directory(objects_directory.buf))
-		return -1;
-
+	if (!is_directory(objects_directory.buf)) {
+		ret = -1;
+		goto done;
+	}
 	/* avoid adding it twice */
 	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
 		if (alt_odb->name - alt_odb->base == objects_directory.len &&
 				!strncmp(alt_odb->base, objects_directory.buf,
 					objects_directory.len))
-			return 0;
+			goto done;

 	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
 	alt_odb->next = alt_odb_list;
@@ -31,7 +33,9 @@ static int add_submodule_odb(const char *path)
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
 	prepare_alt_odb();
-	return 0;
+done:
+	strbuf_release(&objects_directory);
+	return ret;
 }

 void show_submodule_summary(FILE *f, const char *path,
-- 
1.7.0.rc1.141.gd3fd.dirty
