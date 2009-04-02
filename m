From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Thu, 2 Apr 2009 08:30:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904020759180.4130@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain> <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain> <alpine.LFD.2.00.0903302250500.4093@localhost.localdomain> <7vmyazimds.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 17:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpOyB-0001F7-PJ
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763439AbZDBPdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 11:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763241AbZDBPdl
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 11:33:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53909 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762486AbZDBPdk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 11:33:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n32FUs7O004881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Apr 2009 08:31:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n32FUqol005769;
	Thu, 2 Apr 2009 08:30:53 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vmyazimds.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.439 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115473>



On Wed, 1 Apr 2009, Junio C Hamano wrote:
> 
> Correct.  But after thinking about this a bit more, I am starting to suspect
> the "of course" in your earlier
> 
>     If I do
> 
>             mark_reachable(cb.ref_commit, 0);
> 
>     instead (to traverse the _whole_ tree, with no regards to date), the time 
>     shrinks to 1.7s. But of course, that's also wrong.
> 
> may not be such a clearly obvious thing.

I think we should never do it up-front, because for nicely behaved people 
who just pull other peoples work (which are also the people most likely to 
not have beefy machines), the normal reflog is going to be entirely 
reachable, and we don't have to traverse the whole thing.

So what I'd suggest is something like:

 - start off with the time limit, possibly with some extra fudging

 - but never bother calling "in_merge_bases()"

 - if we ever get to a commit that doesn't look reachable in that 
   situation, we now have two choices:

    (a) just use the dang 'object->flags & REACHABLE' flag as-is.
        Why even bother to be clever? We did the reachability by time 
        already, it's done, it's there, just use it. In other words, the 
        reachability simply works like "--since=<date>'.

    (b) Try to do the "exact" thing, and waste lots of time on it, and 
        maybe find an odd commit or two where the date had been wrong. Do 
        we really care? 

I'd actually go for 'a', with a slight modification: try to convert the 
"reflog date" (the date of a local action) into a "commit date" (the date 
of a commit in the repository). Because those two are different "time 
spaces", and comparing a "commit date" to a "in my repo" date is fairly 
wrong.

But in general, I don't think this is something that needs any extra 
precision. We're not talking about "theoretically reachable" here. We're 
talking about reflog entries that are already older than the 
unreachability limit, and that point to commits that are older than the 
reachability limit. Yes, yes, clocks aren't synchronized, but do we really 
care?

IOW, I'd suggest just removing the in_merge_base() tests entirely. Make 
the semantics even simpler:

	have_done_reachability = 0;
	reachability_date = 0;

	for_each_reflog_oldest_first() {
		/* Older than unconditional expire? */
		if (really_old(entry)) {
			reachability_date = entry->commit->date;
			goto prune;
		}

		/* Younger than the reflog reachability? */
		if (really_young(entry) && !fix_stale)
			goto save;

		/*
		 * Ok, not an unconditional expire entry.
		 * Do the reachability - once
		 */
		if (!have_done_reachability) {
			have_done_reachability = 1;
			if (fix_stale)
				reachability_date = 0;
			mark_reachabile(top, reachability_date);
		}

		if (!(entry->commit->flags & REACHABLE))
			goto prune;

	save:
		save(entry);
		continue;
	prune:
		prune(entry);
		continue;
	}

Does that change semantics? Yes, absolutely. But it sounds very practical.

		Linus
