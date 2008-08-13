From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Fix escaping of glob special characters in pathspecs
Date: Wed, 13 Aug 2008 15:34:34 -0700
Message-ID: <1218666874-85937-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 00:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOwO-0001kC-Kj
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYHMWeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 18:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYHMWeh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 18:34:37 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:49426 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753331AbYHMWeh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 18:34:37 -0400
Received: from localhost.localdomain (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id BA564185DD7;
	Wed, 13 Aug 2008 15:34:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.1.g9002abb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92288>

match_one implements an optimized pathspec match where it only uses
fnmatch if it detects glob special characters in the pattern. Unfortunately
it didn't treat \ as a special character, so attempts to escape a glob
special character would fail even though fnmatch() supports it.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 dir.c          |    2 +-
 t/t3700-add.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 29d1d5b..109e05b 100644
--- a/dir.c
+++ b/dir.c
@@ -54,7 +54,7 @@ int common_prefix(const char **pathspec)
 
 static inline int special_char(unsigned char c1)
 {
-	return !c1 || c1 == '*' || c1 == '[' || c1 == '?';
+	return !c1 || c1 == '*' || c1 == '[' || c1 == '?' || c1 == '\\';
 }
 
 /*
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7d123d1..77a782c 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -222,4 +222,12 @@ test_expect_success 'git add (add.ignore-errors = false)' '
 	! ( git ls-files foo1 | grep foo1 )
 '
 
+test_expect_success 'git add '\''fo\?bar'\'' ignores foobar' '
+	git reset --hard &&
+	touch fo\?bar foobar &&
+	git add '\''fo\?bar'\'' &&
+	git ls-files fo\?bar | grep -F fo\?bar &&
+	! ( git ls-files foobar | grep foobar )
+'
+
 test_done
-- 
1.6.0.rc3.1.g9002abb
