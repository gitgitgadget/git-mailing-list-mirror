From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 18:31:18 +0200
Message-ID: <86ve9p32cp.fsf@lola.quinscape.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz> <20071002161114.GC6828@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 18:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icl0E-00013d-JE
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 18:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbXJBQxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXJBQxh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 12:53:37 -0400
Received: from main.gmane.org ([80.91.229.2]:49094 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729AbXJBQxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 12:53:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IckpR-0001e9-Ts
	for git@vger.kernel.org; Tue, 02 Oct 2007 16:42:37 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 16:42:37 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 16:42:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:A/q9ld0bhwLZ1r/4U9Qpptycy0c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59698>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 02, 2007 at 08:10:28AM +0200, David Kastrup wrote:

[...]

> The algorithm is something like this: We have N files, and we want
> to find "similar" candidates. So we go through each file and
> generate a table of fingperint hashes
> (diffcore-rename.c:hash_chars), and then compare each file with
> every other file, using the hash tables to do the comparison.
>
> So the comparison step for two files is currently something like:
>
>   for each hash in file1
>     hash2 = look up hash in file2
>     compare hash and hash2
>
> and if they were sorted, perhaps we could do something merge-like:
>
>   while hashes are left to compare
>       compare file1.next, file2.next
>       advance file1, file2, or both (depending on comparison)
>
>> When we are talking about buzzword compliance, "keep sorted" with
>> the meaning of "maintain sorted across modifications" has an O(n^2)
>> or at least O(nm) ring to it.  However, if it is possible to sort
>> it just once, and then then only merge with other lists...
>
> It would be sort once. I.e.,:
>
>   for each file
>      generate file.hashes
>      sort file.hashes
>   for each file1
>     for each file2
>       compare file1.hashes to file2.hashes
>
> where that 'compare' step is taking most of the CPU time (for the
> obvious reason that we call it in an O(n^2) loop).
>
> I will try to implement this as time permits, but if you want to
> tinker with it in the meantime, feel free.

This does not actually require an actual merge _sort_ AFAICS: do the
"sort file.hashed" step using qsort.  The comparison step does not
actually need to produce merged output, but merely advances through
two hash arrays and generates statistics.

This should already beat the pants off the current implementation,
even when the hash array is sparse, simply because our inner loop then
has perfect hash coherence.

Getting rid of this outer O(n^2) remains an interesting challenge,
though.  One way would be the following: fill a _single_ array with
entries containing _both_ hash and file number.  Sort this, and then
gather the statistics of hash runs by making a single pass through.
That reduces the O(n^2) behavior to only those parts with actual hash
collisions.

-- 
David Kastrup
