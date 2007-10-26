From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Add ability to copy a path from an arbitrary commit
Date: Fri, 26 Oct 2007 03:01:57 -0400
Message-ID: <20071026070157.GM14735@spearce.org>
References: <20071020155749.29528.9258.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlJE6-0000dx-6C
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763646AbXJZHCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 03:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763834AbXJZHCG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:02:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52049 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763288AbXJZHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:02:02 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IlJCg-0008Ey-Dg; Fri, 26 Oct 2007 03:01:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9500C20FBAE; Fri, 26 Oct 2007 03:01:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071020155749.29528.9258.julian@quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62396>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> This adds the ability to copy a path from an arbitrary commit instead
> of just from the current commit.  This is done using the 'K' version
> of the filecopy sub-command.

So the reason I didn't apply this earlier when I was playing the role
of "interim maintainer" was four fold:

- There's no test cases for this new 'K' command.  Everything else
  in fast-import has at least one test case for it, this should
  as well.

- There's a huge memory leak every time you use the 'K' command.
  See below in the code for where.

- The documentation doesn't talk about the special "/" source path.

- I was really busy and just forgot to reply to this email.

Other than that I think this is good.  I've just been too busy
to do it myself, and I'm glad that you took it upon yourself to
remedy that.
 
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index d511967..89aefea 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -534,6 +534,17 @@ location has been copied to the destination any future commands
>  applied to the source location will not impact the destination of
>  the copy.
>  
> +It is also possible to copy a file or directory from a commit other
> +than the current one.
> +
> +....
> +	'K' <dataref> SP <path> SP <path> LF
> +....
> +
> +where `<dataref>` is a reference (see `filemodify` above) to the
> +commit that the first (source) `<path>` is located in, the second
> +`<path>` is the destination.
> +

This should talk about the special case of the first (src) <path>
being able to be "/" to copy the entire tree.  If I follow your
implementation right a src_path of "/" also causes the destination
path to be ignored entirely.  Which means you cannot copy another
branch into a subdirectory of this branch (aka one direction of
the subtree merge strategy).

> diff --git a/fast-import.c b/fast-import.c
> index e9c80be..9537c63 100644
> --- a/fast-import.c
> +++ b/fast-import.c
...
> +static void copy_from_commit(
> +	unsigned char *src_commit, const char *src_path,
> +        struct branch *dest_br, const char *dest_path)
...
> +	load_tree(&src_br.branch_tree);

This is a huge memory leak.  You never unload this tree and return
its data onto the freelists so we'll leak everything that wasn't
moved into the destination tree.

-- 
Shawn.
