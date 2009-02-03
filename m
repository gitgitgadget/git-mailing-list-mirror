From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] builtin-remote: make rm() use properly named variable to hold return value
Date: Tue,  3 Feb 2009 12:51:12 -0500
Message-ID: <1233683473-87893-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 18:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPS6-00053L-41
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZBCRvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbZBCRvT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:51:19 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:37381 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbZBCRvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:51:18 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1168459qwe.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0qi6kcpamO4WLZi2NywJaYwx5fNwkhqNxejqPC0pbZs=;
        b=YN6H7wr1eL8SeG05ROyZo3WMCh3IEVskcQ6xII5/GfwqzAADrWNDGaSNKa2usNc7S9
         O7uVIC+jxeGGZrztGnQpMQlHvTqAbJRZKIsuLnNhYwIl5KUQDjHQNtGCtY0DYJG7b99C
         wXI/M2SdOhjsJzb7253wY3kQ3vdQQuS2FHAr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u0lugB5gFzy/EGeZoDlglAyQz1StiT5B/w85RvHgx+m1S62HHGrhrZ39uzyXDK3/rf
         16Yi8b86WniAsshPmA4KLpRqak8J101MO50JSnaf/nUHAXb1v2yhdi3PT2mh3rYy+5n4
         M71CoxAeCJLkqeB7H+5/IYHnDKoV5X10Wu1Ak=
Received: by 10.214.11.11 with SMTP id 11mr4015454qak.308.1233683476150;
        Tue, 03 Feb 2009 09:51:16 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 7sm1071795qwb.58.2009.02.03.09.51.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:51:15 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.311.g2d7f3
In-Reply-To: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108228>

"i" is a loop counter and should not be used to hold a return value; use
"result" instead which is consistent with the rest of builtin-remote.c.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I'm not sure this minor change needed to be broken out into its own commit,
so squash with 2/2 if that's appropriate.

 builtin-remote.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index abc8dd8..21885fb 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -543,7 +543,7 @@ static int rm(int argc, const char **argv)
 	struct known_remotes known_remotes = { NULL, NULL };
 	struct string_list branches = { NULL, 0, 0, 1 };
 	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
-	int i;
+	int i, result;
 
 	if (argc != 2)
 		usage_with_options(builtin_remote_usage, options);
@@ -583,14 +583,14 @@ static int rm(int argc, const char **argv)
 	 * refs, which are invalidated when deleting a branch.
 	 */
 	cb_data.remote = remote;
-	i = for_each_ref(add_branch_for_removal, &cb_data);
+	result = for_each_ref(add_branch_for_removal, &cb_data);
 	strbuf_release(&buf);
 
-	if (!i)
-		i = remove_branches(&branches);
+	if (!result)
+		result = remove_branches(&branches);
 	string_list_clear(&branches, 1);
 
-	return i;
+	return result;
 }
 
 static void show_list(const char *title, struct string_list *list,
-- 
1.6.1.2.311.g2d7f3
