From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive-tar: fix sanity check in config parsing
Date: Sun, 13 Jan 2013 18:42:01 +0100
Message-ID: <50F2F1E9.1040700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:42:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRZj-0002ha-B1
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab3AMRmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 12:42:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:37496 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab3AMRmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 12:42:05 -0500
Received: from [192.168.2.105] (p4FFDB71B.dip.t-dialin.net [79.253.183.27])
	by india601.server4you.de (Postfix) with ESMTPSA id E9F12182;
	Sun, 13 Jan 2013 18:42:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213392>

git archive supports passing generated tar archives through filter
commands like gzip.  Additional filters can be set up using the
configuration variables tar.<name>.command and tar.<name>.remote.

When parsing these config variable names, we currently check that
the second dot is found nine characters into the name, disallowing
filter names with a length of five characters.  Additionally,
git archive crashes when the second dot is omitted:

	$ ./git -c tar.foo=bar archive HEAD >/dev/null
	fatal: Data too large to fit into virtual memory space.

Instead we should check if the second dot exists at all, or if
we only found the first one.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c       | 2 +-
 t/t5000-tar-tree.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index d1cce46..093d10e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -335,7 +335,7 @@ static int tar_filter_config(const char *var, const char *value, void *data)
 	if (prefixcmp(var, "tar."))
 		return 0;
 	dot = strrchr(var, '.');
-	if (dot == var + 9)
+	if (dot == var + 3)
 		return 0;
 
 	name = var + 4;
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e7c240f..3fbd366 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -212,7 +212,8 @@ test_expect_success 'git-archive --prefix=olde-' '
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
 	git config tar.bar.command "tr ab ba" &&
-	git config tar.bar.remote true
+	git config tar.bar.remote true &&
+	git config tar.invalid baz
 '
 
 test_expect_success 'archive --list mentions user filter' '
-- 
1.8.0
