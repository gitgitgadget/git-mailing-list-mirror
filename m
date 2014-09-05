From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/22] receive-pack: factor out queueing of command
Date: Fri,  5 Sep 2014 13:54:52 -0700
Message-ID: <1409950510-10209-5-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xt-0005bR-I9
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbaIEUzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64042 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaIEUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A15BB3663C;
	Fri,  5 Sep 2014 16:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3HzL
	UrF/40LNOZlN36drvGYxxL0=; b=su/J2r5z0m6fKY3sGH8AD3QQJA4oC4Oms2dJ
	qblQmUuKcO+mzuc9+pRwttf9uqVrIsJJMYQYx7mV0ORGN2VxExc5j0pjSLr9sluP
	v8UYoA3N34/TIBXzZxNVaJZSrEeSsobedN66F9mvkuVlTstk2j/x5XrlaHtytMnU
	Sw7rGb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RVUJP9
	fdmlvwLjjYadwpLfI+kKl0jFcNT2IbKmj/0G0lBw6pQQVVZ4N84OySeT35mnDGGa
	eNSMLyyxUp2Ye4XGrfcNI64REObgnoj8Dg4tIA46EivfAAzK8ELPDrC7IWsK6FJA
	sZsAn3NjVRiIZm1weylf5nMYjgICH9Qrmdd8E=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24A473663B;
	Fri,  5 Sep 2014 16:55:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 264F136637;
	Fri,  5 Sep 2014 16:55:22 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F3C0704A-353E-11E4-B92F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256522>

Make a helper function to accept a line of a protocol message and
queue an update command out of the code from read_head_info().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.1.0-399-g2df620b
