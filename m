From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v3 03/13] t3700: Avoid interfering with the racy code
Date: Wed,  8 Aug 2012 13:17:51 +0200
Message-ID: <1344424681-31469-4-git-send-email-t.gummerer@gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 13:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz4Q5-0005W3-J0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 13:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab2HHL0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 07:26:47 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:36957 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044Ab2HHL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 07:26:28 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 299C94EFEB; Wed,  8 Aug 2012 13:18:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203078>

The new git racy code uses the mtime of cache-entries as smudge
marker for racily clean entries. The work of checking the file-system
if the entry really changed is offloaded to the reader. This interferes
with this test, because the entry is racily smudged and thus has
mtime 0.

To avoid interfering with the racy code, we use a time relative
to the time returned by time(3), instead of a time relative to
the mtime of the cache entries.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3700-add.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..829d36d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -184,7 +184,7 @@ test_expect_success 'git add --refresh with pathspec' '
 	echo >foo && echo >bar && echo >baz &&
 	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
 	echo "100644 $H 3	foo" | git update-index --index-info &&
-	test-chmtime -60 bar baz &&
+	test-chmtime =-60 bar baz &&
 	>expect &&
 	git add --refresh bar >actual &&
 	test_cmp expect actual &&
-- 
1.7.10.GIT
