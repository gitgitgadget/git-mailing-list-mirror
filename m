From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 2/2] fast-import: Handle 'sub/testname' to 'sub/testname/testfile' renaming correctly
Date: Thu,  9 Aug 2012 03:42:50 +0800
Message-ID: <1344454971-19559-2-git-send-email-techlivezheng@gmail.com>
References: <1344454971-19559-1-git-send-email-techlivezheng@gmail.com>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"Elijah Newren" <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 08 21:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzC9d-0002bu-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759157Ab2HHTmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:42:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41953 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030485Ab2HHTmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:42:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1929231pbb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mpJpFnRTdoA/au6vHl8OwFhHX8PWTphbMYxz0sPMCio=;
        b=e/HALrW4spH1juG56n4OU1GqhExvF6LFeZaBrITyXc7T+QKUf9t+lZLAGTWpq+JU7p
         DfANnMpHXr2zJcRLIsCfaOia/HkRGVP06bSXJV2rq6szMJM+Yv7HhOJeuhm9OKm65L/0
         7C2B3IBHw5p1hp++0WCXhllP6J/GOpKE+OPJ/0520WlManT2B0BwXSyrTZ5Rdp0sp9dy
         SqJnkTiIvdNxHhHmgI4Si5xXZ16O8uS5D+x2/lym1Nr1tq/K6D6pR3DcaO1iH0u6z2Kd
         AiH4JOazY/I65Q0oDLdHs6W8cL1b/YK6/gXcHysVQD2Gamp1uyov+c8YTkAOdFh6pH+H
         DF/Q==
Received: by 10.68.201.198 with SMTP id kc6mr1713959pbc.122.1344454965336;
        Wed, 08 Aug 2012 12:42:45 -0700 (PDT)
Received: from home.techlive.me ([122.244.158.188])
        by mx.google.com with ESMTPS id tv6sm10526553pbc.24.2012.08.08.12.42.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 12:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1344454971-19559-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203120>

The current git-fast-import would not correctly handle such a commit stream
in which a file was deleted and at the same time a directory with the same
name was created. All paths under the newly created directory will be lost
after the importing.
---
 fast-import.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index eed97c8..8874b4b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1595,6 +1595,15 @@ static int tree_content_remove(
 				 * exist and need not be deleted.
 				 */
 				return 1;
+			if (!slash1 && S_ISREG(e->versions[0].mode) && S_ISDIR(e->versions[1].mode))
+			    /*
+			     * If p names a file in some subdirectory and in
+			     * some commit that file got deleted, a directory
+			     * with the same name was set up in the same directory,
+			     * then there is no need to step into for further
+			     * iteration or deletion.
+			     */
+				return 0;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
-- 
1.7.11.4
