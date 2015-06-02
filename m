From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 03/16] connect: rewrite feature parsing to work on string_list
Date: Mon,  1 Jun 2015 17:02:05 -0700
Message-ID: <1433203338-27493-4-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfI-0000iX-EM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbbFBACl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:41 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33095 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbFBACf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:35 -0400
Received: by iebgx4 with SMTP id gx4so121186062ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tawBgt4lySwLIARFKyBx/tdDgRSUYgRWZO6PvFYhtpA=;
        b=BgPpqGYn463MNUaHs4S4JiPwsIbhp5BbAyrLRFcHgucohvl6IAB0BtJ5AbwDmrhl/1
         GhWwYFk7vULxnP2mxk4O7P+D3IP3tvbehVSlUgSYa8m28EwDGyunoc43SD2IwcGr38v8
         xSSVRNf6vnddfoLFYmmRDSbl7o9jk99FzUkYRvsNr8dNHta7kF+WL+olWMLdkUZ9oag5
         DiEFVyakqnDBt5zT+HC87+JkzTA52/TrUtAXKO9pTmrskDdNw+gv8IQut4CnvEuuTcvF
         501/TZgGIianvtJf7gcoJ+G/AEx8A2iDdnQ3ewPEb78JnmTnU1fEWyaV0moPDyl8yopm
         yeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tawBgt4lySwLIARFKyBx/tdDgRSUYgRWZO6PvFYhtpA=;
        b=IbCzh2aCOhsLMrQmsWLxlkmIYdEIT3DHAjRVZM4WZAJrk4I4HABgdsDzi5pTpKDgtl
         ME77Z63ch2LxcuvFNEgbOE0Nh1P+AJ2QJNJbnTtXCJReBGRjR0ZYL/pw/C9NyjN3p28j
         /0ZlakvV3USlq9hYhV+zHW87n7KXCS0MakUxoGgENXCOhsXM+R27VEXrWxk1VnibH2+Q
         OeIFlqhZuTcbaDC0nsm9nCUZmCUNS3LA16i5kxzzj+dxNQCeulIRf4jWH9Zz6BktThd+
         DSYCl5GFLk7TPi81BcE6Kkt6mlqN+DjW5PGXCDUva6SBAZuIioWzgmOOaO4BTBrgmrRA
         NaXQ==
X-Gm-Message-State: ALoCoQl81nj+ICvtRwQX+I7dDd2zFuaccMVhu/d6qSocQdWLaGX9a4hAEITAApNBbi85Nzv5stIE
X-Received: by 10.43.84.73 with SMTP id aj9mr31996235icc.69.1433203355233;
        Mon, 01 Jun 2015 17:02:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id p4sm8901501igg.20.2015.06.01.17.02.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270486>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 13 +++++----
 connect.c              | 79 ++++++++++++++++++++++----------------------------
 connect.h              |  2 +-
 upload-pack.c          | 11 +++++--
 4 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2ec52b..518ce85 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1391,16 +1391,19 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 		linelen = strlen(line);
 		if (linelen < len) {
-			const char *feature_list = line + linelen + 1;
-			if (parse_feature_request(feature_list, "report-status"))
+			struct string_list feature_list = STRING_LIST_INIT_DUP;
+			from_space_separated_string(&feature_list, line + linelen + 1);
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
index c0144d8..4295ba1 100644
--- a/connect.c
+++ b/connect.c
@@ -10,8 +10,8 @@
 #include "string-list.h"
 #include "sha1-array.h"
 
-static char *server_capabilities;
-static const char *parse_feature_value(const char *, const char *, int *);
+struct string_list server_capabilities = STRING_LIST_INIT_DUP;
+static const char *parse_feature_value(struct string_list *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -80,18 +80,18 @@ reject:
 
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
 
@@ -153,8 +153,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 
 		name_len = strlen(name);
 		if (len != name_len + 41) {
-			free(server_capabilities);
-			server_capabilities = xstrdup(name + name_len + 1);
+			string_list_clear(&server_capabilities, 1);
+			from_space_separated_string(&server_capabilities, name + name_len + 1);
 		}
 
 		if (extra_have && !strcmp(name, ".have")) {
@@ -176,51 +176,40 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
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
index c41a685..47492e5 100644
--- a/connect.h
+++ b/connect.h
@@ -7,7 +7,7 @@ extern struct child_process *git_connect(int fd[2], const char *url, const char
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
 extern int server_supports(const char *feature);
-extern int parse_feature_request(const char *features, const char *feature);
+extern int parse_feature_request(struct string_list *, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
 extern int url_is_local_not_ssh(const char *url);
 
diff --git a/upload-pack.c b/upload-pack.c
index 5449ff7..2493964 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -531,7 +531,7 @@ error:
 	}
 }
 
-static void parse_features(const char *features)
+static void parse_features(struct string_list *features)
 {
 	if (parse_feature_request(features, "multi_ack_detailed"))
 		multi_ack = 2;
@@ -563,7 +563,10 @@ static void receive_needs(void)
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
-		char *line = packet_read_line(0, NULL);
+		int pkt_len;
+		struct string_list list = STRING_LIST_INIT_DUP;
+		char *line = packet_read_line(0, &pkt_len);
+
 		reset_timeout();
 		if (!line)
 			break;
@@ -596,7 +599,9 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 
-		parse_features(line + 45);
+		from_space_separated_string(&list, xstrdup(line + 45));
+		parse_features(&list);
+		string_list_clear(&list, 1);
 
 		o = parse_object(sha1_buf);
 		if (!o)
-- 
2.4.1.345.gab207b6.dirty
