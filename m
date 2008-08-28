From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix a warning (on cygwin) to allow -Werror
Date: Thu, 28 Aug 2008 17:09:03 +0100
Message-ID: <48B6CD9F.6020302@ramsay1.demon.co.uk>
References: <48B4426D.3090801@ramsay1.demon.co.uk> <48B508F0.70402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlCj-0006T8-1D
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbYH1RVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbYH1RVd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:21:33 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:39158 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752675AbYH1RVc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 13:21:32 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.69)
	id 1KYlBb-0005Ct-Nf; Thu, 28 Aug 2008 17:21:31 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <48B508F0.70402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94088>

Johannes Sixt wrote:
> Ramsay Jones schrieb:
>> Also, I noticed that git_ntohl() is still defined in compat/mingw.h; is this
>> still required?  It's not a problem, just curious! (I don't have mingw
>> installed, so I can't test myself)
> 
> Yes, it's still needed. The reason is that on Windows ntohl() returns
> 'unsigned long', and then gcc warns about
> 
> sha1_file.c:700: warning: unsigned int format, u_long arg (arg 3)
> 
> git_ntohl() is the workaround.

OK, Thanks.

Ah, yes, everything works on cygwin and Linux because:

                             Linux           Cygwin
    ntohl() returns:         uint32_t        uint32_t
    uint32_t typedef-ed as:  unsigned int    unsigned long
    PRIu32 #define-d as:     "u"             "lu"

So, I suspect (IOW I am guessing that) mingw must have:

    ntohl() returns:         unsigned long (well u_long anyway)
    uint32_t typedef-ed as:  unsigned int
    PRIu32 #define-d ad:     "u"

(I've just noticed that you are not #include-ing inttypes.h, so you are
relying on the PRIu32 defined in git-compat-util.h)

If the above is true, then well, ... Bummer ;-)

I suppose a (very) slight improvement would be to change the return type
of your git_ntohl() wrapper to uint32_t. (But we are talking very slight ;-)

ATB,

Ramsay Jones
