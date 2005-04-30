From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 12:40:48 +0200
Message-ID: <20050430124048.79119cac.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<87zmvganq9.fsf@windlord.stanford.edu>
	<1114848175.24014.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Russ Allbery <rra@stanford.edu>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 12:35:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRpJy-0001Vl-8K
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 12:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVD3KlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 06:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVD3KlM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 06:41:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:46026 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261185AbVD3Kkz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 06:40:55 -0400
Received: (qmail invoked by alias); 30 Apr 2005 10:40:52 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp018) with SMTP; 30 Apr 2005 12:40:52 +0200
X-Authenticated: #271361
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114848175.24014.35.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
>
> Eww. The time functions we have to play with _really_ suck, don't they?
> How about this...
> 
> +	then += tm.tm_gmtoff;

tm_gmtoff is not available everywhere - POSIX doesn't even mention it (BSD?).

Oh btw, when we are about sucking time functions: the %s and %z strftime-
sequences used further down are also non-standard (POSIX has no %s, old
libc has neither %s nor %z).

A possible workaround:

void make_datestamp(char *buf)
{
	time_t now;
	struct tm *tm;
	int tz;

	time(&now);

	tm = localtime(&now); /* get timezone and tm_isdst */
	tz = -timezone / 60;
	if (tm->tm_isdst > 0)
		tz += 60;

	sprintf(buf, "%lu %+05d", now, tz/60*100+tz%60);
}

That *should* work on any POSIX system but who knows ...

Ciao, ET.
