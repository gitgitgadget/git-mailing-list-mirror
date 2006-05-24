From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Wed, 24 May 2006 16:18:20 -0700
Message-ID: <7vy7wr3tc3.fsf@assigned-by-dhcp.cox.net>
References: <20060519091716.GM22257@spearce.org>
	<7vk68fyarn.fsf@assigned-by-dhcp.cox.net>
	<20060524035234.GA13329@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 01:18:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj2cU-0002s2-0V
	for gcvg-git@gmane.org; Thu, 25 May 2006 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEXXSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 19:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWEXXSW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 19:18:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47489 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932313AbWEXXSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 19:18:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524231821.UAWB15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 19:18:21 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060524035234.GA13329@spearce.org> (Shawn Pearce's message of
	"Tue, 23 May 2006 23:52:34 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20708>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I've swallowed all 10 and pushed them out in "pu", but could you
>> add tests to check the Porcelainish commands you touched with
>> this series to make sure they all log correctly?
>
> Sure.  I've been putting it off as I've been busy the past few days
> and have also been thinking about trying to rebuild reflog using a
> tag/annotation branch style, which might be more generally useful
> to others.

It appears that there is more serious breakage caused by the
lock_ref change.  http-fetch in "next" fails to clone, because
the call to lock-ref-sha1 in fetch.c::pull() forgets that the
program might be creating a new ref.

Another breakage I found (not related to ref-log) is that it
appears fetch.c, even in "master" branch [*1*], has current_ref
variable and does things depending on it, but nobody seems to
set that variable, so there are a lot of dead code that looks as
if they are doing something useful, enclosed in sections like:

	if (somethingelse && current_ref) {
        	dead code
	}

I'll probably revert the ref-log series from "next" in the next
round of updates, while killing the current_ref variable from
"master".


[Footnotes]

*1* It actually is worse than that.  Commit cd541a6 introduced
this variable but nobody touches it ever in the development
history of that variable.  I wonder what the original author and
the maintainer were smoking back then...
