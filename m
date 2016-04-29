From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/14] upload-pack-2: Implement the version 2 of upload-pack
Date: Fri, 29 Apr 2016 16:34:36 -0700
Message-ID: <1461972887-22100-4-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwH-0000r8-9p
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbcD2XfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32944 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbcD2Xe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:34:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id zm5so56984899pac.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPGeNtcXOlRyRCozU/NW4ljslAcK1Jk9Qp8JDuN7nV8=;
        b=cbX/IrETH0v988RPCPt1qlJncOFZMMxeEq/NFTb+on4v5MtpYkKPfLaNXEiXdXSDzs
         hrloSPPqDcf60Qn/hiM2FXu/yHZpalUHqt0bAim06PkW74q/p0PgyVp2AH0XbHGrOw2h
         9KNPR+yHfG5anoI+jFXaQ6ulySsgF8UxYdbybLHHeFnSknghoi2SxlAG0wiaooErv0dQ
         aFB7IBOTV/9XGgnHVYVnCVtT8nhhjPTIkjM8X3bWYiyj89tKg+otTF4Bsb6qDcemC40+
         EgCCV3dTRzE1g4XF/aiHkkfQh3woAFW1gVIID+32HmvI6KMf8iMcpWOn4ADKWitC5qmd
         qIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPGeNtcXOlRyRCozU/NW4ljslAcK1Jk9Qp8JDuN7nV8=;
        b=RG6tZEJXB+L9khH9HJYUs7YIWe+N+trB6OcS60aHFHdVDTO5g52DxxKd6lQZrdcaNS
         unO/1es1ynC4zwyBWTWwLgeAAru+yC0bs4tEw50PKZl2pxSZOCqXH/0X96Q3uNLeq+NV
         s8TonW8ZcpZDpYnPtFIfE6JsjEhxQtwnoeHbxb8jzwWgT3Vv/wjRjqyMglfJB/9cr1lf
         poqTWc3A0qfrfg0uPNsx5irGV5Dv0qNjkAzy27Pfk2pqctmDmpLriwLw056HZMkih8zh
         tGNY4FGo7Cfv9DX62MB9lVhYWWg05ol2fUvFWjRT+/tpyzQVGcj3dhuFOI0XdsAR8TNo
         I3ww==
X-Gm-Message-State: AOPr4FXpPs/gxQeuTkybCZ+tC3V2GJhvT7/sWAm5/IKR7UINLIV9L7/nZjG+I5NM/RU6ltYk
X-Received: by 10.66.146.164 with SMTP id td4mr32900894pab.47.1461972898756;
        Fri, 29 Apr 2016 16:34:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id kh2sm33281375pad.9.2016.04.29.16.34.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:34:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293073>

In upload-pack-2 we send each capability in its own packet buffer.
The construction of upload-pack-2 is a bit unfortunate as I would like
it to not be depending on a symlink linking to upload-pack.c, but I did
not find another easy way to do it. I would like it to generate
upload-pack-2.o from upload-pack.c but with '-DTRANSPORT_VERSION=2' set.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .gitignore      |  1 +
 Makefile        |  4 ++++
 upload-pack-2.c |  1 +
 upload-pack.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)
 create mode 120000 upload-pack-2.c

diff --git a/.gitignore b/.gitignore
index 5087ce1..9a6ea8c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -166,6 +166,7 @@
 /git-update-server-info
 /git-upload-archive
 /git-upload-pack
+/git-upload-pack-2
 /git-var
 /git-verify-commit
 /git-verify-pack
diff --git a/Makefile b/Makefile
index a83e322..3d96126 100644
--- a/Makefile
+++ b/Makefile
@@ -580,6 +580,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += upload-pack-2.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -648,6 +649,7 @@ OTHER_PROGRAMS = git$X
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
+BINDIR_PROGRAMS_NEED_X += git-upload-pack-2
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
@@ -1730,6 +1732,8 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
+$X%-2.o: EXTRA_CPPFLAGS = '-DTRANSPORT_VERSION=2'
+
 common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
diff --git a/upload-pack-2.c b/upload-pack-2.c
new file mode 120000
index 0000000..e30a871
--- /dev/null
+++ b/upload-pack-2.c
@@ -0,0 +1 @@
+upload-pack.c
\ No newline at end of file
diff --git a/upload-pack.c b/upload-pack.c
index 85381d5..edfd417 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -820,6 +820,45 @@ static void upload_pack(void)
 	}
 }
 
+#if (TRANSPORT_VERSION == 2)
+static void send_capabilities_version_2(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
+		const char *cap = all_capabilities[i];
+		if (!strcmp(cap, "allow-tip-sha1-in-want")
+		    && !(allow_unadvertised_object_request & ALLOW_TIP_SHA1))
+			continue;
+		if (!strcmp(cap, "no-done") && !stateless_rpc)
+			continue;
+		packet_write(1, "%s\n", cap);
+	}
+
+	packet_write(1, "agent=%s\n", git_user_agent_sanitized());
+	packet_flush(1);
+}
+
+static void receive_capabilities_version_2(void)
+{
+	char *line = packet_read_line(0, NULL);
+	while (line) {
+		parse_features(line);
+		line = packet_read_line(0, NULL);
+	}
+}
+
+static void upload_pack_version_2(void)
+{
+	send_capabilities_version_2();
+	receive_capabilities_version_2();
+
+	/* The rest of the protocol stays the same, capabilities advertising
+	   is disabled though. */
+	advertise_capabilities = 0;
+	upload_pack();
+}
+#endif
+
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
@@ -847,8 +886,11 @@ int main(int argc, char **argv)
 	int strict = 0;
 
 	git_setup_gettext();
-
+#if TRANSPORT_VERSION == 2
+	packet_trace_identity("upload-pack-2");
+#else
 	packet_trace_identity("upload-pack");
+#endif
 	git_extract_argv0_path(argv[0]);
 	check_replace_refs = 0;
 
@@ -891,6 +933,11 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
+
+#if TRANSPORT_VERSION == 2
+	upload_pack_version_2();
+#else
 	upload_pack();
+#endif
 	return 0;
 }
-- 
2.8.0.32.g71f8beb.dirty
