From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: [PATCH] change contract between system_path and it's callers
Date: Mon, 24 Nov 2014 11:33:54 -0800
Message-ID: <xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 20:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XszPL-0003Rs-Au
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 20:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbaKXTeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 14:34:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751705AbaKXTeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 14:34:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8902821AEA;
	Mon, 24 Nov 2014 14:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PCv8MPVmwfX42bYqFGCsZY/i1T4=; b=c3fd8uOsFwTl1dZGO94N
	vlL9JZwsNvwfWjic+l8nM80WF1mSRNgc2DAwSiOQQr+qmmcx8WKMrrIPdMp6mSR8
	4TPakmTgxmosLf3xm8CPrrXGdFpJ2DxghVyWZATN1IfOLQwg4KJ3Q2H5XEgHL5aQ
	SyGwr9v1MU+zN03iKXAvrXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bUgLBbp0uWBjQQN8ccNqBoypcXPa2hjt4La9wNjcJZg3R8
	n53uwOC/9/DNXM8Av2b5yvoJzwZ+tzTDpvZitJwf3CYUDj52gkNhQcogqxRtAJzz
	s9zUyWOWy6+fzqjPuqdsJyBjrXbVPmuhU9MvPXS9GUpwCMNCX2LoTF+0vMY0Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ED9421AE9;
	Mon, 24 Nov 2014 14:33:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2B6121AE8;
	Mon, 24 Nov 2014 14:33:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4DC11FA-7410-11E4-88D4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260139>

0xAX <kuleshovmail@gmail.com> writes:

> Now system_path returns path which is allocated string to callers;
> It prevents memory leaks in some places. All callers of system_path
> are owners of path string and they must release it.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---

> -static const char *git_etc_gitattributes(void)
> +static char *git_etc_gitattributes(void)

Hmph, I think this should keep returning "const char *", as the
caller is not expected to free the pointer or write into the memory
held by the returned string.  The same applies to the change of the
type in "struct git_config_source".

The change in the semantics of system_path() made the "get once and
keep returning it" this function does safer and correct, but this
function itself did not change any behaviour from its caller's point
of view.

