From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 10:31:26 -0700
Message-ID: <7vabyitlld.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
	<20070312115350.GA15179@moooo.ath.cx>
	<20070312121226.GB2268@always.joy.eth.net>
	<20070312131253.GA16452@moooo.ath.cx>
	<fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com>
	<20070312140808.GA17450@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoMv-0003Fk-4H
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXCLRb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbXCLRb2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:31:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51598 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXCLRb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:31:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312173126.QLWF748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Mar 2007 13:31:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZtXS1W00r1kojtg0000000; Mon, 12 Mar 2007 13:31:27 -0400
cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
In-Reply-To: <20070312140808.GA17450@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 12 Mar 2007 15:08:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42044>

Matthias Lederhofer <matled@gmx.net> writes:

> ... because
> $GIT_WORK_DIR is normally interpreted as relative path to the current
> working directory and not relative to $GIT_DIR.

Well, it could be that _that_ handling of the environment
variable is what needs to be fixed.

If you are using $GIT_DIR, you are working in a subdirectory,
say, Documentation/, and you are using a relative path to
specify GIT_WORK_DIR, then you would need to do this, right?

	$ GIT_DIR=/src/git/git.git ;# top of repository
        $ export GIT_DIR
        $ cd /work/git/git.git ;# go to top of working tree
	$ cd Documentation ;# I want to work in here...

        $ GIT_WORK_DIR=.. ;# toplevel is .. relative to here
        $ export GIT_WORK_DIR
        $ hack hack ; git commit

        $ cd .. ;# Now I want to update the toplevel
        $ GIT_WORK_DIR=. ;# oops I need to update this env
	$ hack hack ; git commit

        $ cd t ;# Now to testcase
        $ GIT_WORK_DIR=.. ;# oops again

If $GIT_WORK_DIR is given absolute you do not have to worry
about this problem, but if you allow giving relative path, it
seems to me that it would be more useful to make it relative to
GIT_DIR.  Then you would need to set it just once, at the same
time when you set and export GIT_DIR, and keep working in that
working tree.

The same goes for $GIT_DIR/workdir.
