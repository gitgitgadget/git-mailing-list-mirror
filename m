From: David Turner <dturner@twopensource.com>
Subject: [PATCH] fix flaky untracked-cache test
Date: Mon, 19 Oct 2015 15:48:15 -0400
Message-ID: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, larsxschneider@gmail.com,
	tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Oct 19 21:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoGPz-00044N-N9
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbbJSTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 15:48:23 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33597 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbJSTsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 15:48:22 -0400
Received: by qgeo38 with SMTP id o38so123906123qge.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 12:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6kRqgkYKdAF6/Fsklba2kFw/3vHmuzzMkokQ18Pk0lU=;
        b=FBl3pMfb6ok1ziGpycf1E4A8xurcOp97uSDDrbwpIWIjnYZ82uKM+s8Di8ZKTTyaEi
         XVyqPHKYYwaf0rXvcw/YCaKiUxmZ9vSEjgMSurRYckqKkLXyI/ucfNvocz4WbYMuOj3Q
         6wNaELdappeI5j/90fAREjJlbEfdVKW1kqrZpkplVYq20eOdJBVGctqHxtO6DKePBrYs
         UZLK6XZ8TZrU/RfvHT43wlihfc3cqlT0t8WtW9GY5AOSpM6rUF4o9G+97PGXuN+Fku4B
         IXLnhnvi8KkM3sf68bGjIehjpMUGg6ipg1zPWP1y+AetUCcHRjo3LzNWoZmvCDiipjz4
         phOQ==
X-Gm-Message-State: ALoCoQmOqNvs5N75/dAe65oGdGatpCgA5426SyYWxQBjRzNv1/u3qjOIt2F4nsWPDCe35vijZ2nk
X-Received: by 10.140.98.206 with SMTP id o72mr13979447qge.2.1445284102201;
        Mon, 19 Oct 2015 12:48:22 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i21sm15007210qkh.48.2015.10.19.12.48.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 12:48:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279889>

Dirty the test worktree's root directory, as the test expects.

When testing the untracked-cache, we previously assumed that checking
out master would be sufficient to mark the mtime of the worktree's
root directory as racily-dirty.  But sometimes, the checkout would
happen at 12345.999 seconds and the status at 12346.001 seconds,
meaning that the worktree's root directory would not be racily-dirty.
And since it was not truly dirty, occasionally the test would fail.
By making the root truly dirty, the test will always succeed.

Tested by running a few hundred times.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t7063-status-untracked-cache.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 37a24c1..0e8d0d4 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -412,7 +412,9 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo two bis >done/two &&
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
-	echo five >done/five # five is not gitignored
+	echo five >done/five && # five is not gitignored
+	echo test >base && #we need to ensure that the root dir is touched
+	rm base
 '
 
 test_expect_success 'test sparse status with untracked cache' '
-- 
2.4.2.644.g97b850b-twtrsrc
