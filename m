From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] t7502-commit: add tests for summary output
Date: Mon, 24 May 2010 17:47:30 +0800
Message-ID: <1274694452-4200-2-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 11:48:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUGb-0007Tl-NN
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab0EXJrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:47:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40284 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0EXJrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:47:51 -0400
Received: by pwi2 with SMTP id 2so446247pwi.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/Upu2yrCwyt3SP5oVpOFgPJSI08v0UlrjGnmegYuwa0=;
        b=AqhgmiiLoz0rp+xDgkA7BprqWHkpzcq4B7k61GJt3la5GbPeYVhXGTyDYeVgmedAHm
         3xqrHfbdpOK0m+cdDHvWXxQpXehOnAP9oiFuR4qNa7oIcvRWxiDQ7Bf5vD3ZwuOn7/yh
         x7ubtiCDYVEheNYE1IqJm6URR3xHgotj+FFao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wgM6eIOzCqXcyvSPoM8IbmOWeP0VoMXtAjxyvp/kP/JxknaPqZhoFOSrsf5zszsUKp
         zmICUDbxP3VG4iA8UWSJMHmb9OU7E2UI8EwexfdIU4nJwKYyiyoPx3nawMGxOOiDDehW
         EBUOdUAtR9hblA+iQMt7xwLOKHWAAjnTmVokM=
Received: by 10.115.85.21 with SMTP id n21mr4642154wal.111.1274694469581;
        Mon, 24 May 2010 02:47:49 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id n29sm37041273wae.4.2010.05.24.02.47.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 02:47:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
In-Reply-To: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147616>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7502-commit.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 844fb43..589e8e6 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,8 +4,44 @@ test_description='git commit porcelain-ish'
 
 . ./test-lib.sh
 
+# Arguments: [<prefix] [<commit message>]
+check_summary_oneline() {
+	test_tick &&
+	git commit -m "$2" | head -1 > act &&
+
+	# branch name
+	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
+
+	# append the "special" prefix, like "root-commit", "detached HEAD"
+	if test -n "$1"
+	then
+		SUMMARY_PREFIX="$SUMMARY_PREFIX ($1)"
+	fi
+
+	# abbrev SHA-1
+	SUMMARY_POSTFIX="$(git log -1 --pretty='format:%h')"
+	echo "[$SUMMARY_PREFIX $SUMMARY_POSTFIX] $2" >exp &&
+
+	test_cmp exp act
+}
+
+test_expect_success 'output summary format' '
+
+	echo new >file1 &&
+	git add file1 &&
+	check_summary_oneline "root-commit" "initial" &&
+
+	echo change >>file1 &&
+	git add file1 &&
+	check_summary_oneline "" "a change"
+'
+
 test_expect_success 'the basics' '
 
+	# this is needed for the "partial removal" test to pass
+	git rm file1 &&
+	git commit -m "cleanup" &&
+
 	echo doing partial >"commit is" &&
 	mkdir not &&
 	echo very much encouraged but we should >not/forbid &&
-- 
1.7.1.189.g07419
