From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 14:51:26 -0700
Message-ID: <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	<7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	<7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	<7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
	<20070423211658.GA21404@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg6RY-0000IC-Fy
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbXDWVv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbXDWVv2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:51:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34910 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbXDWVv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 17:51:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423215128.KBFM1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 17:51:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qlrS1W00B1kojtg0000000; Mon, 23 Apr 2007 17:51:26 -0400
In-Reply-To: <20070423211658.GA21404@steel.home> (Alex Riesen's message of
	"Mon, 23 Apr 2007 23:16:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45367>

Alex Riesen <raa.lkml@gmail.com> writes:

> Imagine a project which started using the attributes at some point of
> time. And imagine developers whose repos suddenly start breaking
> because of clueless integrator created a filter which does not work
> anywere but his system (typical, really) and didn't tell anyone to
> update their configuration (whereas .gitattribute files are in working
> trees already).

That's one of the reasons why only the filter names are assigned
to paths using gitattributes mechanism and what action to take
when a specific filter name is attached to a path is determined
by the config.  Missing filter driver definition in the config
is not an error but makes the filter a no-op passthru.

The content filtering is to massage the content into a shape
that is more convenient for the platform/filesystem/the user to
use.  The keyword here is "more convenient" and not "usable"; in
other words, it is "hanging yourself because we gave you a long
rope" if your project tries to do something with the filtering
mechanism to make your project unusable unless the checkout is
done with specific filter in effect.  So defaulting to passthru
is meant to fall-back on the plain-old inconvenient checkout,
which is not a bad thing.

> How do you suggest to distribute filter configurations, BTW?

The same project description message the participant learn about
the project that says the public repository locations and such,
and perhaps in-tree READ.ME file.

The earlier example I gave would fit this pattern rather well.
If somebody (me) cannot deal with UTF-8 encoded Japanese text
very well, that user personally can mark such a file in
$GIT_DIR/info/attributes as 'filter=utf8-japanese-text' and
define the iconv based filtering driver in $GIT_DIR/config in
the repository that he (me) uses for editing.

In addition, I would most likely have another repository that
does not have the filtering driver defined, and that would be
where I would run the build tools for documentation part, since
the project documentation is supposed to be in UTF-8.  

This is a "purely personal" setting that does not have to be
known to the outside world.  But the filter=utf8-japanese-text
attribute could be shared in-tree if the project has more then
one person with difficulty dealing with UTF-8 encoded Japanese
text.  I may personally edit the file after having iconv convert
to EUC-JP and convert it back to UTF-8 when checking in, but the
other person may use local encoding different from EUC-JP for
editing.  In such a case, only the definition in our config
files are different, and in-tree Documentation/.gitattributes
file would have

	git-lost-found.txt	filter=utf8-japanese-text

which is distributed project-wide.

Repositories used by people who do not have trouble handling
UTF-8 encoded Japanese text would not have any filtering driver
defined for utf8-japanese-text in their $GIT_DIR/config, and
their checkout would be in UTF-8, because of this passthru
behaviour.

> How about checkout performance impact?

Measurement would be interesting; I haven't done it, and that is
one of the smaller reasons I am not particularly keen on pushing
the 'filter' attribute.  Hawk-eyed people might have noticed
that I swapped the order of the series in 'pu' to have 'ident'
first and then 'filter'.
