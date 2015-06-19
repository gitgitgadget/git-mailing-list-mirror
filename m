From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors to
 warnings
Date: Fri, 19 Jun 2015 15:33:12 +0200
Organization: gmx
Message-ID: <44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:33:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wQF-0007tD-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbFSNd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:33:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:55582 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbbFSNd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:33:27 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mbx62-1ZN3rY3fyo-00JKP4; Fri, 19 Jun 2015 15:33:14
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:7ItotvGBeeW4owVDw1t9HlUUiz6WicfWiKgWcf2cVKcDIKerV81
 /BUfYtCwAVau7KIIduf82ReR6TsU6srwcVhLwN3n/dP8cR5LcF5BKPUCQdu5Rbe0lUKDDAQ
 BU+4ElLj3xV1HXfw6dmPmDDpDwzyb8BxOPY224FWAzJKYNCB9tiYYte2RgEt5RsrnjjoPAn
 WO5PQtMTU4zA6reZAo8/Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272140>

There are legacy repositories out there whose older commits and tags
have issues that prevent pushing them when 'receive.fsckObjects' is set.
One real-life example is a commit object that has been hand-crafted to
list two authors.

Often, it is not possible to fix those issues without disrupting the
work with said repositories, yet it is still desirable to perform checks
by setting `receive.fsckObjects = true`. This commit is the first step
to allow demoting specific fsck issues to mere warnings.

The `fsck_set_msg_types()` function added by this commit parses a list
of settings in the form:

	missingemail=warn,badname=warn,...

Unfortunately, the FSCK_WARN/FSCK_ERROR flag is only really heeded by
git fsck so far, but other call paths (e.g. git index-pack --strict)
error out *always* no matter what type was specified. Therefore, we need
to take extra care to set all message types to FSCK_ERROR by default in
those cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fsck.h | 10 ++++++--
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index da5717c..8c3caff 100644
--- a/fsck.c
+++ b/fsck.c
@@ -103,13 +103,85 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 {
 	int msg_type;
 
-	msg_type = msg_id_info[msg_id].msg_type;
-	if (options->strict && msg_type == FSCK_WARN)
-		msg_type = FSCK_ERROR;
+	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
+
+	if (options->msg_type)
+		msg_type = options->msg_type[msg_id];
+	else {
+		msg_type = msg_id_info[msg_id].msg_type;
+		if (options->strict && msg_type == FSCK_WARN)
+			msg_type = FSCK_ERROR;
+	}
 
 	return msg_type;
 }
 
+static inline int substrcmp(const char *string, int len, const char *match)
+{
+	int match_len = strlen(match);
+	if (match_len != len)
+		return -1;
+	return memcmp(string, match, len);
+}
+
+static int parse_msg_type(const char *str, int len)
+{
+	if (len < 0)
+		len = strlen(str);
+
+	if (!substrcmp(str, len, "error"))
+		return FSCK_ERROR;
+	else if (!substrcmp(str, len, "warn"))
+		return FSCK_WARN;
+	else
+		die("Unknown fsck message type: '%.*s'",
+				len, str);
+}
+
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, int msg_id_len,
+		const char *msg_type, int msg_type_len)
+{
+	int id = parse_msg_id(msg_id, msg_id_len), type;
+
+	if (id < 0)
+		die("Unhandled message id: %.*s", msg_id_len, msg_id);
+	type = parse_msg_type(msg_type, msg_type_len);
+
+	if (!options->msg_type) {
+		int i;
+		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
+		for (i = 0; i < FSCK_MSG_MAX; i++)
+			msg_type[i] = fsck_msg_type(i, options);
+		options->msg_type = msg_type;
+	}
+
+	options->msg_type[id] = type;
+}
+
+void fsck_set_msg_types(struct fsck_options *options, const char *values)
+{
+	while (*values) {
+		int len = strcspn(values, " ,|"), equal;
+
+		if (!len) {
+			values++;
+			continue;
+		}
+
+		for (equal = 0; equal < len; equal++)
+			if (values[equal] == '=' || values[equal] == ':')
+				break;
+
+		if (equal == len)
+			die("Missing '=': '%.*s'", len, values);
+
+		fsck_set_msg_type(options, values, equal,
+				values + equal + 1, len - equal - 1);
+		values += len;
+	}
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -599,6 +671,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 
 int fsck_error_function(struct object *obj, int msg_type, const char *message)
 {
+	if (msg_type == FSCK_WARN) {
+		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
+		return 0;
+	}
 	error("object %s: %s", sha1_to_hex(obj->sha1), message);
 	return 1;
 }
diff --git a/fsck.h b/fsck.h
index f6f268a..edb4540 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,11 @@
 
 struct fsck_options;
 
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, int msg_id_len,
+		const char *msg_type, int msg_type_len);
+void fsck_set_msg_types(struct fsck_options *options, const char *values);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -25,10 +30,11 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	int *msg_type;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0 }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1 }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.3.1.windows.1.9.g8c01ab4
