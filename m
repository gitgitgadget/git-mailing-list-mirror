From: Junio C Hamano <junkio@cox.net>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 14:45:18 -0800
Message-ID: <7v7iwjwnwh.fsf@assigned-by-dhcp.cox.net>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
	<Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
	<87slf83erg.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0612212009370.3536@woody.osdl.org>
	<877iwjinda.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:45:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxt8m-00047s-13
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbWLVWpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbWLVWpU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:45:20 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34490 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbWLVWpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:45:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222224519.OOT25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 17:45:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1ykc1W02B1kojtg0000000; Fri, 22 Dec 2006 17:44:37 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <877iwjinda.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	22 Dec 2006 14:20:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35241>

Carl Worth <cworth@cworth.org> writes:

> On Thu, 21 Dec 2006 20:13:52 -0800 (PST), Linus Torvalds wrote:
>> I do it all the time, I never even use the old-fashioned syntax any more.
>> It's much more concise and easy to read, and it has all the nice shortcuts
>> (like empty meaning "HEAD", so you can do "git diff ..next" to see the
>> diff from HEAD to another branch).
>
> I can understand the advantage of a shortcut like "git diff ..next",
> but I still don't understand why it's the comparison of HEAD and next
> that's really interesting here. Wouldn't comparing the merge-base to
> next be more desirable?

"git diff ...next" should work just as well, I think.

> But, really, I still don't understand exactly _what_ "diff a..b" even
> means. Can you explain it to me?

diff between two points.

> Presumably the rev-parse magic is happening to the arguments. So does
> the diff code just end up seeing the expanded equivalent of "b ^a" and
> then just use the ^ to decide which tree to be on the left side or
> something?

Exactly; diff just reuses the non-magic part of revision
parameter parsing without using the ancestry traversal
machinery (which is the magic part).

>> It's also useful exactly because of the semantics of things like "...".
>
> And now I'm really confused. If I'm not mistaken, rev-parse will turn
> "a...b" into something like "a b ^$(merge-base a b)", right? So does
> the diff code now end up seeing three different tree specifiers? What
> does it do with that?

It knows that rev-parse makes it "b a ^base", and it knows what
the user meant is "base..b".

That's all because we teach them to spell "a...b" when they want
"base..b".  Similarly, because we allow them to spell "a..b"
when they mean "between two points, a and b", it handles "b ^a"
as the equivalent to giving two trees separately, as "a b".

> And how is this useful? (As you said before,
> diff is always going to end up acting on only two items, so I don't
> see where there could be an interesting distinction from how you
> obtain two items from "a..b" compared to "a...b".) But it might be
> just that I'm really confused here.

I do not think you are seriously saying that comparing A and
B in this picture is meaningless:

      o---o---B
     /
 ---M---o---A

Yes, it is often useful to compare M and B, but that "often" is
limited to the phase of the workflow where you are at A and are
contemplating of merging B.  But merging two forked branches is
not the only thing you do.

Comparing two revisions regardless of how they are topologically
related is useful as often.  It is only that it may not as
useful while you are trying to merge B into A.

So there are two ways to let you do both, and they need to be
specified differently (.. vs ...)  because you need to tell it
to do which one.
