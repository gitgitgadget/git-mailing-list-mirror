From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] rerere: fix for merge.conflictstyle
Date: Tue, 29 Apr 2014 23:08:29 -0500
Message-ID: <1398830909-24680-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 06:19:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfLzD-0007rY-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 06:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaD3ETI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 00:19:08 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:40742 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaD3ETG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 00:19:06 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so1151657yhn.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 21:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C7j/M3TQMoktTSyY8GCR+XRjkd2J77cvaA9lYO8828A=;
        b=dYmPjUu73ULcv17CjvxLXdlxftrRF+Cm+qwTnjpPcCOr35WQAUY8YrvozsiKW8G0F+
         NqH8b8saCHkQMcV+U2KWoPXedv26d1yhg+gfEZXh4DuNhpSWF34L5wrpVKIrdn4xmN3E
         pfywXjxuoyvthnQrnzBF+2fYvnoc/tZR79I0xbrK5H35DCN95ICLBuYHzqhaT+Hkw4ec
         YEKl3jTwIVWP87MOltZpAjZAmGkaizPn/rzCODPM2LbgTq+wijMChZahOnxBucPBb6Ii
         ukGWX/VykODaYfE6FbmGGHZdTTOjfTVcxILqnuFDXvovEmvLcn1JljpFGTTzMj7vJPCY
         qvNQ==
X-Received: by 10.236.79.134 with SMTP id i6mr2690448yhe.16.1398831545337;
        Tue, 29 Apr 2014 21:19:05 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f2sm40737405yhg.7.2014.04.29.21.19.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 21:19:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.10.gc7d6c45.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247674>

If we use a different conflict style `git rerere forget` is not able to
find the matching conflict SHA-1 because the diff generated is actually
different from what `git merge` generated.

The fix is to call git_xmerge_config() so that git_xmerge_style is set
properly and the diffs match.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/rerere.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 4e51add..98eb8c5 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -60,6 +60,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
 
+	git_config(git_xmerge_config, NULL);
+
 	if (autoupdate == 1)
 		flags = RERERE_AUTOUPDATE;
 	if (autoupdate == 0)
-- 
1.9.2+fc1.10.gc7d6c45.dirty
