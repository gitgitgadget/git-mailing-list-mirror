From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/22] checkout: teach check_linked_checkout() about symbolic link HEAD
Date: Fri, 17 Jul 2015 19:00:03 -0400
Message-ID: <1437174017-81687-9-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:02:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdt-0002hL-TH
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbbGQXCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:02:04 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35914 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbbGQXBU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:20 -0400
Received: by igbij6 with SMTP id ij6so47744421igb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMTQAKuOZA3sjkgbv4tV7zm7LULEHYUKGiz1i1lDcI0=;
        b=WAmhBLFC37P2FqVg3Z4SIWyfgKuQ4SqSEeL52ffw6Pi/laMUsr2O7uxmKYScfwiNT7
         IERti1BMF69CcnSruJ8zolXuxFLIHMrLWiIOEvKjVzSV40FBmwCq83s/MWj+lNLoJkAn
         N2AT1aKNfThg2aKVslEFf9jWuW5YSrUmZ5PozUMeRT685hXBMdmEbMopOPRaWzIA2av+
         vL4urxeC3aj+HnX2Ej48B6Y9CtjWB/hF9F835q4Tej2Cdfz/8AcEKAhzkH5F0e8PHZOy
         dJsUifncYIsjg2eHAXufg0tCgW3HrS57l2aDltuBFoa1tXoTs7QWaQINARSmrajK941V
         8RVQ==
X-Received: by 10.107.32.73 with SMTP id g70mr23701398iog.23.1437174079548;
        Fri, 17 Jul 2015 16:01:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.18
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274146>

check_linked_checkout() only understands symref-style HEAD (i.e. "ref:
refs/heads/master"), however, HEAD may also be a an actual symbolic link
(on platforms which support it). To accurately detect if a branch is
checked out elsewhere, it needs to handle symbolic link HEAD, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

 builtin/checkout.c      | 6 +++++-
 t/t2025-worktree-add.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6f4e492..f04dcaa 100644
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
