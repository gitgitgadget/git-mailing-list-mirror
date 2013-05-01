From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/18] remote-bzr: iterate revisions properly
Date: Tue, 30 Apr 2013 20:10:08 -0500
Message-ID: <1367370610-14250-17-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLbH-0007sP-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934189Ab3EABMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:49 -0400
Received: from mail-gg0-f173.google.com ([209.85.161.173]:39814 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934166Ab3EABMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:46 -0400
Received: by mail-gg0-f173.google.com with SMTP id h3so193834gge.4
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2QdbLumc7FwTE+V/4HI8F4bkUkz2YrF/fMD+tr02cGs=;
        b=VK25IyrZ1GxH9eSsg24PrPYaRcRtIppmqy1y2/xmRwcZPhOLiUngaoWE0oMQ1McGgv
         /auBzQb5FLCTDcPWBpYGxqGtVPxnEEtvkg4PXi3aZgYttwtkd5240pNR3GKt0nvsvFgX
         jzu/Em4uv1OY4idW/o5/83o7bYBhL2VQduRbz7f+KYDwbspkumc0ftFnY5IwVbhwyKYN
         J64Ggd/3SYfF8LVG8kmWkrrq24zA2WHgtu5SP1gsMSdkwhbVOXsQEIo0IWDhahTLKLWX
         Plojgn/2L6CigKW6sd+Y13sz5QN1+bimWWepq0zd/9C7pmLUHA4zgsJ8JYoKi9vnPF/O
         Dqpw==
X-Received: by 10.236.124.34 with SMTP id w22mr722152yhh.25.1367370765992;
        Tue, 30 Apr 2013 18:12:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h68sm1516820yhj.24.2013.04.30.18.12.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223060>

This way we don't need to store the list of all the revisions, which
doesn't seem to be very memory efficient with bazaar's design, for
whatever reason.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 2e21008..66e3861 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -286,9 +286,10 @@ def export_branch(repo, name):
     last_revno, _ = branch.last_revision_info()
     total = last_revno - tip_revno
 
-    revs = [revid, seq for revid, _, seq, _ in revs if not marks.is_marked(revid)]
+    for revid, _, seq, _ in revs:
 
-    for revid, seq in revs:
+        if marks.is_marked(revid):
+            continue
 
         rev = repo.get_revision(revid)
         revno = seq[0]
-- 
1.8.3.rc0.399.gc96a135
