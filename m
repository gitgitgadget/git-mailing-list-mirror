From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/4] pathspec: use is_dir_sep() to check for trailing slashes
Date: Thu, 12 Sep 2013 20:24:58 +0100
Message-ID: <88455dac2dce36135c070cff01215e9ae0259635.1379013786.git.john@keeping.me.uk>
References: <cover.1379013786.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCWT-0001hJ-67
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab3ILTZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:25:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42585 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab3ILTZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:25:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 16C7F606531;
	Thu, 12 Sep 2013 20:25:44 +0100 (BST)
X-Quarantine-ID: <R6kVWqumLVMe>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6kVWqumLVMe; Thu, 12 Sep 2013 20:25:43 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id AF5F460651D;
	Thu, 12 Sep 2013 20:25:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A2293161E575;
	Thu, 12 Sep 2013 20:25:43 +0100 (BST)
X-Quarantine-ID: <Lgk2xqCUz8Vr>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lgk2xqCUz8Vr; Thu, 12 Sep 2013 20:25:43 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D925D161E580;
	Thu, 12 Sep 2013 20:25:32 +0100 (BST)
X-Mailer: git-send-email 1.8.4.277.gfbd6843.dirty
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk> <cover.1379013786.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234677>

This allows us to correctly removing trailing backslashes on Windows
when checking for submodules.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 pathspec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ad1a9f5..7c6963b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -252,7 +252,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	item->prefix = prefixlen;
 
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
-	    (item->len >= 1 && item->match[item->len - 1] == '/') &&
+	    (item->len >= 1 && is_dir_sep(item->match[item->len - 1])) &&
 	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
 	    S_ISGITLINK(active_cache[i]->ce_mode)) {
 		item->len--;
@@ -267,7 +267,8 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 			if (!S_ISGITLINK(ce->ce_mode))
 				continue;
 
-			if (item->len <= ce_len || match[ce_len] != '/' ||
+			if (item->len <= ce_len ||
+			    !is_dir_sep(match[ce_len]) ||
 			    memcmp(ce->name, match, ce_len))
 				continue;
 			if (item->len == ce_len + 1) {
-- 
1.8.4.277.gfbd6843.dirty
