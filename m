From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 13:05:32 -0700
Message-ID: <7vird6qlbn.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
	<20070312115350.GA15179@moooo.ath.cx>
	<20070312121226.GB2268@always.joy.eth.net>
	<20070312131253.GA16452@moooo.ath.cx>
	<fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com>
	<20070312140808.GA17450@moooo.ath.cx>
	<7vabyitlld.fsf@assigned-by-dhcp.cox.net>
	<20070312180837.GA22701@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqm0-0007Y5-7u
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 21:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbXCLUFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 16:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbXCLUFe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 16:05:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43673 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbXCLUFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 16:05:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312200533.RFBS2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Mar 2007 16:05:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zw5Y1W00x1kojtg0000000; Mon, 12 Mar 2007 16:05:33 -0400
In-Reply-To: <20070312180837.GA22701@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 12 Mar 2007 19:08:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42078>

Matthias Lederhofer <matled@gmx.net> writes:

> I just thought that GIT_WORK_DIR should be relative to the current
> working directory because it's more intuitive, e.g.
>
>     $ git --git-dir=/path/to/repo.git --work-dir=../.. add a
>
> where ../.. matches the path to the toplevel working directory from
> cwd.  But this definitely is annoying when changing directories.

Not so fast.  That was a trick suggestion, only meant to see if
you have thought through the issues, and you did not have to
agree with me so quickly ;-).  What I was pointing out was
merely that specifying the top as a path relative to the cwd in
permanent basis was not useful if you are going to cd around,
which is a tautology.

For a one-shot thing, I would agree that being able to say "I am
in Documentation/howto directory of the whole thing, so I can
name the top of my working tree as ../.." is far more useful and
natural than having to say "ehhhh, what is the top of the
working tree relative to my repository???".  If it is not a
one-shot thing and the user expects to cd around, then:

	$ GIT_WORK_DIR=$(pwd)/../..; export GIT_WORK_DIR
	$ git foo ...; git bar ...;

would be more natural, so I do not expect the semantics of
relative path would be a big issue in reality, as long as we
make it clear that it is relative to cwd.

By the way, I do not find your command line example intuitive at
all, whether the --work-dir= parameter is relative or absolute.
Do you honestry expect that loooong command line is something
people would use in real life?

With $GIT_DIR/workdir support, I would expect that people would
do (if what is done is only to add one file and nothing else):

	$ GIT_DIR=/path/to/repo.git git add a

And without $GIT_DIR/workdir support:

	$ GIT_DIR=/path/to/repo.git GIT_WORK_DIR=../.. git add a

If the user is going to work in the working tree for extended
period of time, cd'ing around and running multiple git commands:

	$ GIT_DIR=/path/to/repo.git; export GIT_DIR
        $ git foo ; git bar ; cd subdir ; git baz ; ...

And without $GIT_DIR/workdir support, perhaps the user would do:

	$ GIT_DIR=/path/to/repo.git; export GIT_DIR
	$ GIT_WORK_DIR=$(pwd)/../..; export GIT_WORK_DIR
        $ git foo ; git bar ; cd subdir ; git baz ; ...

What I am getting at is that I personally feel that --git-dir=
option is already an unnecessary redundancy that is there only
to confuse new people by having more than one way to do the same
thing, and --work-dir= option seems to be only adding to the
same confusion.  Do we really want that as an option?
