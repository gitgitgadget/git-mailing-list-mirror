From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/20] checkout: teach check_linked_checkout() about symbolic link HEAD
Date: Thu, 16 Jul 2015 04:20:13 -0400
Message-ID: <1437034825-32054-9-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQY-0000Eb-AE
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbbGPIU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:20:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36605 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbbGPIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:55 -0400
Received: by igbij6 with SMTP id ij6so8312508igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hcdi9IaRgBaLh0jwdeGvW7jlKEQMUTaQ6/BOhRQACGE=;
        b=AxjuvxPgoK7b9fBAi8MHVWl8fJLaZ3+L8nEP17hzTTIaIu9X3vIqN6EhnitZ+SImmW
         uMFAKyKXGj8TsuxM2Qn/EOtRnpWkXk2CrsLH+fOqJGwCPRmJ8+JDo/OCsoMbVLY1E1HY
         8nNMyMnVijyQAwAOKwTZz6AGjkbQyqMQtPYTXb/RTeOHOPDu2XQi0Wy5YxuzSX5pwNU6
         hH4IUYbDRAyjka1wViUUtxnmkB69KBg5y7nevPb6EFYhnsz1gCoTs6/HxlzRfjJO4K/a
         Y9bYHeBMuNPSH6yKaP4Swimmg29LHbqMfTqMv9aTVzIpZEufxwTYT6q08kK4NtgsU6YW
         xn7Q==
X-Received: by 10.107.132.7 with SMTP id g7mr10012571iod.9.1437034854477;
        Thu, 16 Jul 2015 01:20:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274017>

check_linked_checkout() only understands symref-style HEAD (i.e. "ref:
refs/heads/master"), however, HEAD may also be a an actual symbolic link
(on platforms which support it). To accurately detect if a branch is
checked out elsewhere, it needs to handle symbolic link HEAD, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v2.

The new test's title intentionally employs slightly odd grammar to match
the grammar of its brother test just above. Test title grammar could be
cleaned up in a separate patch, but the current series is already overly
long.

 builtin/checkout.c      | 6 +++++-
 t/t2025-worktree-add.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3487712..3326aa8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -889,7 +889,11 @@ static void check_linked_checkout(const char *branch, const char *id)
 	else
 		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	if (!strbuf_readlink(&sb, path.buf, 0)) {
+		if (!starts_with(sb.buf, "refs/") ||
+		    check_refname_format(sb.buf, 0))
+			goto done;
+	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
 	    starts_with(sb.buf, "ref:")) {
 		strbuf_remove(&sb, 0, strlen("ref:"));
 		strbuf_trim(&sb);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index ead8aa2..9e30690 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -83,6 +83,14 @@ test_expect_success 'die the same branch is already checked out' '
 	)
 '
 
+test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
+	head=$(git -C there rev-parse --git-path HEAD) &&
+	ref=$(git -C there symbolic-ref HEAD) &&
+	rm "$head" &&
+	ln -s "$ref" "$head" &&
+	test_must_fail git -C here checkout newmaster
+'
+
 test_expect_success 'not die the same branch is already checked out' '
 	(
 		cd here &&
-- 
2.5.0.rc2.378.g0af52e8
