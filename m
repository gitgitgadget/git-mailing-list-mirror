From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk performance questions/issues
Date: Mon, 13 Aug 2007 09:59:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708130945420.30176@woody.linux-foundation.org>
References: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKdH6-0004jO-Lx
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 19:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761278AbXHMQ74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 12:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S948342AbXHMQ7y
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 12:59:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40614 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967118AbXHMQ7u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 12:59:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7DGxGoO016241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Aug 2007 09:59:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7DGxBl1005447;
	Mon, 13 Aug 2007 09:59:11 -0700
In-Reply-To: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55771>



On Mon, 13 Aug 2007, David Tweed wrote:
> 
> 1.  With gitk --all -n 256 on my repo it consistently
> takes 12s for the window to appear and 21s for the
> "I'm working" cursor to change to a normal cursor.

There is something seriously wrong there.

For me, on the kernel archive (which is much bigger than yours), the 
window appears immediately, and the "working cursor" takes about two 
seconds to disappear.

> This is on a dual Xeon machine, /proc/cpuinfo
> excerpt
> 
> model name      :   Intel(R) Xeon(TM) CPU 3.00GHz
> stepping        : 3
> cpu MHz         : 2992.496
> cache size      : 2048 KB

Your CPU is fast enough..

> running x86-64 Fedora 7, packed repo has a 12M
> .git dir.

.. and you're apparently fully packed, and do not even have all that big a 
repository.

So:

> Is this the expected start-up time for such a
> configuration?

Absolutely not.

> The output of
>
> time git-rev-list --parents --topo-order --all>/dev/null
>
> is
> 
> real    0m0.048s
> user    0m0.044s
> sys     0m0.005s

Ok, so it's not the revision generation that takes time. 

> 2. Startup time isn't an excessive problem. However,
> I often don't seem to be getting the "diff with parent"
> being displayed once I click on the another commit. If
> I click on several in sequence I get the error
> message
> 
> "error getting diffs: couldn't fork child process: not enough memory"

You have some *serious* problem somewhere. I think your tcl/tk is screwed 
up somehow. 

Alternatively, maybe your repo has some odd structure (do you have tons 
and tons of branches or tags?) and "gitk" ends up having some problem with 
that. What does

	git rev-parse --all | wc -l

say? Various git tools have had performance problems with thousands of 
branches or tags in the past.

One thing to try: I think that "git gc" back in the 1.5.2.2 days didn't 
pack branches by default - and if you have lots and lots of branches, you 
should try to make sure that they are packed, using

	git pack-refs --all --prune

(newer git versions will do this automatically in "git gc" - while 
v1.5.2.2 will only pack the tags by default, iirc).

> The diffs are relatively small (consecutive commits
> are generated hourly automatically) and a command
> line git-diff generates them instantly.

Yeah, it sounds like git itself has no problems, and it's literally gitk 
that shows some strange behaviour.

> 3. Is "gitk --all -n 256" the best way to say "show me
> relatively recent stuff" or should I be using different
> options for limiting things?

That's a perfectly good thing to do. You don't need the "-n", you can 
just do "-256". That said, if you actually want commits to be in date 
order, use

	gitk -d --all -256

instead, which tells gitk to use "--date-order" instead, which is often 
nicer (the graph ends up being a bit messier, but it gives you a more 
correct view of relative dates when you have multiple branches!

		Linus
