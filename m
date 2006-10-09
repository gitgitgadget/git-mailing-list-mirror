From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bisect idea: Asymmetric split points
Date: Sun, 8 Oct 2006 17:19:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610081711370.3952@g5.osdl.org>
References: <m38xjqfk6r.fsf@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 09 02:20:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWisM-00038d-8c
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 02:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWJIAUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWJIAUE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 20:20:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932170AbWJIAUC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 20:20:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k990JxaX031147
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Oct 2006 17:19:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k990Jwq4015242;
	Sun, 8 Oct 2006 17:19:58 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m38xjqfk6r.fsf@telia.com>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28555>



On Sun, 9 Oct 2006, Peter Osterlund wrote:
> 
> Does this sound like a good idea? Would it be hard to implement?

It should be very easy to implement.

See builtin-rev-list.c: find_bisection(), which has a _very_ simple way of 
trying to find the best commit. It just counts the distance from the 
commit:

	distance = count_distance(p);
	clear_distance(list);

where "distance" is really "how many commits will this cover".

If you wanted to get as close to (say) 75% of the total list of commits as 
possible, you should just do something like

	optimal = nr * percent / 100;
	how_close = abs(optimal - distance);
	if (how_close < closest) {
		best = p;
		closest = how_close;
	}

instead of what we do now (which is just to say that "since we want to get 
half-way, we want to make the biggest distance from _both_ 0 and from 
"nr", which is what it calculates with

 - If we're closer to "nr" than to 0 (ie the difference between nr and 
   distance is smaller than the difference between distance and 0), pick 
   the smaller difference:

	if (nr - distance < distance) 
		distance = nr - distance;

 - if this new distance is larger than any distance we've seen so far, 
   this is the best commit so far:

	if (distance > closest) {
		best = p;
		closest = distance;
	}

and notice how this is really just a special case of the percentage thing 
when percent is 50%.

			Linus
