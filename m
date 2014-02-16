From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/5] builtin/mv: don't use memory after free
Date: Sun, 16 Feb 2014 16:06:05 +0000
Message-ID: <4df594e05741b2bec1201556d34eb22bab2c235a.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4Oh-0002WO-EU
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaBPQQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:16:24 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:43316 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaBPQQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:16:23 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2014 11:16:23 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 3D02B2149C;
	Sun, 16 Feb 2014 16:06:37 +0000 (GMT)
X-Quarantine-ID: <flpkKLXCYzG5>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id flpkKLXCYzG5; Sun, 16 Feb 2014 16:06:36 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id EB70C1FE06;
	Sun, 16 Feb 2014 16:06:36 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D5C22161E545;
	Sun, 16 Feb 2014 16:06:36 +0000 (GMT)
X-Quarantine-ID: <qMdkVLyt0gRM>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qMdkVLyt0gRM; Sun, 16 Feb 2014 16:06:36 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BB6E9161E4CB;
	Sun, 16 Feb 2014 16:06:32 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242233>

If 'src' already ends with a slash, then add_slash() will just return
it, meaning that 'free(src_with_slash)' is actually 'free(src)'.  Since
we use 'src' later, this will result in use-after-free.

In fact, this cannot happen because 'src' comes from
internal_copy_pathspec() without the KEEP_TRAILING_SLASH flag, so any
trailing '/' will have been stripped; but static analysis tools are not
clever enough to realise this and so warn that 'src' could be used after
having been free'd.  Fix this by checking that 'src_w_slash' is indeed
newly allocated memory.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/mv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 21c46d1..7e26eb5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -162,7 +162,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					if (strncmp(path, src_w_slash, len_w_slash))
 						break;
 				}
-				free((char *)src_w_slash);
+				if (src_w_slash != src)
+					free((char *)src_w_slash);
 
 				if (last - first < 1)
 					bad = _("source directory is empty");
-- 
1.9.rc0.187.g6292fff
