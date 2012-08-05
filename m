From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid interfering with the racy code
Date: Sun,  5 Aug 2012 23:49:03 +0200
Message-ID: <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8iv-0001x2-M4
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab2HEVuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51564 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab2HEVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:56 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so648692eaa.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SOT/2gGKvQOQkrBbdrZNZkQTRAIc7G3AEsiIwhY0Oqw=;
        b=GmrxToj9CCUClOgtU9FJ8dLB1CZUr1xu6r1gDmhqj7RMhBaPCYznUQi9G58e6D1rwE
         04/GQByRTngru6AoPcdNzSIa31DMFtntedizTdT9QLD5PMvl/KSccGU8WQ5pXBqkGsmu
         o64QVjktF7mpz+84x/afDmiNiu1vtBcp4mIyVKlo+zBudb54PC6JnJPG7Y1fcXKwkvl5
         rjFkDQ9yNE5ujh5Pzr+hYtVjwFzKDkdm29rjT09m3ktemHgGjKUvGT9T2GB4o5NGQQZx
         6ein3+qe6NV+0k4Zmzq8k+3b3oYIfVkpid0xrwXpKYf7m0pkOvk5Ex0hhad02GSvwGcY
         cbJw==
Received: by 10.14.219.198 with SMTP id m46mr10342254eep.18.1344203396136;
        Sun, 05 Aug 2012 14:49:56 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id o47sm42322291eem.0.2012.08.05.14.49.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202929>

The new git racy code uses the mtime of cache-entries to smudge
a racy clean entry, and loads the work, of checking the file-system
if the entry has really changed, off to the reader. This interferes
with this test, because the entry is racily smudged and thus has
mtime 0. We wait 1 second to avoid smudging the entry and getting
correct test results.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3700-add.sh |    1 +
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
1.7.10.GIT
