From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision traversal: --author, --committer, and --grep.
Date: Mon, 18 Sep 2006 02:05:52 -0400
Message-ID: <20060918060552.GA2833@coredump.intra.peff.net>
References: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Kai Blin <kai.blin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 18 08:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCGc-0000dW-6k
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbWIRGFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965446AbWIRGFz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:05:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:62094 "HELO
	peff.net") by vger.kernel.org with SMTP id S965445AbWIRGFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 02:05:54 -0400
Received: (qmail 24923 invoked from network); 18 Sep 2006 02:05:06 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Sep 2006 02:05:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Sep 2006 02:05:52 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27231>

On Sun, Sep 17, 2006 at 05:42:26PM -0700, Junio C Hamano wrote:

> This adds three options to setup_revisions(), which lets you
> filter resulting commits by the author name, the committer name
> and the log message with regexp.

First of all, thanks for implementing this; I tried to use it the other
day (remembering the discussion and patches a few weeks ago) and was
disappointed to find it absent.

That being said, I find the matching style completely unintuitive. :)

To find --author=foo, your strategy is to stringify the header and grep
for "^author foo". As a user, my expectation was that you would
stringify the author field and grep for "foo".

The important difference is that your approach means that the user's
regex is implicitly anchored at the beginning of the field. Thus,
searching by email address does not work with --author=junkio, but
rather requires --author='.*junkio'.

Possible fixes:
  1. Match against "^<field>.*<regex>" (I haven't looked closely at the
     builtin grep implementation, but presumably '.' as usual does not
     include newline).
  2. Find <field>, and then feed grep_buffer only the contents of that
     line.
The second is what I feel that users will expect (at least what I
expected!), but is probably slightly less efficient (two greps instead
of one, but I doubt the difference would be significant). However, I
don't think there is a way with the first approach to explicitly request
a beginning-of-string anchor (i.e., "^Junio" in the second approach).

A few other thoughts:
  1. Case sensitivity? For convenience sake, it seems reasonable to
     match these fields without case sensitivity (what was the
     capitalization of A Large Angry SCM again? von Brand or Von Brand?
     etc). Should it be optional, and if so, how to specify it (a global
     command line option is probably not desired, as you might want
     case-sensitive --grep but case-insensitive --author). So we either
     need a "-i means the rest of the arguments are insensitive, +i
     means they are sensitive" option, or some syntax to specify it in
     the regex (perl uses (?i)).
  2. Is there any use to exposing the "header_grep" functionality with
     --grep-header? Is there anything worth grepping for besides
     author/committer? The general consensus on non-core headers in
     commit objects seemed to be "don't do it".
  3. An alias (--who=foo?) for --author=foo --committer=foo. I believe
     this doesn't require boolean magic, since we default to OR.

I'm happy to work on implementing any of the above if there's interest.

-Peff
