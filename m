From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 13/14] builtin/update-index.c: cleanup update_one
Date: Thu, 07 Nov 2013 15:44:08 +0100
Message-ID: <527BA738.9000104@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQog-0004w8-02
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab3KGOoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:44:09 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:43920 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3KGOoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:44:08 -0500
Received: by mail-ee0-f53.google.com with SMTP id e51so360019eek.40
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dU1xgjutQHv2FCDgMfkZ6NSUVPTtR++8GvdOCEm/tE4=;
        b=II4WNx4OGte2RnxtjLv2/5EZ9ZyxfTAS6i0DsVajgq1QzZb9A7UJe12s/d4Gd3YBFb
         Y/Lq6UeSL+Qbj1tv0BhUwnuZn15mAJpEh8al6WnnNMDgnFo4YbImXPPArhhtGqyZ/YEc
         rUR9FZLbsDFXT0Grjmwe6b+tdeOe0K9hYZBq2x1tb1Bx380WaWXKClCEn1Wtbin3ryD9
         68tIelplsDLvmqsS8DBE1cBpc7U/sFN/Cniq2GqmXESv24JP2amSYOvab0CWCM1FMlzs
         0YIWMm75M2J3iHS+/7CrAMh/+z+GKJYMjaIrn95B5HS4uRaKHBAVir6e941JzqAar/yk
         a5gQ==
X-Received: by 10.14.103.133 with SMTP id f5mr9923576eeg.48.1383835447115;
        Thu, 07 Nov 2013 06:44:07 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a6sm10016888eei.10.2013.11.07.06.44.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:44:06 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237408>

do_reupdate calls update_one with a cache_entry.name, there's no need for
the extra sanitation / normalization that happens in prefix_path.
cmd_update_index calls update_one with an already prefixed path, no need to
prefix_path twice.

Remove the extra prefix_path from update_one. Also remove the now unused
'prefix' and 'prefix_length' parameters.

As of d089eba "setup: sanitize absolute and funny paths in get_pathspec()",
prefix_path uncoditionally returns a copy, even if the passed in path isn't
changed. Lets unconditionally free() the result.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/update-index.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d180d80..b654d27 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -274,36 +274,32 @@ static void chmod_path(int flip, const char *path)
 	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }
 
-static void update_one(const char *path, const char *prefix, int prefix_length)
+static void update_one(const char *path)
 {
-	const char *p = prefix_path(prefix, prefix_length, path);
-	if (!verify_path(p)) {
+	if (!verify_path(path)) {
 		fprintf(stderr, "Ignoring path %s\n", path);
-		goto free_return;
+		return;
 	}
 	if (mark_valid_only) {
-		if (mark_ce_flags(p, CE_VALID, mark_valid_only == MARK_FLAG))
+		if (mark_ce_flags(path, CE_VALID, mark_valid_only == MARK_FLAG))
 			die("Unable to mark file %s", path);
-		goto free_return;
+		return;
 	}
 	if (mark_skip_worktree_only) {
-		if (mark_ce_flags(p, CE_SKIP_WORKTREE, mark_skip_worktree_only == MARK_FLAG))
+		if (mark_ce_flags(path, CE_SKIP_WORKTREE, mark_skip_worktree_only == MARK_FLAG))
 			die("Unable to mark file %s", path);
-		goto free_return;
+		return;
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(p))
+		if (remove_file_from_cache(path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
-		goto free_return;
+		return;
 	}
-	if (process_path(p))
+	if (process_path(path))
 		die("Unable to process path %s", path);
 	report("add '%s'", path);
- free_return:
-	if (p < path || p > path + strlen(path))
-		free((char *)p);
 }
 
 static void read_index_info(int line_termination)
@@ -579,7 +575,7 @@ static int do_reupdate(int ac, const char **av,
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
 		save_nr = active_nr;
-		update_one(ce->name, NULL, 0);
+		update_one(ce->name);
 		if (save_nr != active_nr)
 			goto redo;
 	}
@@ -836,11 +832,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
-			update_one(p, NULL, 0);
+			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			if (p < path || p > path + strlen(path))
-				free((char *)p);
+			free(p);
 			ctx.argc--;
 			ctx.argv++;
 			break;
@@ -879,11 +874,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &nbuf);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p, NULL, 0);
+			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			if (p < buf.buf || p > buf.buf + buf.len)
-				free((char *)p);
+			free(p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
-- 
1.8.4.msysgit.0.12.g88f5ed0
