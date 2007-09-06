From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] allow bulk import to be packed
Date: Wed, 05 Sep 2007 18:17:19 -0700
Message-ID: <7vps0wfv8g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 03:17:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5zw-0007cV-PF
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 03:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbXIFBR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757246AbXIFBR0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 21:17:26 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbXIFBRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 21:17:25 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3634712F3A1;
	Wed,  5 Sep 2007 21:17:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57794>

This will use fast-import as a backend to dump blobs resulting
from a huge initial import into a packfile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 105a9f0..f512108 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "revision.h"
+#include "run-command.h"
 
 static const char builtin_add_usage[] =
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <filepattern>...";
@@ -153,6 +154,82 @@ static int git_add_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static void pack_one_blob(FILE *g, size_t size, const char *path)
+{
+	void *buf = NULL;
+	unsigned long nsize;
+	char *nbuf;
+	int re_allocated = 0;
+
+	if (size) {
+		int fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return;
+		buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+	}
+	nbuf = convert_to_git(path, buf, &nsize);
+	if (nbuf) {
+		munmap(buf, size);
+		size = nsize;
+		buf = nbuf;
+		re_allocated = 1;
+	}
+
+	fprintf(g, "blob\ndata %lu\n", size);
+	fwrite(buf, 1, size, g);
+	fputc('\n', g);
+}
+
+#ifndef BULK_ADD_LIMIT
+#define BULK_ADD_LIMIT 200
+#endif
+
+static void pack_bluk_blob(struct dir_struct *dir, int verbose)
+{
+	struct child_process gfi;
+	const char *gfi_argv[] = { "fast-import", NULL };
+	int i, cnt;
+	FILE *g;
+	size_t *addmap;
+
+	if (dir->nr < BULK_ADD_LIMIT)
+		return;
+
+	addmap = xcalloc(dir->nr, sizeof(size_t));
+	for (i = cnt = 0; i < dir->nr; i++) {
+		struct stat st;
+		const char *name = dir->entries[i]->name;
+		if (!lstat(name, &st) && S_ISREG(st.st_mode)) {
+			cnt++;
+			addmap[i] = xsize_t(st.st_size);
+		}
+	}
+	if (cnt < BULK_ADD_LIMIT)
+		return;
+
+	memset(&gfi, 0, sizeof(gfi));
+	gfi.argv = gfi_argv;
+	gfi.no_stdout = 1;
+	gfi.in = -1;
+	gfi.git_cmd = 1;
+
+	if (start_command(&gfi)) {
+		warning("could not run fast-import");
+		return;
+	}
+	g = fdopen(gfi.in, "w");
+
+	for (i = 0; i < dir->nr; i++) {
+		if (!addmap[i])
+			continue;
+		pack_one_blob(g, addmap[i], dir->entries[i]->name);
+	}
+	fflush(g);
+	finish_command(&gfi);
+	reprepare_packed_git();
+}
+
 static struct lock_file lock_file;
 
 static const char ignore_error[] =
@@ -258,6 +335,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("no files added");
 	}
 
+	pack_bluk_blob(&dir, verbose);
+
 	for (i = 0; i < dir.nr; i++)
 		add_file_to_cache(dir.entries[i]->name, verbose);
 
