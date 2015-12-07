From: "Eric N. Vander Weele" <ericvw@gmail.com>
Subject: [PATCH] filter-branch: pass tag name via stdin without newline
Date: Sun,  6 Dec 2015 17:17:26 -0800
Message-ID: <1449451046-19752-1-git-send-email-ericvw@gmail.com>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 02:17:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5kQp-000671-V3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 02:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbbLGBRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 20:17:31 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35268 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbLGBRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 20:17:30 -0500
Received: by pfu207 with SMTP id 207so55676898pfu.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WFoI/wPiXDbRp2O8iGPBP0kS9/G+soijeDdzhmznm9U=;
        b=GJS6FfTZ4+v/B/HY+k9AZ58KdRjN+X45dNy+hkx1SY1/v1tCoawH0UjCTjXh/kKL7a
         ZDetnNuF9F/gVzO24kBIpMxEw8xh2/hBTkRrEiux2RwQemrEZwZCwfMLaUI3ZNJzGQv1
         rxW+k1FZcrPhUsnk1MzeOUsag1KAXyxfxWosbxeUAdmFyLHtPBpKfEkHkZYYkAjOd9vH
         IAU4Z4zMtv3NEgGOfTV6urX/MtPpl1snu17dGMKWSD7wg1HJ+NwCoJ0Yl9RyzCFNJLHL
         qWW/hVMaf8j9r+pJvIUdkPDP8ikZZ0xjGtLPhWGEQJbFToPWRQm1NCLKY3MVNevYy9m7
         /81g==
X-Received: by 10.98.13.211 with SMTP id 80mr39391851pfn.112.1449451050428;
        Sun, 06 Dec 2015 17:17:30 -0800 (PST)
Received: from localhost.localdomain (c-73-162-222-93.hsd1.ca.comcast.net. [73.162.222.93])
        by smtp.gmail.com with ESMTPSA id sv8sm1249524pab.13.2015.12.06.17.17.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Dec 2015 17:17:29 -0800 (PST)
X-Mailer: git-send-email 2.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282071>

"git filter-branch --tag-name-filter" fails when the user-provided
command attempts to trivially append text to the originally tag name,
passed via stdin, due to an unexpected newline ('\n').  The newline is
introduced due to "echo" piping the original tag name to the
user-provided tag name filter command.

The only portable usage of "echo" is without any options and escape
sequences.  Therefore, replacing "echo" with "printf" is a suitable,
POSIX compliant alternative.

Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
---
 git-filter-branch.sh     | 2 +-
 t/t7003-filter-branch.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 98f1779..949cd30 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -503,7 +503,7 @@ if [ "$filter_tag_name" ]; then
 		new_sha1="$(cat "../map/$sha1")"
 		GIT_COMMIT="$sha1"
 		export GIT_COMMIT
-		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
+		new_ref="$(printf "$ref" | eval "$filter_tag_name")" ||
 			die "tag name filter failed: $filter_tag_name"
 
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 869e0bf..0db6808 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -269,6 +269,11 @@ test_expect_success 'Tag name filtering retains tag message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Tag name filter does not pass tag ref with newline' '
+	git filter-branch -f --tag-name-filter "cat && printf "_append"" -- A &&
+	git rev-parse A_append > /dev/null 2>&1
+'
+
 faux_gpg_tag='object XXXXXX
 type commit
 tag S
-- 
2.6.3
