From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/11] contrib: cc-cmd: fix parsing of rev-list args
Date: Fri, 19 Apr 2013 14:30:27 -0500
Message-ID: <1366399831-5964-8-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2p-0005C1-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab3DSTcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:17 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:35483 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3DSTcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:07 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so2986425qeb.33
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WeaATPtBX47Ew1cXBU0hxT/YQ3SgQT+Xxuj0EvmNcQ4=;
        b=NphN4JQNDajEXwd4OMfZPky4bKwdQsfENcEEsLdaLd2HqfPnMaLiZ1Kb/zMkC1tBfY
         oygVS4ERQu56EOil/VXygk598hJNhIqUtVTnXLrlA7vbNqhnCvcUpVCMpI56EzGcQvDo
         2dw4vmLBYYpD79y9DBNaNSlHH0ocIezo2016gQoGlOSnXLbEGPxwdGsYOOCY/t4P9roz
         720EvEOtoMfYR/ZL7ADoKuJ0QgNzIRsbdvsFnhrpL37BRjXn/lqqNWJiTPn0BrVVQvBZ
         8i1SbSXhmEWql1siQzTETCzemLS8PKFm6WQjthTMLjvd61KyD/3J7r7f83jq12lOJwcw
         l8fQ==
X-Received: by 10.229.128.30 with SMTP id i30mr5848397qcs.1.1366399926653;
        Fri, 19 Apr 2013 12:32:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 10sm19562379qax.13.2013.04.19.12.32.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221804>

For example '-1'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 4bca7f1..4fad030 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -23,7 +23,8 @@ begin
       $show_commits = v || true
     end
   end.parse!
-rescue OptionParser::InvalidOption
+rescue OptionParser::InvalidOption => e
+  $rev_args += e.args
 end
 
 class Commit
@@ -135,9 +136,11 @@ class Commits
 
     case revs.size
     when 1
-      committish = [ '%s..HEAD' % revs[0] ]
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
     else
-      committish = revs
+      args = revs
     end
 
     source = nil
-- 
1.8.2.1.790.g4588561
