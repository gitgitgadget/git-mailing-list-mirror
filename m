From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 18/19] fsck: git receive-pack: support excluding objects
 from fsck'ing
Date: Sat, 31 Jan 2015 22:06:59 +0100
Organization: gmx
Message-ID: <4bd1cadd9b7b958e4d7c3a4ea07aa92a0ae02065.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:07:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfG5-0005Ou-Gr
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbbAaVHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:07:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:60558 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbAaVHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:07:08 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M9JYE-1YNl7d2zHi-00Cfiq; Sat, 31 Jan 2015 22:06:59
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:QtkxQsHCtRnjEiWLb+uaL2xUC+OswdNaiRI/AuAXihX7A8wXIZL
 934yGmeqeyx/oNavCQeZvKxUBHQkLn7l2nXxQHT736E9SgjRCdt5wvO1/zB/bztK0PumR7J
 57n90ws+cLKlLWof9jhzEIzWit5jZaUTfMI6EIxtcgrEd9xbw8clboXB2KRSwJ5JenEVS2k
 Hb1xd3iK5JqhSWPN923Dw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263228>

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
 builtin/receive-pack.c          |  8 ++++++
 fsck.c                          | 54 +++++++++++++++++++++++++++++++++++++++++
 fsck.h                          |  1 +
 t/t5504-fetch-receive-strict.sh | 12 +++++++++
 5 files changed, 82 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c0a13d..e685aef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2157,6 +2157,13 @@ which would not pass pushing when `receive.fsckObjects = true`, allowing
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
index 9b7f1a8..f454e65 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -122,6 +122,14 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		strbuf_addf(&fsck_severity, "%cskiplist=%s",
+			fsck_severity.len ? ',' : '=', path);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
diff --git a/fsck.c b/fsck.c
index c4079ed..046af02 100644
--- a/fsck.c
+++ b/fsck.c
@@ -8,6 +8,7 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
+#include "sha1-array.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -119,6 +120,43 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
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
@@ -151,6 +189,18 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 			if (mode[equal] == '=' || mode[equal] == ':')
 				break;
 
+		if (!substrcmp(mode, equal, "skiplist")) {
+			char *path = xstrndup(mode + equal + 1,
+				len - equal - 1);
+
+			if (equal == len)
+				die("skiplist requires a path");
+			init_skiplist(options, path);
+			free(path);
+			mode += len;
+			continue;
+		}
+
 		msg_id = parse_msg_id(mode, equal);
 
 		if (equal == len)
@@ -706,6 +756,10 @@ static int fsck_tag(struct tag *tag, const char *data,
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
index 9e4e77b..7881e17 100755
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
 test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
-- 
2.2.0.33.gc18b867
