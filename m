From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Call extended-semantics commands through variables.
Date: Fri, 10 Feb 2006 22:25:58 -0800
Message-ID: <7vwtg2mmx5.fsf@assigned-by-dhcp.cox.net>
References: <1091.1139614506@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 07:26:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7oD2-0007sY-Uy
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 07:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWBKG0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 01:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBKG0A
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 01:26:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52447 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751218AbWBKG0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 01:26:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211062450.KUVF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 01:24:50 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <1091.1139614506@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Fri, 10 Feb 2006 15:35:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15931>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> The variables are just XARGS, FIND, and CPIO.  No GIT_
> was appended so a user can set those once for all scripts
> that may use them (e.g. configure).  A follow-on patch
> will modify the Makefile to allow installation-specific
> defaults.

The use of FIND or CPIO in git clone does not need -0 (and the
code does not use -0, nor your patch adds -0), so you should not
have to override them this way.  Except refnames, the file names
are not something under arbitrary user control and usual LF
termination would work fine.  Even refnames cannot contain LF in
them.  Same thing for FIND in ls-remote and git-push.

FIND in count-objects only lists .git/objects/?? so filenames
there are already well-behaved and you do not need -0 there for
FIND nor XARGS.  Same thing for XARGS in git-prune.sh and FIND
in repack (BTW, you got count-objects one wrong; there is a
leftover GIT_FIND there).

Although most of what your patch does seems to be unnecessary,
reviewing this patch gave me an opportunity to see if we fail to
use -0 where we should, and I am grateful for it.

I did not see any place we did not use -0 when we should, except
one.  The places we _do_ use -0 currently should be converted
with something like your patch to use -0 capable version of the
tool.

The exception is where finding refnames from rsync'ed copy of a
remote (the remote may have screwed-up refnames just to be
hostile), but nobody should be using rsync transfer anyway,
so...
