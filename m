From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Date handling.
Date: Sun, 24 Apr 2005 21:22:23 -0400
Message-ID: <20050425012216.GH29939@delft.aura.cs.cmu.edu>
References: <1113466592.12012.192.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org> <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org> <1113500316.27227.8.camel@hades.cambridge.redhat.com> <20050424030416.GE16751@delft.aura.cs.cmu.edu> <1114324729.3419.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 03:18:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsEb-0003ch-LQ
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVDYBWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVDYBWw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:22:52 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:60831 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262396AbVDYBWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 21:22:34 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPsIp-00024R-00; Sun, 24 Apr 2005 21:22:23 -0400
To: David Woodhouse <dwmw2@infradead.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1114324729.3419.78.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2005 at 04:38:49PM +1000, David Woodhouse wrote:
> On Sat, 2005-04-23 at 23:04 -0400, Jan Harkes wrote:
> > I noticed that some commit timestamps seemed to be off, looking into it
> > a bit more it seems like mktime is influenced by the setting of the
> > local TZ environment.
> 
> Ewww. I missed that in the documentation. I suppose I should have worked
> it out having empirically determined that it ignores the tm_gmtoff
> field.
> 
> > The question is, do we want to just calculate the time_t offset
> > ourselves without using mktime, or force the TZ environment to UTC.
> 
> I don't think we want to be in the business of counting leap seconds; we
> need to let the system do it. I don't much like setting TZ to UTC though
> -- how about we use your test case to find the offset and subtract that?
> 
> Does this work?

As Russ mentioned, that probably doesn't work with daylight savings
time. However I did some testing and it looks like the following lines
around mktime make it work as we would expect.

    tm.tm_isdst = -1;
    then = mktime(&tm);
    then += tm.tm_gmtoff;

Attached is the program I used to test it, it seems pretty much unfazed
by changes to the TZ environment variable. Although I tested around a
daylight savings time switch, I'm still not 100% sure if it doesn't mess
up in some corner case.

Jan


#include <time.h>
#include <stdlib.h>
#include <stdio.h>

time_t mkutctime(struct tm *tm, int offset)
{
    time_t time;

    /* we don't know whether our timezone happens to be dst or not, let libc
     * figure that one out. */
    tm->tm_isdst = -1;

    /* interpret struct tm in the local timezone */
    time = mktime(tm);
    if (time == -1) return -1;

    /* libc lets us know how many seconds our local time differs from UTC
     * this is a non-standard BSD extension, which is probably not as
     * portable, but it seems to work. */
    time += tm->tm_gmtoff;

    /* However as the passed in struct tm was not UTC but in some other
     * timezone, we still have subtract the offset that came with the
     * RFC2822 date */
    time -= offset;

    return time;
}

int main(int argc, char **argv)
{
    struct tm tm = { 0, };
    time_t time;

    tm.tm_year = 70;
    tm.tm_mday = 1;
    time = mkutctime(&tm, 0);
    printf("1970-01-01 00:00:00 UTC = 0 (%d)\n", time);

    tm.tm_year = 105;
    tm.tm_mon = 2;
    tm.tm_mday = 17;
    tm.tm_hour = 20;
    tm.tm_min = 58;
    tm.tm_sec = 31;
    time = mkutctime(&tm, -5 * 3600);
    printf("2005-03-17 20:58:31 EST = 1111111111 (%d)\n", time);

    tm.tm_mon = 3;
    tm.tm_mday = 3;
    tm.tm_hour = 1;
    tm.tm_min = 59;
    tm.tm_sec = 59;
    time = mkutctime(&tm, -5 * 3600);
    printf("2005-04-03 01:59:59 EST = 1112511599 (%d)\n", time);

    tm.tm_hour = 3;
    tm.tm_min = 0;
    tm.tm_sec = 0;
    time = mkutctime(&tm, -4 * 3600);
    printf("2005-04-03 03:00:00 EDT = 1112511600 (%d)\n", time);
}

