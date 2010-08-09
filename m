From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] builtin/checkout: handle -B from detached HEAD correctly
Date: Tue, 10 Aug 2010 00:52:26 +0800
Message-ID: <1281372746-5088-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:52:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVal-0006jg-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab0HIQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:52:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41682 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab0HIQwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:52:46 -0400
Received: by pvg2 with SMTP id 2so817692pvg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MHXM2KeSBR893lm/rAzEgMwfy23vG6S1Q1/kP0IXA4A=;
        b=Dd/bcHMgaQYeMXkABunWYYOgg7NFLe4VjOzCcqjHGbJfQb00PASba8m01kMdYy5sI1
         +iHDGsmR0M7cOIJxqDJqvygmAlZV2I9pwsH+3ZAH+w/kAejLNuhN+Evg9+DOwQBNmjDQ
         bXj2GFCvJrFE3qJGdwk7QzKQd6DzqMYs0hA/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=K92jI8zGoIvnaelixEGK6ZG5XIQut6KYuPhvlj0Qpzv3NAWNa4NM4DecyyMMpV0u60
         PFVzKgPKGLL/CW+eAmFbEPS9e/9EWcapQ5Jl0rJlQOwYFTYd7CVNQQREPuGVkQVqQL9F
         x/sfgIuPfVLfbum4FT9qAgCBsMYThI+DTos1A=
Received: by 10.114.102.3 with SMTP id z3mr18852301wab.71.1281372762761;
        Mon, 09 Aug 2010 09:52:42 -0700 (PDT)
Received: from localhost.localdomain (cm99.zeta153.maxonline.com.sg [116.87.153.99])
        by mx.google.com with ESMTPS id n32sm10730315wag.23.2010.08.09.09.52.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 09:52:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.57.ga5ce7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152984>

Ensure that strcmp() isn't called when head is null.

Previously we were getting segfaults when checkout -B was done from a
detached HEAD.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Junio, this goes on top of the 'tc/checkout-B' series.

 branch.c                   |    2 +-
 t/t2018-checkout-branch.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index 2ab42aa..93dc866 100644
--- a/branch.c
+++ b/branch.c
@@ -159,7 +159,7 @@ void create_branch(const char *head,
 			dont_change_ref = 1;
 		else if (!force)
 			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && !strcmp(head, name))
+		else if (!is_bare_repository() && head && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing = 1;
 	}
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 1caffea..fa69016 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -124,6 +124,12 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '

+test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
+	git checkout $(git rev-parse --verify HEAD) &&
+
+	do_checkout branch2 "" -B
+'
+
 test_expect_success 'checkout -B to an existing branch with an explicit ref resets branch to that ref' '
 	git checkout branch1 &&

--
1.7.2.1.57.ga5ce7c
