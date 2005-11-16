From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] C implementation of the 'git' program, take two.
Date: Tue, 15 Nov 2005 16:18:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511151603510.11232@g5.osdl.org>
References: <20051115233125.3153B5BF76@nox.op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 01:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcB0U-00019K-1c
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVKPASb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKPASb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:18:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965100AbVKPASb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 19:18:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAG0IRnO009844
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 16:18:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAG0IQcr028496;
	Tue, 15 Nov 2005 16:18:27 -0800
To: Andreas Ericsson <exon@op5.se>
In-Reply-To: <20051115233125.3153B5BF76@nox.op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11977>



On Wed, 16 Nov 2005, Andreas Ericsson wrote:
> +
> +	/* allow relative paths, but run with exact */
> +	if (chdir(exec_path)) {
> +		printf("git: '%s': %s\n", exec_path, strerror(errno));
> +		exit (1);
> +	}
> +
> +	getcwd(git_command, sizeof(git_command));
> +	chdir(wd);

Argh. This is pretty horrible way to turn a path into an absolute one. 
Especially since you didn't even test whether the original "wd" was 
successful.

Why don't you just do

	if (exec_path[0] != '/') {
		.. prepend "cwd/" to exec_path ..

since as far as I can tell you don't actually care whether it's a 
simplified path or not (you can remove "./" at the beginning just to make 
it cleaner, if you wish. In fact, you can remove "../" at the beginning 
too (but only the beginning) since getcwd() shouldn't have any symlink 
components).

The reason to avoid "chdir(relative) + chdir(back)" is that it totally 
unnecessarily breaks under some extreme cases. For example, if the 
exec_path is already absolute, and we just happen to be in a really deep 
subdirectory, then the getcwd() could have failed due to the PATH_MAX 
limitations.

Also, depending on getcwd() will not work if any parent directory is 
unreadable or non-executable (well, under Linux it will, as long as it's 
executable, since getcwd() is actually a system call. Not in UNIX in 
general, though). Again, that means that unless you _have_ to know what 
the cwd is, you should try to avoid relying on it.

Now, there are Linux-specific tricks that can avoid some of the problems 
if you want to, but they are very much hacks:

	if (filename[0] != '/') {
		fd = open(filename, O_DIRECTORY);
		if (fd >= 0) {
			snprintf(link_name, sizeof(link_name), "/proc/self/fd/%d", fd);
			if (!readlink(link_name ...)) {
				.. there it is ..
			}
			close(fd);
		}
	..

and the nicer thign to do is to just not try to be clever.

		Linus
