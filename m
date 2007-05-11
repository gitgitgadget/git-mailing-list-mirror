From: Junio C Hamano <junkio@cox.net>
Subject: Re: Build Failure: GIT-GUI-VARS
Date: Fri, 11 May 2007 10:10:26 -0700
Message-ID: <7v3b23cmm5.fsf@assigned-by-dhcp.cox.net>
References: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com>
	<7v8xbwgkia.fsf@assigned-by-dhcp.cox.net>
	<5F2FFEA3-0D62-432D-98F7-8BE896937067@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri May 11 19:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYdW-0003cP-KQ
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759162AbXEKRK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759134AbXEKRK2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:10:28 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51342 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758519AbXEKRK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:10:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511171027.UXGZ2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 13:10:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xtAS1W00E1kojtg0000000; Fri, 11 May 2007 13:10:26 -0400
In-Reply-To: <5F2FFEA3-0D62-432D-98F7-8BE896937067@silverinsanity.com> (Brian
	Gernhardt's message of "Fri, 11 May 2007 10:08:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46965>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On May 10, 2007, at 10:30 PM, Junio C Hamano wrote:
>
>> I do not either, and obviously does not reproduce for me.  Time
>> for you to try "make -d" perhaps?
>
> Sorry for the semi-coherent message.  It started out as "we should fix
> this" and I ended up going "why is it broken", all a little too  late
> at night.  I'm also not used to debugging Makefiles.
>
> And I figured it out (make -p actually was more useful than -d):  It's
> another issue with doing things before including config.mak.

Ahh, config.mak.

I have not been very sympathetic to config.mak from the
beginning, although people seem to want it.  As I try to arrange
variable overrides to be passed from the command line anyway,
I've not used config.mak myself.

> I think we need to be including the config.mak much earlier in the
> Makefile as this is not the first time issues like this have come up
> for me.

However, it needs to be able to override NO_*, NEEDS_* and
friends which means it should come after platform specific
defaults.  But one platform wants to change the default
behaviour depend on the settings of NO_*, possibly set in
config.mak.

It is a mess.  Moving it around would fix one person's problem
while breaking others.  I think the best course of action is

 (1) first for somebody more fluent in speaking Makefile than me
     to volunteer to tackle this problem, and ask help from the
     list;

 (2) have people on various "non-stock" configurations sign-up
     as testers; this does not have to cover the systems listed
     in the ifeq ($(uname_S),XXX) part of the current Makefile;
     what is of interest is to see what kind of variables are
     overridden on the real-world systems via config.mak;

 (3) The volunteer cooks up an improved Makefile, using
     config.mak "non-stock" testers have.

This would be something that "volunteer" would be deciding, but
I have a feeling that we can have two config.mak include in the
makefile, one early and one late.  But I suspect that picking
the right two places would have the same "moving would fix one
while breaking another" issue.
