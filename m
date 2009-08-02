From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 2/2] fast-import: add option command
Date: Sat,  1 Aug 2009 22:06:09 -0700
Message-ID: <1249189570-26576-3-git-send-email-srabbelier@gmail.com>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
 <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
 <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 07:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXTHv-0001YW-Pn
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 07:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbZHBFHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 01:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbZHBFG7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 01:06:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:52835 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZHBFG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 01:06:59 -0400
Received: by rv-out-0506.google.com with SMTP id f6so836613rvb.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1xz7V2zfeAIvlUVQ6c4YEjfWdwkArc0aLsGEMG9kObM=;
        b=qNF5wQEkHNYKHg0CW4Upb3x4XPYrXe4rM4oZQv5DQ9n1aRH9/rtIWQLWBTB4j2CqAO
         bjExQoyXfdTcW7djUsK2hNgE0C7qNWNIRubuhQOqs4SPWUsl61Rg7Lhy1Y7Bg8jEtb+C
         32tDSzJvy4HW4JktjifOE6EZv2bQQIXMwD/Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mj4Za73AyXTo677675tzMiwmvdCK4yZY0X9hOWKGQ3H+1EYccEBdc9fgkD2FRnJrUJ
         ogbUsK/tq4gZi1x377DHpbe3Qukxiptgo4HI5RsK9bBvGjOSNAI2UDwv7F9Xe6LjCriQ
         wygiDBrqO0pgJ2bs0lcsSSsHB+/usSuCc1fOg=
Received: by 10.140.132.13 with SMTP id f13mr2871871rvd.124.1249189620229;
        Sat, 01 Aug 2009 22:07:00 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm27870127rvb.40.2009.08.01.22.06.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 22:06:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.15.g8b2be
In-Reply-To: <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124664>

This allows the frontend to specify any of the supported options as
long as no non-option command has been given. This way the
user does not have to include any frontend-specific options, but
instead she can rely on the frontend to tell fast-import what it
needs.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    This addds an extra prefixcmp for each command, but only for the
    first command, and any 'option' commands. I felt that was better
    than to add seen_non_option_command=1 to each other command.

 fast-import.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 57fff3b..2007ed8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -348,6 +348,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int seen_non_option_command;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1663,6 +1664,10 @@ static int read_next_command(void)
 			if (stdin_eof)
 				return EOF;
 
+			if (!seen_non_option_command
+				&& prefixcmp(command_buf.buf, "option "))
+				seen_non_option_command = 1;
+
 			rc = rc_free;
 			if (rc)
 				rc_free = rc->next;
@@ -2422,6 +2427,38 @@ static void option_stats() {
 	show_stats = 1;
 }
 
+static void parse_option(void)
+{
+    char* option = command_buf.buf + 7;
+
+	if (seen_non_option_command)
+		die("Got option command '%s' after non-option command", option);
+
+    if (!prefixcmp(option, "date-format")) {
+		option_date_format(option + 12);
+    } else if (!prefixcmp(option, "max-pack-size")) {
+		option_max_pack_size(option + 14);
+    } else if (!prefixcmp(option, "depth")) {
+		option_depth(option + 6);
+    } else if (!prefixcmp(option, "active-branches")) {
+		option_active_branches(option + 16);
+    } else if (!prefixcmp(option, "import-marks")) {
+		option_import_marks(option + 13);
+    } else if (!prefixcmp(option, "export-marks")) {
+		option_export_marks(option + 13);
+    } else if (!prefixcmp(option, "export-pack-edges")) {
+		option_export_pack_edges(option + 18);
+    } else if (!prefixcmp(option, "force")) {
+		option_force();
+    } else if (!prefixcmp(option, "quiet")) {
+		option_quiet();
+    } else if (!prefixcmp(option, "stats")) {
+		option_stats();
+    } else {
+		die("Unsupported option: %s", option);
+    }
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2516,6 +2553,8 @@ int main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
+		else if (!prefixcmp(command_buf.buf, "option "))
+			parse_option();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
-- 
1.6.3.GIT
