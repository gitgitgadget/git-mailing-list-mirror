From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH 1/2] t0060: Add test for manipulating symlinks via absolute paths
Date: Sun, 26 Jan 2014 15:22:25 +0100
Message-ID: <1390746146-9478-2-git-send-email-martinerikwerner@gmail.com>
References: <20140115124859.GA4283@mule>
 <1390746146-9478-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 15:23:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7QcV-0001we-Oo
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 15:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaAZOXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 09:23:22 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36633 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaAZOWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 09:22:52 -0500
Received: by mail-lb0-f181.google.com with SMTP id z5so3802399lbh.12
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 06:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wn+Pq0wSiQi71pEB7X3Ru/8HeP43m8mgqQqHMzz8NkM=;
        b=Bkw9ORgPBq/aqGfOwY1Pb/6XNWVGNBHZPLt/p/DZOOXmGQR2MZwW8RG0+3/p5sHUg3
         vb8DGI1nw1d25QcTIU7GddKewvIH494EsI48biqJCWYCFc2+anNlID8cdN5fS4qhNJPd
         x90YzJLyqrkLwFFniwYIPjAgBooYGzgpJ6g6E5XrceMXlW0ER7wqWJnSSzJEy0S5V/TM
         fM9PSMYVgBrHPn5zkz8dTkcrrHgT1G05C5nkKA/h6+X00wLm6UmGG3DdfY+T2MAouUDK
         0myMWIgVJFcL3teg0riMVheroSVsRR4z0FvwkVuX1Msw5mtdrfsHpRNQsQfYV6YGQlc6
         Xo/w==
X-Received: by 10.152.220.170 with SMTP id px10mr2601703lac.13.1390746170968;
        Sun, 26 Jan 2014 06:22:50 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm12109991lae.1.2014.01.26.06.22.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jan 2014 06:22:50 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390746146-9478-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241089>

When symlinks in the working tree are manipulated using the absolute
path, git dereferences them, and tries to manipulate the link target
instead.

This is a regression introduced by 18e051a:
  setup: translate symlinks in filename when using absolute paths
(which did not take symlinks in the work tree into consideration).

Add a known-breakage tests using the prefix_path function, which
currently uses real_path, causing the dereference.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t0060-path-utils.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..3a0677a 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,6 +190,13 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+test_expect_failure SYMLINKS 'prefix_path works with work tree symlinks' '
+
+	ln -s target symlink &&
+	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
