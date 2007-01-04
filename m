From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_tags_body
Date: Thu, 04 Jan 2007 12:51:25 -0800
Message-ID: <7vsleqjz1u.fsf@assigned-by-dhcp.cox.net>
References: <11678612691404-git-send-email-jnareb@gmail.com>
	<enh9h8$7l0$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 21:52:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ZZI-00039A-8w
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 21:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbXADUwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 15:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbXADUwE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 15:52:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49576 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030209AbXADUwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 15:52:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104205201.DBEI18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 15:52:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 78rg1W0161kojtg0000000; Thu, 04 Jan 2007 15:51:41 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <enh9h8$7l0$2@sea.gmane.org> (Jakub Narebski's message of "Wed,
	03 Jan 2007 23:11:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35955>

Jakub Narebski <jnareb@gmail.com> writes:

>> Fix "Use of uninitialized value" warning in git_tags_body generated
>> for lightweight tags of tree and blob object; those don't have age
>> ($tag{'age'}) defined.
>
> By the way, the latest "Fix warnings" patches for gitweb were result
> of working on bare bones test suite for gitweb. For now I'm only
> checking if there was anything written to STDERR.

I think this is a useful thing to have in-tree at this point,
with perhaps minor tweaks I'd suggest later.  That way other
people can write more tests to catch regressions.

> BTW how in portable way to check that given file matches given patterns
> in specified order, or matches given patterns in any order?

This depends on how different the same page is rendered at
different times; I suspect the outputs for the same request from
two runs of the test are expected to be different in age, commit
and tag object ID and nothing else?

If so, I think using test_tick() to force the stable commit
object ID while your test is building a test repository would be
a useful thing to do.  Also I think replacing call to "time"
(you seem to call it from multiple places, all to compute "age")
with a call to a subroutine "git_time" and then defining:

	sub git_time {
        	if (exists $::ENV{GIT_TEST_TIME}) {
                	return $::ENV{GIT_TEST_TIME};
                }
                return time;
        }

to help testing would be sensible.  Set and export GIT_TEST_TIME
to a fixed time (say, midnight GMT December 28th, 2006) in
gitweb_init and you will get stable agestring if you have
already made the commit and author timestamps stable with
test_tick().
