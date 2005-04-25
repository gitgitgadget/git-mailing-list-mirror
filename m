From: Russ Allbery <rra@stanford.edu>
Subject: Re: Date handling.
Date: Sun, 24 Apr 2005 18:32:01 -0700
Organization: The Eyrie
Message-ID: <87br83wsj2.fsf@windlord.stanford.edu>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	<1113500316.27227.8.camel@hades.cambridge.redhat.com>
	<20050424030416.GE16751@delft.aura.cs.cmu.edu>
	<1114324729.3419.78.camel@localhost.localdomain>
	<20050425012216.GH29939@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 25 03:28:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsOJ-0004PP-KB
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVDYBcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVDYBcd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:32:33 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:19122 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262423AbVDYBcG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 21:32:06 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp1.Stanford.EDU (8.12.11/8.12.11) with SMTP id j3P1W1q6024023
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 18:32:02 -0700
Received: (qmail 12521 invoked by uid 1000); 25 Apr 2005 01:32:01 -0000
To: git@vger.kernel.org
In-Reply-To: <20050425012216.GH29939@delft.aura.cs.cmu.edu> (Jan Harkes's
 message of "Sun, 24 Apr 2005 21:22:23 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> As Russ mentioned, that probably doesn't work with daylight savings
> time. However I did some testing and it looks like the following lines
> around mktime make it work as we would expect.

>     tm.tm_isdst = -1;
>     then = mktime(&tm);
>     then += tm.tm_gmtoff;

> Attached is the program I used to test it, it seems pretty much unfazed
> by changes to the TZ environment variable. Although I tested around a
> daylight savings time switch, I'm still not 100% sure if it doesn't mess
> up in some corner case.

I don't know what sort of portability you're striving for, but many
platforms don't have tm.tm_gmtoff.  But reimplementing mktime from scratch
isn't particularly hard so long as you don't need some of the "extra"
features of mktime (canonicalizing a struct tm or accepting out of range
values and doing the "right thing").

I came in a little late to this discussion, but I gather that the overall
goal here is parsing RFC 2822 dates.  You're all certainly welcome to take
the code that I wrote for INN to do this if you wish, although it parses
the full RFC 2822 syntax and therefore may accept things you consider
insane (comments, newlines, etc.)  Or you're welcome to cherry-pick bits
and pieces out of it (like mktime_utc).  This code has a fairly extensive
test suite and has also been tested against the old INN parsedate function
on ~2M Usenet articles.

All of this code is my own work, and as far as I'm concerned it's in the
public domain or as close of an approximation that one can get to that in
your local legal environment.

The code is largish and needs some Autoconf support, so I won't just send
it to the list unless someone wants it, but let me know if you do.  You
can also get it by downloading INN from:

    <ftp://ftp.isc.org/isc/inn/snapshots/>

(getting the latest CURRENT snapshot) and looking in lib/date.c.  You
don't need the parsedate_nntp stuff, and you probably don't care about
parsedate_rfc2822_lax, which accepts common violations of RFC 2822 syntax
found in Usenet messages.  The test suite is in tests/lib/date-t.c.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
