From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] When exec'ing sub-commands, fall back on execvp (the
 PATH)
Date: Sat, 20 Oct 2007 08:30:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710200824270.25221@racer.site>
References: <20071020064459.GB2237@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8oG-0001FL-7Y
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757684AbXJTHbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757414AbXJTHbN
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:31:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755750AbXJTHbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:31:11 -0400
Received: (qmail invoked by alias); 20 Oct 2007 07:31:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 20 Oct 2007 09:31:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IcrhFgH/Imo8+Xs+iWTaf4Be4XSuXWjz/cWZavz
	5Kab4Z8ZuEEAhQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071020064459.GB2237@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61806>

Hi,

On Fri, 19 Oct 2007, Scott Parish wrote:

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..674c9f3 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -34,15 +34,15 @@ int execv_git_cmd(const char **argv)
>  {
>  	char git_command[PATH_MAX + 1];
>  	int i;
> +	int rc;
>  	const char *paths[] = { current_exec_path,
>  				getenv(EXEC_PATH_ENVIRONMENT),
>  				builtin_exec_path };
> +	const char *tmp;
> +	size_t len;
>  
>  	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
> -		size_t len;
> -		int rc;
>  		const char *exec_dir = paths[i];
> -		const char *tmp;
>  
>  		if (!exec_dir || !*exec_dir) continue;
>  
> @@ -106,8 +106,26 @@ int execv_git_cmd(const char **argv)
>  
>  		argv[0] = tmp;
>  	}
> -	return -1;
>  
> +	rc = snprintf(git_command, sizeof(git_command), "git-%s", argv[0]);
> +	if (rc < 0 || rc >= sizeof(git_command) - len) {
> +		fprintf(stderr, "git: command name given is too long.\n");
> +		return -1;
> +	}
> +
> +	tmp = argv[0];
> +	argv[0] = git_command;
> +
> +	trace_argv_printf(argv, -1, "trace: exec:");
> +
> +	/* execve() can only ever return if it fails */
> +	execvp(git_command, (char **)argv);
> +
> +	trace_printf("trace: exec failed: %s\n", strerror(errno));
> +
> +	argv[0] = tmp;
> +
> +	return -1;
>  }

I am not sure that this is elegant enough: Something like this (completely 
untested) might be better:

diff --git a/exec_cmd.c b/exec_cmd.c
index 9b74ed2..c928f37 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
 	int i;
 	const char *paths[] = { current_exec_path,
 				getenv(EXEC_PATH_ENVIRONMENT),
-				builtin_exec_path };
+				builtin_exec_path,
+				"" };
 
 	for (i = 0; i < ARRAY_SIZE(paths); ++i) {
 		size_t len;
@@ -44,9 +45,12 @@ int execv_git_cmd(const char **argv)
 		const char *exec_dir = paths[i];
 		const char *tmp;
 
-		if (!exec_dir || !*exec_dir) continue;
+		if (!exec_dir) continue;
 
-		if (*exec_dir != '/') {
+		if (!*exec_dir)
+			/* try PATH */
+			*git_command = '\0';
+		else if (*exec_dir != '/') {
 			if (!getcwd(git_command, sizeof(git_command))) {
 				fprintf(stderr, "git: cannot determine "
 					"current directory: %s\n",
@@ -81,7 +85,7 @@ int execv_git_cmd(const char **argv)
 
 		len = strlen(git_command);
 		rc = snprintf(git_command + len, sizeof(git_command) - len,
-			      "/git-%s", argv[0]);
+			      "%sgit-%s", *exec_dir ? "/" : "", argv[0]);
 		if (rc < 0 || rc >= sizeof(git_command) - len) {
 			fprintf(stderr,
 				"git: command name given is too long.\n");

Ciao,
Dscho
