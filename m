From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Migrating away from SHA-1?
Date: Wed, 13 Apr 2016 21:53:24 -0400
Message-ID: <20160414015324.GA16656@thunk.org>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 03:53:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqWTW-00044r-AO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 03:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbcDNBxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 21:53:31 -0400
Received: from imap.thunk.org ([74.207.234.97]:51720 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbcDNBx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 21:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kChEc60G6RGOVhleV+5+5HEqRdsdFiuslPY02KL4ywQ=;
	b=d4yTKC6T2EooaQBpFQHhqWV+Jqjos3/GXqmp2UhEa7gAKK0CVo3zE6sPiq4x9RfJ40wprlslHR2TH2qpANLPrLFrF/BZJuvD/My0Ns/L/kkR+q9nDI45v3WGu9ypL5DReYb6GYQ1kv0mmEMhkPx3Lc48vglZzlKYbESJB2/txkU=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1aqWTG-0003Ba-8J; Thu, 14 Apr 2016 01:53:26 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 04ED782E614; Wed, 13 Apr 2016 21:53:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1460502934.5540.71.camel@twopensource.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291511>

On Tue, Apr 12, 2016 at 07:15:34PM -0400, David Turner wrote:
> 
> If SHA-1 is broken (in certain ways), someone *can* replace an
> arbitrary blob.  GPG does not help in this case, because the signature
> is over the commit object (which points to a tree, which eventually
> points to the blob), and the commit hasn't changed.  So the GPG
> signature will still verify.

The "in certain ways" is the critical bit.  The question is whether
you are trying to replace an arbitrary blob, or a blob that was
submitted under your control.

If you are trying to replace an arbitrary blob under the you need to
carry a preimage attack.  That means that given a particular hash, you
need to find another blob that has the same hash.  SHA-1 is currently
resistant against preimage attack (that is, you need to use brute
force, so the work factor is 2**159).  

If you are trying to replace an arbitrary blob which is under your
control, then all you need is a collision attack, and this is where
SHA-1 has been weakened.  It is now possible to find a collision with
a work factor of 2**69, instead of the requisite 2**80.

It was a MD5 collision which was involved with the Flame attack.
Someone (in probably the US or Isreali intelligence services)
submitted a Certificate Signing Request (CSR) to the Microsoft
Terminal Services Licensing server.  That CSR was under the control of
the attacker, and it resulted in a certificate where parts of the
certificate could be swapped out with the corresponding fields from
another CSR (which was not submitted to the Certifiying Authority)
which had the code signing bit set.

So in order to carry out this attack, not only did the (cough)
"unknown" attackers had to have come up with a collision, but the two
pieces of colliding blobs had to parsable a valid CSR's, one which had
to pass inspection by the automated CA signing authority, and the
other which had to contain the desired code signing bits set so the
attacker could sabotage an Iranian nuclear centrifuge.

OK, so how does this map to git?  First of all, from a collision
perspective, the two blobs have to map into valid C code, one of which
has to be innocuous enough such that any humans who review the patch
and/or git pull request don't notice anything wrong.  The second has
to contain whatever security backdoor the attacker is going to try to
introduce into the git tree.  Ideally this is also should pass muster
by humans who are inspecting the code, but if the attack is targetted
against a specific victim which is not likely to look at the code, it
might be okay if something like this:

#if 0  /* this is needed to make the hash collision work */
aev2Ein4Hagh8eimshood5aTeteiVo9hOhchohN6jiem6AiNEipeeR3Pie4ePaeJ
fo8eLa9ateeKie5VeG5eZuu2Sahqu1Ohai9ohGhuAevoot5OtohQuai7koo4IeTh
ohCefae4Ahkah0eiku2Efo0iuHai8ideaRooth8wVahlia0nuu1eeSh5oht1Kaer
aiJi4chunahK9oozpaiWu7viee5aiFahud6Ee2zieich1veKque6PhiaAit1shie
#endif

... was hidden in the middle of the replacement blob.  One would
*hope*, though, that if something like this appeared in a blob that
was being sent to the upstream repository, that even a sloppy github
pull request reviewer would notice.

That's because in this scenario, the attacker needs to be able to get
the first blob into the git tree first, which means they need to be
trusted enough to get the first blob in.  And so the question which
comes to mind is if you are that trusted (or if the git pull review
process is that crappy), might it not be easier to simply introduce an
obfuscated code that has a security weakness?  That is, something from
the Underhanded C contest, or an accidental buffer overrun, hopefully
one that isn't noticed by static code checkers.  If you do that, you
don't even need to figure out how to create a SHA-1 collision.

Does that mean that we shouldn't figure out how to migrate to another
hash function?  No, it's probably worth planning how to do it.  But we
probably have a fair amount of time to get this right.

Cheers,

					- Ted
