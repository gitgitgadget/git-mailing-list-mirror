From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] stash: It looks like a stash, but doesn't quack like a stash...
Date: Tue,  3 Aug 2010 10:59:39 +1000
Message-ID: <1280797179-14161-1-git-send-email-jon.seymour@gmail.com>
Cc: jon.seymour@gmail.com, ams@toroid.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 03:01:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og5sP-000446-IE
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 03:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0HCBA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 21:00:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38610 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab0HCBA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 21:00:58 -0400
Received: by pwi5 with SMTP id 5so1499877pwi.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WSLU4U+AnK1Ju8YbT3/SM0sO5vkf/jKxS/ze6xpEDs4=;
        b=WPR+h1t2/5jO/SInUszxGIJdxBMSbDb2zpYnGblHEQlEam560m3elZ1lmW7jnH5Tkd
         8ou9qcZ6fSuZtFwXUxOsfKb2fpr03cUB7fkfgdy57xaJ3zeDRW1DAyoW6E7+Q3w9aEL/
         /wBUxNlTNOB5hPW0UuXeSyHYeCq2VVFc6ADEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BUe1qUwoFZbToXAH+9JYm3OkK3pCn3lwEOQ06NzYUmSWeKAKl8rS+VZdwExqqLuhwI
         OYc4Hm51IVLrH6abczXNKHvIOXdt9+6Dogx5VXy55scrb4IUam2rEjV18NBEi+Gk27R4
         zp61NyFoRZHzqtbmAwwX6MvXgvVmdzxr/G7M0=
Received: by 10.114.109.10 with SMTP id h10mr8240456wac.132.1280797258062;
        Mon, 02 Aug 2010 18:00:58 -0700 (PDT)
Received: from localhost.localdomain ([120.16.54.241])
        by mx.google.com with ESMTPS id q6sm12468014waj.10.2010.08.02.18.00.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 18:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152484>

In particular, a stash created with git stash create cannot be used as
an argument to git stash branch because of two separate reasons.

1. a pre-condition assumes that there is always a stash on the stack when git stash branch is called,
which is not necessarily true

2. the cleanup code assumes the specified stash is a stash reference, rather than an arbitrary commit.

The tests test_expect_failure tests in this patch demonstrate these issues.
---
 t/t3903-stash.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..7fea2a2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,32 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_failure 'stash branch from arbitrary stash ref when there are no stash references' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	test_when_finished "git reset --hard HEAD && git checkout master" &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
+	test $(git ls-files --modified) -eq 1
+'
+
+test_expect_failure 'stash branch from arbitrary stash ref fails even if there is a stash' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	echo bar >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
+	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test $(git ls-files --modified) -eq 1
+'
+
 test_done
-- 
1.7.2
