From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 1/3] receive-pack: Two small code cleanups
Date: Wed, 24 Feb 2010 16:33:33 +0100
Message-ID: <f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 18:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKlD-0001kE-74
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab0BXRKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:10:32 -0500
Received: from cantor.suse.de ([195.135.220.2]:51326 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757355Ab0BXRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:10:26 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 8487294608
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:10:25 +0100 (CET)
In-Reply-To: <cover.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140959>

Rename show_ref()'s path parameter to refname.

In read_head_info(), lines may have trailing capability strings.  Throw
away such strings after evaluation; they are not needed in the command
structs.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin-receive-pack.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 0559fcc..77cbc2a 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -105,13 +105,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (sent_capabilities)
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
 	else
 		packet_write(1, "%s %s%c%s%s\n",
-			     sha1_to_hex(sha1), path, 0,
+			     sha1_to_hex(sha1), refname, 0,
 			     " report-status delete-refs side-band-64k",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
@@ -524,7 +524,7 @@ static void read_head_info(void)
 		static char line[1000];
 		unsigned char old_sha1[20], new_sha1[20];
 		struct command *cmd;
-		char *refname;
+		const char *refname;
 		int len, reflen;
 
 		len = packet_read_line(0, line, sizeof(line));
@@ -548,10 +548,10 @@ static void read_head_info(void)
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
-		cmd = xmalloc(sizeof(struct command) + len - 80);
+		cmd = xmalloc(sizeof(struct command) + reflen + 1);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
-		memcpy(cmd->ref_name, line + 82, len - 81);
+		memcpy(cmd->ref_name, refname, reflen + 1);
 		cmd->error_string = NULL;
 		cmd->next = NULL;
 		*p = cmd;
-- 
1.6.6.243.gff6d2
