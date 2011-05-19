From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/11] write_entry(): separate two helper functions out
Date: Thu, 19 May 2011 14:33:40 -0700
Message-ID: <1305840826-7783-6-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAsr-0007T2-D8
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934846Ab1ESVeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:34:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934832Ab1ESVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58F1252AD
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=F1Uf
	+bRVjpFOiMBDjr/h/Y2LkSs=; b=CY3+AJypA9wEMTVJ/mguVUbq0fiQG4HD+/MM
	OEvlYoRaGjtp+prDW8Fn6cYFeWaORibdN+i3oKuwmrd0R9/DE/Nn1WKB7vT4itV/
	NYtNFinn3k9bz8F4Ea0WfCIFkFTbklgrgWQYWfGGqJ3s49LWG8+F/e9rFkFKMC9w
	RPhEIoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t4OlcF
	mae6/gyK6mAuTEejodIdj1r/ejxvt4BYLn12sbEEkmd6iuiW/eIzWUPR4ESqF66v
	XW0L3N6xSzd95W5AN+0QBGIwIBTlIw+UoXeAQRyt2vAz8bXrFopUiyU6K3nmb232
	0dIfJWKhkXPUqtBq420o4SmpIuCdSxYgPQqlU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55CC552AC
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7B4E52AB for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 01F8B0CC-8260-11E0-A4B9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174023>

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
1.7.5.1.416.gac10c8
