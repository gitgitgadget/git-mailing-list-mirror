From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Wed, 5 Nov 2008 21:28:49 +0100
Message-ID: <20081105202849.GA9484@localhost>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <20081104085630.GA22530@localhost> <20081105024932.GA20907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 21:30:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxp1U-0001DR-HP
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 21:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYKEU3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 15:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbYKEU3S
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 15:29:18 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:33824 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbYKEU3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 15:29:17 -0500
Received: from darc.dyndns.org ([84.154.100.25]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Nov 2008 21:29:12 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Kxozh-0002kG-9I; Wed, 05 Nov 2008 21:28:49 +0100
Content-Disposition: inline
In-Reply-To: <20081105024932.GA20907@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 05 Nov 2008 20:29:14.0320 (UTC) FILETIME=[2B1B9D00:01C93F85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100180>

On Tue, Nov 04, 2008 at 09:49:32PM -0500, Jeff King wrote:
[...]
> However, I would like to make one additional request.  Since you are
> killing off all usage of new_sha1 initial assignment, I think it makes
> sense to just get rid of the variable entirely, so it cannot create
> confusion later.

Ok, I can live with that.

> > > Hmm. I was hoping to see more in update_tracking_ref. With your patch,
> > > we end up calling update_ref for _every_ uptodate ref, which results in
> > > writing a new unpacked ref file for each one. And that _is_ a
> > > performance problem for people with large numbers of refs.
> > [...]
> > I think update_ref already takes care of that. See this check in
> > write_ref_sha1:
> > 
> >         if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
> >                 unlock_ref(lock);
> >                 return 0;
> >         }
> 
> Nope. That check is a concurrency safeguard. It checks that when we are
> moving the ref from "A" to "B", that the ref still _is_ "A" when we lock
> it.

I think you are confusing this with verify_lock(). The code in
write_ref_sha1() really does compare with the new sha1.

> But more importantly, it is easy to demonstrate the problem with your
> patch:
> 
>   mkdir parent &&
>     (cd parent &&
>        git init && touch file && git add file && git commit -m one) &&
>   git clone parent child &&
>     (cd child &&
>        echo BEFORE: && ls -l .git/refs/remotes/origin &&
>        git push &&
>        echo AFTER:  && ls -l .git/refs/remotes/origin)
> 
> I get:
> 
>   BEFORE:
>   -rw-r--r-- 1 peff peff 32 2008-11-04 21:43 HEAD
>   Everything up-to-date
>   AFTER:
>   -rw-r--r-- 1 peff peff 32 2008-11-04 21:43 HEAD
>   -rw-r--r-- 1 peff peff 41 2008-11-04 21:43 master
> 
> Oops. With the patch snippet I posted in my previous message, the
> 'master' ref is not created by the uptodate push.

The reason it doesn't work is a bug in lock_ref_sha1_basic(). Dating back to
pre-"pack-refs" times, this code forces a write if the ref file does not
exist. I will resubmit the patch including your above testcase and a bugfix
for lock_ref_sha1_basic().

Clemens
