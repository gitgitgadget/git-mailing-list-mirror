From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Fri, 9 May 2014 11:59:45 -0400
Message-ID: <20140509155945.GG18197@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
 <20140508041423.GC26630@sigill.intra.peff.net>
 <536B1DF4.5080109@fabiodalfonso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:59:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinDD-0001XI-Qm
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbaEIP7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:59:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:48333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750987AbaEIP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:59:47 -0400
Received: (qmail 28455 invoked by uid 102); 9 May 2014 15:59:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:59:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:59:45 -0400
Content-Disposition: inline
In-Reply-To: <536B1DF4.5080109@fabiodalfonso.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248578>

On Thu, May 08, 2014 at 08:02:28AM +0200, Fabio D'Alfonso wrote:

> this is the error in httpd error.log
> 
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user name
> from  uid 4294967295, you probably need to modify the User directive
>  [Wed May 07 20:44:10 2014] [notice] Apache/2.2.17 (Ubuntu) configured --
> resuming normal operations
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user name
> from  uid 4294967295, you probably need to modify the User directive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user name
> from  uid 4294967295, you probably need to modify the User directive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user name
> from  uid 4294967295, you probably need to modify the User directive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user name
> from  uid 4294967295, you probably need to modify the User directive
>  [Wed May 07 20:44:11 2014] [alert] Child 12037 returned a Fatal error...
> Apache is exiting!

Hmm.  Some googling turned up a similar case:

  http://www.linuxquestions.org/questions/linux-server-73/apache-won%27t-start-because-490312/

It looks like apache is trying to getpwuid (probably as part of doing a
setuid on its children), failing, and then crashing. I suspect that this
is related to you running as root, as a non-root apache would not want
to (nor be able to) call setuid.

Does running the tests as a non-root user fix it? If so, I think we have
a few options in git:

  1. Add a User directive to our httpd.conf. I doubt this is a good
     idea to do unconditionally, as a non-root apache would probably be
     unhappy with it.

  2. Add a User directive when we detect that the tests are running as
     root.  This might work, but I'm a bit iffy, as we do not know the
     appropriate username for the system (e.g., "nobody" versus
     "www-data" versus something else).

  3. Just disable the http tests when run as root.

I think I'd favor 3. But I'd like to be sure that being root is the
problem.

-Peff
