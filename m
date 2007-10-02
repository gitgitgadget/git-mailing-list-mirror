From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 12:11:14 -0400
Message-ID: <20071002161114.GC6828@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IckLH-0001Mx-Ab
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 18:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXJBQLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbXJBQLT
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 12:11:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3859 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbXJBQLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 12:11:19 -0400
Received: (qmail 28185 invoked by uid 111); 2 Oct 2007 16:11:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 12:11:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 12:11:14 -0400
Content-Disposition: inline
In-Reply-To: <86ejge6o8b.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59697>

On Tue, Oct 02, 2007 at 08:10:28AM +0200, David Kastrup wrote:

> I have not actually looked at the actual task that the structures are
> going to be used in, and whether "reusing" the information is likely
> to be worth the trouble.

The algorithm is something like this:  We have N files, and we want to
find "similar" candidates. So we go through each file and generate a
table of fingperint hashes (diffcore-rename.c:hash_chars), and then
compare each file with every other file, using the hash tables to do the
comparison.

So the comparison step for two files is currently something like:

  for each hash in file1
    hash2 = look up hash in file2
    compare hash and hash2

and if they were sorted, perhaps we could do something merge-like:

  while hashes are left to compare
      compare file1.next, file2.next
      advance file1, file2, or both (depending on comparison)

> When we are talking about buzzword compliance, "keep sorted" with the
> meaning of "maintain sorted across modifications" has an O(n^2) or at
> least O(nm) ring to it.  However, if it is possible to sort it just
> once, and then then only merge with other lists...

It would be sort once. I.e.,:

  for each file
     generate file.hashes
     sort file.hashes
  for each file1
    for each file2
      compare file1.hashes to file2.hashes

where that 'compare' step is taking most of the CPU time (for the
obvious reason that we call it in an O(n^2) loop).

I will try to implement this as time permits, but if you want to tinker
with it in the meantime, feel free.

-Peff
