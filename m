From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 04/14] grep: add --staged option
Date: Sat, 12 Oct 2013 02:04:35 -0500
Message-ID: <1381561488-20294-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLm-0003qi-RQ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab3JLHKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:54 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:54269 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3JLHKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:53 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3136847oag.12
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UIdvBSn4Is8qAm3qcPwEf3WNN7J0O/sZOcL2cL44RP4=;
        b=avOrK5GPOXjjHK/lvBkPH92tgPS4dScqrJGaKv75K8Y0i2F/NHz37a/SBOkZN2/arS
         E7WcquCGVU7YTRoblWBX6qKOdBaOUeKrJIkN7nqNIsQxhviMJ9yqzDH/HWrD4x17V0rU
         J2lR4Zh6TKRPta68TmX+2f8NSYhkT72wN1XBB/0WWDCVR6OZQ8xkdXusNQJ40KKVmqlL
         DHT6z5F6gltEpamDxCUR6Fj0wWLrEK7e3ahVDmDpt3CJMonun9rn+OALkhRewfhLFwGq
         uNBHZyicV8j8Zvk+MF0KVfycW07krchYdvtMF78Rx+OQ3zLzpwLb3lzOrJfPh1zATQee
         MNEQ==
X-Received: by 10.60.45.102 with SMTP id l6mr13736173oem.36.1381561852773;
        Sat, 12 Oct 2013 00:10:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm28652197obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235964>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-grep.txt | 5 ++++-
 builtin/grep.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8497aa4..9f7899c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --staged | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -60,6 +60,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--staged::
+	Synonym for `--cached`.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..b953911 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -640,6 +640,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
+		OPT_BOOLEAN(0, "staged", &cached,
+			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
-- 
1.8.4-fc
