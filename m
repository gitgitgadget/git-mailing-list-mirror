From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 04/23] receive-pack: factor out queueing of command
Date: Wed, 17 Sep 2014 15:45:39 -0700
Message-ID: <1410993958-32394-5-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzP-000236-O7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbaIQWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52517 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbaIQWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FCE539DD9;
	Wed, 17 Sep 2014 18:46:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=08nQ
	r5z/76AtJsgcdJbZkz0D0Bg=; b=U2z51LDur5SzCDaMJMKmra4bKPbnj5HfyuCD
	ArZw0a+CM5d1pG6TYFld7V5pkIH5pxcdn+3sJtjk4qbg6zpQUftnjOi6UlKi79Nb
	v+ob91Zu3e/kcvB9dYifv5iHNWUEspfX/GYcUR7aRvZ3zDuUDXgcEuHYHoyJR8Xl
	gIueWAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fz1JSa
	rpt5v/4PW4SJUVJ4w7Wf14TYtTXfWX6zcSRSft7ldNWH5T0DdhWAB/ys7hzGwa/9
	pefHSzMLeMcto27RbZHPaWn7uXz90asbt1Eh4IoLPs5oqnsSVJVYA44dtN04f77p
	agEmEvcqMhaPdU+UK2sDHkNCUvxZU4hIy80IU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2755839DD8;
	Wed, 17 Sep 2014 18:46:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1DC7539DD4;
	Wed, 17 Sep 2014 18:46:09 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6A9B4BC8-3EBC-11E4-8094-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257231>

Make a helper function to accept a line of a protocol message and
queue an update command out of the code from read_head_info().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

 builtin/receive-pack.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9b92bf..587f7da 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -831,16 +831,40 @@ static void execute_commands(struct command *commands,
 		      "the reported refs above");
 }
 
+static struct command **queue_command(struct command **tail,
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
+	*tail = cmd;
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
2.1.0-403-g099cf47
