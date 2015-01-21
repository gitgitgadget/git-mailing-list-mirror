From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 18/19] fsck: git receive-pack: support excluding objects
 from fsck'ing
Date: Wed, 21 Jan 2015 20:27:36 +0100
Organization: gmx
Message-ID: <93c9736d3fcf0b61389334af750465c2897d409d.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:27:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0wK-0003lk-T4
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbbAUT1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:27:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:64672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbbAUT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:27:40 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBq8p-1Y3Fh000TX-00AoqX; Wed, 21 Jan 2015 20:27:37
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:z/RFW7LHhLW6iDn4pO5BfeoZ+d/SYVRhm1ruTXvTE/7TMV6D1VQ
 f8VfnE5XGOOVKMR5nwj8lgfQLWhBqp3JB1me0WXQQ/n0xA+B41SBxrTxaqaemat+7w1O7Tz
 6wjC/jO0+9b9P0xX4r7sDavmie2He19hgfOxle1ve7larlraJdApoSFSSqsxB+hqFfgJicr
 61f6/N+EtAlwMKyXAQsnQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262763>

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
 Documentation/config.txt        |  7 ++++++
 builtin/receive-pack.c          |  9 +++++++
 fsck.c                          | 53 +++++++++++++++++++++++++++++++++++++++++
 fsck.h                          |  1 +
 t/t5504-fetch-receive-strict.sh | 12 ++++++++++
 5 files changed, 82 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 115811c..636adff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2173,6 +2173,13 @@ which would not pass pushing when `receive.fsckObjects = true`, allowing
 the host to accept repositories with certain known issues but still catch
 other issues.
 
+receive.fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 18d5012..8e6d1a1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -116,6 +116,15 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		if (fsck_severity.len)
+			strbuf_addch(&fsck_severity, ',');
+		strbuf_addf(&fsck_severity, "skiplist=%s", path);
+		return 0;
+	}
+
 	if (skip_prefix(var, "receive.fsck.", &var)) {
 		strbuf_addf(&fsck_severity, "%s%s=%s",
 			fsck_severity.len ? "," : "", var, value);
diff --git a/fsck.c b/fsck.c
index 1334941..15cb8bd 100644
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
index 5e54a13..d367bb2 100755
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
2.2.0.33.gc18b867
