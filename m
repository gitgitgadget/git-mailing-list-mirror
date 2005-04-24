From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Date handling.
Date: Sat, 23 Apr 2005 23:04:16 -0400
Message-ID: <20050424030416.GE16751@delft.aura.cs.cmu.edu>
References: <1113466592.12012.192.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org> <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org> <1113500316.27227.8.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 04:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXLX-0001mI-Ek
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVDXDE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVDXDE2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:04:28 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:19373 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262237AbVDXDEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 23:04:22 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPXPs-0000W1-00; Sat, 23 Apr 2005 23:04:16 -0400
To: David Woodhouse <dwmw2@infradead.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1113500316.27227.8.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 06:38:36PM +0100, David Woodhouse wrote:
> +/* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
> +   (i.e. English) day/month names, and it doesn't work correctly with %z. */
> +static void parse_rfc2822_date(char *date, char *result, int maxlen)
> +{
...
> +	then = mktime(&tm); /* mktime appears to ignore the GMT offset, stupidly */

I noticed that some commit timestamps seemed to be off, looking into it
a bit more it seems like mktime is influenced by the setting of the
local TZ environment. However in parse_rfc2822_date we are trying to
interpret a time in the timezone of the original author not in the
timezone of the committer.

Here is a short test program that I believe shows the problem.

The question is, do we want to just calculate the time_t offset
ourselves without using mktime, or force the TZ environment to UTC.

Jan


/* cc -o mktime mktime.c ; ./mktime
 *
 * I get the following output,
 *   current 18000
 *   TZ=EST 18000
 *   TZ=UTC 0
 *   TZ=CET -3600
 */

#include <time.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    struct tm tm = { 0, };
    time_t zero;

    /* 1970-01-01 00:00:00 UTC, should map to 'time_t 0' */
    tm.tm_mday = 1;
    tm.tm_year = 70;
			    zero = mktime(&tm); printf("current %d\n", zero);
    setenv("TZ", "EST", 1); zero = mktime(&tm); printf("TZ=EST %d\n", zero);
    setenv("TZ", "UTC", 1); zero = mktime(&tm); printf("TZ=UTC %d\n", zero);
    setenv("TZ", "CET", 1); zero = mktime(&tm); printf("TZ=CET %d\n", zero);
}
