From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Clean up git-ls-file directory walking library interface
Date: Tue, 16 May 2006 21:06:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605162100570.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605161859050.16475@g5.osdl.org>
 <Pine.LNX.4.64.0605161944480.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 06:07:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgDJN-00051B-Ky
	for gcvg-git@gmane.org; Wed, 17 May 2006 06:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWEQEG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 00:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWEQEG7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 00:06:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWEQEG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 00:06:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4H46otH001259
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 21:06:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4H46njZ001318;
	Tue, 16 May 2006 21:06:49 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605161944480.10823@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20161>



On Tue, 16 May 2006, Linus Torvalds wrote:
> 
> That not only allows us to turn the function push_exclude_per_directory() 
> static again, it also simplifies the library interface a lot (the caller 
> no longer needs to worry about any of the per-directory exclude files at 
> all).

Just as an example, here's all you need to basically do

	git-ls-files --others --directory
		--exclude-from="$GIT_DIR/info/exclude"
		--exclude-per-directory=.gitignore

like "git status" does (where the "--exclude-from" is conditional on 
whether the file exists or not).

		Linus
---
#include "cache.h"
#include "dir.h"

int main(int argc, char **argv)
{
	struct dir_struct dir;
	const char *prefix = setup_git_directory();
	const char *base, *path;
	int baselen, i;

	/* Read the index */
	read_cache();

	/* Set up the "struct dir_struct */
	memset(&dir, 0, sizeof(dir));
	dir.show_other_directories = 1;

	/* normal git porcelain exclude patterns */
	dir.exclude_per_dir = ".gitignore";
	path = git_path("info/exclude");
	if (!access(path, R_OK))
		add_excludes_from_file(&dir, path);

	/* Set up read_directory() arguments and go go go! */
	path = ".";
	base = "";
	baselen = 0;
	if (prefix) {
		path = base = prefix;
		baselen = strlen(prefix);
	}
	read_directory(&dir, path, base, baselen);

	/* And print it all out */
	if (dir.nr)
		printf("#\n# Untracked files:\n#\n");
	for (i = 0; i < dir.nr; i++)
		printf("# %s\n", dir.entries[i]->name);
	return 0;
}
