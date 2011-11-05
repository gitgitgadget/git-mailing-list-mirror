From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/10] fmt-merge-msg: avoid early returns
Date: Fri,  4 Nov 2011 23:01:37 -0700
Message-ID: <1320472900-6601-8-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKO-0005a3-Us
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab1KEGB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:01:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab1KEGB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED1D3C29
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zJp+
	9uQlo17GM7XJHaX3T79zgJw=; b=yJo71s0RL5NLIacat7UmKPs/zhFfwtP6Ze/4
	cSq7PekS16ElqbAhTNUP3uDyIJ6Gt9RH9ZoLAX/INHXwo/fUXi/31onhjFqHPuM/
	0LK8eE8j1+9Pni5bKOs2lkve5AM4jOas2Fki5m5XreZs94tgI/VNujbNX8A2SB6s
	FbbHK8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=D69vQJ
	tirw7XPpp7sbav7lHVWwhViajTCnuOdmUR5Bwrjuer3cITJIEfaov08vhliWjNtS
	74SBP0q5NW6C8QNvVzrBGCRmVEQffsoC+LbOGNkowkj6uETxl63AHVSl1GWuSMsN
	5rSsDUJQ8MyhZ7Jma7DrhPb5ig+uwHF19vc/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69683C28
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32FC03C26 for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AA927090-0773-11E1-8F39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184821>

In various places in the codepath, the program tries to return early
assuming there is no more work needed. That is generally untrue when
over time new features are added.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7e2f225..7b492f9 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -26,6 +26,7 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 	return 0;
 }
 
+/* merge data per repository where the merged tips came from */
 struct src_data {
 	struct string_list branch, tag, r_branch, generic;
 	int head_status;
@@ -71,6 +72,11 @@ static int handle_line(char *line)
 		line[len - 1] = 0;
 	line += 42;
 
+	/*
+	 * At this point, line points at the beginning of comment e.g.
+	 * "branch 'frotz' of git://that/repository.git".
+	 * Find the repository name and point it with src.
+	 */
 	src = strstr(line, " of ");
 	if (src) {
 		*src = 0;
@@ -283,10 +289,7 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
 
-	if (!srcs.nr)
-		return 0;
-
-	if (merge_title)
+	if (merge_title && srcs.nr)
 		do_fmt_merge_msg_title(out, current_branch);
 
 	if (shortlog_len) {
@@ -306,6 +309,8 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, shortlog_len, out);
 	}
+	if (out->len && out->buf[out->len-1] != '\n')
+		strbuf_addch(out, '\n');
 	return 0;
 }
 
@@ -341,12 +346,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !shortlog_len) {
-		char nl = '\n';
-		write_in_full(STDOUT_FILENO, message, strlen(message));
-		write_in_full(STDOUT_FILENO, &nl, 1);
-		return 0;
-	}
+
 	if (shortlog_len < 0)
 		die("Negative --log=%d", shortlog_len);
 
-- 
1.7.8.rc0.108.g71b5ec
