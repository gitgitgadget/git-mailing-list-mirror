From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH 1/2] Add support for a shared config file
Date: Thu, 25 Nov 2010 11:21:03 -0600
Message-ID: <f687e6c4830e21db606db99b584864a61e5cf8c3.1290870042.git.nathan.panike@gmail.com>
References: <cover.1290870041.git.nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 16:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMMnf-0006E8-9K
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 16:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab0K0PeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 10:34:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65383 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0K0PeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 10:34:23 -0500
Received: by mail-iw0-f174.google.com with SMTP id 35so661819iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:in-reply-to
         :references:from:date:subject:to;
        bh=zaoCibvn+IrTbEZ1EHwDCOqC8GkaIlD7qw3cDl2O8A4=;
        b=GYEsRe/v1uWKxFgFTNFR0Bw+PFxmOKZxHmb9xSbvQGeRCegkUO9SUZL+LqlfCT7Cy8
         IJyley9hI9BRDL5jZqW+lfc7fGPyOKs4NvVTtZVuc82yE5Pssjn4smoV38o4ypi3wNKV
         ivjQWvq3WjrOMAvdCO5qrnKResX9Z9uCHKxt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:from:date:subject:to;
        b=KcGw7mAmYPf6r0Bdds2Brp1CY6btNvEXE4iY7j51ghfUxYXccjdpbpX84kctv+wDcf
         mW+VjFfM3KIYl/43AxxNx7UEwTkdphILkc8nrjP/vBv68+8E3zD8r4SgvGr6bM9Om6q+
         twXVHnXJiCLPmguA6E1nQaNH7wESvHZmZX6z0=
Received: by 10.231.182.131 with SMTP id cc3mr3084240ibb.36.1290872062733;
        Sat, 27 Nov 2010 07:34:22 -0800 (PST)
Received: from localhost (ppp-70-226-163-137.dsl.mdsnwi.ameritech.net [70.226.163.137])
        by mx.google.com with ESMTPS id i16sm3484042ibl.12.2010.11.27.07.34.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 07:34:22 -0800 (PST)
In-Reply-To: <cover.1290870041.git.nathan.panike@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162310>

The idea is that a project develops indigenous aliases that
should be shared project-wide.  The only way to communicate this
now is by channels outside of git--email or IRC or such. We add
support for the case where a project configuration can be in
.gitconfig in the top level of the repository.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
 builtin/config.c |    9 ++++++++-
 config.c         |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..26c679d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -154,7 +154,7 @@ static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
-	char *global = NULL, *repo_config = NULL;
+	char *global = NULL, *repo_config = NULL, *shared = NULL;
 	const char *system_wide = NULL, *local;
 
 	local = config_exclusive_filename;
@@ -165,6 +165,8 @@ static int get_value(const char *key_, const char *regex_)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
+		if(git_config_shared())
+			shared=xstrdup(".gitconfig");
 	}
 
 	key = xstrdup(key_);
@@ -198,11 +200,15 @@ static int get_value(const char *key_, const char *regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
+	if (do_all && shared) 
+		git_config_from_shared_file(show_config, shared, NULL);	
 	if (do_all)
 		git_config_from_file(show_config, local, NULL);
 	git_config_from_parameters(show_config, NULL);
 	if (!do_all && !seen)
 		git_config_from_file(show_config, local, NULL);
+	if (!do_all && !seen && shared) 
+		git_config_from_shared_file(show_config, shared, NULL);	
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
@@ -222,6 +228,7 @@ static int get_value(const char *key_, const char *regex_)
 free_strings:
 	free(repo_config);
 	free(global);
+	free(shared);
 	return ret;
 }
 
diff --git a/config.c b/config.c
index c63d683..a9e6bec 100644
--- a/config.c
+++ b/config.c
@@ -795,6 +795,38 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
+struct config_interceptor {
+	config_fn_t fn;
+	void* data;
+};
+
+/*
+ * The purpose of this function is to keep a malicious contributor from
+ * poisoning our configuration.  The idea of a shared configuration it to
+ * pass around helpful stuff like aliases, but we do not want to allow someone
+ * to say, change our email address or the url of the remote.
+ */
+
+static int config_interceptor_fn(const char*name, const char* value, void* data)
+{
+	int ret=0;
+	struct config_interceptor *ci = (struct config_interceptor*)data;
+	if( !ci ) {
+		return -1;
+	}
+	if(!prefixcmp(name,"alias."))
+		ret = (*ci->fn)(name,value,ci->data);
+	return ret;
+}
+
+int git_config_from_shared_file(config_fn_t fn,const char* filename, void* data)
+{
+	struct config_interceptor ci;
+	ci.fn=fn;
+	ci.data=data;	
+	return git_config_from_file(config_interceptor_fn,filename,&ci);
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
@@ -819,6 +851,11 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
 }
 
+int git_config_shared(void)
+{
+	return !git_env_bool("GIT_CONFIG_NOSHARED", 0);
+}
+
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	static int loaded_environment;
@@ -840,7 +877,8 @@ int git_config(config_fn_t fn, void *data)
 	int ret = 0, found = 0;
 	char *repo_config = NULL;
 	const char *home = NULL;
-
+	const char * shared = NULL;
+	
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
 		return git_config_from_file(fn, config_exclusive_filename, data);
@@ -860,6 +898,15 @@ int git_config(config_fn_t fn, void *data)
 		free(user_config);
 	}
 
+	if (git_config_shared()) {
+		char *shared_config=xstrdup(".gitconfig");
+		if (!access(shared_config, R_OK)) {
+			ret += git_config_from_shared_file(fn, shared_config, data);
+			found += 1;
+		}
+		free(shared_config);
+	}
+	
 	repo_config = git_pathdup("config");
 	if (!access(repo_config, R_OK)) {
 		ret += git_config_from_file(fn, repo_config, data);
-- 
1.7.3.2.347.gd33a62
