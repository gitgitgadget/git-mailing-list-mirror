From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-commit: avoid always using reduce_heads()
Date: Thu, 2 Oct 2008 19:35:18 -0700
Message-ID: <20081003023518.GA3291@spearce.org>
References: <20080926155204.GD17584@spearce.org> <1222457868-9864-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER Gabor <szeder@ira.uka.de>, jnareb@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 04:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlaWt-0005rd-Eo
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 04:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbYJCCfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 22:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbYJCCfU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 22:35:20 -0400
Received: from george.spearce.org ([209.20.77.23]:35661 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbYJCCfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 22:35:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 88B713835F; Fri,  3 Oct 2008 02:35:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222457868-9864-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97390>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 55e1087..f546cf7 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -1040,6 +1050,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	unlink(git_path("MERGE_HEAD"));
>  	unlink(git_path("MERGE_MSG"));
> +	unlink(git_path("MERGE_MODE"));
>  	unlink(git_path("SQUASH_MSG"));
>  
>  	if (commit_index_files())

Hmmph.  Should branch.c and builtin-reset.c clean this new file
up too?

> diff --git a/builtin-merge.c b/builtin-merge.c
> index 5c65a58..20102a0 100644
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
> +			strbuf_addf(&buf, "no-ff");
> +		if (write_in_full(fd, buf.buf, buf.len) != buf.len)

Shouldn't we open this file with O_TRUNC to avoid this scenario:

  $ git merge --no-ff --no-commit foo
  $ git reset --hard
  $ git merge --no-commit foo
  ... *sigh* MERGE_MODE still has "no-ff" in it ...

This is especially true since some porcelain (e.g. git-gui) just
deletes MERGE_HEAD right now and doesn't know about cleaning up
MERGE_MODE.  We'd want to at least reset it correctly on the next
invocation to git-merge.

-- 
Shawn.
