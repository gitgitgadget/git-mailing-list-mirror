From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/18] remote-bzr: fix order of locking in CustomTree
Date: Tue, 30 Apr 2013 20:09:55 -0500
Message-ID: <1367370610-14250-4-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaS-00073I-IY
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934058Ab3EABLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:11:52 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:45109 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933936Ab3EABLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:11:45 -0400
Received: by mail-gg0-f176.google.com with SMTP id c4so163593ggn.21
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lPwaq6GrtiKDDDeg89I7SInadQg9yeUAD2cXQBYcLVs=;
        b=rEC5jitxyYeKlg2PZnamYWrzHCIh+rmxcB8zR112gK5HXwJ9+qHVOFacCjzJ0Fo/rY
         lu8HFdjLDQzAWc9LlVSKNCyDTJgnoyZa83ksX2tB+6c2CzeMWlVp5BdSYiSZRvoTxGfB
         29nIXQIAQrLFJSsecp4QpWvFvKNogqgibOOx+qfsJrKxPmC2+fKY/HRhsaTLSMPxepdI
         tKD5JHCmYZTC5MxStPN/I/nrFMnCoVkSbi8yPQ+fe5eTczVevUuxHhZh6rbmFHPL3vLs
         LgHYh9coR4Q3IPVp2OtI9H2/JUWOVFs6xRaVIS/dXhheaIM67QSppL7nqE8OG9xgdoHo
         Ro+g==
X-Received: by 10.236.41.199 with SMTP id h47mr553036yhb.192.1367370704885;
        Tue, 30 Apr 2013 18:11:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p31sm1605594yhm.10.2013.04.30.18.11.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223046>

It doesn't seem to make any difference, but revision_tree() requires a
lock.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 91b5cda..b428244 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -389,8 +389,8 @@ class CustomTree():
 
         def copy_tree(revid):
             files = files_cache[revid] = {}
-            tree = repo.repository.revision_tree(revid)
             repo.lock_read()
+            tree = repo.repository.revision_tree(revid)
             try:
                 for path, entry in tree.iter_entries_by_dir():
                     files[path] = entry.file_id
-- 
1.8.3.rc0.399.gc96a135
