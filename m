From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/4] pathspec: strip multiple trailing slashes from submodules
Date: Thu, 12 Sep 2013 20:24:59 +0100
Message-ID: <7c478c19da6ee3322ca87e77a90358a30178c286.1379013786.git.john@keeping.me.uk>
References: <cover.1379013786.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 21:26:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCWe-0001qH-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab3ILTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:25:56 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:46830 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3ILTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:25:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 74DBACDA5EB;
	Thu, 12 Sep 2013 20:25:55 +0100 (BST)
X-Quarantine-ID: <aHwGadN-xryV>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHwGadN-xryV; Thu, 12 Sep 2013 20:25:54 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 31321CDA5E1;
	Thu, 12 Sep 2013 20:25:54 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 2702B161E581;
	Thu, 12 Sep 2013 20:25:54 +0100 (BST)
X-Quarantine-ID: <HqWV+2wl88ca>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HqWV+2wl88ca; Thu, 12 Sep 2013 20:25:53 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EEBE5161E575;
	Thu, 12 Sep 2013 20:25:43 +0100 (BST)
X-Mailer: git-send-email 1.8.4.277.gfbd6843.dirty
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
In-Reply-To: <cover.1379013786.git.john@keeping.me.uk>
References: <cover.1378840318.git.john@keeping.me.uk> <cover.1379013786.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234678>

This allows us to replace the submodule path trailing slash removal in
builtin/rm.c with the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag to
parse_pathspec() without changing the behaviour with respect to multiple
trailing slashes.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 pathspec.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 7c6963b..11b031a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -251,12 +251,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	item->len = strlen(item->match);
 	item->prefix = prefixlen;
 
-	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
-	    (item->len >= 1 && is_dir_sep(item->match[item->len - 1])) &&
-	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
-	    S_ISGITLINK(active_cache[i]->ce_mode)) {
-		item->len--;
-		match[item->len] = '\0';
+	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) {
+		size_t pathlen = item->len;
+		while (pathlen > 0 && is_dir_sep(item->match[pathlen - 1]))
+			pathlen--;
+
+		if ((i = cache_name_pos(item->match, pathlen)) >= 0 &&
+		    S_ISGITLINK(active_cache[i]->ce_mode)) {
+			item->len = pathlen;
+			match[item->len] = '\0';
+		}
 	}
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
@@ -271,11 +275,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 			    !is_dir_sep(match[ce_len]) ||
 			    memcmp(ce->name, match, ce_len))
 				continue;
-			if (item->len == ce_len + 1) {
-				/* strip trailing slash */
+
+			while (item->len > 0 && is_dir_sep(match[item->len - 1]))
 				item->len--;
-				match[item->len] = '\0';
-			} else
+
+			/* strip trailing slash */
+			match[item->len] = '\0';
+
+			if (item->len != ce_len)
 				die (_("Pathspec '%s' is in submodule '%.*s'"),
 				     elt, ce_len, ce->name);
 		}
-- 
1.8.4.277.gfbd6843.dirty
