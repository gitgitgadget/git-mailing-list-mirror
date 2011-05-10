From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] count_pathspec(): return number of elements in pathspec
Date: Mon,  9 May 2011 22:51:12 -0700
Message-ID: <1305006678-4051-4-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrB-0001Bh-AE
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1EJFve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab1EJFvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4259E5C8E;
	Tue, 10 May 2011 01:53:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8unc
	UA+MmvEVKLQaXfGWpdQRAwk=; b=jyZuQAIKC0iVSjnd9PuLlMYo9shMP/uts4oy
	/oFui72M3p4V5DjzoDllAkk2qmRwVbvEAxBttYtc7FUoBUO/+XnCegUJpXTPl72O
	sn2dnRMbPoYgo5xiZzJs5QwC0wC4DizSBHfV0K3FxSS1wftUHr4cNLOWRCS65BTS
	qMsBdtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	sOGZhfusgO7ZAxFKkUSdER/wt/CBGPX+ProCse8aWgfXwqH4jSZri1RHu/HDV5cc
	+LSyCHkc9MX/LChlCBGYNn1s13ollSVOea6lraOl9BgvKFTqQMqIfsKIwkRGqC4o
	JLdcpCQZY+OqD46dnjbVe0SqrnM2bjqgNbG8mq1D7z8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E8485C8D;
	Tue, 10 May 2011 01:53:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B2735C8C; Tue, 10 May 2011
 01:53:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D920E5FE-7AC9-11E0-824C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173306>

When fed a non-empty argv[], get_pathspec(prefix, argv) used to always
return an array of string that has the same number of elements as argv[]
had, but with ":" (work at toplevel without any path limit) magic pathspec
it can return zero elements.  Passing the result from get_pathspec() to
this function will always give the correct number of pathspec elements.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    3 ++-
 setup.c |   10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index be6ce72..6170dce 100644
--- a/cache.h
+++ b/cache.h
@@ -425,7 +425,8 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern const char **get_pathspec(const char *prefix, const char **pathspec);
+extern const char **get_pathspec(const char *prefix, const char **argv);
+extern int count_pathspec(const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/setup.c b/setup.c
index c1be388..cab9ddd 100644
--- a/setup.c
+++ b/setup.c
@@ -287,6 +287,16 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	return pathspec;
 }
 
+int count_pathspec(const char **pathspec)
+{
+	int i;
+	if (!pathspec)
+		return 0;
+	for (i = 0; pathspec[i]; i++)
+		; /* just counting */
+	return i;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
-- 
1.7.5.1.290.g1b565
