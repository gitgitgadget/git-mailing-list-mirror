From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sat, 15 Nov 2014 08:26:18 +0100
Message-ID: <1416036379-4994-2-git-send-email-mhagger@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpXkx-0002FF-GP
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288AbaKOH0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:26:44 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42052 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752003AbaKOH0n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 02:26:43 -0500
X-AuditID: 12074411-f79856d000000bd5-3b-546700280920
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E2.DF.03029.82007645; Sat, 15 Nov 2014 02:26:32 -0500 (EST)
Received: from michael.fritz.box (p5DDB2373.dip0.t-ipconnect.de [93.219.35.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAF7QTam011566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 15 Nov 2014 02:26:31 -0500
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqKvJkB5i0Mtt0XWlm8miofcKs8XC
	f0fZLW6vmM9ssb8pyYHV4+/7D0weO2fdZfe4eEnZ4/MmOY/mKedZA1ijuG2SEkvKgjPT8/Tt
	ErgzHjbOYS7Yz11x4fdP9gbG9ZxdjJwcEgImEt3dS9ggbDGJC/fWA9lcHEIClxklXm+dwA7h
	nGCSeP53CytIFZuArsSinmYmEFtEQE1iYtshFpAiZoGpjBJ7Hi0Hcjg4hAUCJV794AapYRFQ
	ldj79CPYBl4BZ4m1z7czQ2yTk9g7eTULiM0p4CLRMeslO4gtBFSze/0n9gmMvAsYGVYxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASU4A7GGSflDjEKcDAq8fBemJQWIsSa
	WFZcmXuIUZKDSUmUt+AOUIgvKT+lMiOxOCO+qDQntfgQowQHs5II75HvQDnelMTKqtSifJiU
	NAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvtP9AjYJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGg2IgvBkYHSIoHaO+NfyB7iwsSc4GiEK2nGBWlxHllQOYKgCQySvPgxsLS
	xCtGcaAvhXmLQap4gCkGrvsV0GAmoMGMx1JBBpckIqSkGhhXqJj7mplvU7j/UUgwY90CnT4O
	4RjeEE02qw6dP9Z7dKfcsmtYoBT2LXum96wMnR/iLTNq9kX3P4qtuqX+rGPH/EblxHvWHlf+
	cmxcdEg38tnFzr2mF7lnsT9rF4+bX/zau1Dd9kH5hKmPRKxYAt3aAy9a3XBvv30w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since time immemorial, the test of whether to set "core.filemode" has
been done by trying to toggle the u+x bit on $GIT_DIR/config and then
testing whether the change "took". It is somewhat odd to use the
config file for this test, but whatever.

The test code didn't set the u+x bit back to its original state
itself, instead relying on the subsequent call to git_config_set() to
re-write the config file with correct permissions.

But ever since

    daa22c6f8d config: preserve config file permissions on edits (2014-05-06)

git_config_set() copies the permissions from the old config file to
the new one. This is a good change in and of itself, but it interacts
badly with create_default_files()'s sloppiness, causing "git init" to
leave the executable bit set on $GIT_DIR/config.

So change create_default_files() to reset the permissions on
$GIT_DIR/config after its test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..95ca5e4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
 		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode != st2.st_mode);
+		chmod(path, st1.st_mode);
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-- 
2.1.1
