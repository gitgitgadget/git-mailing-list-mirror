From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 3/5] t0060: Add tests for prefix_path when path begins with work tree
Date: Sun,  2 Feb 2014 17:35:38 +0100
Message-ID: <1391358940-17373-4-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:37:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA02X-0000DW-UX
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbaBBQgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:43 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:58595 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaBBQgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:41 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so4593538lbh.8
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQWTUYYRunwu4Q82EDxRYKvFV8fI357/TLoA28SQQUw=;
        b=Y79Ur7r+b2FfNDwS/2lpW1ZFBpxhfyX1wGeiLy7Il2m1imJojDTY6IzCKBo2Xxn5bL
         8Th4qbFZ+JU8pVjlbDpJoBv98ZV7NOe5G+7NLUAoXvIxtevgs/6UvaMv0noi5i0whIFe
         82bagTG+pL9QMBqbq8b96Fht7RVXkItoNT61on4HoXzQd+DM4zbQEvEHSNdMdHNT7+O5
         ZlfPsl/XQWeCLZlP0ocd0OXw9u694Sr0eexb6URT/iDuPsfvePFxpW2DdsqAa0E2mk9P
         PN7V/ZCW1UGDnF3TMgEZ5kFaOKUiszFrW81NT+wpe8nALuIFUxQTvbbTGnQrHw4yuJFz
         /w/w==
X-Received: by 10.152.219.97 with SMTP id pn1mr21176176lac.9.1391359000366;
        Sun, 02 Feb 2014 08:36:40 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241377>

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
