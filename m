From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 04/19] fsck: Offer a function to demote fsck errors to
 warnings
Date: Mon, 22 Jun 2015 17:25:25 +0200
Organization: gmx
Message-ID: <08ab723892b4412431b88df8764f506f0abbb0a6.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:25:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73bO-0006Vb-4S
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbFVPZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:25:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:52175 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbbFVPZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:25:29 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSv6D-1ZYryd0SjF-00Rsq4; Mon, 22 Jun 2015 17:25:26
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:TcC/6PoZ3UazfkuIgXyI5B/uomhBZyYXm5hCzKmtUWxH53MEWVC
 L9MP1neDWRNmQaEtfWH0NI8iRFlAm7p4SRHHSy3Ht+6XkzzzxLYAQOhYJmX6Ukse0r+DHve
 gRohXXw2aEzxODf8QJZGYX9wqs4k+Yg1wU820G0RKl5Vvft5W/IaMMIxXWebDbRtft+0XFe
 03VRLJ6oUy4+dPgNX6TPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D2Tage/oTOU=:KoaIS9iqdxZs285+vz32LA
 1TdzxAI2ZPoSLxTDuugD5h1+qaRMx0ZjeEbW+cJKK8d8nw5d1Uf7Re+hD8RN/LXsPdE8zkSPy
 o0y23HDpr+WYoxbrgLFSdp5CMiNXS1RfrQvuXhL8nvh+h/gxi9hpqggb2r4dVnT1BNWYNQKcN
 c9eJ6x7qakaRcyjq2HAhEKYNmYW3zZWpwsCjdJJiLha84STcOqSCeMOf+VDDdzoGKj3kV5TSF
 jCLoPm2nnPCkL+ox9acYn6eBRUqlFieCMy0YZNwOjop+tc+dtSBOUyKnt7uU6qRkW3N2665Y5
 XedYcatj0jWX6600QLOOWee1EoxVbOKC1hIm106tNJdY71gdy1tT3zGeg+Qu8AYI5H1ZfH7ls
 zXXc/hZTgQB2NrpZrWacla0F1olLN7j7kwHhaQM34EnLdG4kXxi5uT8u6CzKpHQRHSCMhjZnq
 baI0x7JS6QlGZPv+tfb9Tn03bcmW8yuONVdVMdFlCc1eFiaTjWkcgYuA8JvdzgagDqoe3anca
 aVKScDya7Lzw1/EO8nunIojO3TCVpMoAzdpw9dBCm54ABOkm6TbPaPm86guKpM7Tc2JLFQ46q
 cTQsd0bzjJXoow61hzrXFLHT7csbAIkOa86GAsb6G0jHmaoOlPtRIbR/1NLpybdHfCAqAg6Lh
 6wtkjGzceMPBHKjhl6R5vicRhhf78BDNhozTadCIbtOjB3Iv19ntbavhWW0dKN2Yhcok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272375>

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
 fsck.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 fsck.h |  9 +++++--
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1a3f7ce..e81a342 100644
--- a/fsck.c
+++ b/fsck.c
@@ -64,30 +64,29 @@ enum fsck_msg_id {
 #undef MSG_ID
 
 #define STR(x) #x
-#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
+#define MSG_ID(id, msg_type) { STR(id), NULL, FSCK_##msg_type },
 static struct {
 	const char *id_string;
+	const char *lowercased;
 	int msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
-	{ NULL, -1 }
+	{ NULL, NULL, -1 }
 };
 #undef MSG_ID
 
 static int parse_msg_id(const char *text)
 {
-	static char **lowercased;
 	int i;
 
-	if (!lowercased) {
+	if (!msg_id_info[0].lowercased) {
 		/* convert id_string to lower case, without underscores. */
-		lowercased = xmalloc(FSCK_MSG_MAX * sizeof(*lowercased));
 		for (i = 0; i < FSCK_MSG_MAX; i++) {
 			const char *p = msg_id_info[i].id_string;
 			int len = strlen(p);
 			char *q = xmalloc(len);
 
-			lowercased[i] = q;
+			msg_id_info[i].lowercased = q;
 			while (*p)
 				if (*p == '_')
 					p++;
@@ -98,7 +97,7 @@ static int parse_msg_id(const char *text)
 	}
 
 	for (i = 0; i < FSCK_MSG_MAX; i++)
-		if (!strcmp(text, lowercased[i]))
+		if (!strcmp(text, msg_id_info[i].lowercased))
 			return i;
 
 	return -1;
@@ -109,13 +108,78 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
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
 
+static int parse_msg_type(const char *str)
+{
+	if (!strcmp(str, "error"))
+		return FSCK_ERROR;
+	else if (!strcmp(str, "warn"))
+		return FSCK_WARN;
+	else
+		die("Unknown fsck message type: '%s'", str);
+}
+
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, const char *msg_type)
+{
+	int id = parse_msg_id(msg_id), type;
+
+	if (id < 0)
+		die("Unhandled message id: %s", msg_id);
+	type = parse_msg_type(msg_type);
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
+	char *buf = xstrdup(values), *to_free = buf;
+	int done = 0;
+
+	while (!done) {
+		int len = strcspn(buf, " ,|"), equal;
+
+		done = !buf[len];
+		if (!len) {
+			buf++;
+			continue;
+		}
+		buf[len] = '\0';
+
+		for (equal = 0; equal < len &&
+				buf[equal] != '=' && buf[equal] != ':'; equal++)
+			buf[equal] = tolower(buf[equal]);
+		buf[equal] = '\0';
+
+		if (equal == len)
+			die("Missing '=': '%s'", buf);
+
+		fsck_set_msg_type(options, buf, buf + equal + 1);
+		buf += len + 1;
+	}
+	free(to_free);
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -605,6 +669,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 
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
index f6f268a..af3c84e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,10 @@
 
 struct fsck_options;
 
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, const char *msg_type);
+void fsck_set_msg_types(struct fsck_options *options, const char *values);
+
 /*
  * callback function for fsck_walk
  * type is the expected type of the object or OBJ_ANY
@@ -25,10 +29,11 @@ struct fsck_options {
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
