From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 01:23:58 +0200
Message-ID: <20060617232358.GK2609@pasky.or.cz>
References: <e720r0$qdv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 01:23:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frk84-0000DS-LE
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 01:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWFQXW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWFQXW4
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 19:22:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63917 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751066AbWFQXWz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 19:22:55 -0400
Received: (qmail 24319 invoked by uid 2001); 18 Jun 2006 01:23:58 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e720r0$qdv$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22042>

Dear diary, on Sun, Jun 18, 2006 at 12:48:12AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis <pasky@suse.cz> writes:
> >  - we might want to have a configuration mechanism in place
> >    before enhancing gitweb.  My gut feeling is that we can use
> >    [gitweb] section in project.git/config (and probably
> >    duplicate first and deprecate later existing "description" as
> >    well).

(Note that this is what Junio said, not me.)

> - gitweb installation options (gitweb version need not to correspond to 
>   git version, and we could theoretically have more than one gitweb
>   installation while one git-core installation). It was proposed to put
>   such options on gitweb.conf file in the same directory as gitweb.cgi.
>   Unfortunately if one would want to use git-repo-config for managing
>   gitweb.conf one is out of luck: git-repo-config uses $GIT_DIR/config.

In the longer term, perhaps this kind of configuration might land in the
global git configuration file.

---
[PATCH] Support for extracting configuration from different files

Add $GIT_CONFIG environment variable whose content is used instead
of .git/config if set. Also add $GIT_CONFIG_LOCAL as a
forward-compatibility cue for whenever we will finally come to support]
global configuration files (properly).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-repo-config.txt |   12 ++++++++++++
 config.c                          |   12 +++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index d5142e0..803c0d5 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -73,6 +73,18 @@ OPTIONS
 	List all variables set in .git/config.
 
 
+ENVIRONMENT
+-----------
+
+GIT_CONFIG::
+	Take the configuration from the given file instead of .git/config.
+
+GIT_CONFIG_LOCAL::
+	Currently the same as $GIT_CONFIG; when Git will support global
+	configuration files, this will cause it to take the configuration
+	from the global configuration file in addition to the given file.
+
+
 EXAMPLE
 -------
 
diff --git a/config.c b/config.c
index c474970..42e1493 100644
--- a/config.c
+++ b/config.c
@@ -317,7 +317,17 @@ int git_config_from_file(config_fn_t fn,
 
 int git_config(config_fn_t fn)
 {
-	return git_config_from_file(fn, git_path("config"));
+	const char *filename = git_path("config");
+	/* Forward-compatibility cue: $GIT_CONFIG makes git read _only_
+	 * the given config file, $GIT_CONFIG_LOCAL will make it process
+	 * it in addition to the global config file, the same way it would
+	 * the per-repository config file otherwise. */
+	if (getenv("GIT_CONFIG")) {
+		filename = getenv("GIT_CONFIG");
+	} else if (getenv("GIT_CONFIG_LOCAL")) {
+		filename = getenv("GIT_CONFIG_LOCAL");
+	}
+	return git_config_from_file(fn, filename);
 }
 
 /*

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
