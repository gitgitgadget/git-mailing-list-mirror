From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] pager: factor out a helper to prepare a child process to run the pager
Date: Wed, 17 Feb 2016 11:15:15 -0800
Message-ID: <1455736516-13466-3-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455736516-13466-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:19:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7d1-0004YD-EW
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423738AbcBQTPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:15:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423727AbcBQTPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:15:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CA9A423EA;
	Wed, 17 Feb 2016 14:15:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=a6d8
	Bb2TMe3PWJvO1qeMsS73TuI=; b=t4kLgRNCNePQAYPpZ5xWpXGhD9M9mS/TmrfP
	qsT1M6QqCZC329NkGHAq4Y0Hl2dUZz3AGCMBMGDC0Um49S181R8EeG5NuYgjIVPf
	YyXMMl6aS+IWW1Cv6x2qyEAGPrWkag3iNhtXKMUIZruvrCGdQT8jvJGVMnJmXvLh
	3hY6Llc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	p3v7vatAn+nTc7t5cu7QhTf9lwlou86/efwobK7QJ5PpFZ9HUQ37es4TLfHtHFio
	wV16yiEGKJe13oAlMYOZdj4UYRNqyMS11HYFzfodKwPx0RGwUk6cfxl7vDTILvjh
	/EAT4XXEmSZJaz4hE2T7vOv6RtbtmenvgJNmA4/E65U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C1A4423E9;
	Wed, 17 Feb 2016 14:15:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A428C423E8;
	Wed, 17 Feb 2016 14:15:20 -0500 (EST)
X-Mailer: git-send-email 2.7.1-489-g20b2cbe
In-Reply-To: <1455736516-13466-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C986B2B8-D5AA-11E5-823C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286538>

When running a pager, we need to run the program git_pager() gave
us, but we need to make sure we spawn it via the shell (i.e. it is
valid to say PAGER='less -S', for example) and give default values
to $LESS and $LV environment variables.  Factor out these details
to a separate helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Simplified per Peff's suggestion.

 cache.h |  3 +++
 pager.c | 17 +++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 6bb7119..a839acc 100644
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
@@ -1550,6 +1552,7 @@ extern int pager_use_color;
 extern int term_columns(void);
 extern int decimal_width(uintmax_t);
 extern int check_pager_config(const char *cmd);
+extern void prepare_pager_args(struct child_process *, const char *pager);
 
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/pager.c b/pager.c
index 5dbcc5a..cb28207 100644
--- a/pager.c
+++ b/pager.c
@@ -53,6 +53,16 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+void prepare_pager_args(struct child_process *pager_process, const char *pager)
+{
+	argv_array_push(&pager_process->args, pager);
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
@@ -69,13 +79,8 @@ void setup_pager(void)
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
 	/* spawn the pager */
-	argv_array_push(&pager_process.args, pager);
-	pager_process.use_shell = 1;
+	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
-	if (!getenv("LESS"))
-		argv_array_push(&pager_process.env_array, "LESS=FRX");
-	if (!getenv("LV"))
-		argv_array_push(&pager_process.env_array, "LV=-c");
 	argv_array_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
 		return;
-- 
2.7.1-489-g20b2cbe
