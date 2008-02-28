From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/9] Make setup_work_tree() return new prefix
Date: Thu, 28 Feb 2008 11:30:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281130140.22527@racer.site>
References: <cover.1204130175.git.pclouds@gmail.com> <20080227163902.GA28058@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1831121410-1204198153=:22527"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 12:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUgz7-0003nL-G7
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 12:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbYB1La5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 06:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756785AbYB1La5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 06:30:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:36136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756750AbYB1La4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 06:30:56 -0500
Received: (qmail invoked by alias); 28 Feb 2008 11:30:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 28 Feb 2008 12:30:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KufV/pdRKJaHLTtUJQpddGs6CzYXVkz48O5mJzk
	k4VPG6Blja+zNg
X-X-Sender: gene099@racer.site
In-Reply-To: <20080227163902.GA28058@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75387>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1831121410-1204198153=:22527
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 27 Feb 2008, Nguyễn Thái Ngọc Duy wrote:

> @@ -336,24 +321,21 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			static char buffer[1024 + 1];
>  			const char *retval;
>  
> +			/*
> +			 * The old behaviour (which we retain here) is to set
> +			 * the work tree root to the cwd, unless overridden by
> +			 * the config, the command line, or GIT_WORK_TREE.
> +			 */
>  			if (!work_tree_env) {
> -				retval = set_work_tree(gitdirenv);
> -				/* config may override worktree */
> -				if (check_repository_format_gently(nongit_ok))
> -					return NULL;
> -				return retval;
> +				char buffer[PATH_MAX + 1];
> +
> +				if (!getcwd(buffer, sizeof(buffer)))
> +					die ("Could not get the current working directory");
> +				git_work_tree_cfg = xstrdup(buffer);
> +				inside_work_tree = 1;
>  			}
> -			if (check_repository_format_gently(nongit_ok))
> -				return NULL;
> -			retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
> -					get_git_work_tree());
> -			if (!retval || !*retval)
> -				return NULL;
> -			set_git_dir(make_absolute_path(gitdirenv));
> -			if (chdir(work_tree_env) < 0)
> -				die ("Could not chdir to %s", work_tree_env);
> -			strcat(buffer, "/");
> -			return retval;
> +			check_repository_format_gently(nongit_ok);
> +			return NULL;

What about the situation where you are in a subdirectory of core.worktree?  
You return prefix NULL?  That's wrong.

I am sorry, but with all these intrusive changes, I get a very uneasy 
feeling.  As uneasy as with the original series, which I tried to fix up, 
not really succeeding.

Ciao,
Dscho

---1463811741-1831121410-1204198153=:22527--
