From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 2/8] builtin-merge.c: call exclude_cmds() correctly.
Date: Wed, 25 Nov 2009 21:23:54 -0500
Message-ID: <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKN-0004ry-Hx
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbZKZCmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZKZCmy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:54 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbZKZCmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:37 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Brightmail-Tracker: AAAAAQAAA+k=
thread-index: AcpuP/gtxk9iR/NGQbyyoZ0VVLbbJQ==
X-Language-Identified: TRUE
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:26:41 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5520 invoked from network); 26 Nov 2009 02:25:37 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:37 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:11 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:26:41.0137 (UTC) FILETIME=[E371EE10:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133761>

We need to call exclude_cmds() after the loop, not during the loop, because
excluding a command from the array can change the indexes of objects in the
array.  The result is that, depending on file ordering, some commands
weren't excluded as they should have been.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 builtin-merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 57eedd4..855cf65 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -107,8 +107,8 @@ static struct strategy *get_strategy(const char *name)
 					found = 1;
 			if (!found)
 				add_cmdname(&not_strategies, ent->name, ent->len);
-			exclude_cmds(&main_cmds, &not_strategies);
 		}
+		exclude_cmds(&main_cmds, &not_strategies);
 	}
 	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, name)) {
 		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-- 
1.6.6.rc0.62.gaccf
