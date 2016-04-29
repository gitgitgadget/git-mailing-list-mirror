From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/14] remote.h: add get_remote_capabilities, request_capabilities
Date: Fri, 29 Apr 2016 16:34:39 -0700
Message-ID: <1461972887-22100-7-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHws-0001Cp-TO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbcD2XfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:05 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35504 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbcD2XfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:03 -0400
Received: by mail-pf0-f178.google.com with SMTP id 77so21504846pfv.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7SlE4eBzxc91SwoENICLTqpnrtcFMBAjHaTp5gps+jg=;
        b=oD3gzrGgPzK9OX90emUrrIw3nkMa02reLnVJRqmyqLas1iUj9DrJ2TYsoHhWY3pTsb
         Rvh/lsmkvK3ydpcXF67ww5Dhto0dFk+wVw1GUOc/19cCX+WuuV2vEqDY+ycY5urvZ75I
         ABXLCOnERFsoIvn2Cs7U8gl/blzY2sn0XoHi9uYIhH9aUJpKoeZTQqcFY3MOgc0kkLkZ
         SoEfeXJMXU26c3r7p05ntQ/T2iZHB9HsreASgGc9S/UyHbq2xgszceFWGb7pZs3aKP9l
         3HOCLxG6oe9xMMINMaSQ3tiCv03SwXX3JbHbfuN5qmVrfjoEbc6xNapL2W9xvSWkvzJ0
         BLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7SlE4eBzxc91SwoENICLTqpnrtcFMBAjHaTp5gps+jg=;
        b=nMxcAomNo9whp2iPnSNn09ZJg9jq4FAn9IM9bMZ+wlvwu6ABO/1is2OTQLbP48f1UN
         KIHOArxewMt1VLMQWDUF7jcDs04OhdKn2Yn6cshVaAZdPQkwy3sD1nBuNu7Rhh6fZPkG
         qQkrZ6G155k7Vq+iIWp7yeBt0YJdLDGp+/831/0pP5XqdeCKP9JNNzbdFPiGGCz3pKRj
         h7j7KN75r/QvxgwnoPTXosVHnEX4sok1NJfbyAaJAm530UnbmHyZqW39nblQg8KI1yvQ
         KzzYIx1PY+XyY4a6onWyptsMXw1TlCiqcvt6t0kTwEKG/CVN2namNhY/qPM7uuZ42t1T
         pq5A==
X-Gm-Message-State: AOPr4FW5669pw8cfo7ZqGcnj1aFvzfvdX4WzrnZRuDKHh2zS3LqqCXxJUQeonvOd6/+8Z1Nt
X-Received: by 10.98.64.144 with SMTP id f16mr32632764pfd.159.1461972902935;
        Fri, 29 Apr 2016 16:35:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 80sm26212237pfx.68.2016.04.29.16.35.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293083>

Instead of calling get_remote_heads as a first command during the
protocol exchange, we need to have fine grained control over the
capability negotiation in version 2 of the protocol.

Introduce get_remote_capabilities, which will just listen to
capabilities of the remote and request_capabilities which will
tell the selection of capabilities to the remote.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h  |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/connect.c b/connect.c
index 79505fb..1ba9a0f 100644
--- a/connect.c
+++ b/connect.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "transport.h"
+#include "version.h"
 
 struct string_list server_capabilities = STRING_LIST_INIT_DUP;
 static const char *parse_feature_value(struct string_list *, const char *, int *);
@@ -106,6 +107,64 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
+const char *known_capabilities[] = {
+	"multi_ack",
+	"thin-pack",
+	"side-band",
+	"side-band-64k",
+	"ofs-delta",
+	"shallow",
+	"no-progress",
+	"include-tag",
+	"multi_ack_detailed",
+	"allow-tip-sha1-in-want",
+	"allow-reachable-sha1-in-want",
+	"no-done",
+};
+
+static int keep_capability(char *line)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(known_capabilities); i++)
+		if (starts_with(line, known_capabilities[i]))
+			return 1;
+	return 0;
+}
+
+void get_remote_capabilities(int in, char *src_buf, size_t src_len)
+{
+	for (;;) {
+		int len;
+		char *line = packet_buffer;
+
+		len = packet_read(in, &src_buf, &src_len,
+				  packet_buffer, sizeof(packet_buffer),
+				  PACKET_READ_GENTLE_ON_EOF |
+				  PACKET_READ_CHOMP_NEWLINE);
+		if (len < 0)
+			die_initial_contact(0);
+
+		if (!len)
+			break;
+
+		/*
+		 * We need to ignore and drop unknown capabilities as they
+		 * may be huge.
+		 */
+		if (keep_capability(line))
+			string_list_append(&server_capabilities, line);
+	}
+}
+
+
+void request_capabilities(int out, struct string_list *list)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, list)
+		packet_write(out, "%s\n", item->string);
+	packet_flush(out);
+}
+
 /*
  * Read all the refs from the other end
  */
diff --git a/remote.h b/remote.h
index cdb25d0..534282b 100644
--- a/remote.h
+++ b/remote.h
@@ -153,6 +153,9 @@ extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				     struct sha1_array *extra_have,
 				     struct sha1_array *shallow);
 
+extern void get_remote_capabilities(int in, char *src_buf, size_t src_len);
+extern void request_capabilities(int out, struct string_list*);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 
-- 
2.8.0.32.g71f8beb.dirty
