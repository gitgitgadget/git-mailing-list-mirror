From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/6] diff.c: remove useless check for value != NULL
Date: Sat, 16 Feb 2008 05:59:53 +0100
Message-ID: <20080216055953.d5fafe10.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF4L-0003mn-K0
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbYBPEx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYBPEx7
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:53:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34701 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbYBPEx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:53:58 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CB6631AB2B9;
	Sat, 16 Feb 2008 05:53:56 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 298661AB2B5;
	Sat, 16 Feb 2008 05:53:56 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74009>

It is not necessary to check if value != NULL before calling
'parse_lldiff_command' as there is already a check inside this
function.

By the way this patch also improves the existing check inside
'parse_lldiff_command' by using:
	return config_error_nonbool(var);
instead of:
	return error("%s: lacks value", var);

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

	This patch series can be applied on "master"
	on top of my "diff.c: strdup -> xstrdup" patch. 

	The first 3 patches apply cleanly on "next" though.

diff --git a/diff.c b/diff.c
index e5db293..5640cbf 100644
--- a/diff.c
+++ b/diff.c
@@ -87,7 +87,7 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 	}
 
 	if (!value)
-		return error("%s: lacks value", var);
+		return config_error_nonbool(var);
 	drv->cmd = xstrdup(value);
 	return 0;
 }
@@ -166,13 +166,8 @@ int git_diff_ui_config(const char *var, const char *value)
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
-		if (ep != var + 4) {
-			if (!strcmp(ep, ".command")) {
-				if (!value)
-					return config_error_nonbool(var);
-				return parse_lldiff_command(var, ep, value);
-			}
-		}
+		if (ep != var + 4 && !strcmp(ep, ".command"))
+			return parse_lldiff_command(var, ep, value);
 	}
 
 	return git_diff_basic_config(var, value);
-- 
1.5.4.1.129.gf12af-dirty
