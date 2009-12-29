From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Tue, 29 Dec 2009 13:42:38 -0800
Message-ID: <1262122958-9378-10-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqn-0003gs-JS
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbZL2VnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZL2VnF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:43:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZL2Vm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3060ABFC3
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wXY5
	4adTHk73Xa/OAXdLIz1qxd4=; b=kJIM78LODi0EglN+brmrEthQTqb94LOuI+Oe
	mVO2GcIT8T+j58lCPQkxQYlIDrYow3BoDmZC/nDzxFoI+bW4gTG4HuI7fA9nbmrD
	Pz9uePxixgYqNRkoDw9AbJdAMYNvxmarentwZ6lKzmLv7iiQskUqRJfXKrXUncGS
	hRj7AXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lZoHg4
	J7vjUTT7GJ8a60FAduHByBZqiCUhMUorFcyWoXo8ojpJAfrCGekjOi8OSkFj35w0
	Dv3A1ibhwVpSgzTp2zvx5rJOOe+R4Ik9HUiNeqs4c0zlUXzb197KDublG4SEbRXn
	lZvwxZHCWu24ztp0RYcYvB2FRRvYK5sOmb4W0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F044BABFC2
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2258EABFC1 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:57 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 21BBE464-F4C3-11DE-AB55-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135830>

After you find out an earlier resolution you told rerere to use was a
mismerge, there is no easy way to clear it.  A new subcommand "forget" can
be used to tell git to forget a recorded resolution, so that you can redo
the merge from scratch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-rerere.c          |    2 +
 rerere.c                  |  127 +++++++++++++++++++++++++++++++++++++++++++++
 rerere.h                  |    1 +
 t/t2030-unresolve-info.sh |   22 ++++++++
 4 files changed, 152 insertions(+), 0 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 2be9ffb..0253abf 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -110,6 +110,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "-h"))
 		usage(git_rerere_usage);
+	else if (!strcmp(argv[1], "forget"))
+		return rerere_forget(argv + 2);
 
 	fd = setup_rerere(&merge_rr);
 	if (fd < 0)
diff --git a/rerere.c b/rerere.c
index f013ae7..c1da6f6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -3,6 +3,9 @@
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "dir.h"
+#include "resolve-undo.h"
+#include "ll-merge.h"
 
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
@@ -229,6 +232,95 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	return hunk_no;
 }
 
+struct rerere_io_mem {
+	struct rerere_io io;
+	struct strbuf input;
+};
+
+static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
+{
+	struct rerere_io_mem *io = (struct rerere_io_mem *)io_;
+	char *ep;
+	size_t len;
+
+	strbuf_release(sb);
+	if (!io->input.len)
+		return -1;
+	ep = strchrnul(io->input.buf, '\n');
+	if (*ep == '\n')
+		ep++;
+	len = ep - io->input.buf;
+	strbuf_add(sb, io->input.buf, len);
+	strbuf_remove(&io->input, 0, len);
+	return 0;
+}
+
+static void rerere_mem_putstr(const char *str, struct rerere_io *io_)
+{
+	; /* no-op */
+}
+
+
+static void rerere_mem_putmem(const char *mem, size_t sz, struct rerere_io *io_)
+{
+	; /* no-op */
+}
+
+static int handle_cache(const char *path, unsigned char *sha1)
+{
+	mmfile_t mmfile[3];
+	mmbuffer_t result = {NULL, 0};
+	struct cache_entry *ce;
+	int pos, len, i, hunk_no;
+	struct rerere_io_mem io;
+
+	/*
+	 * Reproduce the conflicted merge in-core
+	 */
+	len = strlen(path);
+	pos = cache_name_pos(path, len);
+	if (0 <= pos)
+		return -1;
+	pos = -pos - 1;
+
+	for (i = 0; i < 3; i++) {
+		enum object_type type;
+		unsigned long size;
+
+		mmfile[i].size = 0;
+		mmfile[i].ptr = NULL;
+		if (active_nr <= pos)
+			break;
+		ce = active_cache[pos++];
+		if (ce_namelen(ce) != len || memcmp(ce->name, path, len)
+		    || ce_stage(ce) != i + 1)
+			break;
+		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
+		mmfile[i].size = size;
+	}
+	for (i = 0; i < 3; i++) {
+		if (!mmfile[i].ptr && !mmfile[i].size)
+			mmfile[i].ptr = xstrdup("");
+	}
+	ll_merge(&result, path, &mmfile[0],
+		 &mmfile[1], "ours",
+		 &mmfile[2], "theirs", 0);
+	for (i = 0; i < 3; i++)
+		free(mmfile[i].ptr);
+
+	memset(&io, 0, sizeof(&io));
+	io.io.getline = rerere_mem_getline;
+	io.io.putstr = rerere_mem_putstr;
+	io.io.putmem = rerere_mem_putmem;
+
+	strbuf_init(&io.input, 0);
+	strbuf_attach(&io.input, result.ptr, result.size, result.size);
+
+	hunk_no = handle_path(sha1, (struct rerere_io *)&io);
+	strbuf_release(&io.input);
+	return hunk_no;
+}
+
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
@@ -440,3 +532,38 @@ int rerere(void)
 		return 0;
 	return do_plain_rerere(&merge_rr, fd);
 }
+
+int rerere_forget(const char **pathspec)
+{
+	int i;
+	struct string_list conflict = { NULL, 0, 0, 1 };
+
+	if (read_cache() < 0)
+		return error("Could not read index");
+
+	unmerge_cache(pathspec);
+	find_conflict(&conflict);
+	for (i = 0; i < conflict.nr; i++) {
+		unsigned char sha1[20];
+		const char *postimage;
+		int ret;
+		struct string_list_item *it = &conflict.items[i];
+		if (!match_pathspec(pathspec, it->string, strlen(it->string),
+				    0, NULL))
+			continue;
+		ret = handle_cache(it->string, sha1);
+		if (ret < 1) {
+			error("Could not parse conflict hunks in '%s'",
+			      it->string);
+			continue;
+		}
+		postimage = rerere_path(sha1_to_hex(sha1), "postimage");
+		if (!unlink(postimage))
+			fprintf(stderr, "forgot resolution for %s\n", it->string);
+		else if (errno == ENOENT)
+			error("no remembered resolution for %s", it->string);
+		else
+			error("cannot unlink %s: %s", postimage, strerror(errno));
+	}
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 13313f3..36560ff 100644
--- a/rerere.h
+++ b/rerere.h
@@ -7,5 +7,6 @@ extern int setup_rerere(struct string_list *);
 extern int rerere(void);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
+extern int rerere_forget(const char **);
 
 #endif
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 28e2eb1..92e006b 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -115,4 +115,26 @@ test_expect_success 'unmerge with plumbing' '
 	test $(wc -l <actual) = 3
 '
 
+test_expect_success 'rerere and rerere --forget' '
+	mkdir .git/rr-cache &&
+	prime_resolve_undo &&
+	echo record the resolution &&
+	git rerere &&
+	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
+	rerere_id=${rerere_id%/postimage} &&
+	test -f .git/rr-cache/$rerere_id/postimage &&
+	git checkout -m file &&
+	echo resurrect the conflict &&
+	grep "^=======" file &&
+	echo reresolve the conflict &&
+	git rerere &&
+	test "z$(cat file)" = zdifferent &&
+	echo register the resolution again &&
+	git add file &&
+	check_resolve_undo kept file initial:file second:file third:file &&
+	test -z "$(git ls-files -u)" &&
+	git rerere forget file &&
+	! test -f .git/rr-cache/$rerere_id/postimage
+'
+
 test_done
-- 
1.6.6
