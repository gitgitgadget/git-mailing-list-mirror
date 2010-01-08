From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] ident.c: check explicit identity for name and email
 separately
Date: Fri, 08 Jan 2010 08:04:52 -0800
Message-ID: <7vbph4eg63.fsf_-_@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>
To: git@vger.kernel.org,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHKr-00018e-V3
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0AHQFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233Ab0AHQFG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:05:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab0AHQFC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:05:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C0528F05F;
	Fri,  8 Jan 2010 11:05:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MlfcYz9itH2EsbTPw5qHnyATY1c=; b=LxkaJt
	voOgdGNjVfsPLc1q1HcIk2SRfEvKj8gU6rv+tdFBinJS33eAAPWKpzthtbgkzDS3
	kqx2oZgCLOuVIwV1Xuofm44R61n8RPIm4g6cVeYYfNbk1Xuci6JJvxAAkaB+gVcf
	hntknxr5Q+IxY8X1QJ9aj9ZhMgnvaZ/hEL8OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=picEKtSkEIr6MgorIM6PRIHiFkvwsGbY
	j7hj3xql3ZO0VB43kATMbZpegHeyUw3CSPVLc7j1lxMsw66miW81285e4P3WUSUT
	vfib6TxBO55dhMbf97qb5iM1tRUsy+lHs8xTzShkBgHi402Fv/Hmh5k/20C+5AH/
	RRdSUqtd2zI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF7A8F05B;
	Fri,  8 Jan 2010 11:04:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B3308F057; Fri,  8 Jan
 2010 11:04:54 -0500 (EST)
In-Reply-To: <7vskagh9fg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 08\:02\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91A53E7A-FC6F-11DE-9D4B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136450>

bb1ae3f (commit: Show committer if automatic, 2008-05-04) added a logic to
check both name and email were given explicitly by the end user, but it
assumed that fmt_ident() is never called before git_default_user_config()
is called, which was fragile.  The former calls setup_ident() and fills
the "default" name and email, so the check in the config parser would have
mistakenly said both are given even if only user.name was provided.

Make the logic more robust by keeping track of name and email separately.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |    2 +-
 cache.h          |    3 +++
 config.c         |    6 ++----
 ident.c          |    7 ++++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 073fe90..f4974b5 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -624,7 +624,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				author_ident);
 		free(author_ident);
 
-		if (!user_ident_explicitly_given)
+		if (user_ident_explicitly_given != IDENT_ALL_GIVEN)
 			fprintf(fp,
 				"%s"
 				"# Committer: %s\n",
diff --git a/cache.h b/cache.h
index bf468e5..16c8e8d 100644
--- a/cache.h
+++ b/cache.h
@@ -925,6 +925,9 @@ extern const char *config_exclusive_filename;
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
+#define IDENT_NAME_GIVEN 01
+#define IDENT_MAIL_GIVEN 02
+#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 extern int user_ident_explicitly_given;
 
 extern const char *git_commit_encoding;
diff --git a/config.c b/config.c
index 37385ce..fa1a0c0 100644
--- a/config.c
+++ b/config.c
@@ -528,8 +528,7 @@ static int git_default_user_config(const char *var, const char *value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_name, value, sizeof(git_default_name));
-		if (git_default_email[0])
-			user_ident_explicitly_given = 1;
+		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
 
@@ -537,8 +536,7 @@ static int git_default_user_config(const char *var, const char *value)
 		if (!value)
 			return config_error_nonbool(var);
 		strlcpy(git_default_email, value, sizeof(git_default_email));
-		if (git_default_name[0])
-			user_ident_explicitly_given = 1;
+		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 
diff --git a/ident.c b/ident.c
index e6c1798..e67c5ad 100644
--- a/ident.c
+++ b/ident.c
@@ -249,9 +249,10 @@ const char *git_author_info(int flag)
 
 const char *git_committer_info(int flag)
 {
-	if (getenv("GIT_COMMITTER_NAME") &&
-	    getenv("GIT_COMMITTER_EMAIL"))
-		user_ident_explicitly_given = 1;
+	if (getenv("GIT_COMMITTER_NAME"))
+		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
+	if (getenv("GIT_COMMITTER_EMAIL"))
+		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
-- 
1.6.6.209.g52296.dirty
