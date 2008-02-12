From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 2/2] pack-objects: Use git_config_magic_int()
Date: Tue, 12 Feb 2008 09:23:59 +0100
Message-ID: <47B1579F.8030407@op5.se>
References: <1202804110-3715-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqS3-0003mp-Gq
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759191AbYBLIYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbYBLIYG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:24:06 -0500
Received: from mail.op5.se ([193.201.96.20]:47955 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYBLIYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:24:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 65D211F08850;
	Tue, 12 Feb 2008 09:24:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.295
X-Spam-Level: 
X-Spam-Status: No, score=-2.295 tagged_above=-10 required=6.6
	tests=[AWL=0.204, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXlIuUQb4QVc; Tue, 12 Feb 2008 09:24:00 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 248431F0884E;
	Tue, 12 Feb 2008 09:24:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Followup-To: <47B15701.8040803@op5.se>
In-Reply-To: <1202804110-3715-1-git-send-email-ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73640>

This lets users specify "auto" as a valid parameter to --threads
and pack.threads instead of having to remember what the magic
number 0 actually meant. 0 still works. This is just a nicer way
of saying it.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/config.txt           |    4 ++--
 Documentation/git-pack-objects.txt |    4 ++--
 builtin-pack-objects.c             |   16 ++++++++++------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e9f26ed..398c6e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -756,8 +756,8 @@ pack.threads::
 	warning. This is meant to reduce packing time on multiprocessor
 	machines. The required amount of memory for the delta search window
 	is however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
-	and set the number of threads accordingly.
+	Specifying 'auto' or 0 will cause git to auto-detect the number
+	of CPU's and set the number of threads accordingly.
 
 pack.indexVersion::
 	Specify the default pack index version.  Valid values are 1 for
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 5c1bd3b..e4b6fe9 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -177,8 +177,8 @@ base-name::
 	This is meant to reduce packing time on multiprocessor machines.
 	The required amount of memory for the delta search window is
 	however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
-	and set the number of threads accordingly.
+	Specifying 'auto' or 0 will cause git to auto-detect the number
+	of CPU's and set the number of threads accordingly.
 
 --index-version=<version>[,<offset>]::
 	This is intended to be used by the test suite only. It allows
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a7ffb53..be04829 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1857,7 +1857,7 @@ static int git_pack_config(const char *k, const char *v)
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		delta_search_threads = git_config_int(k, v);
+		delta_search_threads = git_config_magic_int(k, v, "auto", 0);
 		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
@@ -2128,11 +2128,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--threads=")) {
-			char *end;
-			delta_search_threads = strtoul(arg+10, &end, 0);
-
-			if (!arg[10] || *end || delta_search_threads < 0)
-				usage(pack_usage);
+			if (!strcasecmp(arg+10, "auto"))
+				delta_search_threads = 0;
+			else {
+				char *end;
+				delta_search_threads = strtoul(arg+10, &end, 0);
+
+				if (!arg[10] || *end || delta_search_threads < 0)
+					usage(pack_usage);
+			}
 #ifndef THREADED_DELTA_SEARCH
 			if (delta_search_threads > 1)
 				warning("no threads support, "
-- 
1.5.4.rc5.11.g0eab8
