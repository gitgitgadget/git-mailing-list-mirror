From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Thu, 28 Sep 2006 02:20:42 -0700
Message-ID: <7v64f8xs7p.fsf@assigned-by-dhcp.cox.net>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609270810470.3952@g5.osdl.org>
	<20060928081757.GF8056@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 11:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSs4b-0004Z3-2s
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 11:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWI1JUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 05:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWI1JUo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 05:20:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:24317 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751335AbWI1JUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 05:20:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928092043.ZCXU2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 05:20:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TlLl1V00t1kojtg0000000
	Thu, 28 Sep 2006 05:20:45 -0400
To: Martin Waitz <tali@admingilde.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27996>

Martin Waitz <tali@admingilde.org> writes:

>> It should at least never be superlinear, I believe.
>
> So if we want to keep the logarithmic scale we can do some maths:
>...
> But only I have not succeeded in solving these equations, I always stop
> at the last invariant :-(

There is another constraint you did not mention.  Here is the
output from my another failed experiment:

 .gitignore                       |    1 -
 Documentation/git-tar-tree.txt   |    3 +++
 Documentation/git-upload-tar.txt |   39 -----------------------------
 Documentation/git.txt            |    4 ----
 Makefile                         |    1 -
 builtin-tar-tree.c               |  130 +++++++++++++++-----------------------
 builtin-upload-tar.c             |   74 ----------------------------------
 git.c                            |    1 -
 8 files changed, 53 insertions(+), 200 deletions(-)

The deletion from Documentation/git-upload-tar.txt looks much
larger than addition to builtin-tar-tree.c in the above, but
there are 50 lines added to builtin-tar-tree.c (which is why
this experiment is a failure).

Because we are dealing with non-linear scaling, the total of
scaled adds and scaled deletes does not equal to scaled total.
We can deal with this in two ways.  Scale the total and
distribute it, or scale adds and deletes individually and make
sure the sum of scaled adds and deletes never exceed the width.
Obviously the former is easier to implement but it was _wrong_.

The fitting algorithm in the posted patch scales the total to
fit the alloted width and then distributes the result to adds
and deletes.
