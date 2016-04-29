From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/14] connect: rewrite feature parsing to work on string_list
Date: Fri, 29 Apr 2016 16:34:37 -0700
Message-ID: <1461972887-22100-5-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwm-000190-B2
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcD2XfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:06 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34590 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcD2XfC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:02 -0400
Received: by mail-pf0-f175.google.com with SMTP id y69so54012190pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPHvnCp5w3iC/vsO/Z596/jgMRoJsou8y/zIK9WFliU=;
        b=gh4Vn8nUYGE1NaDYmw13ON4megI8a7zerVT9wmzwTyWOBiqB0HHYqScT9JRqcfNvyX
         9kCcN8UD2/PBm259teCxWTAol1xU5Th8ztxjE+1pSnKCMxZ8zHn0ZvGoB9zjOqaB2jRw
         FeTN1TjZB+pLklT6WZQNVXmBAY0Q/QKMcuuEjJsLWSTQuTdd8Po112v5PNw31spgH1OE
         BiaANJ8EHYZ9UIYe6lQ1im2Ry0wqbhkgKta3VJlaqa8gRSIhyNuAvvo2D+KyxzriaMja
         L1lwa0ZHN7mKYxp2xrz0uEBWrC6nXbTY60RM4DeMdpkCbHiJIoowVGaUk3KQKCDMtz0M
         I3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPHvnCp5w3iC/vsO/Z596/jgMRoJsou8y/zIK9WFliU=;
        b=ZTTCfPvSeG9wI3vZGSNcS98lboYkipFWwghEDR8KCRgbbiK4xuncYq2N6sxWNDErAk
         jjT3R5wIwGzl8wh6uVMJtEx52u+wNRKDDZIju09KviLsLwoH/sm5kyzsJWq150DURdlO
         498eBAWeqLz1FVF00GS3ynt12PQftu/TpbYqRj8IUg/sOF9yyW+N62ARe4yRjk4rIF/2
         3lMKo9U/vPu5y3Jp5Hj1g5RBLPk4v77m/5Yc+Zup6eqWXGS+qHDLP+m4DngTpIxaerf/
         tbutxTL0LR7EGWHyX4Y7gvcweM4ESQm362TTqoZyD52V+pec0jSRAgqsA7lKKBc/ELnZ
         ei7Q==
X-Gm-Message-State: AOPr4FVEsdmNSdJhZQxLlYaVv6H4nlKDAEDlrOG77f45OXcRDfRRdXT3L2VX05hiDlax6r1/
X-Received: by 10.98.70.144 with SMTP id o16mr33134379pfi.26.1461972900221;
        Fri, 29 Apr 2016 16:35:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id e87sm26214280pfb.76.2016.04.29.16.34.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:34:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293081>

Later on when we introduce the version 2 transport protocol, the
capabilities will not be transported in one lone string but each
capability will be carried in its own pkt line.

