From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 18/18] git receive-pack: support excluding objects from
 fsck'ing
Date: Mon, 8 Dec 2014 17:15:40 +0100 (CET)
Message-ID: <bafa42210f8885335aeacac41a81380a9a7eef24.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yS-0006Um-Ow
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbaLHQPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:60790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbaLHQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:43 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MgszY-1YJxi02KfY-00M0gY;
 Mon, 08 Dec 2014 17:15:40 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ywL71LfRWeoZcW65tEFg9KkmeW5XT9/F85t6o3Gb5781KUSPqNq
 5/5uFDAOIpPoOiAlMKMewg1jigNFcyFBaw03nF7LDc8+7zuD+/yJmhRBenXwn2kWbwez1Vk
 Idca/sq39+CFtFTlXCiafqSUiDAgJW86eFA3ae3lvCAHEd3UjJj+nfGp4ehyBEmrlh3LIIc
 r9sNdTRMgB6iR2akF3cfQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261069>

The optional new config option `receive.fsck.skip-list` specifies the path
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
 fsck.c                          | 59 +++++++++++++++++++++++++++++++++++++++--
 fsck.h                          |  2 ++
 t/t5504-fetch-receive-strict.sh | 12 +++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 111e514..5169f1f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -110,6 +110,15 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "receive.fsck.skip-list")) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		if (fsck_strict_mode.len)
+			strbuf_addch(&fsck_strict_mode, ',');
+		strbuf_addf(&fsck_strict_mode, "skip-list=%s", path);
+		return 0;
+	}
+
 	if (starts_with(var, "receive.fsck.")) {
 		if (fsck_strict_mode.len)
 			strbuf_addch(&fsck_strict_mode, ',');
diff --git a/fsck.c b/fsck.c
index 154f361..00693f2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -7,6 +7,7 @@
 #include "tag.h"
 #include "fsck.h"
 #include "refs.h"
+#include "sha1-array.h"
 
 #define FOREACH_MSG_ID(FUNC) \
 	/* fatal errors */ \
@@ -56,7 +57,9 @@
 	FUNC(ZERO_PADDED_FILEMODE) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(INVALID_TAG_NAME) \
-	FUNC(MISSING_TAGGER_ENTRY)
+	FUNC(MISSING_TAGGER_ENTRY) \
+	/* special value */ \
+	FUNC(SKIP_LIST)
 
 #define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
 #define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
@@ -109,6 +112,43 @@ int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
 	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
 }
 
+static void init_skip_list(struct fsck_options *options, const char *path)
+{
+	static struct sha1_array skip_list = SHA1_ARRAY_INIT;
+	int sorted, fd;
+	char buffer[41];
+	unsigned char sha1[20];
+
+	if (options->skip_list)
+		sorted = options->skip_list->sorted;
+	else {
+		sorted = 1;
+		options->skip_list = &skip_list;
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
+		sha1_array_append(&skip_list, sha1);
+		if (sorted && skip_list.nr > 1 &&
+				hashcmp(skip_list.sha1[skip_list.nr - 2],
+					sha1) > 0)
+			sorted = 0;
+	}
+	close(fd);
+
+	if (sorted)
+		skip_list.sorted = 1;
+}
+
 static inline int substrcmp(const char *string, int len, const char *match)
 {
 	int match_len = strlen(match);
@@ -141,6 +181,18 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 			if (mode[equal] == '=')
 				break;
 
+		msg_id = parse_msg_id(mode, equal);
+		if (msg_id == FSCK_MSG_SKIP_LIST) {
+			char *path = xstrndup(mode + equal + 1, len - equal - 1);
+
+			if (equal == len)
+				die("skip-list requires a path");
+			init_skip_list(options, path);
+			free(path);
+			mode += len;
+			continue;
+		}
+
 		if (equal < len) {
 			const char *type_str = mode + equal + 1;
 			int type_len = len - equal - 1;
@@ -155,7 +207,6 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 					len - equal - 1, type_str);
 		}
 
-		msg_id = parse_msg_id(mode, equal);
 		if (type != FSCK_ERROR && msg_id < FIRST_NON_FATAL_ERROR)
 			die("Cannot demote %.*s", len, mode);
 		options->strict_mode[msg_id] = type;
@@ -681,6 +732,10 @@ static int fsck_tag(struct tag *tag, const char *data,
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
+	if (options->skip_list &&
+			sha1_array_lookup(options->skip_list, obj->sha1) >= 0)
+		return 0;
+
 	if (!obj)
 		return report(options, obj, FSCK_MSG_INVALID_OBJECT_SHA1, "no valid object to fsck");
 
diff --git a/fsck.h b/fsck.h
index 82bedf9..74d11cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -29,6 +29,8 @@ struct fsck_options {
 	fsck_error error_func;
 	int strict:1;
 	int *strict_mode;
+	/* TODO: consider reading into a hashmap */
+	struct sha1_array *skip_list;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 0e521d9..cf6cd5d 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,6 +123,18 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'push with receive.fsck.skip-list' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.skip-list SKIP &&
+	echo $commit > dst/.git/SKIP &&
+	git push --porcelain dst bogus
+'
+
 test_expect_success 'push with receive.fsck.missing-mail = warn' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
-- 
2.0.0.rc3.9669.g840d1f9
