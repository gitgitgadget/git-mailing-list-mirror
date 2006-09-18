From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] revision traversal: --author, --committer, and --grep.
Date: Sun, 17 Sep 2006 23:51:26 -0700
Message-ID: <7vslipsm4x.fsf@assigned-by-dhcp.cox.net>
References: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
	<20060918060552.GA2833@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Kai Blin <kai.blin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 18 08:51:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCyb-0007RF-7x
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965495AbWIRGv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965494AbWIRGv3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:51:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10190 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965495AbWIRGv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 02:51:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918065127.TYRO18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 02:51:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PirE1V00C1kojtg0000000
	Mon, 18 Sep 2006 02:51:15 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060918060552.GA2833@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Sep 2006 02:05:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27237>

Jeff King <peff@peff.net> writes:

>The important difference is that your approach means that the user's
>regex is implicitly anchored at the beginning of the field. Thus,
>searching by email address does not work with --author=junkio, but
>rather requires --author='.*junkio'.

I wanted to default it to left anchored, so this was somewhat
deliberate, but this is probably subject to taste.

I actually wanted to do only --grep-header and --grep-message
internally with --author and --committer as simple shorthands,
and that is why --author=<pattern> is just an internal synonym
for "author <pattern>".  I even considered doing without
distinction between header and body (meaning, a line in the
commit log message that happens to begin with "author " would
match --author string), which is technically incorrect but would
be more efficient.  I do not think occasional false hits would
matter much in practice.

Not making the match case insensitive was probably a mistake.
Looking for "--author=linus" would be easier to type.

One thing that I know is broken is the match at the tail; I am
actually thinking of doing something like this:

	sprintf(pat, "^%s %s [0-9][0-9]* [+-][0-9][0-9][0-9][0-9]$",
		field, pattern);

to avoid matching the timestamps.

> A few other thoughts:
>   1. Case sensitivity?

I do not think much is lost if we make the match always case
insensitive for this application.  It might be reasonable to to
default to case insensitive match but if there is a pattern that
has an uppercase use case sensitive match.

>  2. Is there any use to exposing the "header_grep" functionality with
>     --grep-header?

I considered it but did not think of any.  We obviously would
need to revisit this if we do "note " header in the future, but
not for now.  On the other hand, it might be useful to allow

	--grep-header='^\(author\|committer\) Junio'

>   3. An alias (--who=foo?) for --author=foo --committer=foo. I believe
>      this doesn't require boolean magic, since we default to OR.

This should be trivial to implement (two calls to
add_header_grep instead of one), but would it be useful?  I
dunno.
