From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 3/5] connect.c: connect to a remote service with some flags
Date: Fri, 27 Feb 2015 17:01:56 -0800
Message-ID: <1425085318-30537-4-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnO-0003Zx-1s
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbB1BCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 20:02:07 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:40941 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB1BCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:05 -0500
Received: by igal13 with SMTP id l13so4909728iga.5
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NPWVyVRHWTi25xKY4IuNEtXoY8x8eqX/aAU+KLTalZ8=;
        b=RGTk1wC7vy94ncmU3pRxfGZjfGafNsVSePGRe371jQjuW3Kf6PUwATm23mL1dhiSCx
         7axE5L/eUzdZ7cFno7E8SgQOLHldOuG3ttTny/blkTMFLrG2BaO0WrSfUB4AK8jpA5c+
         RuWyjR7q1OyVN/Sqo68Zpabnl1LeeIPEOtEgocX9LVC6UrHd5jLWPvD2iEZ9MwHlHxqa
         r71pXz2z5m+7Eb7gWazvwSirErsWv2K8uWYZh+tNxEQ5eHnXfbfw/58Edhh4ugrdovI3
         zmCYfxEq3GHCpL/KvF8joPY4o2IoOMZmm611sdjdYD9wTbAm984f+MmUG1OUbd9vtBnr
         r1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NPWVyVRHWTi25xKY4IuNEtXoY8x8eqX/aAU+KLTalZ8=;
        b=Gl5cJ6MO4YzmeyiCPlzpxZ2GiGI/MZ+ZnxQqAM7gGGenHVILkMrWLf6HlX9QLbR0uX
         ZRY0CwcVsBy3hFFTaOdr5CAydY+lx/4K5w1DzpWf+8CBD32MFOlAXJxrs04qB3m4je6t
         J2uGIuyKQZDTFfTGdnIfWIaDBfLPH7gSavAx/w0SkZAozbtd4ZMNIfvcPKg5daM6pqSL
         +Eu9i/jf9HORHKcyRw8hS+gGxUbL/bWgYLPDaGGMM890vfR1pH/lYD0RgNk6ylBF7WGl
         EvuMuJb+UKqqmlTgbkpDZhK4g9FyMxdw0OLeLJ0ATP2eCGyurYHDyon6n+K/eUesERQ1
         nibQ==
X-Gm-Message-State: ALoCoQmqV2l5bTY6csaV+E6zA+GLL4nLLDdSjYMt8gy9G2r2jzv/ncZuvNGxVcdr+jNbu0HweH4c
X-Received: by 10.50.124.73 with SMTP id mg9mr8047675igb.38.1425085324728;
        Fri, 27 Feb 2015 17:02:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id ao5sm2299498igc.3.2015.02.27.17.02.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:04 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264520>

If this is over git protocol, the flags is appended as the next
parameter after host=. If it's ssh, a new argument is appended to the
command line.

None of the callers use this now though.

[sb: originally by pclouds, rebased as jk implemented 1823bea10,
(git_connect: use argv_array), so any error is mine]

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  2 +-
 connect.c            | 18 ++++++++++++------
 connect.h            |  2 +-
 transport.c          |  3 ++-
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..7e5b5fd 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -171,7 +171,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
 		conn = git_connect(fd, dest, args.uploadpack,
-				   flags);
+				   NULL, flags);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b961e5a..c2a066a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -261,7 +261,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, receivepack,
+		conn = git_connect(fd, dest, receivepack, NULL,
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
diff --git a/connect.c b/connect.c
index 062e133..7b6b241 100644
--- a/connect.c
+++ b/connect.c
@@ -650,7 +650,9 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url,
-				  const char *prog, int flags)
+				  const char *prog,
+				  const char *service_flags,
+				  int flags)
 {
 	char *hostandport, *path;
 	struct child_process *conn = &no_fork;
@@ -685,10 +687,13 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
-		packet_write(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
-			     target_host, 0);
+		if (!service_flags)
+			packet_write(fd[1], "%s %s%chost=%s%c",
+				     prog, path, 0, target_host, 0);
+		else
+			packet_write(fd[1], "%s %s%chost=%s%c%s%c",
+				     prog, path, 0, target_host, 0,
+				     service_flags, 0);
 		free(target_host);
 	} else {
 		conn = xmalloc(sizeof(*conn));
@@ -733,7 +738,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 			conn->use_shell = 1;
 		}
 		argv_array_push(&conn->args, cmd.buf);
-
+		if (service_flags)
+			argv_array_push(&conn->args, service_flags);
 		if (start_command(conn))
 			die("unable to fork");
 
diff --git a/connect.h b/connect.h
index c41a685..c4fa8a1 100644
--- a/connect.h
+++ b/connect.h
@@ -3,7 +3,7 @@
 
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
-extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, const char *service_flags, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
 extern int server_supports(const char *feature);
diff --git a/transport.c b/transport.c
index 0694a7c..626fd92 100644
--- a/transport.c
+++ b/transport.c
@@ -495,6 +495,7 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
+				 NULL,
 				 verbose ? CONNECT_VERBOSE : 0);
 
 	return 0;
@@ -850,7 +851,7 @@ static int connect_git(struct transport *transport, const char *name,
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 executable, 0);
+				 executable, NULL, 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
-- 
2.3.0.81.gc37f363
