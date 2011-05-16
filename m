From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/11] write_entry(): separate two helper functions out
Date: Sun, 15 May 2011 17:30:25 -0700
Message-ID: <1305505831-31587-6-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLli1-00047D-QJ
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab1EPAas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1EPAap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2534E5F7E
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oHyK
	/Phv00lsVOndYJLWmasGEK4=; b=awqfyH2KE/fBDQvLYKfwx3aF2DMV3nOHYnoQ
	hiKpjLcnIX6UmovED6Lwvku1wIvjDVgIikuKO80FqRLG2eKg9BfUPvP+11h39h96
	7rrt475RBV2izBVHSETxYbFxU26kPoot+MkNhDkOq2MqHSyDpoX2nI2vxwd8Ghx6
	e51IUno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Vsrbko
	2KL3CF6JNsI4PVYICa9qp6d/YKgmg/u1yl5zQhiezcY/pFbjVEdiVuyRbsIBGHqv
	f5o7ZOP9KR08nJaHrZnRxt6FeFL3Am0lonm7N+VOzxmRf9UYeAbLdHgfeIm1CHgJ
	k+y9zayBEpcovVSuM/hyyAVHZCE8bPwcu61Xo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2284A5F7D
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 886CA5F7C for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 08ABE38A-7F54-11E0-B1EE-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173686>

In the write-out codepath, a block of code determines what file in the
working tree to write to, and opens an output file descriptor to it.

After writing the contents out to the file, another block of code runs
fstat() on the file descriptor when appropriate.

Separate these blocks out to open_output_fd() and fstat_output()
helper functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/entry.c b/entry.c
index b017167..cc6502a 100644
--- a/entry.c
+++ b/entry.c
@@ -91,6 +91,29 @@ static void *read_blob_entry(struct cache_entry *ce, unsigned long *size)
 	return NULL;
 }
 
+static int open_output_fd(char *path, struct cache_entry *ce, int to_tempfile)
+{
+	int symlink = (ce->ce_mode & S_IFMT) != S_IFREG;
+	if (to_tempfile) {
+		strcpy(path, symlink
+		       ? ".merge_link_XXXXXX" : ".merge_file_XXXXXX");
+		return mkstemp(path);
+	} else {
+		return create_file(path, !symlink ? ce->ce_mode : 0666);
+	}
+}
+
+static int fstat_output(int fd, const struct checkout *state, struct stat *st)
+{
+	/* use fstat() only when path == ce->name */
+	if (fstat_is_reliable() &&
+	    state->refresh_cache && !state->base_dir_len) {
+		fstat(fd, st);
+		return 1;
+	}
+	return 0;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
@@ -128,17 +151,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			size = newsize;
 		}
 
-		if (to_tempfile) {
-			if (ce_mode_s_ifmt == S_IFREG)
-				strcpy(path, ".merge_file_XXXXXX");
-			else
-				strcpy(path, ".merge_link_XXXXXX");
-			fd = mkstemp(path);
-		} else if (ce_mode_s_ifmt == S_IFREG) {
-			fd = create_file(path, ce->ce_mode);
-		} else {
-			fd = create_file(path, 0666);
-		}
+		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
 			free(new);
 			return error("unable to create file %s (%s)",
@@ -146,12 +159,8 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		}
 
 		wrote = write_in_full(fd, new, size);
-		/* use fstat() only when path == ce->name */
-		if (fstat_is_reliable() &&
-		    state->refresh_cache && !to_tempfile && !state->base_dir_len) {
-			fstat(fd, &st);
-			fstat_done = 1;
-		}
+		if (!to_tempfile)
+			fstat_done = fstat_output(fd, state, &st);
 		close(fd);
 		free(new);
 		if (wrote != size)
-- 
1.7.5.1.365.g32b65
