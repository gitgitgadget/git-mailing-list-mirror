From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/3] git-p4: support multiple depot paths in p4 submit
Date: Sat, 19 Dec 2015 09:39:39 +0000
Message-ID: <1450517980-1744-3-git-send-email-luke@diamand.org>
References: <1450517980-1744-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Hocevar <sam@hocevar.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 10:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAE0J-0001WP-BR
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 10:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbbLSJkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 04:40:35 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33207 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbbLSJjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 04:39:40 -0500
Received: by mail-wm0-f49.google.com with SMTP id p187so13497957wmp.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+FTzgGvVOr0VolSITdmbaDFEtkwowfwIB4bUDuwJ63I=;
        b=LnYujxnkHcGL/4dEXegHCk0FjnsD6RKcroFV50O0yo84aD1syexBLqCzBuTSuCK0pG
         OztuvhHJvs0FkUyDWsVBGMpeYZlEYL3zls6eeiQAARluHRRyPRLfuyDjaXO15MoERVnp
         4oLMsR8U1BJP+4BErOLmpGLBxIDl3lHeudMcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+FTzgGvVOr0VolSITdmbaDFEtkwowfwIB4bUDuwJ63I=;
        b=O4gALPkbNkPXF+WR3VCjwbyvj0LXugEVW3O5H9k0jjo0I4CPAeBGtPDu1QXg9BJSmL
         8gfwVYQSzEkd8qZ9jpeNNCAEjqQSn2c+7i2D2Wp310VzVL6Pt82C3wvTiP4AVrcipVdU
         sSmWnMU8/cAQJCMQzqiRR8GyapDOubAIdgInx50nuTRN74haKwCppo3BCidmFcQXXJXQ
         d+ejyPQ2bm0QC/tYdcEoJ4503ES7/+M1ncEr8IopT0hwPONkU1lmaEr8RVZCN2r7ZMdW
         WC4DchDxS5JRoz/TuF4HFNHmQAr9P3Ibn/RRJA5c4O+CBf56aFgBzlyK7Flr9MBstj9Y
         tpgQ==
X-Gm-Message-State: ALoCoQlW+yitylCa1+Rjic2MIoqAu6vvoNwvpTuYRRLakrfiaQdkstmXDXqkN73OY8rKfGfZRsJYoaHXxC15H3t+adSIRbe1YQ==
X-Received: by 10.194.171.226 with SMTP id ax2mr2306670wjc.98.1450517978791;
        Sat, 19 Dec 2015 01:39:38 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id b84sm10211547wmh.15.2015.12.19.01.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 01:39:38 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
In-Reply-To: <1450517980-1744-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282741>

From: Sam Hocevar <sam@hocevar.net>

When submitting from a repository that was cloned using a client spec,
use the full list of paths when ruling out files that are outside the
view.  This fixes a bug where only files pertaining to the first path
would be included in the p4 submit.

Signed-off-by: Sam Hocevar <sam@hocevar.net>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7a9dd6a..122aff2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1458,6 +1458,8 @@ class P4Submit(Command, P4UserMap):
            Remove lines in the Files section that show changes to files
            outside the depot path we're committing into."""
 
+        [upstream, settings] = findUpstreamBranchPoint()
+
         template = ""
         inFilesSection = False
         for line in p4_read_pipe_lines(['change', '-o']):
@@ -1470,8 +1472,13 @@ class P4Submit(Command, P4UserMap):
                     lastTab = path.rfind("\t")
                     if lastTab != -1:
                         path = path[:lastTab]
-                        if not p4PathStartsWith(path, self.depotPath):
-                            continue
+                        if settings.has_key('depot-paths'):
+                            if not [p for p in settings['depot-paths']
+                                    if p4PathStartsWith(path, p)]:
+                                continue
+                        else:
+                            if not p4PathStartsWith(path, self.depotPath):
+                                continue
                 else:
                     inFilesSection = False
             else:
-- 
2.6.2.474.g3eb3291
