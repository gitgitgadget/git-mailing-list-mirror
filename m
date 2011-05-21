From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/12] write_entry(): separate two helper functions out
Date: Fri, 20 May 2011 23:56:28 -0700
Message-ID: <1305960995-25738-6-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg7w-0006Ar-Bu
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab1EUG52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1EUG50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C095F5DBD
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Q97C
	UviCwbGZP2MetHBEA/2Krtg=; b=fpfdkM2STiYWj+q3eaQA0D+95DcgI7ZsJu0C
	IxYcYfEMEwBxPL8fEE8pRvXSYUPuDfWfVClP0iRxsM8ElnbotQl2z1mSsjeiyAx7
	OIL745jWmvJDXXDoCTWkNlDFUEDmk99y74sTcYibOQ5JNtYrpB7A6Y71t2/V8HDc
	v7RZNwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wV61R/
	+gaiKsdVq37yG9U9daS23iW1AFkS6ehKrDwCFj4LAq/4RBtoJrPZSuBBDPGTvwrN
	MkuyEqEtqjBD9mvlb7IutA3coDSZUUsw8GHSejbCmvP2LmRGI0iMj8zoYmTcB7lm
	bee7H0VMVJk09ty+pgFV1VP7klP36/rEU/+3U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD03E5DBC
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D3005DB7 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E164A834-8377-11E0-ADB3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174099>

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
1.7.5.2.369.g8fc017
