From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fetch: plug two leaks on error exit in store_updated_refs
Date: Fri, 07 Oct 2011 08:13:59 +0200
Message-ID: <4E8E98A7.8010008@lsrfire.ath.cx>
References: <20111007014136.GB10839@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 08:14:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC3hI-0007oR-0L
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 08:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab1JGGOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 02:14:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:56387 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1JGGOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 02:14:09 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 290822F804A;
	Fri,  7 Oct 2011 08:14:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111007014136.GB10839@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183058>

Close FETCH_HEAD and release the string url even if we have to leave the
function store_updated_refs() early.

Reported-by: Chris Wilson <cwilson@vigilantsw.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/fetch.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7a4e41c..79db796 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -379,8 +379,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm))
-		return error(_("%s did not send all necessary objects\n"), url);
+	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+		error(_("%s did not send all necessary objects\n"), url);
+		free(url);
+		fclose(fp);
+		return -1;
+	}
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
-- 
1.7.7
