From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] remote-hg: properly detect missing contexts
Date: Tue, 29 Apr 2014 04:04:31 -0500
Message-ID: <1398762275-346-5-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48Y-0008V4-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbaD2JP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:28 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57884 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042AbaD2JPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:24 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so8568702obc.6
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ty8phpdnv9se0iI9vG51KGc+jKZgNKhrUYjmQl+RwCQ=;
        b=A81bYMM7yK3Be1lo4gP7GrvaccRUdE7cDyi9gVIAXLUNtIMmzlwDwWDLUygrd6CZul
         xbbjbM7aBdmK2RcrxAWuP17DJ9Re43fAFfH8cIeyWN9JJaN602WAtZ5zPQVDWOZSO+s5
         4KwrSsLGwuYhPICzbguBz4ZEn/azXozfp0BYILzMAu8MiqIkrIiHoZFbFDVhuNsaNLaQ
         M0isVHi1SIm0va8hRIHuArz2RnQpQx94q7Kdiwwdfk+PPbI3Rnn+l/xKcu5tHRFcFWt1
         F6OUkL2kJJ3bdFiHErUbuoS2LEmvGAXv7Ob2dn7+D/KWcdUIBMat2eWKLGfobucd/jlJ
         Y5ig==
X-Received: by 10.182.104.71 with SMTP id gc7mr26572310obb.34.1398762923953;
        Tue, 29 Apr 2014 02:15:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm42779189obc.22.2014.04.29.02.15.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247550>

This can happen when there's a synchronization issue between marks-git
and marks-hg; a key is missing in marks-hg, and when we receive a reset
command the value of ctx basically comes from None.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 8aca6dd..1972f7f 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -917,6 +917,11 @@ def checkheads_bmark(repo, ref, ctx):
 
     ctx_old = bmarks[bmark]
     ctx_new = ctx
+
+    if not ctx.rev():
+        print "error %s unknown" % ref
+        return False
+
     if not repo.changelog.descendant(ctx_old.rev(), ctx_new.rev()):
         if force_push:
             print "ok %s forced update" % ref
-- 
1.9.2+fc1.3.gade8541
