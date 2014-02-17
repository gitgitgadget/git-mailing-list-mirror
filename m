From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] rev-parse: fix --resolve-git-dir argument handling
Date: Mon, 17 Feb 2014 08:46:20 +0000
Message-ID: <65ea2c8ce4f0d60f0d93f730aac50183ba63bd1c.1392626780.git.john@keeping.me.uk>
References: <5301C4B4.5070503@thequod.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Hahler <genml+git-2014@thequod.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 09:46:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFJqh-0002YM-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 09:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbaBQIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 03:46:43 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:43397 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaBQIqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 03:46:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E2480CDA59E;
	Mon, 17 Feb 2014 08:46:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5rXiRnyu3aU2; Mon, 17 Feb 2014 08:46:40 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 99137CDA602;
	Mon, 17 Feb 2014 08:46:40 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8E8DE161E265;
	Mon, 17 Feb 2014 08:46:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHXXN3-Q9xzH; Mon, 17 Feb 2014 08:46:40 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 942AA161E480;
	Mon, 17 Feb 2014 08:46:33 +0000 (GMT)
X-Mailer: git-send-email 1.9.0.6.g037df60.dirty
In-Reply-To: <5301C4B4.5070503@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242248>

There are two problems here:

1) If no argument is provided, then the command segfaults
2) The argument is not consumed, so there will be excess output

Fix both of these in one go by restructuring the handler for this
option.

Reported-by: Daniel Hahler <genml+git-2014@thequod.de>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/rev-parse.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index aaeb611..645cc4a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -738,9 +738,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
-				const char *gitdir = resolve_gitdir(argv[i+1]);
+				const char *gitdir;
+				if (++i >= argc)
+					die("--resolve-git-dir requires an argument");
+				gitdir = resolve_gitdir(argv[i]);
 				if (!gitdir)
-					die("not a gitdir '%s'", argv[i+1]);
+					die("not a gitdir '%s'", argv[i]);
 				puts(gitdir);
 				continue;
 			}
-- 
1.9.0.6.g037df60.dirty
