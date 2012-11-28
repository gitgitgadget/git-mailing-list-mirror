From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote-hg: fix for older versions of python
Date: Wed, 28 Nov 2012 02:01:33 +0100
Message-ID: <1354064495-23171-3-git-send-email-felipe.contreras@gmail.com>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 02:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW2b-0001oe-8i
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab2K1BCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:02:00 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54402 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab2K1BB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:01:59 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5441611bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hrWfNOzZjjyAN+n1bG13uhvyXpH959z6eXRzdMHoKdg=;
        b=FwEcjFOvtsMTn7klkrncse6pcqAZwHkn3qo05hlBmTOJkuAB1X21/v9U16hz3Pnkt4
         6ZePI5IMhuP+DC+2Vh0gG3YUPS0KE7eUA9yMG8C2QPGCNB993G8l9MVWSb9pVVZw41KP
         6akqnJ2v+QzHvm2lkzhpeGk9YRx+SHeKLOUFzjq6jEhXFlEi+1Uv4l2uQYDrlpVh8o/9
         1DnKkGXau3F1GUlisLlAT/hJ+3vKBSCkD+9REzOiH/AwWDl58jsicWI2oIZKStFXITAg
         oOdOorvubaSpT7OhCEeIyjqBzh7+VyTMJwFIMHH4u8J6CcBatOo3mNXdsTKQiLQqUqqF
         AVFw==
Received: by 10.204.4.131 with SMTP id 3mr5024340bkr.25.1354064518389;
        Tue, 27 Nov 2012 17:01:58 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id 18sm2265438bkv.0.2012.11.27.17.01.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 17:01:57 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210649>

As Amit Bakshi reported, older versions of python (< 2.7) don't have
subprocess.check_output, so let's use subprocess.Popen directly as
suggested.

Suggested-by: Amit Bakshi <ambakshi@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 62c39db..016cdad 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -56,6 +56,12 @@ def hgmode(mode):
     m = { '0100755': 'x', '0120000': 'l' }
     return m.get(mode, '')
 
+def get_config(config):
+    cmd = ['git', 'config', '--get', config]
+    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
+    output, _ = process.communicate()
+    return output
+
 class Marks:
 
     def __init__(self, path):
@@ -727,12 +733,10 @@ def main(args):
     hg_git_compat = False
     track_branches = True
     try:
-        cmd = ['git', 'config', '--get', 'remote-hg.hg-git-compat']
-        if subprocess.check_output(cmd) == 'true\n':
+        if get_config('remote-hg.hg-git-compat') == 'true\n':
             hg_git_compat = True
             track_branches = False
-        cmd = ['git', 'config', '--get', 'remote-hg.track-branches']
-        if subprocess.check_output(cmd) == 'false\n':
+        if get_config('remote-hg.track-branches') == 'false\n':
             track_branches = False
     except subprocess.CalledProcessError:
         pass
-- 
1.8.0
