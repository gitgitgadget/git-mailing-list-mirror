From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 4/5] daemon.c: accept extra service arguments
Date: Fri, 27 Feb 2015 17:01:57 -0800
Message-ID: <1425085318-30537-5-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnO-0003Zx-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbB1BCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 20:02:15 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36497 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbB1BCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:06 -0500
Received: by ierx19 with SMTP id x19so35433262ier.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kf5l7SAVsoHKskXTWVJMdp9QNIisthFjV1N+2QDwIaE=;
        b=ZlhbIqx38wMdz9k4f+f4y3hOUvx3sehtwtnK5GpFweUV/GU30yBoxqoV28ILhIO1sj
         UXZIgFtavWSn1luxqy5lqGDJp0S5K6AxtGoWWbwc4RI5v3Ai+QXlDFFPy7DWVP3piLJO
         0Oz0uVuhIzK0rDlqxCYoQYRFWXmkD0y8/qL2AOL3yLozr8ELj0GL30qrlvOcevSDaNJx
         yhTubOx5JPeZOV1X7uz6AXpJ/YIX2O/ZSNy3jp6V1HB2wqqF9tUp2H/LlN8QwZ/HWhFL
         Q1HsBbxP0D+nVjjRL5SxI2ztoIkwy+L41oSXZWRRLOjxLn/YSgDJalnYIHHUQ9zr24HJ
         veGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kf5l7SAVsoHKskXTWVJMdp9QNIisthFjV1N+2QDwIaE=;
        b=Jb8QY4LLW/gWTC+pQw0Td7mfX9fqCbn4ULE4eSve5zYHuyxj1d33KNxrQU4FCHNrD4
         eaLmjANhi8gTzpe9dL3c0e3+DsY6FJp7PXKLh/6FcFn3zO9DL2h4DYNW9KCGyFTb38GR
         WnUVbSiLS1xjYUdiIsZv6mwqIzDLUo2d4T/9Vy9rGOIgOj+nQ2Vfdf/3KJ7jWnda3eFv
         PLlVigrCOXRqvUIBG2xIWG4Z9D6LzY85w4ib6pybUc5/fCuzNPwk0L7FOU1rWRmbsUMr
         JQzyn05u20vKSfpDf9tkXzQy/tcePB35e+YGoMJ3SclI7dBxi1DB3amg9fG2rQMbKlhY
         cF4g==
X-Gm-Message-State: ALoCoQlefv99MQt1w+CUI+Pq7iwYUWp50KlXAx4NeWg6YRKogCrbmF3wHBRUJLnIWgaTk2sqZskB
X-Received: by 10.107.9.213 with SMTP id 82mr22406839ioj.56.1425085325786;
        Fri, 27 Feb 2015 17:02:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id r78sm3332561ioi.22.2015.02.27.17.02.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:05 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264521>

Before 73bb33a (daemon: Strictly parse the "extra arg" part of the
command - 2009-06-04) a client sending extra arguments could DoS
git-daemon. 73bb33a fixed it by forbidding extra arguments.

Allow arguments other than "host=" again as a preparation step for
upload-pack2. "host=" if present must be the first argument
though. The remaining arguments are concatenated by whitespace.

So far none of supported services support extra arguments. Attempting
to do will abort the service, just like how it is before. We might
want to make them silently ignore extra arguments though.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c |  3 ---
 daemon.c  | 37 ++++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/connect.c b/connect.c
index 7b6b241..97dd732 100644
--- a/connect.c
+++ b/connect.c
@@ -683,9 +683,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
-		 *
-		 * Note: Do not add any other headers here!  Doing so
-		 * will cause older git-daemon servers to crash.
 		 */
 		if (!service_flags)
 			packet_write(fd[1], "%s %s%chost=%s%c",
diff --git a/daemon.c b/daemon.c
index 54a03bd..c45d0d6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -221,7 +221,7 @@ static const char *path_ok(const char *directory)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-typedef int (*daemon_service_fn)(void);
+typedef int (*daemon_service_fn)(const char *);
 struct daemon_service {
 	const char *name;
 	const char *config_name;
@@ -302,7 +302,8 @@ error_return:
 	return -1;
 }
 
-static int run_service(const char *dir, struct daemon_service *service)
+static int run_service(const char *dir, struct daemon_service *service,
+		       const char *args)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -361,7 +362,7 @@ static int run_service(const char *dir, struct daemon_service *service)
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	return service->fn();
+	return service->fn(args);
 }
 
 static void copy_to_log(int fd)
@@ -403,27 +404,31 @@ static int run_service_command(const char **argv)
 	return finish_command(&cld);
 }
 
-static int upload_pack(void)
+static int upload_pack(const char *args)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
-	const char *argv[] = { "upload-pack", "--strict", NULL, ".", NULL };
+	const char *argv[] = { "upload-pack", "--strict", NULL, ".", NULL, NULL };
 
 	argv[2] = timeout_buf;
+	argv[4] = args;
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 	return run_service_command(argv);
 }
 
-static int upload_archive(void)
+static int upload_archive(const char *args)
 {
 	static const char *argv[] = { "upload-archive", ".", NULL };
+	if (args)
+		die("invalid request");
 	return run_service_command(argv);
 }
 
-static int receive_pack(void)
+static int receive_pack(const char *args)
 {
-	static const char *argv[] = { "receive-pack", ".", NULL };
+	static const char *argv[] = { "receive-pack", ".", NULL, NULL };
+	argv[2] = args;
 	return run_service_command(argv);
 }
 
@@ -487,7 +492,7 @@ static void parse_host_and_port(char *hostport, char **host,
 /*
  * Read the host as supplied by the client connection.
  */
-static void parse_host_arg(char *extra_args, int buflen)
+static void parse_host_arg(char *extra_args, char **remaining_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -514,8 +519,13 @@ static void parse_host_arg(char *extra_args, int buflen)
 			/* On to the next one */
 			extra_args = val + vallen;
 		}
-		if (extra_args < end && *extra_args)
-			die("Invalid request");
+	}
+
+	if (remaining_args) {
+		for (val = extra_args; val < end; val++)
+			if (!*val)
+				*val = ' ';
+		*remaining_args = extra_args;
 	}
 
 	/*
@@ -577,6 +587,7 @@ static int execute(void)
 {
 	char *line = packet_buffer;
 	int pktlen, len, i;
+	char *args = NULL;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 
 	if (addr)
@@ -603,7 +614,7 @@ static int execute(void)
 	hostname = canon_hostname = ip_address = tcp_port = NULL;
 
 	if (len != pktlen)
-		parse_host_arg(line + len + 1, pktlen - len - 1);
+		parse_host_arg(line + len + 1, &args, pktlen - len - 1);
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -616,7 +627,7 @@ static int execute(void)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(arg, s);
+			return run_service(arg, s, args);
 		}
 	}
 
-- 
2.3.0.81.gc37f363
