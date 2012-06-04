From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG attributes
 and XDG ignore files
Date: Mon, 04 Jun 2012 18:54:03 +0100
Message-ID: <4FCCF63B.8070609@ramsay1.demon.co.uk>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: nguyenhu@ensibm.imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 04 19:56:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbW1-0006Kk-O6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab2FDR4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:56:25 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:37040 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375Ab2FDR4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 13:56:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SbbVu-0005Mx-WO; Mon, 04 Jun 2012 17:56:23 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199165>

Huynh Khoi Nguyen NGUYEN wrote:
> From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
> 
> Git will be able to read in $XDG_CONFIG_HOME/git/config, a new
> configuration file following XDG specification. In the order of
> reading, this file is between global configuration file and system
> wide configuration file. Git will not be able to write in this new
> configuration file. If core.excludesfile is not define, Git will read
> the global exclude files in $XDG_CONFIG_HOME/git/ignore. Same goes for
> core.attributesfile in $XDG_CONFIG_HOME/git/attributes. If
> $XDG_CONFIG_HOME is either not set or empty, $HOME/.config will be
> used.
> 
> Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> Signed-off-by: Lucien KONG <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Franck JONAS <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>  Documentation/git-config.txt    |   12 +++-
>  attr.c                          |   10 +++
>  builtin/config.c                |   28 ++++++---
>  cache.h                         |    1 +
>  config.c                        |   21 ++++---
>  dir.c                           |    4 +
>  path.c                          |   26 ++++++++
>  t/t1306-read-xdg-config-file.sh |  133 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 214 insertions(+), 21 deletions(-)
>  create mode 100755 t/t1306-read-xdg-config-file.sh
> 

[...]

> diff --git a/attr.c b/attr.c
> index 303751f..441387f 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -497,6 +497,9 @@ static int git_attr_system(void)
>  static void bootstrap_attr_stack(void)
>  {
>  	struct attr_stack *elem;
> +	char *xdg_attributes_file;
> +
> +	home_config_paths(NULL, &xdg_attributes_file, "attributes");

who free()'s xdg_attributes_file ?

[...]

> diff --git a/config.c b/config.c
> index 71ef171..d1393b8 100644
> --- a/config.c
> +++ b/config.c
> @@ -929,7 +929,10 @@ int git_config_system(void)
>  int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  {
>  	int ret = 0, found = 0;
> -	const char *home = NULL;
> +	char *xdg_config = NULL;
> +	char *user_config = NULL;
> +
> +	home_config_paths(&user_config, &xdg_config, "config");

who free()'s user_config and xdg_config?

[...]

> diff --git a/dir.c b/dir.c
> index ed1510f..e0c3589 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1234,13 +1234,17 @@ int remove_dir_recursively(struct strbuf *path, int flag)
>  void setup_standard_excludes(struct dir_struct *dir)
>  {
>  	const char *path;
> +	char *xdg_path;
>  
>  	dir->exclude_per_dir = ".gitignore";
>  	path = git_path("info/exclude");
> +	home_config_paths(NULL, &xdg_path, "ignore");

ditto xdg_path ;-)

>  	if (!access(path, R_OK))
>  		add_excludes_from_file(dir, path);
>  	if (excludes_file && !access(excludes_file, R_OK))
>  		add_excludes_from_file(dir, excludes_file);
> +	else if (!access(xdg_path, R_OK))
> +		add_excludes_from_file(dir, xdg_path);
>  }
>  
>  int remove_path(const char *name)
> diff --git a/path.c b/path.c
> index 6f2aa69..53f3f53 100644
> --- a/path.c
> +++ b/path.c
> @@ -122,6 +122,32 @@ char *git_path(const char *fmt, ...)
>  	return cleanup_path(pathname);
>  }
>  
> +void home_config_paths(char **global, char **xdg, char *file)
> +{
> +	char *xdg_home = getenv("XDG_CONFIG_HOME");
> +	char *home = getenv("HOME");
> +	char *to_free = NULL;
> +
> +	if (!home) {
> +		if (global)
> +			*global = NULL;
> +	} else {
> +		if (!xdg_home) {
> +			to_free = strdup(mkpath("%s/.config", home));
> +			xdg_home = to_free;
> +		}
> +		if (global)
> +			*global = xstrdup(mkpath("%s/.gitconfig", home));
> +	}
> +
> +	if (!xdg_home)
> +		*xdg = NULL;
> +	else
> +		*xdg = xstrdup(mkpath("%s/git/%s", xdg_home, file));
> +
> +	free(to_free);
> +}
> +

So, this re-introduces the bug addressed by commit 05bab3ea. The test number
is now 29 (rather than 21) but the same test is failing; namely t3200-branch.sh
test #29 (git branch -m q q2 without config should succeed).

In order to fix the bug, I created the patch given below (on top of this patch).
(Note that it does not address the above issues).

HTH

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] path.c: Fix a static buffer overwrite bug by avoiding mkpath()

The v4 version of the "Read (but not write) from XDG configuration,
XDG attributes and XDG ignore files" patch, re-introduced the bug
addressed by commit 05bab3ea ("config.c: Fix a static buffer overwrite
bug by avoiding mkpath()", 19-11-2011). Note that the patch refactored
the code to determine the user (or home) configuration filename into
a new function (home_config_paths()). In doing so, the new code once
again uses mkpath() rather than mksnpath().

In order to fix the bug, we introduce a new variation of the mkpath()
function, mkpathdup(), which avoids the use of the internal static
buffers. As the name implies, the new function returns a pointer to
the pathname as a dynamically allocated string. It is the callers
responsibility to free the memory for the returned string.

Having introduced the new function, we can now replace the calls to
'xstrdup(mkpath(...))' in the home_config_paths() function with a
call to mkpathdup() to achieve the same effect, without tickling the
original bug.

(Also, note that the 'xstrdup(mkpath(...))' pattern occurs in several
other places in the source ...)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 cache.h |    2 ++
 path.c  |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 0632503..fbba2d6 100644
--- a/cache.h
+++ b/cache.h
@@ -619,6 +619,8 @@ extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern char *mkpathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
diff --git a/path.c b/path.c
index 53f3f53..ca29bdd 100644
--- a/path.c
+++ b/path.c
@@ -87,6 +87,20 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(path);
 }
 
+char *mkpathdup(const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list args;
+	unsigned len;
+
+	va_start(args, fmt);
+	len = vsnprintf(path, sizeof(path), fmt, args);
+	va_end(args);
+	if (len >= sizeof(path))
+		return xstrdup(bad_path);
+	return xstrdup(cleanup_path(path));
+}
+
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
@@ -133,17 +147,17 @@ void home_config_paths(char **global, char **xdg, char *file)
 			*global = NULL;
 	} else {
 		if (!xdg_home) {
-			to_free = strdup(mkpath("%s/.config", home));
+			to_free = mkpathdup("%s/.config", home);
 			xdg_home = to_free;
 		}
 		if (global)
-			*global = xstrdup(mkpath("%s/.gitconfig", home));
+			*global = mkpathdup("%s/.gitconfig", home);
 	}
 
 	if (!xdg_home)
 		*xdg = NULL;
 	else
-		*xdg = xstrdup(mkpath("%s/git/%s", xdg_home, file));
+		*xdg = mkpathdup("%s/git/%s", xdg_home, file);
 
 	free(to_free);
 }
-- 
1.7.10
