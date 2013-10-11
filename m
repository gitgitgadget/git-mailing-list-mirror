From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] clone --branch: refuse to clone if upstream repo is empty
Date: Fri, 11 Oct 2013 18:49:02 +0200
Message-ID: <1381510142-3026-1-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMOLRt=kJPNhNDSfY_oMV90Xp=_wY=yf0OhiAcaShhWLCnA@mail.gmail.com>
Cc: stefanbeller@googlemail.com, gitster@pobox.com, jrnieder@gmail.com,
	robert.mitwicki@opensoftware.pl, pclouds@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 18:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUftq-0007nP-Q0
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 18:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab3JKQtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 12:49:10 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:37665 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3JKQtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 12:49:09 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so1724548bkb.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hdQ4S0SN3j0mj54Koiy15qYCAPrIBRjLlKkCjL/y8o=;
        b=s+ds1/Vk5QfceekU1uRyipFblELAfveetMWj4b+yzgGebGADlZqR056FHqz9P5Dc6S
         uAwxQfHVHKh+HJFThhcaAgo2u6W/zBrr9Xx2WDMm/dXhC+1ZluUmfkwuBJTMs8l9ceFS
         gqWMh2r8cvNDEzE1rfTniJr2cs3+qBbvHVOmLf4Q7w1+2YBVM2Vrt7GZCkD/WB4hqvBj
         ILeneK7FczHVBJ+HmFv+5iiJjcqNXfQeNKXGp5XwYnyPaw5u04FNWsh+DmVRQR7T7ji7
         +kv5xrf26rstclYLiITRxC66tmR3oxSvVoOCuZyAkJ5kNx6Ou/LUr78puzO57lg6DW4+
         3MXQ==
X-Received: by 10.205.86.199 with SMTP id at7mr18899655bkc.9.1381510148013;
        Fri, 11 Oct 2013 09:49:08 -0700 (PDT)
Received: from localhost (dslb-178-005-121-004.pools.arcor-ip.net. [178.5.121.4])
        by mx.google.com with ESMTPSA id kk2sm31049884bkb.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 09:49:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
In-Reply-To: <CAN0XMOLRt=kJPNhNDSfY_oMV90Xp=_wY=yf0OhiAcaShhWLCnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235912>

Since 920b691 (clone: refuse to clone if --branch
points to bogus ref) we refuse to clone with option
"-b" if the specified branch does not exist in the
(non-empty) upstream. If the upstream repository is empty,
the branch doesn't exist, either. So refuse the clone too.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/clone.c         | 4 ++++
 t/t5706-clone-branch.sh | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ca3eb68..5af386e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -945,6 +945,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			our_head_points_at = remote_head_points_at;
 	}
 	else {
+		if (option_branch)
+			die(_("Remote branch %s not found in upstream %s"),
+					option_branch, option_origin);
+
 		warning(_("You appear to have cloned an empty repository."));
 		mapped_refs = NULL;
 		our_head_points_at = NULL;
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
index 56be67e..6e7a7be 100755
--- a/t/t5706-clone-branch.sh
+++ b/t/t5706-clone-branch.sh
@@ -20,7 +20,9 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
-	 git checkout master)
+	 git checkout master) &&
+	mkdir empty &&
+	(cd empty && git init)
 '
 
 test_expect_success 'vanilla clone chooses HEAD' '
@@ -61,4 +63,8 @@ test_expect_success 'clone -b with bogus branch' '
 	test_must_fail git clone -b bogus parent clone-bogus
 '
 
+test_expect_success 'clone -b not allowed with empty repos' '
+	test_must_fail git clone -b branch empty clone-branch-empty
+'
+
 test_done
-- 
1.8.4.652.g0d6e0ce
