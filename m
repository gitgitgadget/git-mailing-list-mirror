From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 04/19] fsck: Offer a function to demote fsck errors to
 warnings
Date: Wed, 21 Jan 2015 20:24:37 +0100
Organization: gmx
Message-ID: <901cfd52214133a62e216b5d09f4671f63536827.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:24:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0tX-00025S-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbbAUTYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:24:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:51532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbAUTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:24:47 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MbbWD-1YUAIV1p6D-00J3ip; Wed, 21 Jan 2015 20:24:38
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:prOT0f5OwS8e36qjaYJ1XXmNUpU24UEWxUGuiBTsHbJZ7GVDfYh
 AA66bAaq32VBielnJKptZgKU86PRlOEYIjXvXVuFrJ525YiozxhnMDxMWN+nu2sLKXXZIav
 yQyypYt2RkyiT4/rgqd2L962VeYiGZkpaknZ045RK9mfsAN2v/cBProOrXolrhcPvH/X/Vd
 gFTvzVwqJl0mev+UeRgCw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262749>

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
 fsck.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fsck.h |  7 +++++--
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2d91e28..02715ee 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,13 +100,67 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 {
 	int severity;
 
-	severity = msg_id_info[msg_id].severity;
-	if (options->strict && severity == FSCK_WARN)
-		severity = FSCK_ERROR;
+	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+		severity = options->msg_severity[msg_id];
+	else {
+		severity = msg_id_info[msg_id].severity;
+		if (options->strict && severity == FSCK_WARN)
+			severity = FSCK_ERROR;
+	}
 
 	return severity;
 }
 
+static inline int substrcmp(const char *string, int len, const char *match)
+{
+	int match_len = strlen(match);
+	if (match_len != len)
+		return -1;
+	return memcmp(string, match, len);
+}
+
+void fsck_set_severity(struct fsck_options *options, const char *mode)
+{
+	int severity = FSCK_ERROR;
+
+	if (!options->msg_severity) {
+		int i;
+		int *msg_severity = xmalloc(sizeof(int) * FSCK_MSG_MAX);
+		for (i = 0; i < FSCK_MSG_MAX; i++)
+			msg_severity[i] = fsck_msg_severity(i, options);
+		options->msg_severity = msg_severity;
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
+			if (!substrcmp(mode, equal, "error"))
+				severity = FSCK_ERROR;
+			else if (!substrcmp(mode, equal, "warn"))
+				severity = FSCK_WARN;
+			else
+				die("Unknown fsck message severity: '%.*s'",
+					equal, mode);
+			mode += equal + 1;
+			len -= equal + 1;
+		}
+
+		msg_id = parse_msg_id(mode, len);
+		options->msg_severity[msg_id] = severity;
+		mode += len;
+	}
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -596,6 +650,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 
 int fsck_error_function(struct object *obj, int severity, const char *message)
 {
+	if (severity == FSCK_WARN) {
+		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
+		return 0;
+	}
 	error("object %s: %s", sha1_to_hex(obj->sha1), message);
 	return 1;
 }
diff --git a/fsck.h b/fsck.h
index f6f268a..4349860 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,8 @@
 
 struct fsck_options;
 
+void fsck_set_severity(struct fsck_options *options, const char *mode);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -25,10 +27,11 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	int *msg_severity;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0 }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1 }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.2.0.33.gc18b867
