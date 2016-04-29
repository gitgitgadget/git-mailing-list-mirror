From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1] git-p4: workaround p4 removal of client directory
Date: Fri, 29 Apr 2016 08:40:26 +0100
Message-ID: <1461915626-10250-2-git-send-email-luke@diamand.org>
References: <1461915626-10250-1-git-send-email-luke@diamand.org>
Cc: Jacob Smith <jaroslav@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 09:37:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw2zk-0004i9-K1
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 09:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcD2Hhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 03:37:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35757 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcD2Hhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 03:37:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so3019013wme.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MRHUMSXlz6GXQzQwXxqm1TTBo6eXqAEpYVxzTKfGLyc=;
        b=Q1xrIyjCMWjcKAWvXcWrKRD+dtFUwEe1iw3+ER1DG3zHyaI97nDzzWHUW2n3vI7/u8
         L/0PGkltONi+dNKbNinI4Lj9muIRiBdTxYE1qmt0G4mSmOD5BlhXb5TuHlo/qgrXvQve
         DgcDdFo93lfvxOye3P4gbTzeAw0rU5j4lqN24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MRHUMSXlz6GXQzQwXxqm1TTBo6eXqAEpYVxzTKfGLyc=;
        b=kfXSQvhIel8MHPK1lXrucOAIxcEj8xlgyp8jOAIdLWbitDfc/z0XaKKBrXyeQhTNWs
         U81YZeIDv8KC/pE9JicFzqvgVhu138bKnkYm0+rkM2AG1p+ODzK82+U7LkHott4+cTH0
         ltUEZh+bYb0fuXf9P8IxIyLAz2lyyalkHvTSRuxmKTTozIxyjpSQoVovnhxH6vYdTtxK
         BeOze28SQrjDhP/gbFWtsqCth2g3p6TtxDoP4fw/yOGuiSgDYCWcUjEidecP9DasFuKw
         urSJasG+iIvnsQ5E+ASHzQJvvMjqQr1p4e1zvP+7smzZGHQ0PneDgpPkzTD/oLKE0AsJ
         6PPw==
X-Gm-Message-State: AOPr4FXwA8mORPcLn4PmF+0TlSyei4o8mhN6srh0mgdY5TQxJx9qnAnpPtzoVhwgLGM9qg==
X-Received: by 10.28.140.17 with SMTP id o17mr2113070wmd.18.1461915458372;
        Fri, 29 Apr 2016 00:37:38 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id w82sm1937078wmw.5.2016.04.29.00.37.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 00:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461915626-10250-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292974>

On some platforms, "p4 sync -f" will remove the workspace
directory after we have just created it; on some it won't.
This causes problems later when git finds itself in an
orphaned directory.

Workaround this by cd'ing back to the directory after
the "p4 sync -f".

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 527d44b..2b75a61 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python2
 #
 # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
 #
@@ -1956,6 +1956,9 @@ class P4Submit(Command, P4UserMap):
             if new_client_dir:
                 # old one was destroyed, and maybe nobody told p4
                 p4_sync("...", "-f")
+
+                # sometimes p4 will unlink the directory and recreate it
+                chdir(self.clientPath, is_client_path=True)
             else:
                 p4_sync("...")
         self.check()
-- 
2.8.1.218.gd2cea43.dirty
