From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] clone: fix progress-regression
Date: Mon,  7 May 2012 21:23:13 +0200
Message-ID: <1336418593-2792-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j.sixt@viscovery.net, peff@peff.net,
	rctay89@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 21:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRTXN-0007ET-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 21:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757697Ab2EGTX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 15:23:57 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35394 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2EGTX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 15:23:56 -0400
Received: by lbbgm6 with SMTP id gm6so3688228lbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=btfE7u6btp8dWJjUUb5I6My40HAyTjtKS3rM/8xtnlw=;
        b=HuwQ1YP+ix6sV2SH91PFKC+fEk4+00hNFxmZYYFz+pZEaaQJSzn2ncvXprl29sEcNu
         Mzp5nH/OkBjx70S7yxJdpXGJU03/LC52fW0lxopswYGpsmeF74O+hZql/xR5uKmrad3l
         n5vE3cZT7XBDu3ON+ih17XvRhwqo0Y/u2PJNcysgdxs4X5mygGJy7SVmdUiAsHr5brWl
         VxOtUmnI0MwpJFDKP1pdIkypSGKOh0GxT9b0TFbxpyckpFavbIXvM4sjC4UgqDaOP5t4
         G0tivRcWmdqIsS+VQxGGfEYY8Z0go80d51/IrMvwKo4nOW94UMGnE/+Cnr2h6RhDksu9
         noNA==
Received: by 10.152.111.33 with SMTP id if1mr15516784lab.10.1336418635373;
        Mon, 07 May 2012 12:23:55 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id gw17sm19953584lab.11.2012.05.07.12.23.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 12:23:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197300>

In 5bd631b3 ("clone: support multiple levels of verbosity"), the
default behavior to show progress of the implicit checkout in
the clone-command regressed so that progress was only shown if
the verbose-option was specified.

Fix this by making option_verbosity == 0 output progress as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Hmpf. While tidying this up for a proper submission, I found out that
writing a reliable test is tricky due to the start_progress_delay-usage.
I'd have to clone a repo that does not progress more than 50% of the
checkout-operation within one second or something like that (I didn't
quite follow the logic there), which is a lot :P. This strikes me as
error-prone, and I can't see an obvious hack around it (other than
modifying the progress-code, which I consider a somewhat nasty
alternative).

So perhaps writing a test to avoid similar breakages in the future isn't
worth it?

 builtin/clone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd5c96..a4d8d25 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -569,7 +569,7 @@ static int checkout(void)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = (option_verbosity > 0);
+	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 
-- 
1.7.10.msysgit.1
