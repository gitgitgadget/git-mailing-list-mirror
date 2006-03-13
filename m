From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up diffcore-rename scoring
Date: Mon, 13 Mar 2006 02:43:15 -0800
Message-ID: <7vzmjupqv0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
	<7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 11:43:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIkWG-000705-W3
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 11:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCMKnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 05:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCMKnS
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 05:43:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47821 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751243AbWCMKnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 05:43:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313104137.LFFB20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 05:41:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Mar 2006 23:44:44 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17562>

Linus Torvalds <torvalds@osdl.org> writes:

> Instead of doing a fixed-chunk thing and saying that any copy is 
> equivalent to any other copy. That's simply not true. It's _much_ better 
> to have one 24-byte copy than it is to have three 8-byte copies, but the 
> new faster diffcore-delta.c just can't see that.

Exactly.

You know what?  Once we start counting to detect 24-byte
straight copy and try distinguishing it from 3 separate 8-byte
copies, it will eventually lead us to what we have in
diff-delta.c anyway.  I avoided counting runs of bytes on
purpose because I wanted to see how far we can go without it.

The primary reason I started the jc/diff topic branch was
because we _might_ want to replace what is in the current
diff-delta.c with much finer-grained comparison code, and when
that happens, counting xdelta output for rename detection
purpose would have stopped making sense.  For now we decided to
postpone it for performance reasons, but we still might want to
when Nico comes back with a better implementation.

Now, I know the current diff-delta based similarity estimator we
have in "main" seems to do a reasonable if not perfect job,
within a reasonabe amount of time.  And it does know how to
count copying of consecutive bytes.  In the worst case we could
just fork the xdelta part of the code when Nico comes back with
improved finer-grained delta, and we can keep using the current
diff-delta code for rename detection.  Knowing we have that
fallback position, I wanted to pursue a different avenue.
Distinguishing a straight 24-byte run from three independent
8-byte run, using hash to find the offset in the source and
actually do maximum string match, is something we already know
how to do, because that is essentially what the current
diff-delta code does.

By the way, the reason the diffcore-delta code in "next" does
not do every-eight-bytes hash on the source material is to
somewhat alleviate the problem that comes from not detecting
copying of consecutive byte ranges.  If you have a 8-byte run
that is copied from source to destination, we would give it one
point (let's for now forget about false match coming from hash
collisions).  Since the source material is hashed at every byte
offset, if we have 9-byte run copied from source to destination,
that is awarded two points (for the first 8-byte we award one
point, and then another 8-byte sequence starting from the second
byte we award another point; we are talking about an overlapping
range).  That way, the code does reward copying consecutive
bytes around more heavily than copying things at random places.
At one extreme, if you copy 7-byte, throw in a garbage, another
7-byte, throw in a garbage, and keep going, you would not get
any point.

It's really a funky heuristics, and as you have seen, it
sometimes gives spectaculary phony matches.  But in practice,
with some tweaking it seems to do an OK job.
