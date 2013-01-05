From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] status: report ignored yet tracked directories
Date: Sat,  5 Jan 2013 21:42:43 +0100
Message-ID: <1357418563-6626-1-git-send-email-apelisse@gmail.com>
References: <20130105112432.GA14666@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: <tboegi@web.de>, <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trai3-0001bd-Lz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 21:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab3AEUuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 15:50:52 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:55456 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab3AEUuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 15:50:50 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2013 15:50:50 EST
Received: by mail-we0-f179.google.com with SMTP id r6so8719812wey.24
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ityLbDSlw8iLW22XXqGBeKzeQb0/HwBWeq/2Sud4ye0=;
        b=Tuuz/bE+XN6ZGu8a+eK1pUIBYGJbKFxu3QQjfkDZjaqtBCe8YbiUX60YOvO4/wJQ/o
         G4E+woVtsHErcoKlzeyqN6Grk1773iTSHXrBVx2yz/A883m5hpPYjjjB8oI079BDWuCT
         StjYh2PMFx3rGy9w4jTclb3Z031DawjIRsfgCr4fRRcCUOSBy6j1JxKLY85QJi7gg73x
         TlVVCs12aMMKaZ0XLkXSRC3Yy6U3J17EI4WTmuDoLaMbOeQoWtX3XOGCaokjelVJ+oSe
         1tFgOqng960KMI7CVcYWTRmXdsKkX/kGivmHBa17XiXfuk2qDqmapdwzGBIum8sisN3l
         KyuA==
X-Received: by 10.194.89.167 with SMTP id bp7mr88824091wjb.0.1357418618858;
        Sat, 05 Jan 2013 12:43:38 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id eo10sm5452330wib.9.2013.01.05.12.43.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 12:43:37 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4.3.g2036a08.dirty
In-Reply-To: <20130105112432.GA14666@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212713>

Tracked directories (i.e. directories containing tracked files) that
are ignored must be reported as ignored if they contain untracked files.

Currently, tracked files or directories can't be reported untracked or ignored.
Remove that constraint when searching ignored files.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Torsten, Jeff,

Can you please test this patch and tell me if this is better ? (t7061 is now
successful with core.ignorecase=true)

This patch applies on top of ap/status-ignored-in-ignored-directory (but
 should also apply cleanly on top of next for testing purpose).

Thanks,

 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9b80348..eefa8ab 100644
--- a/dir.c
+++ b/dir.c
@@ -672,7 +672,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)

 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    cache_name_exists(pathname, len, ignore_case))
 		return NULL;

 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
--
1.7.12.4.2.geb8c5b8.dirty
