From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-pack: do not give up when remote has insanely large number of refs.
Date: Wed, 22 Feb 2006 10:42:46 -0800
Message-ID: <7v3bibnsk9.fsf@assigned-by-dhcp.cox.net>
References: <1140547568.5509.21.camel@orbit.scot.redhat.com>
	<7vwtfotaq3.fsf@assigned-by-dhcp.cox.net>
	<7virr8t82n.fsf@assigned-by-dhcp.cox.net>
	<7v1wxvsovj.fsf_-_@assigned-by-dhcp.cox.net>
	<1140633034.3385.5.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 19:43:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBywv-0005u7-S1
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 19:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBVSmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 13:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBVSmu
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 13:42:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31368 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750761AbWBVSmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 13:42:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222183939.XDPK17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 13:39:39 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <1140633034.3385.5.camel@orbit.scot.redhat.com> (Stephen
	C. Tweedie's message of "Wed, 22 Feb 2006 13:30:33 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16606>

"Stephen C. Tweedie" <sct@redhat.com> writes:

> Adding more ^refs up to the limit of 900 should be possible, too, and
> should catch more already-present objects --- while the refs count for
> this repo was under 900, push still worked fine for me, so we don't
> necessarily have to cut it hard to as low a number as 16.

Actually it was done on purpose.  My first round did not have
that 16 limit, and then it turned out that rev-list, given extra
work to cull those 900 negative refs, were spending a lot of
time.  I created a repository with 1500 tags for this test ;-).

Unless we were talking about a repository that happens to host
1000 unrelated projects, each tracked with separate sets of
heads and tags, those negative refs should be related with each
other in the ancestry graph.  We should be able to eliminate
most of them by using the latest handful.

> Perhaps ultimately we may want to simply send the refs list to
> git-rev-list via a pipe or similar if we want this to scale?  We'll need
> this for edge cases such as sending >900 new tags to an old repository
> at once, as we'll exhaust the size of the positive refs list in that
> case.

True.  We should support unbounded number of positive refs.
