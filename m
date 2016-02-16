From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] pager: factor out a helper to prepare a child process to run the pager
Date: Tue, 16 Feb 2016 15:06:56 -0800
Message-ID: <1455664017-27588-3-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoiB-00057H-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbcBPXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:07:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756302AbcBPXHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:07:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 310C6453B7;
	Tue, 16 Feb 2016 18:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AsWL
	MSVebHLserX6s8IGhO2JJRA=; b=FPwNzxPG99UZ6wYNRKc3bAvP6BnwCZ5J01nl
	DwqwN//tIrMh+aZbeUZIyVcHQULTjjpOfCh4ujovkjnL8AwGVjkSc/S594PNbZGC
	xcoNVaDOmzbfgwHvs+6fP+XBjdp1SYljLgDZqNjlnczkZbNEByb2IeoLZVB7N4n9
	fggBydk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	suVWXPsuaLQLMUvq2HVSbLWaFH/GmlJT8sJODOlEvlIDdNwfTrA7EPQ+cmjoIBr1
	zfTm6yzy0qcjMHNdbaDqQpvPDGTc5MA7U/PfAUdVYaLJjGxqRErvR9RTRTuF+8wJ
	hJUX6/zTtpZswawUiDClHvDouKlEJPJrGYXt7vRiDBk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 296EB453B5;
	Tue, 16 Feb 2016 18:07:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77EDC453B3;
	Tue, 16 Feb 2016 18:07:02 -0500 (EST)
X-Mailer: git-send-email 2.7.1-460-gd45d0a4
In-Reply-To: <1455664017-27588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FD3E0D76-D501-11E5-B12D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286450>

When running a pager, we need to run the program git_pager() gave
us, but we need to make sure we spawn it via the shell (i.e. it is
valid to say PAGER='less -S', for example) and give default values
to $LESS and $LV environment variables.  Factor out these details
to a separate helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |  4 ++++
 pager.c | 24 ++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 6bb7119..6827acb 100644
--- a/cache.h
+++ b/cache.h
@@ -210,7 +210,9 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
+/* Forward structure decls */
 struct pathspec;
+struct child_process;
 
 /*
  * Copy the sha1 and stat state of a cache entry from one to
@@ -1550,6 +1552,8 @@ extern int pager_use_color;
 extern int term_columns(void);
 extern int decimal_width(uintmax_t);
 extern int check_pager_config(const char *cmd);
+LAST_ARG_MUST_BE_NULL
+extern void prepare_pager_args(struct child_process *, ...);
 
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/pager.c b/pager.c
index 5dbcc5a..1406370 100644
--- a/pager.c
+++ b/pager.c
@@ -53,6 +53,23 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+void prepare_pager_args(struct child_process *pager_process, ...)
+{
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, pager_process);
+	while ((arg = va_arg(ap, const char *)))
+		argv_array_push(&pager_process->args, arg);
+	va_end(ap);
+
+	pager_process->use_shell = 1;
+	if (!getenv("LESS"))
+		argv_array_push(&pager_process->env_array, "LESS=FRX");
+	if (!getenv("LV"))
+		argv_array_push(&pager_process->env_array, "LV=-c");
+}
+
 void setup_pager(void)
 {
 	const char *pager = git_pager(isatty(1));
@@ -69,13 +86,8 @@ void setup_pager(void)
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
 	/* spawn the pager */
-	argv_array_push(&pager_process.args, pager);
-	pager_process.use_shell = 1;
+	prepare_pager_args(&pager_process, pager, NULL);
 	pager_process.in = -1;
-	if (!getenv("LESS"))
-		argv_array_push(&pager_process.env_array, "LESS=FRX");
-	if (!getenv("LV"))
-		argv_array_push(&pager_process.env_array, "LV=-c");
 	argv_array_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
 		return;
-- 
2.7.1-460-gd45d0a4
