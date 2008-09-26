From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Fri, 26 Sep 2008 08:52:04 -0700
Message-ID: <20080926155204.GD17584@spearce.org>
References: <20080926151517.GV23137@genesis.frugalware.org> <1222442432-7430-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER Gabor <szeder@ira.uka.de>, jnareb@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:53:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFdB-0002pk-4u
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYIZPwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYIZPwH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:52:07 -0400
Received: from george.spearce.org ([209.20.77.23]:49967 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbYIZPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:52:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E6C4B3835F; Fri, 26 Sep 2008 15:52:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222442432-7430-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96873>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> In case git merge --no-ff is used with --no-commit or we have a
> conflict, write info about if fast forwards are allowed or not to
> $GIT_DIR/MERGE_MODE.
 
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 55e1087..aac5cb4 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -988,7 +990,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		reflog_msg = "commit";
>  		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
>  	}
> -	parents = reduce_heads(parents);
> +	strbuf_reset(&sb);
> +	if (!stat(git_path("MERGE_MODE"), &statbuf)) {
> +		if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
> +			die("could not read MERGE_MODE: %s", strerror(errno));
> +		printf("debug, contents of buf: '%s'\n",sb.buf);
> +		if (!strcmp(sb.buf, "deny_fast_forward")) {
> +			printf("debug, deny fast forward\n");

Left over debugging.

> diff --git a/builtin-merge.c b/builtin-merge.c
> index 5c65a58..973b167 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -1210,6 +1210,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			merge_msg.len)
>  			die("Could not write to %s", git_path("MERGE_MSG"));
>  		close(fd);
> +		fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT, 0666);
> +		if (fd < 0)
> +			die("Could open %s for writing", git_path("MERGE_MODE"));
> +		strbuf_reset(&buf);
> +		if (!allow_fast_forward)
> +			strbuf_addf(&buf, "deny_fast_forward");

I wonder if the option in the file shouldn't be more related to
the merge command line option.  Its --no-ff to the user.  Maybe we
should call it "no-ff" here?  Or "no-fast-forward" if we want to go
with a longer name that is less likely to be ambiguous in the future?

-- 
Shawn.
