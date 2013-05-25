From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 38/48] remote-hg: improve branch listing
Date: Fri, 24 May 2013 21:29:54 -0500
Message-ID: <1369449004-17981-39-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Il-0002lu-WC
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab3EYCdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:42 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48307 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab3EYCdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so6964047oag.19
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=p4vcsES/b/N2h9S9zqRR62Ipds5k6TgSakGj8uNR7F8=;
        b=bqC5wUt51k2KUClz3Erp1GBhqA37zOtC4ntSHObx6miYCPnCLFIIyJXdazGtXFeEOJ
         XPK5CE16KkVG5JtG0Kn4X3JxyHDFJAdhfT+QHBGfh/PC2Ev/DLFWpgy9n7g8E3ZVu2NZ
         mclBsf2RIiA+JGSXaV+WdV9cjEGJYmszBA+dAq8CETQVoq8bNC41I5thA9cYfxSMDNAM
         uwyPKKr/Evv3+HRU6FPq070Odqo8R+mYrUT8l737cfEcXbFjlSQVXf2nUlm1nHUbtYPc
         z+TFgmELCtJH1GZ2FTrpvZ3ObjFTVd5ttnQcIFZlE3gZYEwtH466/3gS+cAGn/Gi0NGJ
         w77A==
X-Received: by 10.182.99.199 with SMTP id es7mr13543677obb.5.1369449219902;
        Fri, 24 May 2013 19:33:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20065190obi.8.2013.05.24.19.33.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225452>

We want to show the remote heads, not the internal ones, which might
have garbage.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 8df72d9..5ad5c1e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -605,9 +605,12 @@ def do_list(parser):
     list_head(repo, cur)
 
     if track_branches:
-        for branch in repo.branchmap():
-            heads = repo.branchheads(branch)
-            if len(heads):
+        orig = peer if peer else repo
+
+        for branch, heads in orig.branchmap().iteritems():
+            # only open heads
+            heads = [h for h in heads if 'close' not in repo.changelog.read(h)[5]]
+            if heads:
                 branches[branch] = heads
 
         for branch in branches:
-- 
1.8.3.rc3.312.g47657de
