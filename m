From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] fast-import: tree allocation cleanups
Date: Sat, 10 Mar 2007 22:21:47 -0500
Message-ID: <20070311032147.GA10781@spearce.org>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192114.GA3875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 04:21:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQEdA-00060q-2c
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 04:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXCKDVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXCKDVx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 22:21:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58442 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbXCKDVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 22:21:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQEcs-0003hz-AI; Sat, 10 Mar 2007 22:21:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EB70320FBAE; Sat, 10 Mar 2007 22:21:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070310192114.GA3875@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41900>

A nicely done series.  Thanks for fixing this performance bug.

Jeff King <peff@peff.net> wrote:
> @@ -1059,7 +1068,6 @@ static void load_tree(struct tree_entry *root)
>  
>  		if (t->entry_count == t->entry_capacity)
>  			root->tree = t = grow_tree_content(t, t->entry_count);
> -		t->entries[t->entry_count++] = e;
>  
>  		e->tree = NULL;
>  		c = get_mode(c, &e->versions[1].mode);
> @@ -1071,6 +1079,8 @@ static void load_tree(struct tree_entry *root)
>  		hashcpy(e->versions[0].sha1, (unsigned char*)c);
>  		hashcpy(e->versions[1].sha1, (unsigned char*)c);
>  		c += 20;
> +
> +		t->entries[t->entry_count++] = e;
>  	}
>  	free(buf);
>  }

This I wouldn't have bothered to do in this patch.  It is just
unecessary code churning, as you turn around and change this again
in the next patch.  I actually dropped these two hunks from this
patch (but left the dang commit message comment in, whoops) and
moved the first hunk to the next patch.

> @@ -1194,40 +1205,40 @@ static int tree_content_set(
>  	else
>  		n = strlen(p);
>  
> -	for (i = 0; i < t->entry_count; i++) {
> +	name = to_atom(p, n);

You missed an unsigned short cast here.

> -	e->name = to_atom(p, (unsigned short)n);
> +	e->name = name;

See?  ;-) I put the correct cast into the patch when I applied it.


Your series is applied on top of master and is now in my
fast-import.git fork on repo.or.cz.

-- 
Shawn.
