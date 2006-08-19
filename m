From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] adding support for md5
Date: Sun, 20 Aug 2006 00:30:27 +0200
Message-ID: <20060819223027.GA23891@pasky.or.cz>
References: <20060819031931.486.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rientjes@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 00:30:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEZKx-0002x1-QN
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 00:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHSWaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWHSWaa
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 18:30:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42930 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751577AbWHSWa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 18:30:29 -0400
Received: (qmail 29857 invoked by uid 2001); 20 Aug 2006 00:30:27 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060819031931.486.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25739>

Pre Scriptum: I do not advocate supporting many hashing functions just
for the heck of it, but I don't like the "full sweep" approach _when_
(not "in case") we _need_ to change the hash function. After all,
currently we have to operate with the fact that the next one will likely
fall victim of attacks in time as well and this is going to be
periodical operation.

Dear diary, on Sat, Aug 19, 2006 at 05:19:31AM CEST, I got a letter
where linux@horizon.com said that...
> So you can get silly things like the need for a merge commit to
> record the merge of trees that are actually identical.

You can create an ordering of hashes based on their strength and then
rehash your objects to max() of hash types used in the operation. So, if
you're about to merge md5(x) and sha1(y), you first recompute the first
id as sha1(x). Of course "recomputing" needs to be a wee bit more
complex: you need to first substitute tree id for a common hash as well
(and recursively do the same in the trees); slow, yes, but you can
cache it.

It gets worse when you are about to recompute ancestry, so you need to
set up the hash usage transition so that you don't ever have to
- such an event is sufficiently rare that each branch keeper can declare
a flag day "before now I merged only md5 commits and from now on I
will merge only sha1 commits". The tool can help to enforce this.
This strategy will not help in 100% of the cases (md5git-based tool
takes sha1git-created commit and re-creates it based on a snapshot and
the precise same metadata) but I guess it's good enough.

It's good that this is just theory so far, though. I'd say let it be for
now (at least from the "emergency hash switch" standpoint) and do it
when it's needed; you will have to have people upgrade their Git at that
point anyway and the code would bitrot just sitting there and adding
so-far unnecessary complexity. We have worse problems at our hands right
now anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
