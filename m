From: Junio C Hamano <junkio@cox.net>
Subject: Re: Something wrong with pickaxe?
Date: Wed, 18 Jan 2006 18:46:56 -0800
Message-ID: <7vwtgxlysf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601181541150.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 03:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzPpN-00014C-VU
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 03:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWASCrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 21:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbWASCrE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 21:47:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41717 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161046AbWASCrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 21:47:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119024605.ITTR3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 21:46:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601181541150.3240@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Jan 2006 15:55:13 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14878>

Linus Torvalds <torvalds@osdl.org> writes:

> Me, I find the pickaxe semantics so non-intuitive that I never use it 
> (that said, the counting begaviour is better than what it _used_ to be, 
> which, if I recall correctly, was just "it existed before, doesn't exist 
> now").

You are so polite to say "non-intuitive" when you mean
"useless".

I use pickaxe primarily when I want to find out what commit made
the code into the current shape.

For example, after I start debugging or code change, if I
suspect the first "if (!nr_match) return;" is bogus in
filter_refs() of fetch-pack.c, before declaring that code is
bogus and start butchering it, I run something like this:

$ git whatchanged -p -S'static void filter_refs(struct ref **refs, int nr_match, char **match)
{
	struct ref *prev, *current, *next;

	if (!nr_match)
		return;
' master -- fetch-pack.c

to find the commit that made the function to look like so,
hoping to find the reason _why_ it is that way is explained in
the log message for that commit.  If the commit log is not
enough, then next thing I do is to see its commit/author date
and go back to the mailing list logs to see discussion around
that timeframe.

For this use pattern, even counting behaviour we added later is
redundant, since "did not have it that way but now it does" is
the only thing that matters.

"What commits changed the lines that use this symbol over time"
is not a question I ask pickaxe.  When I ask a question about an
individual symbol, such as "get_remote_heads", I often use "git
grep", to learn what other existing users of the function would
be affected in the current code if I changed that function, or
to learn how other functions in the current code uses that
symbol, but for that kind of research, historical usage of that
symbol does not interest me.

Having said all of the above, I agree a different kind of
pickaxe that gives you "if you were to run diff -u between these
two blobs, the resulting patch would contain this text" might
also be useful, and I am very open to have such an additional
diffcore module next to pickaxe (IOW, not a replacement).

But it might not be as easy to use as the current pickaxe if the
question I want to ask is "who made it into this shape".
