From: Junio C Hamano <junkio@cox.net>
Subject: Re: sprintf security holes?
Date: Mon, 19 Sep 2005 00:42:08 -0700
Message-ID: <7voe6pv6zz.fsf@assigned-by-dhcp.cox.net>
References: <86zmqd5aey.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 09:42:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHGI2-0003aE-Bs
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 09:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVISHmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 03:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVISHmL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 03:42:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11926 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932361AbVISHmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 03:42:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919074208.NHXJ18416.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 03:42:08 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86zmqd5aey.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "16 Sep 2005 07:56:05 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8844>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Since sprintf() can lead to buffer overflows from unprotected user
> data, and you want to use git in server situtations, wouldn't it be
> prudent to eliminate those in some near-ish timeframe?

I do not have any objection for a code audit, but what I do not
particularly like about the above statement is what to do after
you audited and know your sprintf() would not overrun any of
your allocated buffers.  I suspect OpenBSD will keep complaining
just because sprintf() is used.

Rewriting them all to use snprintf() is probably not a good
enough answer.  Later somebody will make mistakes while changing
our code, and if the modified format string (or any other change
that affects the condition under which snprintf() is called)
would now generate a string longer than allotted buffer, then
what happens?  Does OpenBSD nicely complain again, or keep mum
about the problem because it is happy that we are using
snprintf()?

We _might_ be protected from buffer overrun errors [*1*], but we
would then end up operating on a truncated data -- which would
lead to an equally unexpected behaviour.  I do not think there
is any guarantee that working with unexpectedly truncated data
leads to less severe security problems than buffer overruns with
careless sprintf().


[Footnotes]

*1* I do not think even that is guaranteed -- does OpenBSD
compare the xmalloc()'ed buffer length passed to snprintf
against the size limit?  What if we pass a statically allocated
buffer as a pointer to another function that uses snprintf?
Does it follow the flow of the data in such a way to take
notice?
