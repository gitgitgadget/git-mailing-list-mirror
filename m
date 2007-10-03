From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 3 Oct 2007 10:53:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710031007340.3579@woody.linux-foundation.org>
References: <20070927023633.GA28902@coredump.intra.peff.net>
 <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
 <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net>
 <86ejge6o8b.fsf@lola.quinscape.zz> <20071002161114.GC6828@coredump.intra.peff.net>
 <86ve9p32cp.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
 <85641oy5ge.fsf@lola.goethe.zz>
 <20071003165927.GA25055@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id8QE-0006y8-Fi
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 19:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbXJCRxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbXJCRxl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 13:53:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57150 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620AbXJCRxk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 13:53:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l93HrSH7029173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2007 10:53:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l93HrRLJ000728;
	Wed, 3 Oct 2007 10:53:28 -0700
In-Reply-To: <20071003165927.GA25055@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.448 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.187 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59862>



On Wed, 3 Oct 2007, Jeff King wrote:
>
> Try profiling the code, and you will see that the creation of the hashes
> is totally dwarfed by the comparisons. So yes, you might be able to
> speed up the creation code, but it's going to have a minimal impact on
> the overall run time.

Yeah. Oprofile is your friend.

The biggest win would be to avoid calling diffcore_count_changes() in the 
first place, and we actually do that in the caller by looking at the size 
of the files. However, while that prunes out the *really* obvious cases, 
it's not nearly enough, since there tends to be very limited filesizes 
anyway.

What we could also do is to pass in the minimum similarity score, and use 
that to at least exit early. We currently pass in "delta_limit" which is 
close, but we never use it, and we really probably would be better off 
passing in the minimum score itself and perhaps be able to exit early from 
diffcore_count_changes.

However, while I did think about doing that, I came to the conclusion that 
we'd still always end up having to look at least at *half* the hash data 
(for the default 50% score), so while it would help, it again wouldn't be 
a matter of orders-of-magnitudes, and it looked like the end result would 
be unnecessarily complex too.

The best option, of course, would be to use a similarity hash to make the 
initial choice. I think we had one at one point, but it wasn't 
fine-grained enough. But it might be interesting to do that as a filter in 
*front* of the more expensive diffcore_count_changes() call.

We had some "similarity fingerprint" code at some point using a Rabin 
polynomial. It wasn't reliable enough to be used as a direct score, but 
maybe it can be used as a first-line "we know this isn't even worth doing 
the expensive stuff on".

			Linus
