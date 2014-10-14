From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] [kernel] completion: silence "fatal: Not a git repository" error
Date: Tue, 14 Oct 2014 06:49:45 -0400
Message-ID: <1413283785-505-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 12:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdzfz-0004Bv-L1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 12:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbaJNKtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 06:49:55 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:44962 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbaJNKtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 06:49:55 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so2411372qgd.26
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VE4J1j0Li0goTFxusLZEtxk/vVg6Ehevqhz2kO/FI8M=;
        b=Q7nZuuEC+Nz3xUCMEKEgdpn9OkqJM1SMHcn7PVxNOS/jsN670MSM6jQ7IZjzwezPex
         5mMjeyyN2yG4w3hQexO4mpYC6IjhGPsuYju/Tre07qvbo3yfSELNxjfV8XdyzJG1DwfU
         LgM0bUWSRcqYg4Szdlu90y7JvjGIR6tZfPXPfx/1Zmo0MbkPBOh2Byf6F8MB9xFh1BsA
         Ihx63jpPlucFGfrRaYgzHOa1n+pVRO8Wk/BIxiRU+vx3khm4isK18fLzXxXDS2KzdWtA
         27NGI6zOxJSYNxjjLf2D4xZ04HSzcxdnaMg9v5hZhLNXoYbof0MB2MwF2JNkJZW2/ZIZ
         ubGA==
X-Received: by 10.224.125.129 with SMTP id y1mr7527145qar.75.1413283794259;
        Tue, 14 Oct 2014 03:49:54 -0700 (PDT)
Received: from localhost.localdomain (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id a93sm15111481qga.26.2014.10.14.03.49.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 03:49:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible that a user is trying to run a git command and fail to realize
that they are not in a git repository or working tree.  When trying to complete
an operation, __git_refs would fall to a degenerate case and attempt to use
"git for-each-ref", which would emit the error.

Let's fix this by shunting the error message coming from "git for-each-ref".

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5ea5b82..31b4739 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -388,7 +388,8 @@ __git_refs ()
 		;;
 	*)
 		echo "HEAD"
-		git for-each-ref --format="%(refname:short)" -- "refs/remotes/$dir/" | sed -e "s#^$dir/##"
+		git for-each-ref --format="%(refname:short)" -- \
+			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
 		;;
 	esac
 }
-- 
2.0.1