>  {
> -	static const char *system_wide;
> +	static char *system_wide;
>  	if (!system_wide)
>  		system_wide = system_path(ETC_GITATTRIBUTES);
>  	return system_wide;


> @@ -489,7 +489,9 @@ static void bootstrap_attr_stack(void)
>  	attr_stack = elem;
>  
>  	if (git_attr_system()) {
> -		elem = read_attr_from_file(git_etc_gitattributes(), 1);
> +		char *etc_attributes = git_etc_gitattributes();
> +		elem = read_attr_from_file(etc_attributes, 1);
> +		free(etc_attributes);

And freeing here is actively wrong, I think.  You are freeing the
piece of memory still pointed by "static char *system_wide" in the
function git_etc_gitattributes(); when it is called again, the
caller will get a pointer into the memory you have freed here.

> diff --git a/builtin/config.c b/builtin/config.c
> index 15a7bea..266d42b 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -575,8 +575,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		if (given_config_source.blob)
>  			die("editing blobs is not supported");
>  		git_config(git_default_config, NULL);
> -		config_file = xstrdup(given_config_source.file ?
> -				      given_config_source.file : git_path("config"));
> +
> +		if (use_system_config)
> +			config_file = given_config_source.file ?
> +							given_config_source.file : git_path("config");
> +		else
> +			config_file = xstrdup(given_config_source.file ?
> +								  given_config_source.file : git_path("config"));
> +

Sorry, but I do not understand this change.

Why do you need "if use-system-config, do not allocate" here and
then later everywhere "if use-system-config, free it"?  I would
understand if the change were "earlier we had mixture of borrowed
and owned strings, but we make sure we always own the string by
running xstrdup() in the caller when we used to let this function
borrow, so that we can always free() before returning from here",
or something.

For example, in the original code, use_local_config codepath uses
git_pathdup(), which is an allocated piece of memory, to initialize
given_config_source.file.  Doesn't it need to be freed?

Even if it is not in the use_system_config mode, if
given_config_source.file is not an absolute path, we store a copy of
prefix-filename result to given_config_source.file.  Doesn't it need
to be freed?

I think the implementation strategy you took makes the result
unnecessarily messy and error prone.  Let's step back a bit.

When you have code that sometimes borrows memory and sometimes owns
memory, writing the clean-up part like this is error prone:

	char *var;

	if (A)
		var = borrowed memory;
	else if (B)
		var = borrowed memory;
	else if (C)
		var = xstrdup(borrowed memory);
	else	
		var = borrowed memory;

	use var; /* a loong piece of code in reality */

	if (C)
        	free(var);

because the set-up part can and will change over time as the code
evolves.  If written this way:

	char *var, *to_free = NULL;

	if (A)
		var = borrowed memory;
	else if (B)
		var = borrowed memory;
	else if (C)
		to_free = var = xstrdup(borrowed memory);
	else	
		var = borrowed memory;

	use var; /* a loong piece of code in reality */

	free(to_free);

the clean-up part would not have to worry how the set-up part
decided when to borrow memory and when to own memory.  Another way
to do so would obviously be:

	char *var;

	if (A)
		var = xstrdup(borrowed memory);
	else if (B)
		var = xstrdup(borrowed memory);
	else if (C)
		var = xstrdup(borrowed memory);
	else	
		var = xstrdup(borrowed memory);

	use var; /* a loong piece of code in reality */

       	free(var);

to always own the memory, but depending on the original code, it may
make the result more inefficient and the patch more noisy.

This is especially true when the clean-up part is spread all over
the place like your patch does, i.e. the "use var" part of the code
looks like

	if (X) {
        	... a looong piece of code to use var ...
	        if (C)
                	free(var);
	} else if (Y) {
        	... a looong piece of code to use var ...
	        if (C)
                	free(var);
        } else {
        	... a looong piece of code to use var ...
	        if (C)
                	free(var);
	}

which is simply unmaintainable.  Better to make "use var" and the
clean-up part structured more like this, using the to_free trick:

	if (X) {
        	... a looong piece of code to use var ...
		goto cleanup;
	} else if (Y) {
        	... a looong piece of code to use var ...
		goto cleanup;
        } else {
        	... a looong piece of code to use var ...
		goto cleanup;
	}

	cleanup:
		free(to_free);

> diff --git a/builtin/help.c b/builtin/help.c
> index b3c818e..20ffbb1 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -326,7 +326,8 @@ static void setup_man_path(void)
>  	 * old_path, the ':' at the end will let 'man' to try
>  	 * system-wide paths after ours to find the manual page. If
>  	 * there is old_path, we need ':' as delimiter. */
> -	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
> +	char *git_man_path = system_path(GIT_MAN_PATH);

Defile variable in the definition block above to avoid future
decl-after-stmt, i.e.

	 const char *old_path = getenv("MANPATH");
	+char *git_man_path = system_path(GIT_MAN_PATH);

	 /* We should always put ...

> +	strbuf_addstr(&new_path, git_man_path);

And better free it immediately after you are done, instead of at the
end of the function.

>  	strbuf_addch(&new_path, ':');
>  	if (old_path)
>  		strbuf_addstr(&new_path, old_path);
> @@ -334,6 +335,7 @@ static void setup_man_path(void)
>  	setenv("MANPATH", new_path.buf, 1);
>  
>  	strbuf_release(&new_path);
> +	free(git_man_path);
>  }

> -static void get_html_page_path(struct strbuf *page_path, const char *page)
> +static void get_html_page_path(struct strbuf *page_path, const char *page, char *html_path)
>  {
>  	struct stat st;
> -	if (!html_path)
> -		html_path = system_path(GIT_HTML_PATH);
>  
>  	/* Check that we have a git documentation directory. */
>  	if (!strstr(html_path, "://")) {
>  		if (stat(mkpath("%s/git.html", html_path), &st)
> -		    || !S_ISREG(st.st_mode))
> -			die("'%s': not a documentation directory.", html_path);
> +				|| !S_ISREG(st.st_mode)){
> +			printf("'%s': not a documentation directory.\n", html_path);
> +			free(html_path);
> +			exit(1);

This is an unnecessary churn, and an unwarranted change to the
externally visible behaviour.  die() gives its message to the
standard error stream (not to the standard output stream), and exits
with 128 (not with 1).

We are exiting immediately after; it is not worth changing the API
to the caller or external behaviour, only to free(html_path)
conditionally.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 2619ca5..6f36f3f 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -126,11 +126,17 @@ static void copy_templates(const char *template_dir)
>  		template_dir = init_db_template_dir;
>  	if (!template_dir)
>  		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
> -	if (!template_dir[0])
> +	if (!template_dir[0]){

A SP between ) and {

> +		if (!template_dir)
> +			free((char*)template_dir);

No need for "call free only if it is not NULL"; free(NULL) works
just fine.

>  		return;
> +	}
>  	template_len = strlen(template_dir);
> -	if (PATH_MAX <= (template_len+strlen("/config")))
> +	if (PATH_MAX <= (template_len+strlen("/config"))){
> +		if (!template_dir)
> +			free((char*)template_dir);
>  		die(_("insanely long template path %s"), template_dir);

You are freeing and then using it in the message, and it cannot be
NULL anyway so "if (!template_dir)" is doubly unnecessary.

I wouldn't bother freeing immediately before dying, exiting, or
execing.

Here is my quick attempt, starting solely from the output of "git
grep system_path".  How does it look?

One thing to note is that this illustration does not consider memory
pointed at by the "system_wide" variable here (from attr.c)

        static const char *git_etc_gitattributes(void)
        {
                static const char *system_wide;
                if (!system_wide)
                        system_wide = system_path(ETC_GITATTRIBUTES);
                return system_wide;
        }

at the point of process exit as a "leak".

-- >8 --
Subject: system_path(): always return free'able memory to the caller

The function sometimes returns a newly allocated string and
sometimes returns a borrowed string, the latter of which the callers
must not free().  The existing callers all assume that the return
value belongs to the callee and most of them copy it with strdup()
when they want to keep it around.  They end up leaking the returned
copy when the callee returned a new string because they cannot tell
if they should free it.

Change the contract between the callers and system_path() to make
the returned string owned by the callers; they are responsible for
freeing it when done, but they do not have to make their own copy to
store it away.

Adjust the callers to make sure they do not leak the returned string
once they are done, but do not bother freeing it just before dying,
exiting or exec'ing other program to avoid unnecessary churn.

Reported-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/help.c    |  9 +++++++--
 builtin/init-db.c | 15 ++++++++++-----
 exec_cmd.c        |  7 +++----
 exec_cmd.h        |  2 +-
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b3c818e..e78c135 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -321,16 +321,18 @@ static void setup_man_path(void)
 {
 	struct strbuf new_path = STRBUF_INIT;
 	const char *old_path = getenv("MANPATH");
+	char *git_man_path = system_path(GIT_MAN_PATH);
 
 	/* We should always put ':' after our path. If there is no
 	 * old_path, the ':' at the end will let 'man' to try
 	 * system-wide paths after ours to find the manual page. If
 	 * there is old_path, we need ':' as delimiter. */
-	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
+	strbuf_addstr(&new_path, git_man_path);
 	strbuf_addch(&new_path, ':');
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 
+	free(git_man_path);
 	setenv("MANPATH", new_path.buf, 1);
 
 	strbuf_release(&new_path);
@@ -380,8 +382,10 @@ static void show_info_page(const char *git_cmd)
 static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
+	char *to_free = NULL;
+
 	if (!html_path)
-		html_path = system_path(GIT_HTML_PATH);
+		html_path = to_free = system_path(GIT_HTML_PATH);
 
 	/* Check that we have a git documentation directory. */
 	if (!strstr(html_path, "://")) {
@@ -392,6 +396,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
+	free(to_free);
 }
 
 /*
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2619ca5..9966522 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -119,15 +119,18 @@ static void copy_templates(const char *template_dir)
 	DIR *dir;
 	const char *git_dir = get_git_dir();
 	int len = strlen(git_dir);
+	char *to_free = NULL;
 
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
 		template_dir = init_db_template_dir;
 	if (!template_dir)
-		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
-	if (!template_dir[0])
+		template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
+	if (!template_dir[0]) {
+		free(to_free);
 		return;
+	}
 	template_len = strlen(template_dir);
 	if (PATH_MAX <= (template_len+strlen("/config")))
 		die(_("insanely long template path %s"), template_dir);
@@ -139,7 +142,7 @@ static void copy_templates(const char *template_dir)
 	dir = opendir(template_path);
 	if (!dir) {
 		warning(_("templates not found %s"), template_dir);
-		return;
+		goto free_return;
 	}
 
 	/* Make sure that template is from the correct vintage */
@@ -155,8 +158,7 @@ static void copy_templates(const char *template_dir)
 			"a wrong format version %d from '%s'"),
 			repository_format_version,
 			template_dir);
-		closedir(dir);
-		return;
+		goto close_free_return;
 	}
 
 	memcpy(path, git_dir, len);
@@ -166,7 +168,10 @@ static void copy_templates(const char *template_dir)
 	copy_templates_1(path, len,
 			 template_path, template_len,
 			 dir);
+close_free_return:
 	closedir(dir);
+free_return:
+	free(to_free);
 }
 
 static int git_init_db_config(const char *k, const char *v, void *cb)
diff --git a/exec_cmd.c b/exec_cmd.c
index 698e752..8ab37b5 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -6,7 +6,7 @@
 static const char *argv_exec_path;
 static const char *argv0_path;
 
-const char *system_path(const char *path)
+char *system_path(const char *path)
 {
 #ifdef RUNTIME_PREFIX
 	static const char *prefix;
@@ -16,7 +16,7 @@ const char *system_path(const char *path)
 	struct strbuf d = STRBUF_INIT;
 
 	if (is_absolute_path(path))
-		return path;
+		return xstrdup(path);
 
 #ifdef RUNTIME_PREFIX
 	assert(argv0_path);
@@ -34,8 +34,7 @@ const char *system_path(const char *path)
 #endif
 
 	strbuf_addf(&d, "%s/%s", prefix, path);
-	path = strbuf_detach(&d, NULL);
-	return path;
+	return strbuf_detach(&d, NULL);
 }
 
 const char *git_extract_argv0_path(const char *argv0)
diff --git a/exec_cmd.h b/exec_cmd.h
index e4c9702..93b0c02 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -9,6 +9,6 @@ extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
-extern const char *system_path(const char *path);
+extern char *system_path(const char *path);
 
 #endif /* GIT_EXEC_CMD_H */
