From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 20:44:30 +0200
Message-ID: <85sl4tz78x.fsf@lola.goethe.zz>
References: <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
	<20071002041652.GA32133@coredump.intra.peff.net>
	<7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
	<20071002050820.GA4261@coredump.intra.peff.net>
	<20071002051332.GA4462@coredump.intra.peff.net>
	<86ejge6o8b.fsf@lola.quinscape.zz>
	<20071002161114.GC6828@coredump.intra.peff.net>
	<86ve9p32cp.fsf@lola.quinscape.zz>
	<20071002173941.GA7187@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icnsf-0004jK-U4
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbXJBT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbXJBT5z
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:57:55 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:39999 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbXJBT5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:57:54 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Icnra-00027B-Hx; Tue, 02 Oct 2007 15:57:02 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id EFDD81C4CE11; Tue,  2 Oct 2007 20:44:30 +0200 (CEST)
In-Reply-To: <20071002173941.GA7187@coredump.intra.peff.net> (Jeff King's message of "Tue\, 2 Oct 2007 13\:39\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 02, 2007 at 06:31:18PM +0200, David Kastrup wrote:
>
>> This does not actually require an actual merge _sort_ AFAICS: do the
>> "sort file.hashed" step using qsort.  The comparison step does not
>> actually need to produce merged output, but merely advances through
>> two hash arrays and generates statistics.
>
> Right, that's why I used "merge" in quotes.
>
>> This should already beat the pants off the current implementation,
>> even when the hash array is sparse, simply because our inner loop
>> then has perfect hash coherence.
>
> Yes, I hope so. We'll see. :)
>
>> Getting rid of this outer O(n^2) remains an interesting challenge,
>> though.  One way would be the following: fill a _single_ array with
>> entries containing _both_ hash and file number.  Sort this, and
>> then gather the statistics of hash runs by making a single pass
>> through.  That reduces the O(n^2) behavior to only those parts with
>> actual hash collisions.
>
> Interesting. Care to take a stab at implementing it?

I actually have worked through the last night on the day job, have
urgent stuff piling up in my freelance work queue, and the next thing
I need to finish for git is some smart stuff for delta packing.

So it's unlikely I'll get to _that_ anytime soon.  However, I had a
hilarious idea on the way home that kept me rather amused (perhaps my
programmer's humour is affected by sleep deprivation).

I was annoyed at needing double the space because of having to keep
score of both hash and file number.  So I came up with a rather cute
manner to avoid this: first do all files in isolation with full
precision, but store the resulting list of hash as difference to the
last value.  When merging the data of 2^k and 2^k (or somewhat less)
files, we multiply the values by two (this will not carry except for
utterly improbable cases or very small data sets which we can do
differently) and add one bit of identification.  When we have just a
single sequence remaining, undeltafying will tell us about collisions
in the high bits, and the affected files in the low bits.

Of course, using a merge-like algorithm means that we temporarily need
double space anyway.  Which takes some of the fun.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
