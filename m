From: David Bryson <david@statichacks.org>
Subject: [PATCH] Use "git_config_string" to simplify "builtin-gc.c" code
	where "prune_expire" is set
Date: Tue, 30 Sep 2008 13:28:58 -0700
Message-ID: <20080930202858.GA1953@eratosthenes.cryptobackpack.org>
References: <20080930190549.GA9869@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 22:30:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KklrG-0004f6-0o
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbYI3U3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYI3U3A
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:29:00 -0400
Received: from cryptobackpack.org ([64.105.32.74]:33519 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYI3U27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:28:59 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 4AEC210D025B; Tue, 30 Sep 2008 13:28:59 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 80E5310D0108
	for <git@vger.kernel.org>; Tue, 30 Sep 2008 13:28:58 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 743FA5075; Tue, 30 Sep 2008 13:28:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080930190549.GA9869@eratosthenes.cryptobackpack.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97158>


Signed-off-by: David Bryson <david@statichacks.org>
---
Manage to fix the const char ** compile error, third time is a
harm(hopefully!)

 builtin-gc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index fac200e..7af65bb 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -26,7 +26,7 @@ static int pack_refs = 1;
 static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
-static char *prune_expire = "2.weeks.ago";
+static const char *prune_expire = "2.weeks.ago";
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
@@ -57,15 +57,12 @@ static int gc_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (strcmp(value, "now")) {
+		if (value && strcmp(value, "now")) {
 			unsigned long now = approxidate("now");
 			if (approxidate(value) >= now)
 				return error("Invalid %s: '%s'", var, value);
 		}
-		prune_expire = xstrdup(value);
-		return 0;
+		return git_config_string(&prune_expire, var, value);
 	}
 	return git_default_config(var, value, cb);
 }
-- 
1.6.0.2
