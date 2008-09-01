From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/1] fast-import: show a warning for non-existent files.
Date: Mon, 1 Sep 2008 12:25:06 -0700
Message-ID: <20080901192506.GE7482@spearce.org>
References: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaF2b-0006kp-Km
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbYIATZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYIATZI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:25:08 -0400
Received: from george.spearce.org ([209.20.77.23]:44778 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYIATZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:25:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA18138375; Mon,  1 Sep 2008 19:25:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94602>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> This is useful in certain SCMs like monotone, where each 'merge revision' has
> the changes of all the micro-branches merged. So it appears as duplicated commands.
> 
> The delete command was ignoring the issue completely. The rename/copy commands
> where throwing a fatal exception.

Signed-off-by line?  See Documentation/SubmittingPatches.

> diff --git a/fast-import.c b/fast-import.c
> index 7089e6f..3dd2ab6 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1952,7 +1953,13 @@ static void file_change_d(struct branch *b)
>  			die("Garbage after path in: %s", command_buf.buf);
>  		p = uq.buf;
>  	}
> -	tree_content_remove(&b->branch_tree, p, NULL);
> +	memset(&leaf, 0, sizeof(leaf));
> +	tree_content_remove(&b->branch_tree, p, &leaf);
> +	if (!leaf.versions[1].mode)
> +	{
> +		warning("Path %s not in branch", p);
> +		return;
> +	}
>  }
>  
>  static void file_change_cr(struct branch *b, int rename)

This is going to leak memory unless you add this before the
if (..mode) condition:

	if (leaf->tree)
		release_tree_content_recursive(e->tree);

We didn't worry about deleting a path that doesn't exist because
the importer clearly wants it gone.  If it wants it gone and it is
already gone then it should be fine to ignore the delete command.

But as I point out below some import front-ends should be accurate
enough that they should not send a 'D' command unless the path is
already in the tree.  Thus this can be an error condition for some
types of frontends, but can be ignored for others.

> @@ -1994,7 +2001,10 @@ static void file_change_cr(struct branch *b, int rename)
>  	else
>  		tree_content_get(&b->branch_tree, s, &leaf);
>  	if (!leaf.versions[1].mode)
> -		die("Path %s not in branch", s);
> +	{
> +		warning("Path %s not in branch", s);
> +		return;
> +	}
>  	tree_content_set(&b->branch_tree, d,
>  		leaf.versions[1].sha1,
>  		leaf.versions[1].mode,

Normally we consider invalid paths to be an error.  I wonder if this
should still be an error, unless the front-end passes an option on
the command line.  Then monotone based importers can make these
warnings, but other importers that don't have this problem can
still treat them what they are, which is a fatal error.

Did you run the test suite (t/t9300-fast-import.sh) after your patch?
I would have thought a few of the bad path errors should be caught
there.

-- 
Shawn.
