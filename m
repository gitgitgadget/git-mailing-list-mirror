From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] rev-parse: fix --verify to error out when passed junk after
 a good rev
Date: Sat, 26 Apr 2008 15:19:29 +0200
Message-ID: <20080426151929.819ced3e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 15:15:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpkFQ-0005yu-Ck
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 15:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYDZNO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYDZNO0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 09:14:26 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33575 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbYDZNOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 09:14:25 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2D19F1AB2AF
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 15:14:24 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 021BF1AB2C5
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 15:14:23 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80373>

Before this patch something like:

$ git rev-parse --verify <good-rev> <junk>

worked whatever junk was as long as <good-rev> could be parsed
correctly.

This patch makes "git rev-parse --verify" error out when passed
any junk after a good rev.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-parse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

	With this patch something like:

	$ git rev-parse --verify <good1> <good2>

	will still fail.

	For example:

	$ git rev-parse --verify v1.5.5 v1.4.0
	9d831805195ba40b62f632acc6bb6e53d3ec9ee1
	120530fb2e10679d9095e278c95c0e98c96f3080
	fatal: Needed a single revision

	but it failed like that before.

	I don't know if I should make it work.  

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 9384a99..0e59707 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -576,11 +576,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			show_rev(REVERSED, sha1, arg+1);
 			continue;
 		}
+		if (verify)
+			die_no_single_rev(quiet);
 		as_is = 1;
 		if (!show_file(arg))
 			continue;
-		if (verify)
-			die_no_single_rev(quiet);
 		verify_filename(prefix, arg);
 	}
 	show_default();
-- 
1.5.5.1.164.g3d51ee.dirty
