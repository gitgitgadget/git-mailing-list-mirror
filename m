From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Mon, 22 Oct 2007 01:30:17 -0400
Message-ID: <20071022053016.GN14735@spearce.org>
References: <20071021214846.GI16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjpsN-0005QA-Oj
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXJVFaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXJVFaX
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:30:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46026 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbXJVFaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:30:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijprn-0007sq-Ma; Mon, 22 Oct 2007 01:30:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AC5F120FB09; Mon, 22 Oct 2007 01:30:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071021214846.GI16291@srparish.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61935>

Scott R Parish <srp@srparish.net> wrote:
> Currently "git help -a" only searches in the highest priority exec_path,
> meaning at worst, nothing is listed if the git commands are only available
> from the PATH. It also makes git slightly less extensible.
...
>  extern char **environ;
>  static const char *builtin_exec_path = GIT_EXEC_PATH;
> -static const char *current_exec_path;
> +static const char *argv_exec_path;
>  
> -void git_set_exec_path(const char *exec_path)
> +void git_set_argv_exec_path(const char *exec_path)
>  {
> -	current_exec_path = exec_path;
> +	argv_exec_path = exec_path;
>  }

I'd rather see a rename isolated from a logic change.  I find
it easier to review.
  
> +const char *git_argv_exec_path(void)
> +const char *git_builtin_exec_path(void)
> +const char *git_env_exec_path(void)

And yet later you then build the same priority array as already used
by execv_git_cmd().  Why not just make a function that builds the
array for the caller, so both execv_git_cmd() and list_commands()
can both use the same array?

> +static unsigned int list_commands_in_dir(const char *dir, const char *prefix)
>  {
> +	int start_dir = open(".", O_RDONLY, 0);
...
> +	if (!dirp || chdir(dir)) {
> +		fchdir(start_dir);

fchdir() isn't as portable as Git currently is.  Thus far we have
avoided using fchdir().  Requiring it here for something as "simple"
as listing help is not a good improvement as it will limit who can
run git-help.  Why can't you stat the individual entries by joining
the paths together?

-- 
Shawn.
