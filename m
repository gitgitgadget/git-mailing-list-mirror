From: Junio C Hamano <junkio@cox.net>
Subject: Re: Another memory overrun in http-push.c
Date: Fri, 02 Mar 2007 00:16:28 -0800
Message-ID: <7vwt20giw3.fsf@assigned-by-dhcp.cox.net>
References: <20070301160911.GU57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN2wL-0007EE-EL
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbXCBIQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbXCBIQa
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:16:30 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37776 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbXCBIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:16:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302081628.MQGZ26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 03:16:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VkGU1W00L1kojtg0000000; Fri, 02 Mar 2007 03:16:29 -0500
In-Reply-To: <20070301160911.GU57456@codelabs.ru> (Eygene Ryabinkin's message
	of "Thu, 1 Mar 2007 19:09:12 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41166>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Me again ;))
>
> Spotted another memory overrun in the http-push.c. In principle,
> it is the read-only overrun, but it provokes the coredump on my
> system.  The problem is that strlcpy(dst, src, size) returns the
> length of the 'src' and demands it to be NULL-terminated (see
> 'man strlcpy' and http://www.gratisoft.us/todd/papers/strlcpy.html).
> It is not the case for the xml_cdata and possibly other places. So
> I've just replaced strlcpy with memcpy + zero termination all over
> the http-push.c. The patch is below.

Please check Documentation/SubmittingPatches.

Use of strlcpy() in general _is_ stupid if you are computing how
much space is needed, allocating that much as your own buffer
and then copying.  strlcpy() needs to say how much it would have
copied if it were given large enough buffer, and it needs to be
able to run strlen(src), so it is not valid to give a buffer
that may not be NUL-terminated as you say.
