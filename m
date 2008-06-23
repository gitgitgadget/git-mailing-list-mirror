From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Create a fnmatch-style pattern TreeFilter
Date: Sun, 22 Jun 2008 20:27:07 -0400
Message-ID: <20080623002707.GK11793@spearce.org>
References: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 02:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAZuk-0006Ti-14
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 02:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbYFWA1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYFWA1N
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 20:27:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52103 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbYFWA1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 20:27:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAZtb-0000ZF-HX; Sun, 22 Jun 2008 20:26:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D3FB620FBAE; Sun, 22 Jun 2008 20:27:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1214177145-18963-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85818>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> +
> +package org.spearce.jgit.revwalk.filter;

This should be treewalk.filter, its a filter for tree entries.

> + * This class implements a TreeeFilter that uses the wildcard style pattern

fyi, minooooor typo on TreeFilter.

> +public class WildCardTreeFilter extends TreeFilter {
...
> +	@Override
> +	public boolean include(TreeWalk walker) throws MissingObjectException,
> +			IncorrectObjectTypeException, IOException {
> +		matcher.reset();
> +		matcher.append(walker.getPathString());
> +		if (matcher.isMatch())
> +			return true;
> +		return false;
> +	}

Hmm. 

It isn't as efficient as it could be.  Obtaining the string of
the path is somewhat costly as we have to convert from the byte[]
to a char[] and then wrap that into a String, just to check the
pattern again.  Its more accurate to convert to the string, but
it is a lot slower.

But I'm wondering about what happens when the TreeWalk is considering
a subtree path name.  Does the matcher still match the pattern?  By
that I mean lets say the pattern was:

	src/xdiff/*.c

In this case the include method is first called with the path "src";
if it returns false the TreeWalk won't recurse into the subtree and
thus you'll never get to consider "src/xdiff" or "src/xdiff/foo.c".

-- 
Shawn.
