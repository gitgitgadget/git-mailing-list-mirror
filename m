From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 01/15] config: introduce set_or_die wrappers
Date: Tue, 16 Feb 2016 13:56:28 +0100
Message-ID: <1455627402-752-2-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:57:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfBp-0001g8-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbcBPM47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:56:59 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34565 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932191AbcBPM4w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 07D6B20A12
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Feb 2016 07:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=WBx7
	f/aWb48o4b5oJI7CIa8LgA8=; b=pqSUX9DxiTSl3mWEMB2e0r9+0/QGPBaBfBw2
	PVkbCsTlxuYeEgQsQi1GRzjWPBgmYvTSxO5yRAqCSU4POCFGJdI4P9iHLmSk7k16
	at1I7dFCF4GdMH4aG+L3txDwE+oL8HtZ4/nA2aIbAU14+yQd3C/HyfFOKyW+/gaK
	1azISic=
X-Sasl-enc: ehZcwTrNjaA4BNEtg65WcLIQcjOfnyW3ZDc9MfzLx6XC 1455627411
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 84DB2680130;
	Tue, 16 Feb 2016 07:56:51 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286341>

A lot of call-sites for the existing family of `git_config_set`
functions do not check for errors that may occur, e.g. when the
configuration file is locked. In many cases we simply want to die
when such a situation arises.

Introduce wrappers that will cause the program to die in those
cases. These wrappers are temporary only to ease the transition
to let `git_config_set` die by default. They will be removed
later on when `git_config_set` itself has been replaced by
`git_config_set_gently`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache.h  |  4 ++++
 config.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/cache.h b/cache.h
index 553b04b..6870a25 100644
--- a/cache.h
+++ b/cache.h
@@ -1526,11 +1526,15 @@ extern int git_config_maybe_bool(const char *, const char *);
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
2.7.1
