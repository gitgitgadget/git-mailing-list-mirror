From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: boolean expression on pattern matching.
Date: Fri, 30 Jun 2006 17:11:19 +0200
Message-ID: <E1FwKeN-000087-5x@moooo.ath.cx>
References: <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <7vsllnj6rh.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 17:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKeo-00089z-VW
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 17:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWF3PLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 11:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF3PLY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 11:11:24 -0400
Received: from moooo.ath.cx ([85.116.203.178]:46509 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751409AbWF3PLX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 11:11:23 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vsllnj6rh.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22993>

> This extends the behaviour of git-grep when multiple -e options
> are given.  So far, we allowed multiple -e to behave just like
> regular grep with multiple -e, i.e. the patterns are OR'ed
> together.
> 
> With this change, you can also have multiple patterns AND'ed
> together, or form boolean expressions, like this (the
> parentheses are quoted from the shell in this example):
> 
> 	$ git grep -e _PATTERN --and \( -e atom -e token \)
This looks really nice. So for a few trivial tests it did not fail :)

I noticed an unrelated bug. The context separators ("--") are missing
between matches in different files:

$ git-grep -e foobar -A 1 (this uses external grep)
Documentation/git-diff-tree.txt:I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
Documentation/git-diff-tree.txt-so it can be used to name subdirectories.
--
git-send-email.perl:#$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
git-send-email.perl-
--
[..]

$ git-grep -e foobar -A 1 master (this is internal grep)
master:Documentation/git-diff-tree.txt:I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
master:Documentation/git-diff-tree.txt-so it can be used to name subdirectories.
master:git-send-email.perl:#$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
master:git-send-email.perl-
[..]

I think this cannot be fixed in the loop in builtin-grep.c:grep_cache
because after the last hit there should be no separator but it is not
known if a grep_sha1/grep_file will match and produce output. So I
think there has to be a variable passed down which tells those
functions to print the separator before any other output.
