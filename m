From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 4/5] fsck: add a few committer name tests
Date: Thu, 28 Jul 2011 11:44:03 +0600
Message-ID: <1311831844-13123-5-git-send-email-divanorama@gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLi-0004L5-RQ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab1G1Fla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61460 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab1G1FlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:20 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so916401fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5aERBlHBWKcow5GGCxI4s3BjxPn2Wl7I9bzYaC5wxYw=;
        b=o3RxWj9eZQLdsZuIWurnsX8VA99HWphPm3BoC9nX/TeUo/EfQxwFjfh28r9PpAW328
         I+9Y52q63cbqOL7dLzVnWshF3slTwmptILrZlUF/CKsN5UnZfhYp5wuit7SIdTFdt5af
         g6UMb6aHzNpN56K+JMVtSDScqm9svpAjw9nxA=
Received: by 10.205.65.9 with SMTP id xk9mr164160bkb.388.1311831680221;
        Wed, 27 Jul 2011 22:41:20 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178038>

fsck reports "missing space before <email>" for committer string equal
to "name email>". It'd be nicer to say "missing < in email" or "name is
bad" (has > in it). The second option looks a bit better, add such a
failing test.

For "name> <email>" no error is reported. Looks like a bug, so add
such a failing test."

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 t/t1450-fsck.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bb01d5a..fc7ee8e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -110,6 +110,30 @@ test_expect_success 'email with embedded > is not okay' '
 	grep "error in commit $new" out
 '
 
+test_expect_failure 'missing < email delimiter is reported nicely' '
+	git cat-file commit HEAD >basis &&
+	sed "s/<//" basis >bad-email-2 &&
+	new=$(git hash-object -t commit -w --stdin <bad-email-2) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new.* - bad name" out
+'
+
+test_expect_failure '> in name is reported' '
+	git cat-file commit HEAD >basis &&
+	sed "s/ </> </" basis >bad-email-3 &&
+	new=$(git hash-object -t commit -w --stdin <bad-email-3) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
-- 
1.7.3.4
