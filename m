From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Troubles when directory is replaced by symlink
Date: Thu, 11 Jun 2009 16:37:49 +0200
Organization: private
Message-ID: <86ab4erg3m.fsf@broadpark.no>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
 <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
 <20090611114846.GC4409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:39:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MElQs-0001JK-4j
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 16:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZFKOjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 10:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbZFKOjB
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 10:39:01 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:41931 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZFKOjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 10:39:00 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KL2006BFWP1PFA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 11 Jun 2009 16:39:01 +0200 (CEST)
Received: from localhost ([80.202.166.19]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KL2005MEWP03680@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 11 Jun 2009 16:39:01 +0200 (CEST)
In-reply-to: <20090611114846.GC4409@coredump.intra.peff.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121341>

Jeff King <peff@peff.net> writes:

> [Kjetil: I bisected this bug to your 92604b4. Details below.]
>
> On Tue, Jun 09, 2009 at 12:18:16PM +0400, Alexander Gladysh wrote:
>
>> Any help here? This bug is pretty annoying (especially that it
>> requires double hard resets).
>> 
>> Should I provide any extra information?
>
> Actually, I think the problem happens earlier than you realize; I see
> problems when switching back to master:
>
> -- >8 --
> # make a repo
> mkdir repo && cd repo && git init
>
> # content in alpha
> mkdir alpha && echo content >alpha/file && git add . && git commit -m one
> # and duplicate content inside beta
> mkdir beta && cp -R alpha beta && git add . && git commit -m two
>
> # now replace the duplicate with a symlink
> git checkout -b branch
> rm -rf beta/alpha && git add -u && git commit -m deleted
> ln -s ../alpha beta/alpha && git add . && git commit -m symlink
>
> # now checkout master again; alpha/file will be missing, even
> # though it wasn't touched at all
> git checkout master
> git status
> -- 8< --
>
> We handled this correctly in v1.6.1, so I was able to bisect it down to:
>
>     commit 92604b466344b2157efc42ef3521dac22d7906a2
>     Author: Kjetil Barvik <barvik@broadpark.no>
>     Date:   Sun Jan 18 16:14:50 2009 +0100
>
>         lstat_cache(): more cache effective symlink/directory detection
>
>         Make the cache functionality more effective.  Previously when
>         A/B/C/D was in the cache and A/B/C/E/file.c was called for,
>         there was no match at all from the cache.  Now we use the fact
>         that the paths "A", "A/B" and "A/B/C" are already tested, and we
>         only need to do an lstat() call on "A/B/C/E".
>
> I don't have time to look more closely now, but I'm guessing we are
> treating the symlink to the directory like the directory itself in a
> place that we shouldn't.
>
> -Peff

  OK, I start debuging in a few minutes.  Thanks for mail!

  -- kjetil
