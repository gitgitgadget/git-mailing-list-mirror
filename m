From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/19] receive-pack: factor out queueing of command
Date: Fri, 22 Aug 2014 13:30:09 -0700
Message-ID: <1408739424-31429-5-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvUY-0007R0-JP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaHVUbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:31:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65398 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:31:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F232D33148;
	Fri, 22 Aug 2014 16:31:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=44Sa
	iD0mbmGbklMHT4c3W0E+DY8=; b=JbFDeaNOE4/YnyY3Qg819Oq8/UrKPFHSyFZn
	62sc/HTS0oY9FlL5umXAMXIVH02GQ0kXpmcn+yHOcvM6dgAnUlXXcD7i8df3cjJ6
	YOrF2xOFmXt+uLZ5xdk2uzDNsGu5EUMptVwAGb+jrg710aI6leIm1gx+IWKI1Ogi
	l8dzvXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=A7zGge
	EW+nZM0T7yzwH61ARYaEuIn3TRqs41XbhIK4mDPmeOeO0DxZCq+etWRedeV+A+Ed
	NglvyTiAhZP4ok5BxoevrAcyZmjiWN5fSvr4lb/I0nuBGmcyKjJHN5IMO/6x6Mq6
	AazS1V9jbXqj2qpAUWnQ0cRV/OcNt3H249FYk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9D5833147;
	Fri, 22 Aug 2014 16:31:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 62C9C33138;
	Fri, 22 Aug 2014 16:31:07 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3EDE29AA-2A3B-11E4-9666-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255705>

Make a helper function to accept a line of a protocol message and
queue an update command out of the code from read_head_info().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9b92bf..341bb46 100644
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
-		reflen = linelen - 82;
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
2.1.0-304-g950f846
