From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MinGW port - initial work uploaded
Date: Mon, 22 Jan 2007 08:39:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 17:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H92D9-0000YT-Oo
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbXAVQjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbXAVQjy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:39:54 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60487 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbXAVQjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:39:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0MGdeN8001863
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 Jan 2007 08:39:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0MGdc0A027642;
	Mon, 22 Jan 2007 08:39:39 -0800
To: Christian MICHON <christian.michon@gmail.com>
In-Reply-To: <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
X-Spam-Status: No, hits=-0.667 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37426>



On Mon, 22 Jan 2007, Christian MICHON wrote:
> 
> One problem I haven't found a solution for though: the date
> of commit is wrong, always back to epoch (1970???).

Without knowing MinGW, I'd assume it's one of two issues:

 - parse_date will probably do this when the date is empty. The way git 
   works, is it takes the date from the GIT_COMMITTER|AUTHOR_DATE 
   environment variables, and it depends on getenv() returning NULL if 
   that environment variable isn't set.

   Maybe getenv() under MinGW always returns a real string, and it's just 
   empty? If so, get_ident() should probably be changed from doing

	if (date_str)
		parse_date(...)

   to

	if (date_str && *date_str)
		parse_date(...)

   or something like that.

 - datestamp() uses "time()" to get the number of seconds since the epoch. 
   HOWEVER, it does it by actually doing

	time_t now;

	time(&now);

   which is proper, but maybe a bit unusual. Try changing that to

	now = time(NULL);

   and see if that changes behaviour (it's datestamp() in date.c).

   Alternatively, if "time()" just doesn't work in MinGW, just use 
   gettimeofday() instead, something like

	time_t now;
	int offset;
	struct timeval tv;
	struct timezone tz;

	/* Just in case not everybody necessarily fills in TZ correctly.. */
	memset(&tz, 0, sizeof(tz));
	gettimeofday(&tv, &tz);
	now = tv.tv_sec;
	offset = tz.tz_minuteswest;

   instead of the current mess with localtime() and company.

   [ NOTE NOTE NOTE! The above gettimeofday() thing has NOT been tested. 
     Using the "tz" value to gettimeofday() is generally considered a bug, 
     and shouldn't really be done. It's very traditional (read: 
     old-fashioned) and very incorrect (it will ignore the TZ variable, 
     and ask the kernel, which generally has no clue at all about 
     timezones). But maybe it works on MinGW, so it might be worth 
     testing. ]

Anyway. I have no idea of Windows or MinGW, or what you did to make it all 
compile, so..

		Linus
