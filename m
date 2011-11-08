From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/12] fmt-merge-msg: avoid early returns
Date: Mon,  7 Nov 2011 19:00:39 -0800
Message-ID: <1320721245-13223-7-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbvw-0001LQ-HW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab1KHDBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab1KHDBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:01:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B27536512;
	Mon,  7 Nov 2011 22:01:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9vNq
	S0JH1juDWxZutAZgcoczWfg=; b=rYh4F3KaWXAJ0OztpLaNcrtyBqebPkD0lzhL
	3DLjQDPVTGIBdBGES1ZNcT5aWNPcBDILwtXpjKVQCHjF+CKVztDzobnhsMOuvUqV
	/Iuy+NWHYiQenLJbfhanNG9D755Xx2SE+dn1u2iSauy32fgO3TprzE/7wGFjb3IS
	GgPDa4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HxT8j0NVnO+AlJjreJFzsqP1GaLIynISnG4ddTVxuFnYfWJ+VLrfZ6MdxnCq8bBw
	YCNX8KjjnCYbc+Xx828hEhPElQvlENZpCp+V2taK6IeAM0ZIdOFAs6Ouor9IEfAC
	94dZVdomdJPNfSJUhsEIpzP2/w+TTOVxLBVnOKz3/4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9D2A6511;
	Mon,  7 Nov 2011 22:01:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A5626510; Mon,  7 Nov 2011
 22:01:00 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E3263628-09B5-11E1-B7AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185055>

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
1.7.8.rc0.128.g31aa4
