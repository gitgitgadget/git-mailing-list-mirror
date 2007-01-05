From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] use xread where we are not checking for EAGAIN/EINTR
Date: Fri, 05 Jan 2007 12:20:00 +0000
Message-ID: <459E4270.9090307@shadowen.org>
References: <1cb8699724ff000fbf0c14ba3e15031e@pinky> <7vvejlg1pg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 13:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2o3N-0002Tr-Vu
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 13:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbXAEMUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 07:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbXAEMUF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 07:20:05 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2642 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965101AbXAEMUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 07:20:04 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2o2N-00086t-LW; Fri, 05 Jan 2007 12:19:08 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvejlg1pg.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35999>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>>     We have an xread() wrapper to help us with those nasty
>>     interrupt returns and yet we fail to use it consistently.
>>     This patch updates those plain read()'s which do not
>>     have any handling for errors, or which treat those errors
>>     as user visible fatal errors.
>>
>>     This feels right to me, but perhaps there is some good
>>     reason that things are done this way ... if so could
>>     someone elighten me.
> 
> Thanks.
> 
> I do not think any of the changes you did introduced new bugs,
> but I think some of them are still wrong.  xread() protects us
> from EINTR happening before any byte is read, but it can still
> give a short read.  Many callers have a loop like this:
> 
> 	do {
>         	size = xread(...);
>                 yet_to_go -= size;
> 	} while (yet_to_go);
> 
> but some are not (e.g. add_excludes_from_file_1() in dir.c
> expects xread() does not return before reading full buffer).

Yes, that is true.  I was going to fix that in the next step with the
writes.  But yes thats likely to involve them becoming 'read_in_full'
style thing and in fact churn us more.

Ignore this one and I'll look to do it 'right'.

-apw
