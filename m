From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 01/15] config: introduce set_or_die wrappers
Date: Tue,  2 Feb 2016 12:51:42 +0100
Message-ID: <1454413916-31984-2-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVR-000650-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbcBBLwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:14 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45224 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754458AbcBBLwL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9C4EE20DC2
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:10 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Cw2s
	KV4YIecwpvoeCtu6vsxMCm4=; b=XeDPSWY350Mt0v4kL3rrW72LAh+Ju0ufGX5U
	genapNLogWRjfoeD/MAbNo2jMoyYGSN/WqaswAcBfx28DccBwrOMieL6tfiy+xbY
	b3di0jTqNkQbkhz8ybQPBNFftn5vAKYXxwPfz7OmCKbCSYMpTwUe6pw5utaiXm6f
	TGNxSd8=
X-Sasl-enc: JPv5WNurkG9LO5vhnUafB3UBoa+pOQcCMYBr0P25Ex2Y 1454413929
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5E0E8680179;
	Tue,  2 Feb 2016 06:52:09 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285252>

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
