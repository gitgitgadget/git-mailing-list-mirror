From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Allow users to un-configure rename detection
Date: Thu, 9 Apr 2009 11:46:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904091141420.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:49:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzJn-00011Q-Fi
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbZDISrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 14:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761523AbZDISrv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 14:47:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35019 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760384AbZDISru (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 14:47:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39IkF4e022128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Apr 2009 11:46:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39IkFmD030880;
	Thu, 9 Apr 2009 11:46:15 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.443 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116197>


I told people on the kernel mailing list to please use "-M" when sending 
me rename patches, so that I can see what they do while reading email 
rather than having to apply the patch and then look at the end result.

I also told them that if they want to make it the default, they can just 
add

	[diff]
		renames

to their ~/.gitconfig file. And while I was thinking about that, I wanted 
to also check whether you can then mark individual projects to _not_ have 
that default in the per-repository .git/config file.

And you can't. Currently you cannot have a global "enable renames by 
default" and then a local ".. but not for _this_ project". Why? Because if 
somebody writes

	[diff]
		renames = no

we simply ignore it, rather than resetting "diff_detect_rename_default" 
back to zero.

Fixed thusly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Ok, so I didn't test it much. But it seems to work now.

 diff.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index e0fa78c..3ac7168 100644
--- a/diff.c
+++ b/diff.c
@@ -62,6 +62,15 @@ static int parse_diff_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
+static int git_config_rename(const char *var, const char *value)
+{
+	if (!value)
+		return DIFF_DETECT_RENAME;
+	if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
+		return  DIFF_DETECT_COPY;
+	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -75,13 +84,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
-		if (!value)
-			diff_detect_rename_default = DIFF_DETECT_RENAME;
-		else if (!strcasecmp(value, "copies") ||
-			 !strcasecmp(value, "copy"))
-			diff_detect_rename_default = DIFF_DETECT_COPY;
-		else if (git_config_bool(var,value))
-			diff_detect_rename_default = DIFF_DETECT_RENAME;
+		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
