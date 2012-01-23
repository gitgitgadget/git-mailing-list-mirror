From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH/RFC] Fix the result of "git grep -l -C <num>"
Date: Mon, 23 Jan 2012 11:01:24 -0500
Message-ID: <1327334484-35196-1-git-send-email-surfingalbert@gmail.com>
Cc: trast@student.ethz.ch, rene.scharfe@lsrfire.ath.cx,
	Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 17:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpML8-0000jh-9H
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 17:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab2AWQBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 11:01:45 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39082 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2AWQBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 11:01:44 -0500
Received: by qadc10 with SMTP id c10so1877414qad.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vJunJpdARVrXReZZv4U8TYnAtA9T0y9ziqSlgZqYVWM=;
        b=n6OpRBFw2GZFgwrxuQjABAWfkApemLW2DTx3I9BlgcABIMa/iEiWEPcxVQ6os7suYm
         IniNXm9b2pYh4ut8lRjFDTA25kecv8Bb3MLeI0VItc74iAbFUP08ceAdvslTPYKLLnik
         FicCViLhjMLwXKCbg4Yqx6BZqrrYhH0H3isFQ=
Received: by 10.224.207.134 with SMTP id fy6mr9284002qab.72.1327334503894;
        Mon, 23 Jan 2012 08:01:43 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id g3sm15091753qap.2.2012.01.23.08.01.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 08:01:43 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188995>

When combining "git grep -l" with "-C <num>",
the first result is omitted.

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
For example, if the following command should output a list of 3
different files (a.txt, b.txt, c.txt):

$ git grep -l -C 1 albert_yale
b.txt
c.txt

The first result (a.txt) will be missing.

Understandably, you wouldn't normally use "-C" with "-l",
but the output should still be correct.

My solution is to take "opt.name_only" into account before setting
"skip_first_line" in grep.c.

I've reproduced this bug with git version 1.7.8.3
and git version 1.7.9.rc2, both under Mac OS X 10.7.2.

Albert Yale

 builtin/grep.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..076de21 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1036,7 +1036,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context || opt.file_break ||
 		    opt.funcbody)
-			skip_first_line = 1;
+		{
+			if( ! opt.name_only )
+				skip_first_line = 1;
+		}
 		start_threads(&opt);
 	}
 #endif
-- 
1.7.8.3
