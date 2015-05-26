From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of upload-pack
Date: Tue, 26 May 2015 15:01:08 -0700
Message-ID: <1432677675-5118-5-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMus-0001xC-KQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbEZWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:37 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33048 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbEZWBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:33 -0400
Received: by igbpi8 with SMTP id pi8so71635098igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tducA7Lbrlqy9dSXj6l299RzezbiEBPhiZFs7hn4dCc=;
        b=UCXq1XecXwGvXEAilJ7q5fGFA2080kS7g5nv+sJmJ4srJUpXamj9SP7GyzsqQxkvHL
         sDhWiuCK0hugrHMddFHvhOfLkSysZu0uXKzExVxhrQtbNx5gNPjfjtPNVri4DpPFkAee
         BSp2kB5yFez3krEcvtWF0S6RrYm2O6T2scceDtSwksmhJ+Wee5gQ/VkvksmrTJIIHZte
         WqwnkyDTk3QqNPqGclnsS/fj4NR8ZRPUPmDlmLCpHSQYwH/cXt2+JhT5qeR98Bf9N/jL
         HgKiNz4N0PpA5xY7oZyThkQjdJOE6cLDapj8t4f2KWRuaP00b/LgPh5FtqQEY0ZToywC
         7ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tducA7Lbrlqy9dSXj6l299RzezbiEBPhiZFs7hn4dCc=;
        b=GOigeSSJB0noq65eiLEMFOyf1TH8S2PjrQSX3E0duAVYGX5dbb3d+FPIA2iX3dXRFs
         xVoHswZ109QzrcX2f9dHmicfS8dyC0NkpVX4FjcCAFyTvOfphxoOyzSCcP6ZcTMmiCCE
         d4pJJh8Tz6LLpoN6Op0fX/cAw9bNa8NDhQ2+hYvz1CD78Hl3i5Loxbp/meeA+zIpcSi7
         0KabEAWpr5ZUHezbTk9uB/s3JqzsD9Fo3BMVllf708xeqN+z/+AIyiM7xE8HwI+OHinx
         DB8YNg3S7oeZiLUT+J/e36nbQ3jVm6U/TQxKkma/EkYcQWcBmzs8HDV9sqTlxXP+ZSrV
         jv8g==
X-Gm-Message-State: ALoCoQkAK4OlMxrIGjdpc6zqDgyuNUf34MKffAW5W4227c/WXXiloxY2hXCgvIbOkqpA+JY5lYow
X-Received: by 10.107.13.11 with SMTP id 11mr38197011ion.70.1432677692818;
        Tue, 26 May 2015 15:01:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id fm3sm9278031igb.1.2015.05.26.15.01.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269989>

In upload-pack-2 we send each capability in its own packet.
By reusing the advertise_capabilities and eventually setting it to
NULL we will be able to reuse the methods for refs advertisement.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .gitignore      |  1 +
 Makefile        |  2 ++
 upload-pack-2.c |  1 +
 upload-pack.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 78 insertions(+), 3 deletions(-)
 create mode 120000 upload-pack-2.c

diff --git a/.gitignore b/.gitignore
index a052419..a3c8ab9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@
 /git-update-server-info
 /git-upload-archive
 /git-upload-pack
+/git-upload-pack-2
 /git-var
 /git-verify-commit
 /git-verify-pack
diff --git a/Makefile b/Makefile
index 25a453b..0f3ee41 100644
--- a/Makefile
+++ b/Makefile
@@ -560,6 +560,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += upload-pack-2.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -625,6 +626,7 @@ OTHER_PROGRAMS = git$X
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
+BINDIR_PROGRAMS_NEED_X += git-upload-pack-2
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
diff --git a/upload-pack-2.c b/upload-pack-2.c
new file mode 120000
index 0000000..e30a871
--- /dev/null
+++ b/upload-pack-2.c
@@ -0,0 +1 @@
+upload-pack.c
\ No newline at end of file
diff --git a/upload-pack.c b/upload-pack.c
index a5f75b7..84f9ee3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -716,10 +716,47 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
-static const char *advertise_capabilities = "multi_ack thin-pack side-band"
+static char *advertise_capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
 
+/*
+ * Reads the next capability and puts it into dst as a null terminated string.
+ * Returns true if more capabilities can be read.
+ * */
+static int next_capability(char *dst)
+{
+	int len = 0;
+	if (!*advertise_capabilities) {
+		/* make sure to not advertise capabilities afterwards */
+		advertise_capabilities = NULL;
+		return 0;
+	}
+
+	while (advertise_capabilities[len] != '\0' &&
+	       advertise_capabilities[len] != ' ')
+		len ++;
+	strncpy(dst, advertise_capabilities, len);
+	dst[len] = '\0';
+
+	advertise_capabilities += len;
+	if (*advertise_capabilities == ' ')
+		advertise_capabilities++;
+
+	return 1;
+}
+
+static void send_capabilities(void)
+{
+	char buf[100];
+
+	while (next_capability(buf))
+		packet_write(1, "capability:%s\n", buf);
+
+	packet_write(1, "agent:%s\n", git_user_agent_sanitized());
+	packet_flush(1);
+}
+
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 
@@ -794,6 +831,28 @@ static void upload_pack(void)
 	}
 }
 
+static void receive_capabilities(void)
+{
+	int done = 0;
+	while (1) {
+		char *line = packet_read_line(0, NULL);
+		if (!line)
+			break;
+		if (starts_with(line, "capability:"))
+			parse_features(line + strlen("capability:"));
+	}
+}
+
+static void upload_pack_version_2(void)
+{
+	send_capabilities();
+	receive_capabilities();
+
+	/* The rest of the protocol stays the same, capabilities advertising
+	   is disabled though. */
+	upload_pack();
+}
+
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var))
@@ -806,16 +865,24 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static int endswith(const char *teststring, const char *ending)
+{
+	int slen = strlen(teststring);
+	int elen = strlen(ending);
+	return !strcmp(teststring + slen - elen, ending);
+}
+
 int main(int argc, char **argv)
 {
 	char *dir;
+	const char *cmd;
 	int i;
 	int strict = 0;
 
 	git_setup_gettext();
 
 	packet_trace_identity("upload-pack");
-	git_extract_argv0_path(argv[0]);
+	cmd = git_extract_argv0_path(argv[0]);
 	check_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
@@ -857,6 +924,10 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
-	upload_pack();
+
+	if (endswith(cmd, "-2"))
+		upload_pack_version_2();
+	else
+		upload_pack();
 	return 0;
 }
-- 
2.4.1.345.gab207b6.dirty
