From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/9] config: introduce set_or_die wrappers
Date: Thu, 28 Jan 2016 10:00:29 +0100
Message-ID: <1453971637-22273-2-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiS5-0007A6-Gi
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbcA1JAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39930 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755189AbcA1JAm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B399121F0C
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:41 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 28 Jan 2016 04:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8OBt
	sNgDKpLG2T52PqfbFSFNfBc=; b=lxQF9gbEqn7ETrVT0yN2z6c/iYSnmueLxRkq
	TdgcyfPSfVKZkh7yAezAX0ilaSJ+iU4hJUrohuUJ4xtQMqUUK26sRzrPUMfSJbZG
	8L2rYzd5Tjrhzh8k2+vnQ0judfTIMLi4CGCAYUSX4SQIXdruv9PHcjB5+Qr+yxMg
	a5DxcQA=
X-Sasl-enc: lvFCeOMod/mtsjjTsMPDv29Qpp14gki3wbGcw0IURetp 1453971641
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 448F6C00012;
	Thu, 28 Jan 2016 04:00:41 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284999>

A lot of call-sites for the existing family of `git_config_set`
functions do not check for errors that may occur, e.g. the
configuration file being locked. In many cases we simply want to
die when such a situation arises.

Introduce wrappers that will cause the program to die in those
cases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache.h  |  4 ++++
 config.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/cache.h b/cache.h
index dfc459c..c1f844d 100644
--- a/cache.h
+++ b/cache.h
@@ -1508,11 +1508,15 @@ extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
+extern void git_config_set_in_file_or_die(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
+extern void git_config_set_or_die(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern void git_config_set_multivar_or_die(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+extern void git_config_set_multivar_in_file_or_die(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
diff --git a/config.c b/config.c
index 86a5eb2..856f7d34 100644
--- a/config.c
+++ b/config.c
@@ -1831,11 +1831,22 @@ int git_config_set_in_file(const char *config_filename,
 	return git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
 }
 
+void git_config_set_in_file_or_die(const char *config_filename,
+			const char *key, const char *value)
+{
+	git_config_set_multivar_in_file_or_die(config_filename, key, value, NULL, 0);
+}
+
 int git_config_set(const char *key, const char *value)
 {
 	return git_config_set_multivar(key, value, NULL, 0);
 }
 
+void git_config_set_or_die(const char *key, const char *value)
+{
+	git_config_set_multivar_or_die(key, value, NULL, 0);
+}
+
 /*
  * Auxiliary function to sanity-check and split the key into the section
  * identifier and variable name.
@@ -2179,6 +2190,15 @@ write_err_out:
 
 }
 
+void git_config_set_multivar_in_file_or_die(const char *config_filename,
+				const char *key, const char *value,
+				const char *value_regex, int multi_replace)
+{
+	if (git_config_set_multivar_in_file(config_filename, key, value,
+					    value_regex, multi_replace) < 0)
+		die(_("Could not set '%s' to '%s'"), key, value);
+}
+
 int git_config_set_multivar(const char *key, const char *value,
 			const char *value_regex, int multi_replace)
 {
@@ -2186,6 +2206,13 @@ int git_config_set_multivar(const char *key, const char *value,
 					       multi_replace);
 }
 
+void git_config_set_multivar_or_die(const char *key, const char *value,
+			const char *value_regex, int multi_replace)
+{
+	git_config_set_multivar_in_file_or_die(NULL, key, value, value_regex,
+					       multi_replace);
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-- 
2.7.0
