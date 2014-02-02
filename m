From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v4 4/4] setup: Don't dereference in-tree symlinks for absolute paths
Date: Sun,  2 Feb 2014 02:59:11 +0100
Message-ID: <1391306351-13237-5-git-send-email-martinerikwerner@gmail.com>
References: <20140131202142.GA9731@mule>
 <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 03:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9mM7-0007yW-FX
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 03:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbaBBCAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 21:00:11 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:53032 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaBBCAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 21:00:06 -0500
Received: by mail-la0-f54.google.com with SMTP id y1so4611889lam.27
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 18:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhKpUf/k+NOV8hKlzBJyoI5gaTC+PIB4v8fJf3qS2F8=;
        b=CgZL0nBx0BiG2AuIc3jeFpRPpgX614WbD7FrkLzhf5ABJro5W39HD/enwNYo4EjBXC
         4ODc5H6VFYMnssEMNwvB4TSHKsHeaPozlxf3gsI9oLBSvNjZzuMsCjhlsdv0GfxIkmBV
         Th7ew5ey0BqQQRU/hVBFrsCXgUIsvx7vvGfRxo9J2mo3N7VnAkMHfHLBpRnIBmnL8vX6
         qtg4cMnCM2UCu9463K3ELKUo3ItqBdB7UnNL7VFDibPnr8kvBAZ9k8vs5OibUbjd7HaX
         5Q3lg81uFyb2ht6jyXOz43n+/IjdRW46phaVTYXuoA8zAzS41nSKYtDI5Bczb2VtMdZf
         LoZg==
X-Received: by 10.112.236.3 with SMTP id uq3mr7506161lbc.14.1391306405274;
        Sat, 01 Feb 2014 18:00:05 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm22136585lae.1.2014.02.01.18.00.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Feb 2014 18:00:04 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241350>

The 'prefix_path_gently' function currently applies real_path to
everything if given an absolute path, dereferencing symlinks both
outside and inside the work tree. In order to manipulate symlinks in the
work tree using absolute paths, symlinks should only be dereferenced
outside the work tree.

Modify the 'prefix_path_gently' to first normalize the path in order to
make sure path levels are separated by '/', then pass the result to
'abspath_part_inside_repo' to find the in-repo part (without dereferencing
any symlinks inside the work tree).

For absolute paths, 'prefix_path_gently' did not, nor does now do, any
actual prefixing, hence the result from 'abspath_part_in_repo' is
returned as-is.

Fixes t0060-82.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 setup.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index e938785..2270bd4 100644
--- a/setup.c
+++ b/setup.c
@@ -79,11 +79,23 @@ char *prefix_path_gently(const char *prefix, int len,
 	const char *orig = path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		const char *temp = real_path(path);
-		sanitized = xmalloc(len + strlen(temp) + 1);
-		strcpy(sanitized, temp);
+		char *npath;
+
+		npath = xmalloc(strlen(path) + 1);
 		if (remaining_prefix)
 			*remaining_prefix = 0;
+		if (normalize_path_copy_len(npath, path, remaining_prefix)) {
+			free(npath);
+			return NULL;
+		}
+		if (abspath_part_inside_repo(npath)) {
+			free(npath);
+			return NULL;
+		}
+
+		sanitized = xmalloc(strlen(npath) + 1);
+		strcpy(sanitized, npath);
+		free(npath);
 	} else {
 		sanitized = xmalloc(len + strlen(path) + 1);
 		if (len)
@@ -91,26 +103,10 @@ char *prefix_path_gently(const char *prefix, int len,
 		strcpy(sanitized + len, path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
-	}
-	if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
-		goto error_out;
-	if (is_absolute_path(orig)) {
-		size_t root_len, len, total;
-		const char *work_tree = get_git_work_tree();
-		if (!work_tree)
-			goto error_out;
-		len = strlen(work_tree);
-		root_len = offset_1st_component(work_tree);
-		total = strlen(sanitized) + 1;
-		if (strncmp(sanitized, work_tree, len) ||
-		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
-		error_out:
+		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
 			free(sanitized);
 			return NULL;
 		}
-		if (sanitized[len] == '/')
-			len++;
-		memmove(sanitized, sanitized + len, total - len);
 	}
 	return sanitized;
 }
-- 
1.8.5.2
