From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: slow process of post-receive script on a remote (samba) share
Date: Thu, 13 Jun 2013 16:29:15 +0200
Message-ID: <87txl2jd8k.fsf@linux-k42r.v.cablecom.net>
References: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
	<87li6eqk2a.fsf@linux-k42r.v.cablecom.net>
	<CAH+Cn14neoV9eXqBAj6_MPXTXK00S=-MnBYs20gaBLZ7YjL00Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Tamas Csabina <tcsabina@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 16:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un8Wg-0000yp-3B
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 16:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab3FMO3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 10:29:18 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:13494 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3FMO3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 10:29:17 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 13 Jun
 2013 16:29:08 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 13 Jun 2013 16:29:15 +0200
In-Reply-To: <CAH+Cn14neoV9eXqBAj6_MPXTXK00S=-MnBYs20gaBLZ7YjL00Q@mail.gmail.com>
	(Tamas Csabina's message of "Thu, 13 Jun 2013 15:47:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227739>

Tamas Csabina <tcsabina@gmail.com> writes:

> Meanwhile I`ve figured it out that the sluggish post-receive execution
> was due to a (mis)-configuration in the samba share where the remote
> repository is hosted. These are:
> oplocks = No
> level2 oplocks = No
[...]
> Now, do I have to worry about allowing oplocks on the remote
> repository from the git point of view? Thinking about concurrent push
> operations from different developers?

>From a brief glance at the relevant docs [1], it would seem that oplocks
are actually just an implementation detail for safe (in the context of
parallel access) client caching.  So they should be fully transparent to
any application usage.  However, the docs do mention that you may be in
trouble if the connection to the server times out.

That being said, some FSes see more usage and thus have been tested more
in this context, and git does tend to show some pretty weird issues on
broken network FSes (one such case: Lustre[2]).

In addition, there are some known races w.r.t. the handling of refs, and
of pruning, if you run git-gc while concurrent pushes are going on.
Jeff King and Michael Haggerty are currently working on getting them
fixed, see e.g. [3].  To see these, you'll have to hit the repo much
harder than a small team can.

So it *should* work, at least if you disable gc.auto and run git-gc
manually at some safe time.  But I wouldn't be surprised if there are
bugs lurking in the context of Windows usage on a Samba-hosted repo,
which sounds like a very rare combination.

And in any case, don't take my word for it; if your life or company
depends on this, you'll need to do your own testing to ensure that it
holds up.


Oh, and why do it that way?  You would most likely get much better
performance out of it if you hosted the repo over ssh (e.g. with
gitolite[4]) or a smart-http server, since the expensive operations (and
they are *expensive*) would be completely local to the server.  The
tradeoff there is that it also shifts a lot of CPU work to the server,
but if you can afford it, you should see a great speedup especially when
fetching large amounts of data (e.g. at cloen time).



[1]  http://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/locking.html#id2615667

[2]  http://thread.gmane.org/gmane.comp.version-control.git/212109

[3]  http://thread.gmane.org/gmane.comp.version-control.git/223299

[4]  http://gitolite.com/gitolite/

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
