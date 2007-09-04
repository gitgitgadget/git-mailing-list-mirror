From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix "cvs log" to use UTC timezone instead of local
Date: Tue, 4 Sep 2007 06:22:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709040612260.3088@evo.linux-foundation.org>
References: <11889090932256-git-send-email-xkr47@outerspace.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Berlin <xkr47@outerspace.dyndns.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:22:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYMa-00050j-MS
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXIDNWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 09:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbXIDNWd
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:22:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45482 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752733AbXIDNWc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 09:22:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l84DMRUu032278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Sep 2007 06:22:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l84DMQZG022390;
	Tue, 4 Sep 2007 06:22:26 -0700
In-Reply-To: <11889090932256-git-send-email-xkr47@outerspace.dyndns.org>
X-Spam-Status: No, hits=-4.442 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_23,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57564>



On Tue, 4 Sep 2007, Jonas Berlin wrote:
>
> The timestamp format used in "cvs log" output does not include a
> timezone, and must thus be in UTC timezone. The timestamps from git on
> the other hand contain timezone information for each commit timestamp,
> but git-cvsserver discarded this information and used the timestamps
> without adjusting the time accordingly. The patch adds code to apply
> the timezone offset to produce a UTC timestamp.

I think this is wrong.

Git *internally* stores things in UTC anyway, so if there are any local 
date format things, it's because git-cvsserver.perl has read the dates 
using some format where git has turned its internal date into a local 
date.

So instead of turning it back into UTC here, I think git-cvsserver should 
be changed to ask for the date in the native git format in the first 
place.

That can be done various ways:

 - use the "raw log format" which has dates as seconds-since-UTC (and with 
   an *informational* timezone thing that should then just be ignored).

   This is likely the best approach, since anything but this will 
   almost invariably result in some potentially broken TZ conversion
   back-and-forth..

 - if it really wants to use the pretty-printing support, git-cvsserver 
   should probably be changed to do something like

	TZ=UTC git rev-list --pretty --date=local

   which will pretty-print the date in local time format rather than in 
   the timezone that the commit was done in, and then the TZ=UTC obviously 
   says that the "local" zone is UTC.

Anything else *will* be broken, or will be converting back-and-forth.

For example, I think your patch may fix "cvs log", but I'm seeing some 
suspiciously similar code in the "cvs annotate" handling, so I suspect 
that would need it too.

If instead of trying to convert things to UTC on demand, git-cvsserver 
just asks for the git date stamps in UTC in the first place, none of the 
places should ever need any timezone conversion.

		Linus
