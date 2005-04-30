From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 13:32:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
 <42730061.5010106@zytor.com> <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org> <87zmvganq9.fsf@windlord.stanford.edu>
 <1114848175.24014.35.camel@localhost.localdomain> <20050430124048.79119cac.froese@gmx.de>
 <87r7gs87a9.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Edgar Toernig <froese@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRycS-0004hW-Kk
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 22:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVD3Uek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVD3Ucq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 16:32:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:23177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261414AbVD3Ua5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 16:30:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3UKUbs4012257
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Apr 2005 13:30:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3UKUZuj018252;
	Sat, 30 Apr 2005 13:30:36 -0700
To: Russ Allbery <rra@stanford.edu>
In-Reply-To: <87r7gs87a9.fsf@windlord.stanford.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Apr 2005, Russ Allbery wrote:
> 
> You really cannot get portable behavior in this area without something
> akin to Autoconf probes, unfortunately. 

Ok, since this only really matters for AUTHOR_DATE, which we pass in as a
random string anyway, and which comes from various mail programs which may
or may not follow all RFC's, I just rewrote it to give "almost correct 
results" for "pretty much any crap you throw at it".

As a test-bed, a "test-date" program that parses a date and then prints 
it out in git format _and_ in the local timezone format, here's a few 
examples:

	./test-date "$(date)" "April 4th, 1992 at 13:45" "13:04:09 +0100 2004 Yesterday, Friday 13th, December"

results in

	Sat Apr 30 13:26:52 PDT 2005 -> 1114892812 -0700 -> Sat Apr 30 13:26:52 2005

	April 4th, 1992 at 13:45 -> 702395100 +0000 -> Sat Apr  4 05:45:00 1992

	13:04:09 +0100 2004 Yesterday, Friday 13th, December -> 1102939449 +0100 -> Mon Dec 13 04:04:09 2004

which is just because it really doesn't check a hell of a lot.

For example, if you say

	"I caught 14 fishes in December 1998"

test-date will happily parse this as

	Sun Dec 13 16:00:00 1998

(That's "0:00:00 Dec 14th, 1998 UTC" shown in the local timezone ;). Or:

	./test-date  "12:15 4/17/2009"

	12:15 4/17/2009 -> 1239970500 +0000 -> Fri Apr 17 05:15:00 2009

ie it just greedily tries to make _some_ sense of the random strings you 
throw at it.

It doesn't even try getting timezones right - it doesn't know about 
summertime or anything. Besides, I probably used the wrong timezone info 
anyway.

I'll probably tweak it a bit more (make "no timezone means local 
timezone", for example, rather than UTC like it is now).

		Linus
