From: John Keeping <john@keeping.me.uk>
Subject: Re: Odd rebase behavior
Date: Sat, 19 Dec 2015 16:09:06 +0000
Message-ID: <20151219160906.GB14056@serenity.lan>
References: <877fkf9j5h.fsf@waller.obbligato.org>
 <20151216221716.GD1581@serenity.lan>
 <nngmvt73b63.fsf@lnx-dag.us.cray.com>
 <20151218180549.GA14056@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 17:09:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAK4V-0005D9-RQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 17:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbbLSQJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 11:09:24 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42424 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbbLSQJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 11:09:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B423BCDA3A8;
	Sat, 19 Dec 2015 16:09:22 +0000 (GMT)
X-Quarantine-ID: <LnXYcVQoZoAx>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LnXYcVQoZoAx; Sat, 19 Dec 2015 16:09:22 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5FD4BCDA593;
	Sat, 19 Dec 2015 16:09:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151218180549.GA14056@serenity.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282747>

On Fri, Dec 18, 2015 at 06:05:49PM +0000, John Keeping wrote:
> On Fri, Dec 18, 2015 at 11:43:16AM -0600, David A. Greene wrote:
> > John Keeping <john@keeping.me.uk> writes:
> > 
> > > It seems that the problem is introduces by --preserve-merges (and
> > > -Xsubtree causes something interesting to happen as well).  I see the
> > > following behaviour:
> > 
> > Thanks for narrowing this down!  Is it possible this is actually a
> > cherry-pick problem since --preserve-merges forces rebase to use
> > cherry-pick?
> 
> I'm pretty sure this a result of the code in git-rebase--interactive.sh
> just below the comment "Watch for commits that have been dropped by
> cherry-pick", which filters out certain commits.  However, I'm not at
> all familiar with the --preserve-merges code in git-rebase so I could be
> completely wrong.

I've traced through git-rebase--interactive.sh and I can see what's
happening here now.  The problematic code is around the handling of the
"rewritten" directory.

In --preserve-merges mode, we write the SHA1 of the "onto" commit into
rewritten and then add any commits descended from it along the
first-parent path that we have identified as candidates for being
rebased.  This allows us to identify commits that have been merged in
and remove them from the rebase instruction list.

Because the right-hand commit in this case is disjoint from "onto", we
end up dropping everything at this point.  The --root option fixes this
because instead of preserving just "onto", it adds all of the commits
given by:

	git merge-base --all $orig_head $upstream

Since the disjoint history causes the root commit to be rewritten, I
think requiring --root for this case to work is reasonable.  However,
I'm not sure we should add it automatically.  It may be better to detect
that there is no common history and die if --root has not been given.
