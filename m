From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities, request_capabilities
Date: Tue, 26 May 2015 15:01:10 -0700
Message-ID: <1432677675-5118-7-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:02:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMvG-0002BM-O8
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbEZWCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:02:01 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35452 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbEZWBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:37 -0400
Received: by igbyr2 with SMTP id yr2so70309046igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJkGX45N7ZPXYtXpnG6jtBpnHkehsZRxLn+M0j5e2U4=;
        b=FN4ApvN6w5WAuuuzwtimkufN1X3jf+f5Gsrs4ZlNc2/Wq9Cr++WtxTJE3T4DGwmWnI
         mE9jeRrCVFSstkCvB6EL5b8KbMitBc0s4Jl+vpGNLR/9OxcyLxuKDj9Hjig+JZtCGuU2
         bfGMX7FpDIYM7lA8yczxxbKXkmWOyetRZbvnEqB/tRoqopyLgVLpQIZj74AblYpf7IQ0
         1tX/DnscnPc9KEJ0pc/JzKYz/Ko4deivyKng1ZxyTQX1JOlyMRZb6OHxLEwA3zuNV4XK
         n5dAgEn6kiKRuzWlJyjrqwOw/3SaTOTa6WmacS0rOfnbksW5qoDZlI2lGFBa0cQ9fNrQ
         AHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJkGX45N7ZPXYtXpnG6jtBpnHkehsZRxLn+M0j5e2U4=;
        b=jDaJbJYqzd+xVvvifHY7hwyIr9sdRWhtAKgq50J0N0GHZjLtf5FxsTWfaR04mkWEUb
         jy6egkU/V/U+n543XdEagivFTQ8KATFhghg0bvYNZ/4bFqvcjH9UrlZsgvzeV9+1cWj7
         trKTE53yAJpb9YS3Va4vbYT++tvpHJ2B3q5NGZiUklcBoLVDF4g39yeglrJqK+l3esVw
         2SEHvhXLqfkpKLD8Wddjf/o+Qyr1VtyjknJP8lsN3klwuSYQ2FM6tjCs1CMp6tTbQpO1
         1w+O14PyYNDJR33mU7uvJhUhBEpCFViIHjzra+TdzOPWSD5bid5FBZTPfGGm0xAZt8rQ
         XWZw==
X-Gm-Message-State: ALoCoQlNRosPVTcer+0vBKWxJdavlvwr3ksdiHgKARmqb6YSbQzJsxdwx4rEisaxIQD+DOXZlwmq
X-Received: by 10.50.2.3 with SMTP id 3mr7919610igq.34.1432677696429;
        Tue, 26 May 2015 15:01:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id l6sm315618igx.10.2015.05.26.15.01.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269996>

Instead of calling get_remote_heads as a first command during the
protocol exchange, we need to have fine grained control over the
capability negotiation in version 2 of the protocol.

Introduce get_remote_capabilities, which will just listen to
capabilities of the remote and request_capabilities which will
tell the selection of capabilities to the remote.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 remote.h  |  3 +++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index c0144d8..bb17618 100644
--- a/connect.c
+++ b/connect.c
@@ -105,8 +105,54 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
+void get_remote_capabilities(int in, char *src_buf, size_t src_len)
+{
+	struct strbuf capabilities_string = STRBUF_INIT;
+	for (;;) {
+		int len;
+		char *line = packet_buffer;
+		const char *arg;
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
+		if (len > 4 && skip_prefix(line, "ERR ", &arg))
+			die("remote error: %s", arg);
+
+		if (starts_with(line, "capability:")) {
+			strbuf_addstr(&capabilities_string, line + strlen("capability:"));
+			strbuf_addch(&capabilities_string, ' ');
+		}
+	}
+	free(server_capabilities);
+	server_capabilities = xmalloc(capabilities_string.len + 1);
+	server_capabilities = strbuf_detach(&capabilities_string, NULL);
+
+	strbuf_release(&capabilities_string);
+}
+
+int request_capabilities(int out)
+{
+	fprintf(stderr, "request_capabilities\n");
+	// todo: send our capabilities
+	packet_write(out, "capability:foo");
+	packet_flush(out);
+}
+
 /*
- * Read all the refs from the other end
+ * Read all the refs from the other end,
+ * in is a file descriptor input stream
+ * src_buf and src_len may be an alternative way to specify the input.
+ * list is the output of refs
+ * extra_have is a list to store information learned about sha1 the other side has.
+ * shallow_points
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
diff --git a/remote.h b/remote.h
index 04e2310..7381ddf 100644
--- a/remote.h
+++ b/remote.h
@@ -146,6 +146,9 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 struct sha1_array;
+
+extern void get_remote_capabilities(int in, char *src_buf, size_t src_len);
+extern int request_capabilities(int out);
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				     struct ref **list, unsigned int flags,
 				     struct sha1_array *extra_have,
-- 
2.4.1.345.gab207b6.dirty
