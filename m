From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] fetch: plug two leaks on error exit in store_updated_refs
Date: Fri,  7 Oct 2011 15:40:22 +0800
Message-ID: <1317973222-7340-1-git-send-email-rctay89@gmail.com>
References: <4E8EA33E.5020009@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Wilson <cwilson@vigilantsw.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 09:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC52s-00066R-9l
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 09:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531Ab1JGHkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 03:40:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51007 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508Ab1JGHkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 03:40:33 -0400
Received: by ggnv2 with SMTP id v2so2499714ggn.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VNvhDdrrynxsAgpsejonVieVnfJefahvKjQt2Ay04gg=;
        b=LT7cXPcnmKdNVB6HfqVYpE5fAH12g6HSea3YKlXrUFAoMacYZPE+3IhHmnhdY8HtSR
         035PzuxQetrDY5ShLSHwcylh662+ZdmFZb7X23tpHEyC6W5uVMvynyvEZGsWAHN+1nOo
         CwXu/f2Z4GiGwOKVNXNaCZWpgxFN1HYPX5bag=
Received: by 10.236.128.161 with SMTP id f21mr7937329yhi.67.1317973232747;
        Fri, 07 Oct 2011 00:40:32 -0700 (PDT)
Received: from localhost (nusnet-141-181.dynip.nus.edu.sg. [137.132.141.181])
        by mx.google.com with ESMTPS id n18sm11728388yhi.14.2011.10.07.00.40.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 00:40:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
In-Reply-To: <4E8EA33E.5020009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183064>

Close FETCH_HEAD and release the string url even if we have to leave the
function store_updated_refs() early.

Reported-by: Chris Wilson <cwilson@vigilantsw.com>
Helped-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/fetch.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc254b6..9b7ce10 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -423,8 +423,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	else
 		url = xstrdup("foreign");
 
-	if (check_everything_connected(ref_map, 0))
-		return error(_("%s did not send all necessary objects\n"), url);
+	if (check_everything_connected(ref_map, 0)) {
+		rc = error(_("%s did not send all necessary objects\n"), url);
+		goto abort;
+	}
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
@@ -506,12 +508,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				fprintf(stderr, " %s\n", note);
 		}
 	}
-	free(url);
-	fclose(fp);
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
+
+ abort:
+	free(url);
+	fclose(fp);
 	return rc;
 }
 
-- 
1.7.7.584.g16d0ea
