From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Build Failure: GIT-GUI-VARS
Date: Fri, 11 May 2007 10:08:40 -0400
Message-ID: <5F2FFEA3-0D62-432D-98F7-8BE896937067@silverinsanity.com>
References: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com> <7v8xbwgkia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 16:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmVne-0003zf-Fe
	for gcvg-git@gmane.org; Fri, 11 May 2007 16:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155AbXEKOIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 10:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756413AbXEKOIq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 10:08:46 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51435 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbXEKOIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 10:08:45 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C2D731FFC003;
	Fri, 11 May 2007 14:08:44 +0000 (UTC)
In-Reply-To: <7v8xbwgkia.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46960>


On May 10, 2007, at 10:30 PM, Junio C Hamano wrote:

> I do not either, and obviously does not reproduce for me.  Time
> for you to try "make -d" perhaps?

Sorry for the semi-coherent message.  It started out as "we should  
fix this" and I ended up going "why is it broken", all a little too  
late at night.  I'm also not used to debugging Makefiles.

And I figured it out (make -p actually was more useful than -d):   
It's another issue with doing things before including config.mak.  My  
config.mak includes the "NO_TCLTK=y" line, which takes effect at  
Makefile:485.  But gitk-wish is getting included in OTHER_PROGRAMS at  
Makefile:272.  So gitk-wish gets included because NO_TCLTK isn't  
defined at that point, but all the other rules involving gitk don't  
get executed because they're after the NO_TCLTK definition.

I think we need to be including the config.mak much earlier in the  
Makefile as this is not the first time issues like this have come up  
for me.  And they tend to be issues that only come up with specific  
configurations and are therefore harder to track down.  Things I can  
see being an issue for people who put their options in config.mak:

149: ifeq ($(prefix),/usr)
224: ifdef WITH_P4IMPORT
271: ifndef NO_TCLTK   # My issue today
279-285: ifndef {SHELL,PERL,PYTHON}_PATH

~~ Brian
