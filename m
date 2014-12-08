From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Mon, 8 Dec 2014 17:14:30 +0100 (CET)
Message-ID: <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0y6-0006GC-CD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbaLHQPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:61199 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbaLHQPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:17 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LbPza-1XaFiP01qE-00kvXN;
 Mon, 08 Dec 2014 17:14:31 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TGcxx4tQcNdg4NsNjoV/5gxbUd1ecBmBIgCeoZE/o0ppRPNMC8G
 zCwo6mSxWFVCRCo2ICOJbOUxEn7bSCkLXjFSoqkR3s8ngBXDep9SYb6PkYKtuOuSXaUa1PT
 3Vj9OEUTHCkrnlJNQoVreiNsHUY8xOXZkhmM4MJFAI9t2TcMGjhvYm2e/bYs1tzJfnpEQIy
 E4pi82fdExXtmqcPs/NMw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261064>

There are legacy repositories out there whose older commits and tags
have issues that prevent pushing them when 'receive.fsckObjects' is set.
One real-life example is a commit object that has been hand-crafted to
list two authors.

Often, it is not possible to fix those issues without disrupting the
work with said repositories, yet it is still desirable to perform checks
by setting `receive.fsckObjects = true`. This commit is the first step
to allow demoting specific fsck issues to mere warnings.

The function added by this commit parses a list of settings in the form:

	missing-email=warn,bad-name=warn,...

Unfortunately, the FSCK_WARN/FSCK_ERROR flag is only really heeded by
git fsck so far, but other call paths (e.g. git index-pack --strict)
error out *always* no matter what type was specified. Therefore, we
need to take extra care to default to all FSCK_ERROR in those cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck.h |  7 +++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 05b146c..9e6d70f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -97,9 +97,63 @@ static int parse_msg_id(const char *text, int len)
 
 int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
 {
+	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+		return options->strict_mode[msg_id];
+	if (options->strict)
+		return FSCK_ERROR;
 	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
 }
 
+static inline int substrcmp(const char *string, int len, const char *match)
+{
+	int match_len = strlen(match);
+	if (match_len != len)
+		return -1;
+	return memcmp(string, match, len);
+}
+
+void fsck_strict_mode(struct fsck_options *options, const char *mode)
+{
+	int type = FSCK_ERROR;
+
+	if (!options->strict_mode) {
+		int i;
+		int *strict_mode = malloc(sizeof(int) * FSCK_MSG_MAX);
+		for (i = 0; i < FSCK_MSG_MAX; i++)
+			strict_mode[i] = fsck_msg_type(i, options);
+		options->strict_mode = strict_mode;
+	}
+
+	while (*mode) {
+		int len = strcspn(mode, " ,|"), equal, msg_id;
+
+		if (!len) {
+			mode++;
+			continue;
+		}
+
+		for (equal = 0; equal < len; equal++)
+			if (mode[equal] == '=')
+				break;
+
+		if (equal < len) {
+			const char *type_str = mode + equal + 1;
+			int type_len = len - equal - 1;
+			if (!substrcmp(type_str, type_len, "error"))
+				type = FSCK_ERROR;
+			else if (!substrcmp(type_str, type_len, "warn"))
+				type = FSCK_WARN;
+			else
+				die("Unknown fsck message type: '%.*s'",
+					len - equal - 1, type_str);
+		}
+
+		msg_id = parse_msg_id(mode, equal);
+		options->strict_mode[msg_id] = type;
+		mode += len;
+	}
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -585,6 +639,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 
 int fsck_error_function(struct object *obj, int type, const char *message)
 {
+	if (type == FSCK_WARN) {
+		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
+		return 0;
+	}
 	error("object %s: %s", sha1_to_hex(obj->sha1), message);
 	return 1;
 }
diff --git a/fsck.h b/fsck.h
index a18e9a6..9d67ea2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,8 @@
 
 struct fsck_options;
 
+void fsck_strict_mode(struct fsck_options *options, const char *mode);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -25,10 +27,11 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	int strict:1;
+	int *strict_mode;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0 }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1 }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.0.0.rc3.9669.g840d1f9
