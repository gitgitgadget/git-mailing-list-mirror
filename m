From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 06/16] t3700: sleep for 1 second, to avoid interfering with the racy code
Date: Thu,  2 Aug 2012 13:01:56 +0200
Message-ID: <1343905326-23790-7-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBT-00056m-Jc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab2HBLDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40752 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:00 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331137eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qXLw67hB96t7PyqM5hg6Q1z0IC3UvTma3h+MGFDOElE=;
        b=YMPXCfsuqr/m0CSkKkAb0HLD33Vs/BxJH4zmi04eUz2uCcINjzJi+5XIY+2p11OSTz
         oB7mRQi5h8mrcco5rL1zN/8kPCZZu/5YX3vtjWxyzgzlTq7XreJXGPQDcDuh4rSk7xUL
         nDBBoaGOg9oLflwA5AI1bXjNViLzLitScJB4GPhe2IqvO7v4SBxFwQt2tEC5OiHhZ+xJ
         bVyLPLjxlJoT4VkZzrxj+lGuECogCSNBzyl7eB8EvK8cljf5Ss2t8nLmBinwYK2LNYgL
         Y/bFkiQT73EcX+GP0xDiSI1jNHf0CxEPk5t5c4eNQi5aA2Buinbwoz944AnJkSx0Y4Y/
         5Z9A==
Received: by 10.14.182.134 with SMTP id o6mr12748435eem.26.1343905380029;
        Thu, 02 Aug 2012 04:03:00 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id v5sm16441915eel.6.2012.08.02.04.02.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202755>

The new git racy code uses the mtime of cache-entries to smudge
a racy clean entry, and loads the work, of checking the file-system
if the entry has really changed, off to the reader. This interferes
with this test, because the entry is racily smudged and thus has
mtime 0. We wait 1 second to avoid smudging the entry and getting
correct test results.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3700-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..4d70805 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -184,6 +184,7 @@ test_expect_success 'git add --refresh with pathspec' '
 	echo >foo && echo >bar && echo >baz &&
 	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
 	echo "100644 $H 3	foo" | git update-index --index-info &&
+	sleep 1 &&
 	test-chmtime -60 bar baz &&
 	>expect &&
 	git add --refresh bar >actual &&
-- 
1.7.10.886.gdf6792c.dirty
