From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Mon, 30 Jun 2008 12:57:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806301233560.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer> <alpine.LNX.1.00.0806291821520.19665@iabervon.org> <7vabh390sc.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806292320300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 14:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDI3G-0001kz-Tu
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 14:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbYF3L7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 07:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbYF3L7N
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:59:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:50350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756968AbYF3L7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:59:12 -0400
Received: (qmail invoked by alias); 30 Jun 2008 11:59:10 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp005) with SMTP; 30 Jun 2008 13:59:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xMZoiRaYxtaYUp7dOCIpRrHFGYcfgSZziuhrZl6
	5S9/rMgV1g1jhY
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806292320300.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86910>

Hi,

On Sun, 29 Jun 2008, Daniel Barkalow wrote:

> Now, clone writes to the config file before reading any configuration, so, 
> if it's going to write to ".git/config" instead of $GIT_CONFIG, it can't 
> read from $GIT_CONFIG either. So there's no way (outside of redesigning 
> config.c) to make GIT_CONFIG useful for "clone" in particular.

Except you could read the config _before_ writing.

Or you could enhance (not redesign, as you suggest) config.c thusly:

-- snip --
diff --git a/cache.h b/cache.h
index 871f6c1..f3ea997 100644
--- a/cache.h
+++ b/cache.h
@@ -742,6 +742,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file(const char *, const char *, const char *, int, const char *);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
diff --git a/config.c b/config.c
index 58749bf..41a35eb 100644
--- a/config.c
+++ b/config.c
@@ -863,23 +863,31 @@ int git_config_set(const char* key, const char* value)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char* key, const char* value,
-	const char* value_regex, int multi_replace)
+int git_config_set_multivar(const char *key, const char *value,
+	const char *value_regex, int multi_replace)
+{
+	return git_config_set_multivar_in_file(key, value, value_regex,
+		multi_replace, NULL);
+}
+
+int git_config_set_multivar_in_file(const char *key, const char *value,
+	const char *value_regex, int multi_replace, const char *config_filename)
 {
 	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
-	char* config_filename;
+	char *filename;
 	struct lock_file *lock = NULL;
 	const char* last_dot = strrchr(key, '.');
 
-	config_filename = getenv(CONFIG_ENVIRONMENT);
+	if (!config_filename)
+		config_filename = getenv(CONFIG_ENVIRONMENT);
 	if (!config_filename) {
 		config_filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!config_filename)
-			config_filename  = git_path("config");
+			config_filename =
+				filename = xstrdup(git_path("config"));
 	}
-	config_filename = xstrdup(config_filename);
 
 	/*
 	 * Since "key" actually contains the section name and the real
@@ -1091,7 +1099,8 @@ int git_config_set_multivar(const char* key, const char* value,
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-	free(config_filename);
+	if (filename)
+		free(filename);
 	return ret;
 
 write_err_out:
-- snap --

... and then have something like

        config_filename = xstrdup(mkpath("%s/config", git_dir));

        if (safe_create_leading_directories_const(git_dir) < 0)
                die("could not create leading directories of '%s'", git_dir);
        set_git_dir(make_absolute_path(git_dir));

	[...]

	if (option_bare) {
                strcpy(branch_top, "refs/heads/");

                git_config_set_multivar_in_file("core.bare", "true",
			NULL, 0, config_filename);

	[...]

Of course, you would also have to teach init_db() to use this filename.

But frankly, I do not see the use of your "narrow" special case.  And as I 
stated in another thread, I am pretty opposed to crossing bridges that are 
miles (or an eternity) away.

So unless you present me with a sensible scenario where your "respect 
GIT_CONFIG for _reading_ in GIT_CONFIG=... git clone" makes sense, there 
is nothing to see here, please move along.

Ciao,
Dscho
