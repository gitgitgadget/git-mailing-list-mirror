From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] convert: rename the "eol" global variable to "core_eol"
Date: Mon,  9 May 2011 15:04:58 -0700
Message-ID: <1304978701-19310-2-git-send-email-gitster@pobox.com>
References: <20110508101925.GA19525@do>
 <1304978701-19310-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYaH-0005q9-3f
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1EIWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab1EIWFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEF86478B;
	Mon,  9 May 2011 18:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KSBR
	QKGdGdvgq6r2/+7O3w7ogdc=; b=Q8+zUyyuQheAKlTuU060H/KJIr0DDv8O2+I/
	C7khupyQ26lJZY79BuqtGhdKILGxFZq0bwggF3cHkse3UtAkIWZ/NJn5DJyQRL94
	FOeFjNadytBq16RTfIoHSi/BvpJkCZXs9htaxugW0iNVwpqRSL+gFYUGg/QA4e2K
	w/2ADsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	SOpYZmJqlZStRaXJ/s17rCCTncVsxHxqLIwcHw5XvQ7EaJnDzRjkY/7xC2jJk57c
	9xtkAovFRN9uZTM7puGDR6OPEvznyy1HGf9ftYB/+qpr9zkxHZQkOd9gHCxW8CKq
	c9sDXcOsOPhw377XTUeFlPZL/zwFEyuWpUVn+NI2UHk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D3C4478A;
	Mon,  9 May 2011 18:07:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C65604789; Mon,  9 May 2011
 18:07:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.288.g93ebc
In-Reply-To: <1304978701-19310-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B23D867C-7A88-11E0-8AD0-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173266>

Yes, it is clear that "eol" wants to mean some sort of end-of-line thing,
but as the name of a global variable, it is way too short to describe what
kind of end-of-line thing it wants to represent. Besides, there are many
codepaths that want to use their own local "char *eol" variable to point
at the end of the current line they are processing.

This global variable holds what we read from core.eol configuration
variable. Name it as such.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h       |    2 +-
 config.c      |   12 ++++++------
 convert.c     |    4 ++--
 environment.c |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 2b34116..4e9123b 100644
--- a/cache.h
+++ b/cache.h
@@ -606,7 +606,7 @@ enum eol {
 #endif
 };
 
-extern enum eol eol;
+extern enum eol core_eol;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
diff --git a/config.c b/config.c
index 5f9ec28..671c8df 100644
--- a/config.c
+++ b/config.c
@@ -583,7 +583,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			if (eol == EOL_CRLF)
+			if (core_eol == EOL_CRLF)
 				return error("core.autocrlf=input conflicts with core.eol=crlf");
 			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
@@ -603,14 +603,14 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.eol")) {
 		if (value && !strcasecmp(value, "lf"))
-			eol = EOL_LF;
+			core_eol = EOL_LF;
 		else if (value && !strcasecmp(value, "crlf"))
-			eol = EOL_CRLF;
+			core_eol = EOL_CRLF;
 		else if (value && !strcasecmp(value, "native"))
-			eol = EOL_NATIVE;
+			core_eol = EOL_NATIVE;
 		else
-			eol = EOL_UNSET;
-		if (eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
+			core_eol = EOL_UNSET;
+		if (core_eol == EOL_CRLF && auto_crlf == AUTO_CRLF_INPUT)
 			return error("core.autocrlf=input conflicts with core.eol=crlf");
 		return 0;
 	}
diff --git a/convert.c b/convert.c
index 7eb51b1..4dba329 100644
--- a/convert.c
+++ b/convert.c
@@ -113,10 +113,10 @@ static enum eol determine_output_conversion(enum action action)
 			return EOL_CRLF;
 		else if (auto_crlf == AUTO_CRLF_INPUT)
 			return EOL_LF;
-		else if (eol == EOL_UNSET)
+		else if (core_eol == EOL_UNSET)
 			return EOL_NATIVE;
 	}
-	return eol;
+	return core_eol;
 }
 
 static void check_safe_crlf(const char *path, enum action action,
diff --git a/environment.c b/environment.c
index 40185bc..7fe9f10 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,7 @@ const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
-enum eol eol = EOL_UNSET;
+enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
-- 
1.7.5.1.288.g93ebc
