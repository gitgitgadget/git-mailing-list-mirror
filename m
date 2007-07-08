From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 00:56:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707090011070.4248@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 09 02:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7gj5-0008EC-3z
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 02:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbXGIADg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 20:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXGIADg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 20:03:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:40149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbXGIADf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 20:03:35 -0400
Received: (qmail invoked by alias); 09 Jul 2007 00:03:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 09 Jul 2007 02:03:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zCj4E+MbzGsh1noVfFjHlPxO2+7fqT42A2RA4CO
	N9HsRYgu/TbCOn
X-X-Sender: gene099@racer.site
In-Reply-To: <1183911808787-git-send-email-skimo@liacs.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51935>

Hi,

I am way too tired to comment in detail, but here are some preliminary 
findings:

- your command line interface is very nice and elegant.

- you use a lot of what was in cg-admin-rewritehist (including 
  adjustments I made in the documentation for filter-branch), but you also 
  make it more confusing for people used to that tool:

	- instead of leaving the original branches as they are, you 
	  overwrite them. That's okay. But then you put the originals into 
	  refs/rewritten. Without cg-admin-rewritehist using that name 
	  for the _result_, you could explain your way out of confusion. 
	  As it is, you cannot.

	- in spite of doing the same as cg-admin-rewritehist with filters, 
	  you call them maps. But they are no maps. They are manipulators, 
	  you can call them mutators or filters, too. Given what people 
	  know of cg-admin-rewritehist, you really should keep the name 
	  "filter".

	- the name "map" itself is used in cg-admin-rewritehist, to map 
	  commit names from old to new. By using that name differently, 
	  again you contribute to confusion, for no good reason.

- neat idea to abuse the decorator for rewriting purposes.

- get_one_line() is a misnomer. It wants to be named get_linelen().

- instead of spawning read-tree, you could use unpack_trees() to boost 
  performance even more. But I guess it is probably left for later, to 
  make it easier to review the patch.

- your memspn() and memcspn() functions are very inefficient. Better walk 
  the memory, introduce a GIT_HEXCHAR into ctype.c, ishexchar() into 
  git-compat-util.h, and use that.

- The example you give with "git update-index --remove" can fail, right? 
  Tell the user about that.

- The commit filter again deviates from the usage in cg-admin-rewritehist. 
  I can see that you wanted to make it more versatile. However, it makes 
  the tool potentially also a bit more cumbersome to use. Besides, you use 
  a temporary file where there is no need to.

- "map" is missing. This is a function that you can use in all filters in 
  cg-admin-rewritehist, except (unfortunately) in the commit filter (for 
  technical reasons). Alas, these technical reasons also prevent such a 
  function to be usable by any of the filters ("maps", as you call them).

- the more fundamental problem with the missing "map", I do not see a 
  reasonable way to get the same functionality from any of the code 
  snippets passed to rewrite-commits. Indeed, even the workaround of 
  cg-admin-rewritehist, to read $TEMP/map/$sha1, does not work, since you 
  are keeping it all in memory. On IRC, gitster suggested to use a 
  bidirectional pipe (such as stdin/stdout) to get at the new commit 
  names, but because of buffering, I guess this is no joy.

As commented on IRC, the env/tree/parent/msg filters of 
cg-admin-rewritehist could be all emulated by commit filters. However, 
that would be really inconvenient. So at a later stage, these would have 
to be integrated into rewrite-commits (even if it would be possible to 
drive rewrite-commits by a shell porcelain, but I guess you are opposed to 
that idea, since you want to do everything else in C, too).

However, the biggest and very real problem is that your filters do not 
have a "map" function to get the rewritten sha1 for a given sha1. That is 
what makes the filters so versatile, though, since you can skip revisions 
by much more complex rules than just greps on the commit message or 
header.

But hey, maybe it _is_ time to rethink the whole filter business, and 
introduce some kind of regular expression based action language. Something 
like

	git rewrite-commits -e '/^author Darl McBribe/skip-commit' \
		-e 'substitute/^author Joahnnes/author Johannes/header' \
		-e 'substitute/poreclain/porcelain/body' \
		-e 'rewrite-commit-names'

Hmm?

Ciao,
Dscho
