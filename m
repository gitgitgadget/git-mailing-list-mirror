From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 18/18] fsck: git receive-pack: support excluding objects  from fsck'ing
Date: Mon, 19 Jan 2015 16:52:06 +0100
Organization: gmx
Message-ID: <dd54b4dc097f18bb3427ec6408e71ad65efd08a1.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 17:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEkA-0006R4-PD
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbASP7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:47 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbbASP7p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:45 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFq6BA026505;
	Mon, 19 Jan 2015 16:52:06 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFq6IS026504;
	Mon, 19 Jan 2015 16:52:06 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262628>

The optional new config option `receive.fsck.skiplist` specifies the path
to a file listing the names, i.e. SHA-1s, one per line, of objects that
are to be ignored by `git receive-pack` when `receive.fsckObjects = true`.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

The intended use case is for server administrators to inspect objects
that are reported by `git push` as being too problematic to enter the
repository, and to add the objects' SHA-1 to a (preferably sorted) file
when the objects are legitimate, i.e. when it is determined that those
problematic objects should be allowed to enter the server.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c          |  9 +++++++
 fsck.c                          | 53 +++++++++++++++++++++++++++++++++++++++++
 fsck.h                          |  1 +
 t/t5504-fetch-receive-strict.sh | 12 ++++++++++
 4 files changed, 75 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index da2e019..40514c2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -116,6 +116,15 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "receive.fsck.skiplist")) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		if (fsck_severity.len)
+			strbuf_addch(&fsck_severity, ',');
+		strbuf_addf(&fsck_severity, "skiplist=%s", path);
+		return 0;
+	}
+
 	if (starts_with(var, "receive.fsck.")) {
 		if (fsck_severity.len)
 			strbuf_addch(&fsck_severity, ',');
diff --git a/fsck.c b/fsck.c
index 480cd87..dbf9fa1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -8,6 +8,7 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
+#include "sha1-array.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -117,6 +118,43 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 	return severity;
 }
 
+static void init_skiplist(struct fsck_options *options, const char *path)
+{
+	static struct sha1_array skiplist = SHA1_ARRAY_INIT;
+	int sorted, fd;
+	char buffer[41];
+	unsigned char sha1[20];
+
+	if (options->skiplist)
+		sorted = options->skiplist->sorted;
+	else {
+		sorted = 1;
+		options->skiplist = &skiplist;
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("Could not open skip list: %s", path);
+	for (;;) {
+		int result = read_in_full(fd, buffer, sizeof(buffer));
+		if (result < 0)
+			die_errno("Could not read '%s'", path);
+		if (!result)
+			break;
+		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
+			die("Invalid SHA-1: %s", buffer);
+		sha1_array_append(&skiplist, sha1);
+		if (sorted && skiplist.nr > 1 &&
+				hashcmp(skiplist.sha1[skiplist.nr - 2],
+					sha1) > 0)
+			sorted = 0;
+	}
+	close(fd);
+
+	if (sorted)
+		skiplist.sorted = 1;
+}
+
 static inline int substrcmp(const char *string, int len, const char *match)
 {
 	int match_len = strlen(match);
@@ -156,6 +194,17 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 				severity = FSCK_WARN;
 			else if (!substrcmp(mode, equal, "ignore"))
 				severity = FSCK_IGNORE;
+			else if (!substrcmp(mode, equal, "skiplist")) {
+				char *path = xstrndup(mode + equal + 1,
+					len - equal - 1);
+
+				if (equal == len)
+					die("skiplist requires a path");
+				init_skiplist(options, path);
+				free(path);
+				mode += len;
+				continue;
+			}
 			else
 				die("Unknown fsck message severity: '%.*s'",
 					equal, mode);
@@ -700,6 +749,10 @@ static int fsck_tag(struct tag *tag, const char *data,
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
+	if (options->skiplist &&
+			sha1_array_lookup(options->skiplist, obj->sha1) >= 0)
+		return 0;
+
 	if (!obj)
 		return report(options, obj, FSCK_MSG_INVALID_OBJECT_SHA1, "no valid object to fsck");
 
diff --git a/fsck.h b/fsck.h
index 7be6c50..cae280e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -29,6 +29,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_severity;
+	struct sha1_array *skiplist;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index e81cedb..21fa9c8 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,6 +123,18 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'push with receive.fsck.skiplist' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.skiplist SKIP &&
+	echo $commit > dst/.git/SKIP &&
+	git push --porcelain dst bogus
+'
+
 test_expect_success 'push with receive.fsck.warn = missing-email' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
-- 
2.0.0.rc3.9669.g840d1f9
