From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 1/5] t0060: Add test for manipulating symlinks via absolute paths
Date: Sun,  2 Feb 2014 17:35:36 +0100
Message-ID: <1391358940-17373-2-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:36:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA02E-0008Ut-EE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbaBBQgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:40 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:46440 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaBBQgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:37 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so4847941lab.29
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNjq++SfCA2rF1vdWEGyZg+cRhmMkq4GOujz225BzUY=;
        b=ChnqEg/RkOU5jkpuk6tovyfP0CugI3agAyNI1S7WJikLQZ3twOcb3Pj+zLz3GFY7NR
         ohRElfWWBx4QMQHfOlYjlN8rL5fVgiT1JCqOCAeMZN5r6OWVocvOADx7ZhUs0uKH5wcg
         NzjK2taID37AieBYhZVGkGHI4mfvSGxNoN3zEVwdFZJGrwU74/QS+RUurtEMH6ewYpMV
         X5WPUAV8ktB1BcUo3sf0BYBm6DXAOZABpyjuxPGgSqKsEUGjtrTRpMFBMDCYKyM0DhfI
         4E30QEwAx6/4Z77NjD62JOIlyClYTI0t//zZC42arSsdvwMKfwd61MHQqRHLNdd1NqyG
         G+3Q==
X-Received: by 10.112.142.230 with SMTP id rz6mr15392570lbb.0.1391358996140;
        Sun, 02 Feb 2014 08:36:36 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:35 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241375>

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
 t/t0060-path-utils.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..0bba988 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,6 +190,11 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
+	ln -s target symlink &&
+	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
