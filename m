From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 04:25:42 +0200
Message-ID: <E1Fw8hS-00023y-FY@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:25:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw8hb-0006TR-BF
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWF3CZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWF3CZs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:25:48 -0400
Received: from moooo.ath.cx ([85.116.203.178]:65418 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751414AbWF3CZr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 22:25:47 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22946>

So here is my proposal how extended expressions would work:

extended expressions have three operators:
    AND, OR (binary), NOT (unary)
extended expressions do not need an extra option. They will be usable
by adding operators between the expressions; a default operator is
used if no operator is specified. The default operator is by default
OR because currently multiple patterns are combined by OR.

OR and AND have precedence, so there are two possibilities, I'd take
the first one.
1. OR, AND:
    This will make it easier to read because OR can be skipped:
      pat1 pat2 AND pat3 pat4
    = pat1 OR pat2 AND pat3 OR pat4
    = (pat1 OR pat2) AND (pat3 OR pat4)
2. AND, OR:
    This is a bit more logic if you think of AND as * and OR as +.

Parenthesis may be used to explicitly override the default precedence.

With this setup we can add an option -FOO (I don't now how to call it,
it is the --and from the patch) which changes the default operator and
the precedence.  With -FOO you'd get AND as default operator and
precedence AND, OR.  Without this option it was easy to write the
formula in a conjungtive form (conjunction of disjunctions), now it is
easy to write a disjunctive form (disjunction of conjunctions):
  pat1 pat2 OR pat3 pat4
= pat1 AND pat2 OR pat3 AND pat4
= (pat1 AND pat2) OR (pat3 AND pat4)

With all this as plan for extended expressions we may also introduce
-FOO now with exactly the behaviour of --and in my patch because
currently no explicit operators and parenthesis are allowed, so only
the default operator may be used and -FOO would change the default
operator.

A short example:
(pat1 AND pat2 AND pat3) OR pat4
could be written as
-FOO pat1 pat2 pat3 OR pat4
which is imho quite readable.

So the next problem are names for the options. We would need
 - AND: between patterns
 - OR:  between patterns
 - NOT: before a pattern
 - FOO: change default operator and precedence
Unfortunately -o, -a, -n are taken and I think the options should be
unique even though they are only allowed at certain positions of the
argument list. I'll think about it a bit, perhaps someone else has a
good idea. FOO should not be named --and imo but I don't have any idea
for a good name atm.
