From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 2/4] verify-tag.c: ignore SIGPIPE around gpg invocation
Date: Sun, 23 Nov 2008 22:23:18 -0500
Message-ID: <1227497000-8684-3-git-send-email-deskinm@umich.edu>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
 <1227497000-8684-2-git-send-email-deskinm@umich.edu>
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 04:25:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4S4J-00061G-P6
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYKXDXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYKXDXc
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:23:32 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:20323 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYKXDX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:23:29 -0500
Received: by yw-out-2324.google.com with SMTP id 9so761603ywe.1
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=37Uk+L5YsLA7dv7CcbulXZF8Hk80I+9DpKWQal5sMT0=;
        b=u1OtlaZBI227cYrllGV2FZJSWkqqNS6K9mRyQKMJ+/hgZoWAO4RZlTefJ9HRyiiCiF
         aMceMAcIHSiPHb5kg5iJsaoik3FnC8JKetiBTCkzVQFcNeTNd85/xGStn4ZYKHgJqDAj
         F0v3NKiJ/n44ETrzLmL0DJrOXNZ4jr7NJwvAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=lrPT+/yK2Ts9Ix0BT5XimFw+tV/HCVqk4ihYTx49R/eZZrv9BaLYUCzvmk0MDvODy+
         IN6DDX1T6j6W2aFEbpA05CgGP+eLoMnvV7AhZZuDgWBAIRQm26YaDRoOvyosjOH/nPzn
         6TxEMa8GRRGAh3EChvdo8v7r8O1bdetL/2Qhk=
Received: by 10.151.113.5 with SMTP id q5mr5795446ybm.145.1227497008505;
        Sun, 23 Nov 2008 19:23:28 -0800 (PST)
Received: from localhost.localdomain ([152.160.57.162])
        by mx.google.com with ESMTPS id a13sm6706484rnc.12.2008.11.23.19.23.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 19:23:28 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.770.ga8394
In-Reply-To: <1227497000-8684-2-git-send-email-deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101583>

builtin-verify-tag.c already sets SIG_IGN for SIGPIPE before calling
verify_tag, but new callers of verify_tag_sha1 may not have modified the
signal handler, and shouldn't have to.  Save and restore the signal
handler for SIGPIPE around the invocation of gpg.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 verify-tag.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/verify-tag.c b/verify-tag.c
index c9be331..c3e35f3 100644
--- a/verify-tag.c
+++ b/verify-tag.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "object.h"
 #include "run-command.h"
+#include <signal.h>
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
@@ -17,6 +18,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	char path[PATH_MAX], *eol;
 	size_t len;
 	int fd, ret;
+	sighandler_t save_handle;
 
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
@@ -40,8 +42,10 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	gpg.argv = args_gpg;
 	gpg.in = -1;
 	args_gpg[2] = path;
+	save_handle = signal(SIGPIPE, SIG_IGN);
 	if (start_command(&gpg)) {
 		unlink(path);
+		signal(SIGPIPE, save_handle);
 		return error("could not run gpg.");
 	}
 
@@ -50,6 +54,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	ret = finish_command(&gpg);
 
 	unlink(path);
+	signal(SIGPIPE, save_handle);
 
 	return ret;
 }
-- 
1.6.0.4.770.ga8394
