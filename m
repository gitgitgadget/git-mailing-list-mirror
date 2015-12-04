From: John Keeping <john@keeping.me.uk>
Subject: Re: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 15:31:03 +0000
Message-ID: <20151204153103.GP18913@serenity.lan>
References: <20151204150546.GA17210@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4sKT-0007iX-6R
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 16:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbbLDPbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 10:31:18 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:54020 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbLDPbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 10:31:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D3B4BCDA63D;
	Fri,  4 Dec 2015 15:31:14 +0000 (GMT)
X-Quarantine-ID: <8yP4i9lDZ0+K>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8yP4i9lDZ0+K; Fri,  4 Dec 2015 15:31:13 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4A62A866036;
	Fri,  4 Dec 2015 15:31:05 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151204150546.GA17210@inner.h.apk.li>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281983>

On Fri, Dec 04, 2015 at 04:05:46PM +0100, Andreas Krey wrote:
> our workflow is pretty rebase-free for diverse reasons yet.
> 
> One obstacle now appearing is that rebases simply take
> very long - once you might want to do a rebase there are
> several hundred commits on the remote branch, and our tree
> isn't small either.
> 
> This produces rebase times in the minute range.
> I suppose this is because rebase tries to see
> if there are new commits in the destination
> branch that are identical to one of the local
> commits, to be able to skip them. (I didn't
> try to verify this hypothesis.)
> 
> What can we do to make this faster?

I'm pretty sure that you're right and the cherry-pick analysis is where
the time is spent.

I looked into this a couple of years ago and I have a variety of
(half-finished) experiments that might improve the performance of this:

	https://github.com/johnkeeping/git/commits/log-cherry-no-merges
	https://github.com/johnkeeping/git/commits/patch-id-limit-paths
	https://github.com/johnkeeping/git/commits/revision-cherry-respect-ancestry-path
	https://github.com/johnkeeping/git/commits/patch-id-notes-cache
	http://comments.gmane.org/gmane.comp.version-control.git/224006

I have no idea if any of these changes will apply to modern Git (or if
some of them are even correct) but I can try to clean them up if there's
interest.

The commit for patch-id-limit-paths includes some numbers that might be
relevant for your case:

    Before:
    $ time git log --cherry master...jk/submodule-subdirectory-ok >/dev/null
    
    real    0m0.373s
    user    0m0.341s
    sys     0m0.031s
    
    After:
    $ time git log --cherry master...jk/submodule-subdirectory-ok >/dev/null
    
    real    0m0.060s
    user    0m0.055s
    sys     0m0.005s
