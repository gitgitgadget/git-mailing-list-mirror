From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 09:47:29 -0700
Message-ID: <7vy7sqic4e.fsf@assigned-by-dhcp.cox.net>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
	<20060911142644.32313.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 11 18:46:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMovk-00075H-9Y
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 18:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWIKQql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWIKQql
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 12:46:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18152 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964923AbWIKQqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 12:46:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911164638.CRBZ26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 12:46:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M4mV1V0031kojtg0000000
	Mon, 11 Sep 2006 12:46:29 -0400
To: linux@horizon.com
In-Reply-To: <20060911142644.32313.qmail@science.horizon.com>
	(linux@horizon.com's message of "11 Sep 2006 10:26:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26854>

linux@horizon.com writes:

>> Ideally we would have two sha1 values in the cache - the sha1 in the
>> file, and if that is the ID of a tag object, we would also put the
>> sha1 of the commit that the tag points to in the cache.
>
> Now that's not a bad idea.  Hacking it in to Linus's scheme, that's
>
> <foo sha>\t<foo^{} sha>\tfoo

That's a dubious idea.

 - Why assume a tag points directly at a commit, or if it is
   not, why assume "foo^{}" (dereferencing repeatedly until we
   get a non-tag) is special?

 - Why assume the user wants access to only the object name of
   what the tag points at?  Perhaps most users would want to
   have its type, dates (committer and author), and probably the
   first line of the commit message if it is (and most likely it
   is) a commit?  -- at least gitweb and gitk would want these.

You should separate the issue of the internal data structure
implementation and programming interface for Porcelains.  From
the internal data structure point-of-view, the second one is a
redundant piece of information.  Caching it _would_ speed up the
access to it, but then the issue becomes where we draw the line
to stop.

It is probably more useful to think about what kind of
information formatted in what way is often wanted by Porcelains
who want to grab many refs in one-go.  If you can come up with a
set that can satisfy everybody using that as the cache file
format would be fine, but I strongly doubt you can satisfy
everybody.  In which case, thinking about the ways for the
Porcelain to express flexibly what information is wanted and
formatted in what way, and have a command to access that
(git-show-refs, anybody?) would be more fruitful, and at that
point, the internal representation of the cached data becomes
the implementation detail.
