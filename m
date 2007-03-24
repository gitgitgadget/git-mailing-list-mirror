From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Documentation: Allow @@GIT_VERSION@@ in asciidoc.conf
Date: Sat, 24 Mar 2007 14:33:26 -0700
Message-ID: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
References: <11746760451462-git-send-email-frank@lichtenheld.de>
	<7vejnfpqx5.fsf@assigned-by-dhcp.cox.net>
	<20070324120421.GL8017@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Mar 24 22:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVDre-0005ox-NM
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 22:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbXCXVd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbXCXVd2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 17:33:28 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51668 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbXCXVd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 17:33:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324213327.ESHJ28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 17:33:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id elZS1W0061kojtg0000000; Sat, 24 Mar 2007 17:33:26 -0400
In-Reply-To: <20070324120421.GL8017@planck.djpig.de> (Frank Lichtenheld's
	message of "Sat, 24 Mar 2007 13:04:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43020>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Fri, Mar 23, 2007 at 02:53:58PM -0700, Junio C Hamano wrote:
> ...
>> While this is attractive to some degree, *I* am grumpy.  Doesn't
>> this patch make html and man branches update all files _every_
>> time any small change is made to some documentation?
>
> Not with my patch; which is a bug in the patch though because
> asciidoc.conf should really depend on GIT-VERSION-FILE.
>
> Another possibility would be to replace the @@GIT_VERSION@@ in the man pages
> themself and not in the asciidoc.conf. This would mean perhaps slightly
> bigger changes to the build system, but running sed on all the files is of
> course a lot faster than regenerating them with asciidoc.
>
> What do you think?

Ideally, I would like a solution that does not update the
resulting git-foo.html if I keep running these two commands
every time the tip of 'master' in the official repo is updated:

	$ git pull ;# get the latest 'master' from the official repo
	$ make -C Documentation
	: do not run 'make clean' here for the next round

when the only difference in git-foo.html left from the previous
round and this make would regenerate are embedded datestamps and
git version numbers in the output (same for manpages).  In other
words, if the description for the command changed between v1.4.4
and v1.5.0 but did not change at all in v1.5.1, provided that
the above sequence "pull && make" is the only thing that is ever
run in the repository (especially, no 'make clean' is ever run),
I would prefer the generated document to say it was formatted on
the day v1.5.0 was pushed out to the official repository, and
the document describes git v1.5.0, even after I did the above
command sequence on the day v1.5.1 is pushed out.  That would
prevent html and man branches from getting meaningless updates
that only change the embedded version numbers and datestamps.

In other words, I do not want the git-cat-file.html to mention
"v1.5.1-rc1-53-g2499857", if what it says has not changed since
v1.2.0.  I'd prefer to see "v1.2.0" there.

Which probably means that the version number should not be part
of the dependencies of generated documents, as far as 'make's
rebuilding decision is concerned.

If somebody wants all documentation to say what the latest git
is, s/he can do "make clean && make", even if you arrange it to
allow me do the above, but the opposite is more cumbersome and
error prone.
