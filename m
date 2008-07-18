From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Fri, 18 Jul 2008 14:07:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness> <1216380408-21671-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJokw-0007ES-D7
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 14:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYGRMHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 08:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYGRMHO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 08:07:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:42372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbYGRMHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 08:07:13 -0400
Received: (qmail invoked by alias); 18 Jul 2008 12:07:11 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp051) with SMTP; 18 Jul 2008 14:07:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MKnFtWm2M7gRKP3emuBP3iRMY2GS6o2KVP6XBfE
	Hng8IJ2+LDi1Z3
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216380408-21671-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89034>

Hi,

On Fri, 18 Jul 2008, Stephan Beyer wrote:

> This patch removes exit()/die() calls and builtin-specific messages from 
> launch_editor(), so that it can be used as a general libgit.a function 
> to launch an editor.

Thanks.  Now we have to convince Junio that it is a good idea :-)

> diff --git a/builtin-commit.c b/builtin-commit.c
> index ed3fe3f..64f69f3 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -647,7 +647,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
>  		char index[PATH_MAX];
>  		const char *env[2] = { index, NULL };
>  		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> -		launch_editor(git_path(commit_editmsg), NULL, env);
> +		if (launch_editor(git_path(commit_editmsg), NULL, env))
> +			die("running editor failed.\n"
> +			"Please supply the message using either -m or -F option.");

In the error case, run_editor() already said more than "running editor 
failed.", right?  Maybe you just want to skip that line and keep the 
second?

> diff --git a/editor.c b/editor.c
> index 483b62d..5d7f5f9 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -17,9 +17,8 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
>  	terminal = getenv("TERM");
>  	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
>  		fprintf(stderr,
> -		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
> -		"Please supply the message using either -m or -F option.\n");
> -		exit(1);
> +		"Terminal is dumb but no VISUAL nor EDITOR defined.\n");
> +		return 1;

Why not "return error()"?

Rest looks obviously correct to me!

Thanks,
Dscho
