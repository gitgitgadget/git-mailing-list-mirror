From: Junio C Hamano <gitster@pobox.com>
Subject: Re: backup or mirror a repository
Date: Thu, 27 Sep 2007 23:27:06 -0700
Message-ID: <7vsl4zqp8l.fsf@gitster.siamese.dyndns.org>
References: <1190921742.2263.17.camel@Tenacity>
	<Pine.LNX.4.64.0709272255360.28395@racer.site>
	<1190940704.2263.32.camel@Tenacity>
	<Pine.LNX.4.64.0709280253150.28395@racer.site>
	<1190947063.2263.46.camel@Tenacity>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dan Farina <drfarina@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 08:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib9Jm-0004mk-58
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 08:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbXI1G1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 02:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbXI1G1I
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 02:27:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52579 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbXI1G1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 02:27:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070928062706.VESN18773.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 28 Sep 2007 02:27:06 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id tiT61X00C1gtr5g0000000; Fri, 28 Sep 2007 02:27:06 -0400
In-Reply-To: <1190947063.2263.46.camel@Tenacity> (Dan Farina's message of
	"Thu, 27 Sep 2007 19:37:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59370>

Dan Farina <drfarina@gmail.com> writes:

> I did look at prune and update, but my problem is the opposite: I want
> something that will remove branches from the remote repo when they no
> longer exist locally. As-is over time I will proliferate little local
> branches unless I occasionally sit down and delete branches by operating
> directly on the bare backup repository. (and then use prune on the
> remote nodes)

The "git remote add --mirror" setup is about setting up the
local repository _AS_ the backup of the remote.  In other words,
the contents come from the remote by fetching from it and safely
kept away from disaster on the local side.  And for that,
"remote prune" is a perfect thing to do.

I think what you are asking for is an opposite, a backup remote
site you would push into.  That is not what "remote add --mirror"
is about.

You can almost do it with

	git push --all $remote

except there is no way to automagically remove the branch you
removed from the local repository.  For that, we would need a
new --mirror option to "git-push".

I think it is trivial to do for native transports, as we first
get the list of all refs from the remote side before starting
the transfer.  You need to change the last parameter called
'all' to remote.c::match_refs() into an enum ('push_all' being
one of choices), introduce another enum 'push_mirror', and teach
it to "match" the remote (i.e. dst) ref that does not have
corresponding entry on our side (i.e. src) with an empty object
name to mark it removed.  Then the part marked as "Finally, tell
the other end!"  in send-pack.c::send_pack() will take care of
the actual removal.
