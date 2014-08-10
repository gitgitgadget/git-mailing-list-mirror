From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] remote.c: don't leak the base branch name in format_tracking_info
Date: Sun, 10 Aug 2014 21:43:33 +0200
Message-ID: <1407699813-1460-1-git-send-email-stefanbeller@gmail.com>
References: <20140810193242.GA9886@peff.net>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sun Aug 10 21:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGZ1o-0008NF-NC
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 21:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbaHJTnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 15:43:37 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:41542 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaHJTng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 15:43:36 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so7667864wes.11
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wqjn2I8Yl/Mo44wxpJDuoCpfXEzcgIR/fT2sq1/W8TA=;
        b=qo51agdrrONYVODPA5nDfmgr5RkhNU6XKH0U366kEtqNgtIT0rIPCORE4qbBZpG14I
         k52vpy6QMTjnCMAWb1zF/MM6MZCMlTxCcqTEPHhlaCa8PO0oUNRd1B6c0fdrt86P/17l
         Piw3QOEHBEEBEmtajlUc73Ao/QCkbYjwYvGZbKL/RAZhOoJXqUvbJ1epzEY/O53Xd8FR
         JjW8edk/sq/LcfO+T9AUxxRJc0p8VJU6XFPHLyyDRhr9b2GeMnkM5ivF44UNGNzQRLuw
         bv7SZxkyC0UY0cyPmVY6iG8RotssZZdsuIWuM04DUFk3EuWdStEKiY81P6U1GGELB7KA
         ijTA==
X-Received: by 10.194.188.46 with SMTP id fx14mr5580716wjc.112.1407699814997;
        Sun, 10 Aug 2014 12:43:34 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id ca8sm34266289wjc.0.2014.08.10.12.43.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Aug 2014 12:43:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
In-Reply-To: <20140810193242.GA9886@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255102>

Found by scan.coverity.com (Id: 1127809)

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 3d6c86a..894db09 100644
--- a/remote.c
+++ b/remote.c
@@ -1920,7 +1920,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 int format_tracking_info(struct branch *branch, struct strbuf *sb)
 {
 	int ours, theirs;
-	const char *base;
+	char *base;
 	int upstream_is_gone = 0;
 
 	switch (stat_tracking_info(branch, &ours, &theirs)) {
@@ -1936,8 +1936,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		break;
 	}
 
-	base = branch->merge[0]->dst;
-	base = shorten_unambiguous_ref(base, 0);
+	base = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -1983,6 +1982,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 			strbuf_addf(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
+	free(base);
 	return 1;
 }
 
-- 
2.1.0.rc2
