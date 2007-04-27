From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] server info: Add HEAD to info/refs
Date: Thu, 26 Apr 2007 20:51:36 -0700
Message-ID: <7vhcr2qxtj.fsf@assigned-by-dhcp.cox.net>
References: <20070427020601.22991.13792.stgit@rover>
	<20070427020608.22991.29273.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 05:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhHUk-0003vp-Gp
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 05:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbXD0Dvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbXD0Dvj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 23:51:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59496 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbXD0Dvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 23:51:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427035138.LWOV1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 23:51:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id s3rc1W00L1kojtg0000000; Thu, 26 Apr 2007 23:51:37 -0400
In-Reply-To: <20070427020608.22991.29273.stgit@rover> (Petr Baudis's message
	of "Fri, 27 Apr 2007 04:06:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45678>

Petr Baudis <pasky@suse.cz> writes:

> For some reason, HEAD was not listed in info/refs until now, which means
> that git-ls-remote does not return it for dumb transports while the native
> transports show it. It would be nice to have it because of git-mirror and
> possibly other nifty stuff.

Hmmm.  I know why you want to do this, but honestly speaking,
this is going somewhat backwards.  Maybe one step back, before
going two steps forward.

I always considered it was a bug that the native transport sends
SHA-1 of HEAD after dereferencing the symref, instead of saying
which branch it points at.  You would understand (or more
likely, "remember", as I suspect you have in the past looked at
what git-clone does and git-clone-pack used to do) what yuck
factor this introduced to git-clone.

The info/refs files is designed to mimick peek-remote output (I
know you looked at ls-remote implementation that has "case-esac"
that switches on transport, whose output is piped to the same
filtering loop), but HEAD SHA-1 is not needed in this file to
support dumb transports, as we try to read HEAD symref by hand
when cloning over http.

Longer term, I would want to have a protocol extension to the
native stuff to additionally send the symref information, so
that git-clone does not have to guess.  At the same time, we
would probably want to update the output from git-peek-remote so
that it can say which branch HEAD points at more explicitly, and
in such way that does not break older clients too badly.  We
would need to update the file format of info/refs at the same
time if we update git-peek-remote.

How about proceeding along these lines?

 * We take this patch to add HEAD SHA-1 to info/refs;

 * We add --symref option to git-ls-remote; without the option,
   its last "while read sha1 path" loop filters out lines that
   begin with "->";

 * We add native protocol extension to let upload-pack to say
   what HEAD symref points at, in addition to the SHA-1 HEAD
   points at.  Update peek-remote to show this information like
   this:

	->refs/heads/master<TAB>HEAD<LF>
        0d5e6c97...<TAB>HEAD<LF>
	...

 * We also enhance update-server-info to generate similar ->
   information.

 * We update git-clone to use --symref when it calls
   git-ls-remote; if it can figure out which branch the remote
   HEAD points at (because the remote side has newer git), it
   uses that information to set the HEAD branch instead of
   guessing.

Hmm?
