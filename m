From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 04/16] upload-pack-2: Implement the version 2 of upload-pack
Date: Mon,  1 Jun 2015 17:02:06 -0700
Message-ID: <1433203338-27493-5-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfP-0000iz-J9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbbFBACo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:44 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36576 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbbFBACh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:37 -0400
Received: by ieclw1 with SMTP id lw1so26286825iec.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apfUOFjNvvqFzljEP8uoH8lNMrE8EG3NMdAEsZ0X8W0=;
        b=i83Ls6S4u6Pih7Z/FCzS9g5VAXwNFLlmqQM/7cGeluNUhKIrhlGaHMwEvhijSto9g+
         DcI3izl9lYIRgIyGI074G9sRrxasZf7+rZy2WwtfoxgvEQ9AWqKigZ3qXb86AZcUrF+R
         o6OPRgoPLoe3N1Yjcww7JFZsj5z/5HauIe6K8io+MUQBIlywVC1J5tKcBGlQ+ZCySkc+
         cgrG4O90bcsZfcmzJp7gz6xbcI3ZL9hdCGJEs/qpFFe8J6W6bSJIvlasQCFLDFHl10/b
         LcJOF3X5YnvOebdJnyZhxCmInuZSI8ubK9RzphwL3vPcL9GYiU+PpKyVyQYUy9pXFbmP
         PFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apfUOFjNvvqFzljEP8uoH8lNMrE8EG3NMdAEsZ0X8W0=;
        b=EWX/rrNsZgsacm7VNfzBzBIIi+lJJdMwI+gnRpNdSsM4deyS4JwF0dyapc2RIWrAvA
         A5e/y7MrRt6mrH/5QHGCGXla1Mmb4qtnjKINCqeGuUqbzI2KuBNw8VFjzVkLRzpCMG2Y
         3wqva5aNwQYzBPrApSa5jDsChPCwVqdCZWbnOfJKW5PmO8Sg4M1gK3hx2LFrpUJpGfZQ
         qPnKSsM0gnV1JgAfyUl7ym21O5xXtDqhNAnsMj/jpGSFk5jAp3k5t/pyHP0h3hdTbGX5
         eYfmEkvfL7XIuxXDVE8BpgvLXIdlqrz41CqmjKxl1gzs8brL3tysPrryZ6/0FKCwvKid
         WG9w==
X-Gm-Message-State: ALoCoQmXtmRUu6xtG6Nho4+WWQ4C2aACWjV7w6fJEKCrPDd9KuX9IQyBZyhuikkjgmq6CJur7lOh
X-Received: by 10.50.64.147 with SMTP id o19mr16617230igs.33.1433203356632;
        Mon, 01 Jun 2015 17:02:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id z195sm11475981iod.33.2015.06.01.17.02.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270485>

In upload-pack-2 we send each capability in its own packet buffer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Moved the capabilities into a struct containing all the capabilities,
    and then we selectively cancel out unwanted capabilities.

 .gitignore      |   1 +
 Makefile        |   2 ++
 upload-pack-2.c |   1 +
 upload-pack.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 86 insertions(+), 18 deletions(-)
 create mode 120000 upload-pack-2.c

diff --git a/.gitignore b/.gitignore
index 422c538..2213af4 100644
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
index 323c401..f83f02d 100644
--- a/Makefile
+++ b/Makefile
@@ -560,6 +560,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += upload-pack-2.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -626,6 +627,7 @@ OTHER_PROGRAMS = git$X
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
index 2493964..7477ca3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -716,33 +716,69 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
+static int advertise_capabilities = 1;
+const char *all_capabilities[] = {
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
+	"no-done",
+};
+
+static void send_capabilities(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
+		const char *cap = all_capabilities[i];
+		if (!strcmp(cap, "allow-tip-sha1-in-want") && !allow_tip_sha1_in_want)
+			continue;
+		if (!strcmp(cap, "no-done") && !stateless_rpc)
+			continue;
+		packet_write(1,"%s", cap);
+	}
+
+	packet_write(1, "agent=%s\n", git_user_agent_sanitized());
+	packet_flush(1);
+}
+
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
 	if (mark_our_ref(refname, sha1))
 		return 0;
 
-	if (capabilities) {
-		struct strbuf symref_info = STRBUF_INIT;
-
-		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
-			     sha1_to_hex(sha1), refname_nons,
-			     0, capabilities,
-			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
-			     stateless_rpc ? " no-done" : "",
-			     symref_info.buf,
-			     git_user_agent_sanitized());
-		strbuf_release(&symref_info);
+	if (advertise_capabilities) {
+		int i;
+		struct strbuf capabilities = STRBUF_INIT;
+
+		for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
+			const char *cap = all_capabilities[i];
+			if (!strcmp(cap, "allow-tip-sha1-in-want") && !allow_tip_sha1_in_want)
+				continue;
+			if (!strcmp(cap, "no-done") && !stateless_rpc)
+				continue;
+			strbuf_addf(&capabilities, " %s", cap);
+		}
+
+		format_symref_info(&capabilities, cb_data);
+		strbuf_addf(&capabilities, " agent=%s", git_user_agent_sanitized());
+
+		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname_nons,
+			     0, capabilities.buf);
+		strbuf_release(&capabilities);
+		advertise_capabilities = 0;
 	} else {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	}
-	capabilities = NULL;
 	if (!peel_ref(refname, peeled))
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
@@ -792,6 +828,29 @@ static void upload_pack(void)
 	}
 }
 
+static void receive_capabilities(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	char *line = packet_read_line(0, NULL);
+	while (line) {
+		string_list_append(&list, line);
+		line = packet_read_line(0, NULL);
+	}
+	parse_features(&list);
+	string_list_clear(&list, 1);
+}
+
+static void upload_pack_version_2(void)
+{
+	send_capabilities();
+	receive_capabilities();
+
+	/* The rest of the protocol stays the same, capabilities advertising
+	   is disabled though. */
+	advertise_capabilities = 0;
+	upload_pack();
+}
+
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var))
@@ -807,13 +866,14 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
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
@@ -855,6 +915,10 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
-	upload_pack();
+
+	if (ends_with(cmd, "-2"))
+		upload_pack_version_2();
+	else
+		upload_pack();
 	return 0;
 }
-- 
2.4.1.345.gab207b6.dirty
