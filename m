From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pager: do not leak "GIT_PAGER_IN_USE" to the pager
Date: Fri, 03 Jul 2015 10:18:45 -0700
Message-ID: <xmqqk2uh5fd6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 19:18:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB4c1-0004TO-SQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbbGCRSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:18:49 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38691 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbbGCRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:18:47 -0400
Received: by igrv9 with SMTP id v9so80873567igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:cc:date:message-id:user-agent:mime-version
         :content-type;
        bh=tA4q03ytYwePdPAf67if6ut/XM8SJFW8TIZbWVNVIOU=;
        b=CRYhxqaJF+9sN2yuv5A7pXxrAHPBlaoKeMDxBmwP9tRsP9XGcUygK0MYpDtkE7oApP
         l3XVMYDZRcb4iQeHauMwsizWCFzeRnpLq36wuKD7Qno7b0FBLqfvI1RJiX0gnaydwhQk
         ulKKOQcJAdVQl5IFoD4PXb2QwSVKIZRRblzgKEtH8aq371AuTfi4iCx26fiSUOkS8lAM
         pe1qd3sqqrpXcrwn7b5PNSvliBP5pzG8UBGfXm2NvYSK89wG9SZjJIwsJCR1TWwwaGRw
         oNXrjDOxhLXOTGyy5WiOLZ2sFu64Zxo7vj9V+hEl9+A4ontpM+kFudMiKXEgMDldVhsN
         dAlw==
X-Received: by 10.50.143.104 with SMTP id sd8mr50768078igb.14.1435943927303;
        Fri, 03 Jul 2015 10:18:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id rj5sm3841014igc.2.2015.07.03.10.18.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:18:46 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273297>

Since 2e6c01e2, we export GIT_PAGER_IN_USE so that a process that
becomes the upstream of the spawned pager can still tell that we
have spawned the pager and decide to do colored output even when
its output no longer goes to a terminal (i.e. isatty(1)).

But we forgot to clear it from the enviornment of the spawned pager.
This is not a problem in a sane world, but if you have a handful of
thousands Git users in your organization, somebody is bound to do
strange things, e.g. typing "!<ENTER>" instead of 'q' to get control
back from $LESS.  GIT_PAGER_IN_USE is still set in that subshell
spawned by "less", and all sorts of interesting things starts
happening, e.g. "git diff | cat" starts coloring its output.

We can clear the environment variable in the half of the fork that
runs the pager to avoid the confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Arguably, "git diff | cat" that is colored is much minor problem
   than that the user keep using that subshell from pager without
   realizing.  The user may run more git commands that spawn a pager
   and do the "!<ENTER>" infinite times creating a deep process tree
   and then "logout" many number of times.

 pager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pager.c b/pager.c
index 98b2682..070dc11 100644
--- a/pager.c
+++ b/pager.c
@@ -78,6 +78,7 @@ void setup_pager(void)
 		argv_array_push(&pager_process.env_array, "LESS=FRX");
 	if (!getenv("LV"))
 		argv_array_push(&pager_process.env_array, "LV=-c");
+	argv_array_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
 		return;
 
