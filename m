From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 18/19] fsck: git receive-pack: support excluding objects
 from fsck'ing
Date: Thu, 18 Jun 2015 22:10:05 +0200
Organization: gmx
Message-ID: <c9da563cf9a3bb031a2b15c39d2a5066b132ee05.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:10:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8f-0004JY-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbbFRUKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:10:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:59788 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756702AbbFRUKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:10:07 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MRoyH-1ZY2nH0QCP-00SsCN; Thu, 18 Jun 2015 22:10:06
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:HxTTu6BHAC6NLeNNF3Iwa8QegW72AVbdHk1op1ZLek/+PzK+A2m
 qgE11D7Q6DIVZXUQ5LGFE2SPS2HRszQTkoCqFyoLLlJq4FcuZZs1UUfC2R/Nnbpl0hs4A1T
 pilyesvomzUVHazxQnpB/wzQoMSA7wtBQ2NuDq0vMpwxaABJbWgNakRO+oc0b7L4IjHbGfE
 ATAw2YfLKWloLDpqL9Iqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RHe07HDFN5A=:mVOkXTXjrmqQZTjzZLkODn
 u2s/TCWM0OB0QbqFE1y3+417A1gdePo69YzBIjQ2q4kXLqOfiTxkmWIPsoZcpKfZM2ArJ4Hkj
 9QcWieIT2dxQO0e8uq1N2VofQEsnKHv9e7HT5Xi47iUxKz49S7o2/fmICLwaM9LdBE9YQ97wA
 BGOqrG7vn2yEu4BKpDckXdXl69sbMt2DQ3PZGox0VLqcMqkhBFUCizZ5wPgH27AnTg4+rlBe3
 jsmekZzGz7gyk/PQBfyPxI8Sfn9oeSbNYf54zXBHq0I/V0IVa0Gua5zddte4rsg/mEvoic3KQ
 dk25vSEmo0nHVcfEJ161BDrFfHQhacBdTCTsmfTvn1A0uOfW+etOCOX6ANHt143+u/eMTKE3G
 dkQCgwPjHM9F0ddTR2HWwPIgFQfjXmMqDuVTG70hFnYFXFMO6GfUVmVyOkzWmX44o1ABtk/hg
 FwTBV/mLUOmpmA7w8OKre3LbYtJ6MMNQSbLAeJF0rjVfzfKYECqmYbujUPLJZIJFerWCDedYx
 6qqCkt1K2thDZd2Kr+AQ3aAeGolO8C6OTWzTGjuTT+GbQrWpPX+mPoFOYJ37jT/EgSFPx58Qt
 u/+Hg0Vt4SUuofRokkQWp9aB9rIKJFBSGyVA65exwsv4DyB2sFC6Dk7pFD56jVll2F862dDf9
 RdgjCU8LcmhooXt26rGmnOgD3l/6PgbeEKHJFeundTKBjD1DJ9w3vjUYrpACC8GQLILs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272061>

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
index 41fd460..5f45115 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2230,6 +2230,13 @@ which would not pass pushing when `receive.fsckObjects = true`, allowing
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
index 3afe8f8..80574f9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -117,6 +117,14 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			fsck_msg_types.len ? ',' : '=', path);
+		return 0;
+	}
+
 	if (skip_prefix(var, "receive.fsck.", &var)) {
 		if (is_valid_msg_type(var, value))
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
diff --git a/fsck.c b/fsck.c
index a5e7dfb..9b8981e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -8,6 +8,7 @@
 #include "fsck.h"
 #include "refs.h"
 #include "utf8.h"
+#include "sha1-array.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -122,6 +123,43 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
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
@@ -193,6 +231,18 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 			if (values[equal] == '=' || values[equal] == ':')
 				break;
 
+		if (!substrcmp(values, equal, "skiplist")) {
+			char *path = xstrndup(values + equal + 1,
+				len - equal - 1);
+
+			if (equal == len)
+				die("skiplist requires a path");
+			init_skiplist(options, path);
+			free(path);
+			values += len;
+			continue;
+		}
+
 		if (equal == len)
 			die("Missing '=': '%.*s'", len, values);
 
@@ -227,6 +277,10 @@ static int report(struct fsck_options *options, struct object *object,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
+	if (options->skiplist && object &&
+			sha1_array_lookup(options->skiplist, object->sha1) >= 0)
+		return 0;
+
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 	else if (msg_type == FSCK_INFO)
diff --git a/fsck.h b/fsck.h
index 7e49372..cab9c65 100644
--- a/fsck.h
+++ b/fsck.h
@@ -33,6 +33,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	int *msg_type;
+	struct sha1_array *skiplist;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index cb077b7..1ada54c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,6 +123,18 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'push with receive.fsck.skiplist' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.skiplist SKIP &&
+	echo $commit >dst/.git/SKIP &&
+	git push --porcelain dst bogus
+'
+
 test_expect_success 'push with receive.fsck.missingemail=warn' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
-- 
2.3.1.windows.1.9.g8c01ab4
