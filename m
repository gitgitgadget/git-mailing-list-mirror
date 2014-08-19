From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/18] receive-pack: factor out queueing of command
Date: Tue, 19 Aug 2014 15:06:13 -0700
Message-ID: <1408485987-3590-5-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrYr-0005il-6K
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbaHSWHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:07:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53073 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbaHSWHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:07:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D9B4330B1;
	Tue, 19 Aug 2014 18:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HsMB
	YgJWwINaRl2WiLuYgvfL3g0=; b=rPs5BAdxpAnKIv8LTIHhKel4TrxIbsmqI/7i
	UdmLXoSIf4xesocvSysjo1VhgGq8SVBPL2yvOhSB2qo+KCFjU6Iz2c4w0gVABKpj
	IXUwCxYhWom+ggFwXVLve9IL4YEtMPLDFllTGU0JCdJWeaTnKqGb6pnZTB3iUdUm
	h2FXux4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XVIzs5
	egjX2603JebV6d6a1yuz8axYIDcdjQdqfj5PUyHIv2Vb2/z+tbt7D9ahXzLztUap
	/YZx8NRUJYp2gmbCFDWlp0M153CUhJ20kV0WsGsk57qb6FP7jO3nabuYXiC9klYG
	paFzba4CNkUsTZD+fNosh6GbEmCuIXRQ2dNGk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84951330B0;
	Tue, 19 Aug 2014 18:07:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CD62330A7;
	Tue, 19 Aug 2014 18:07:07 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 293E19C0-27ED-11E4-9CD2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255524>

Make a helper function to accept a line of a protocol message and
queue an update command out of the code from read_head_info().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ee855b4..341bb46 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -831,16 +831,40 @@ static void execute_commands(struct command *commands,
 		      "the reported refs above");
 }
 
+static struct command **queue_command(struct command **p,
+				      const char *line,
+				      int linelen)
+{
+	unsigned char old_sha1[20], new_sha1[20];
+	struct command *cmd;
+	const char *refname;
+	int reflen;
+
+	if (linelen < 83 ||
+	    line[40] != ' ' ||
+	    line[81] != ' ' ||
+	    get_sha1_hex(line, old_sha1) ||
+	    get_sha1_hex(line + 41, new_sha1))
+		die("protocol error: expected old/new/ref, got '%s'", line);
+
+	refname = line + 82;
+	reflen = linelen - 82;
+	cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
+	hashcpy(cmd->old_sha1, old_sha1);
+	hashcpy(cmd->new_sha1, new_sha1);
+	memcpy(cmd->ref_name, refname, reflen);
+	cmd->ref_name[reflen] = '\0';
+	*p = cmd;
+	return &cmd->next;
+}
+
 static struct command *read_head_info(struct sha1_array *shallow)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
 	for (;;) {
 		char *line;
-		unsigned char old_sha1[20], new_sha1[20];
-		struct command *cmd;
-		char *refname;
-		int len, reflen, linelen;
+		int len, linelen;
 
 		line = packet_read_line(0, &len);
 		if (!line)
@@ -866,23 +890,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				quiet = 1;
 		}
 
-		if (linelen < 83 ||
-		    line[40] != ' ' ||
-		    line[81] != ' ' ||
-		    get_sha1_hex(line, old_sha1) ||
-		    get_sha1_hex(line + 41, new_sha1))
-			die("protocol error: expected old/new/ref, got '%s'",
-			    line);
-
-		refname = line + 82;
-		reflen = strlen(refname);
-		cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
-		hashcpy(cmd->old_sha1, old_sha1);
-		hashcpy(cmd->new_sha1, new_sha1);
-		memcpy(cmd->ref_name, refname, reflen);
-		cmd->ref_name[reflen] = '\0';
-		*p = cmd;
-		p = &cmd->next;
+		p = queue_command(p, line, linelen);
 	}
 	return commands;
 }
-- 
2.1.0-301-g54593e2