To reuse existing infrastructure we would either need to join the
capabilities into a single string again later or refactor the current
capability parsing to be using a data structure which fits both
versions of the transport protocol. We chose to implement the later.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 15 ++++++---
 connect.c              | 82 +++++++++++++++++++++++---------------------------
 connect.h              |  2 +-
 upload-pack.c          | 13 ++++++--
 4 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a744437..4e98514 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1429,16 +1429,21 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 		linelen = strlen(line);
 		if (linelen < len) {
-			const char *feature_list = line + linelen + 1;
-			if (parse_feature_request(feature_list, "report-status"))
+			struct string_list feature_list = STRING_LIST_INIT_DUP;
+			string_list_split(&feature_list,
+					  line + linelen + 1,
+					  ' ', -1);
+			if (parse_feature_request(&feature_list, "report-status"))
 				report_status = 1;
-			if (parse_feature_request(feature_list, "side-band-64k"))
+			if (parse_feature_request(&feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
-			if (parse_feature_request(feature_list, "quiet"))
+			if (parse_feature_request(&feature_list, "quiet"))
 				quiet = 1;
 			if (advertise_atomic_push
-			    && parse_feature_request(feature_list, "atomic"))
+			    && parse_feature_request(&feature_list, "atomic"))
 				use_atomic = 1;
+
+			string_list_clear(&feature_list, 1);
 		}
 
 		if (!strcmp(line, "push-cert")) {
diff --git a/connect.c b/connect.c
index c53f3f1..79505fb 100644
--- a/connect.c
+++ b/connect.c
@@ -11,8 +11,8 @@
 #include "sha1-array.h"
 #include "transport.h"
 
-static char *server_capabilities;
-static const char *parse_feature_value(const char *, const char *, int *);
+struct string_list server_capabilities = STRING_LIST_INIT_DUP;
+static const char *parse_feature_value(struct string_list *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -81,18 +81,18 @@ reject:
 
 static void annotate_refs_with_symref_info(struct ref *ref)
 {
+	struct string_list_item *item;
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	const char *feature_list = server_capabilities;
 
-	while (feature_list) {
-		int len;
+	for_each_string_list_item(item, &server_capabilities) {
 		const char *val;
 
-		val = parse_feature_value(feature_list, "symref", &len);
-		if (!val)
-			break;
-		parse_one_symref_info(&symref, val, len);
-		feature_list = val + 1;
+		if (skip_prefix(item->string, "symref", &val)) {
+			if (!val)
+				continue;
+			val++; /* skip the = */
+			parse_one_symref_info(&symref, val, strlen(val));
+		}
 	}
 	string_list_sort(&symref);
 
@@ -155,9 +155,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		name = buffer + GIT_SHA1_HEXSZ + 1;
 
 		name_len = strlen(name);
+
 		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
-			free(server_capabilities);
-			server_capabilities = xstrdup(name + name_len + 1);
+			string_list_clear(&server_capabilities, 1);
+			string_list_split(&server_capabilities,
+					  name + name_len + 1,
+					  ' ', -1);
 		}
 
 		if (extra_have && !strcmp(name, ".have")) {
@@ -179,51 +182,40 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
+static const char *parse_feature_value(struct string_list *feature_list, const char *feature, int *lenp)
 {
-	int len;
-
-	if (!feature_list)
-		return NULL;
-
-	len = strlen(feature);
-	while (*feature_list) {
-		const char *found = strstr(feature_list, feature);
-		if (!found)
-			return NULL;
-		if (feature_list == found || isspace(found[-1])) {
-			const char *value = found + len;
-			/* feature with no value (e.g., "thin-pack") */
-			if (!*value || isspace(*value)) {
-				if (lenp)
-					*lenp = 0;
-				return value;
-			}
-			/* feature with a value (e.g., "agent=git/1.2.3") */
-			else if (*value == '=') {
-				value++;
-				if (lenp)
-					*lenp = strcspn(value, " \t\n");
-				return value;
-			}
-			/*
-			 * otherwise we matched a substring of another feature;
-			 * keep looking
-			 */
+	const char *value;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, feature_list) {
+		if (!skip_prefix(item->string, feature, &value))
+			continue;
+
+		/* feature with no value (e.g., "thin-pack") */
+		if (!*value) {
+			if (lenp)
+				*lenp = 0;
+			return value;
+		}
+		/* feature with a value (e.g., "agent=git/1.2.3") */
+		else if (*value == '=') {
+			value++;
+			if (lenp)
+				*lenp = strlen(value);
+			return value;
 		}
-		feature_list = found + 1;
 	}
 	return NULL;
 }
 
-int parse_feature_request(const char *feature_list, const char *feature)
+int parse_feature_request(struct string_list *feature_list, const char *feature)
 {
 	return !!parse_feature_value(feature_list, feature, NULL);
 }
 
 const char *server_feature_value(const char *feature, int *len)
 {
-	return parse_feature_value(server_capabilities, feature, len);
+	return parse_feature_value(&server_capabilities, feature, len);
 }
 
 int server_supports(const char *feature)
diff --git a/connect.h b/connect.h
index 01f14cd..eaf21c2 100644
--- a/connect.h
+++ b/connect.h
@@ -9,7 +9,7 @@ extern struct child_process *git_connect(int fd[2], const char *url, const char
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
 extern int server_supports(const char *feature);
-extern int parse_feature_request(const char *features, const char *feature);
+extern int parse_feature_request(struct string_list *, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
 extern int url_is_local_not_ssh(const char *url);
 
diff --git a/upload-pack.c b/upload-pack.c
index edfd417..4e69b8e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -535,7 +535,7 @@ error:
 	}
 }
 
-static void parse_features(const char *features)
+static void parse_features(struct string_list *features)
 {
 	if (parse_feature_request(features, "multi_ack_detailed"))
 		multi_ack = 2;
@@ -567,7 +567,9 @@ static void receive_needs(void)
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
+		struct string_list list = STRING_LIST_INIT_DUP;
 		char *line = packet_read_line(0, NULL);
+
 		reset_timeout();
 		if (!line)
 			break;
@@ -600,7 +602,9 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 
-		parse_features(line + 45);
+		string_list_split(&list, line + 45, ' ', -1);
+		parse_features(&list);
+		string_list_clear(&list, 1);
 
 		o = parse_object(sha1_buf);
 		if (!o)
@@ -840,9 +844,12 @@ static void send_capabilities_version_2(void)
 
 static void receive_capabilities_version_2(void)
 {
+	struct string_list list = STRING_LIST_INIT_NODUP;
 	char *line = packet_read_line(0, NULL);
 	while (line) {
-		parse_features(line);
+		string_list_append(&list, line);
+		parse_features(&list);
+		string_list_clear(&list, 1);
 		line = packet_read_line(0, NULL);
 	}
 }
-- 
2.8.0.32.g71f8beb.dirty
