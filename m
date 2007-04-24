From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Tue, 24 Apr 2007 16:48:40 +0200
Message-ID: <462E18C8.4070001@op5.se>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>	 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>	 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>	 <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com> <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 16:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgMK1-0008P1-BO
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161784AbXDXOsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161788AbXDXOsp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:48:45 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:45663 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161784AbXDXOso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:44 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 82D186BCD2; Tue, 24 Apr 2007 16:48:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.179] (unknown [192.168.1.179])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 74D886BCD1; Tue, 24 Apr 2007 16:48:40 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45454>

Marco Costalba wrote:
> 
> Someone more versed then me in SHA1 could tell the probablity to find
> a corrupted object calculating his hash and checking against his
> stored 160bits known good signature and *FAIL* to find as corrupt *the
> same object* calculating his hash and checking against a truncated sha
> to say 20bits.
> 

The probability of finding a collision when only 20 bits are used is
1 in 1048575. In other words, repositories would already be exhibiting
collisions with only 20 bits of hash, even with a perfect dispersion.

> I would say this probability is veery veery low in random case (not a
> malicious attack of course, but I think this is not the case with git
> repository as it was with SHA1 designers).
> 

I believe the KDE repo is the biggest one in git today, with its several
hundred thousand revisions (and thus most likely several million objects).

The reason it's not much use to cut down the hash-size is that it already
reflects a very small percentage of the total size of the repo, and since
using the full hash allows git to handle up to
1461501637330902918203684832716283019655932542976 objects without
encountering conflicts (it doesn't really, but that's 2 to the power of 160),
this works as a nice size for a hash to be.

If the hash is reduced to 80 bits, the maximum number of unique hashes shrinks
to 1208925819614629174706176 (less than 1% of 160 bits) while only saving 10
bytes of storage per object. Using a more efficient compression algorithm for
the objects themselves (bzip2, anyone?) will most likely reduce storage size
an order of magnitude more than reducing the size of the hash, although at the
expense of CPU-efficiency.

One must also factor in the code-changes necessary to support abbreviated hashes
and ask oneself "is it worth it?". Since using a smaller portion of the hash
doesn't only have upsides, I'd say "no, definitely not".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
