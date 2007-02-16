From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Thu, 15 Feb 2007 17:26:36 -0800
Message-ID: <7vwt2ic2pf.fsf@assigned-by-dhcp.cox.net>
References: <45B6C1FB.7060005@gmail.com>
	<Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45BD4AA9.5090400@gmail.com> <45D3AF9B.40205@gmail.com>
	<Pine.LNX.4.63.0702150236590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D4F4FE.3010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT <git@vger.kernel.org>
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 02:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHrs1-0007MY-PV
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 02:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbXBPB0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbXBPB0i
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 20:26:38 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42513 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbXBPB0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 20:26:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216012637.NTJU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 20:26:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q1Sc1W00i1kojtg0000000; Thu, 15 Feb 2007 20:26:37 -0500
In-Reply-To: <45D4F4FE.3010405@gmail.com> (SungHyun Nam's message of "Fri, 16
	Feb 2007 09:04:14 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39875>

SungHyun Nam <goweol@gmail.com> writes:

>> On Thu, 15 Feb 2007, SungHyun Nam wrote:
>> 
>>>  check_result () {
>>> +    [ -r current ] && rm -f current
>>>      git-ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
>>>      diff -u expected current
>>>  }

I would have written:

	check_result () {
        	rm -f current &&
                git-ls-files --stage | ... &&
                diff -u expected current
	}

If the above still makes the tests pass for your environment,
that would be good.  I am not very happy about the lack of "&&"
after "rm -f current" in your patch.

It seems as if 'current' is sometimes writable and sometimes not,
and when the shell couldn't open it to redirect sed output the
whole test fails for you.  That does not sound like a sane,
reliable filesystem at all, and even if you worked around the
problem in that single shell function, we tend to use shell
redirection to create or overwrite files everywhere (both in
tests and in the real Porcelain scripts) so that means git is a
disaster waiting to happen on your system, which is not good.

What I am trying to get at is to find out what is causing the
problem first, before working it around.  Then, if we are lucky,
we may be able to add a notice in the INSTALL file that says "It
was reported that Filfre virus scanner makes shell redirect in
Cygwin occasionally fail, and both git itself and its testsuite
may not work as expected --- please do not use it", or something
like that.

"Filfre virus scanner" is totally made up, but I think you get
the point.
