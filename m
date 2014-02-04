From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 4/6] t0060: Add tests for prefix_path when path begins with work tree
Date: Tue,  4 Feb 2014 15:25:18 +0100
Message-ID: <1391523920-26946-5-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgwt-0002hc-B6
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbaBDOZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:50 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:57172 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaBDOZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:47 -0500
Received: by mail-ee0-f42.google.com with SMTP id b15so2497965eek.29
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imyBJAL6gx4M/FhFBmTzVwKUPRHSuJi18uTZsAYYzNc=;
        b=LX1mxwQ0bwVOde6gmNYBW2g2WeNg/905O0sWq0ASSr7EWBfwvan2pxDwDyiG8eD5fA
         /sQQ8y37/857CbncTN0MUBG0X7JOUnPw895TgkWrfDGqLiFlbsmFHy8Ec/SRTnsjHdVv
         I4vpR5wI16XThdXZNG7Spj5LUndIoylJ9TmUqjtDDIFWSyXqQgiP9AIfjcojZOhb/juR
         f4MIERzFoEel79BW+eR8c2VQA11hmRrCs+cwxdf7TUOlgFHbnWUNDFVDPmabEfuLPTKT
         eG5LsQlkVm4nKznfDvBYbwa5gqLQ78tSFyvV38rXnAYnNtP5pNbYmT06bUP60NVYGfdu
         aCrg==
X-Received: by 10.14.0.201 with SMTP id 49mr51248902eeb.38.1391523945897;
        Tue, 04 Feb 2014 06:25:45 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:45 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241529>

One edge-case that isn't currently checked in the tests is the beginning
of the path matching the work tree, despite the target not actually
being the work tree, for example:

  path = /dir/repoa
  work_tree = /dir/repo

should fail since the path is outside the repo. However, if /dir/repoa
is in fact a symlink that points to /dir/repo, it should instead
succeed.

Add two tests covering these cases, since they might be potential
regression points.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 t/t0060-path-utils.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index b8e92e1..c0a14f6 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -201,6 +201,16 @@ test_expect_success 'prefix_path works with only absolute path to work tree' '
 	test_cmp expected actual
 '
 
+test_expect_success 'prefix_path rejects absolute path to dir with same beginning as work tree' '
+	test_must_fail test-path-utils prefix_path prefix "$(pwd)a"
+'
+
+test_expect_success 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
+	git init repo &&
+	ln -s repo repolink &&
+	test "a" = "$(cd repo && test-path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
