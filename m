From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 16:03:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 01:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUUp9-00062h-VF
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 01:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYHPXDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbYHPXDg
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 19:03:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38652 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbYHPXDf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2008 19:03:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7GN3Sje003694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Aug 2008 16:03:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7GN3Rgd009217;
	Sat, 16 Aug 2008 16:03:28 -0700
In-Reply-To: <20080816205325.GD10729@mrq1.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.925 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92559>



On Sat, 16 Aug 2008, Hermann Gausterer wrote:
> 
> i used "stat" to get the timestamp of a file
> and set the git history to this date with
> this command:
> 
> GIT_AUTHOR_DATE=`stat -c '%y' "$FILE"`
> 
> old files (created with an older kernel)
> produced this output.
> 
> 2008-05-28 14:21:35.000000000 +0200
> 
> but new files return nanosecond resolution
> timestamps.
> 
> 2008-06-04 17:25:54.917476713 +0200
> 
> of course this resolution is NOT needed
> for git, but git DOES NOT ignore this time-
> stamps. it changes the date to something
> completly wrong :-/

Git uses a fairly odd date parsing library, and it turns out that 
917476713 +0200 is actually a perfectly valid date in the git format, 
because one thing git allows is the "seconds since epoch" one. So doing

	[torvalds@nehalem git]$ ./test-date "917476713 +0200"
	917476713 +0200 -> 917476713 +0200 -> Wed Jan 27 14:38:33 1999
	917476713 +0200 -> Wed Jan 27 14:38:33 1999

and it turns out that git will totally ignore any other format date when i 
sees this standard format (yes, that is literally the format that git uses 
internally).

So because git date parsing doesn't even really understand fractional 
seconds, and thus doesn't parse it, it will take the fraction, and if it 
was larger than 100000000, it will assume it's a seconds-since-epoch date.

Unlucky.

Anyway, something like this should fix it.

Junio: we might also make the code that actually parses the 
seconds-per-epoch thing only trigger if we haven't already seen a date (ie 
it might check for "tm->tm_year < 0" etc before accepting that seconds 
format).

		Linus

---
Subject: Ignore fractional seconds in date parsing
From: Linus Torvalds <torvads@linux-foundation.org>

.. otherwise a nanosecond resolution fractional second might be 
interpreted as a seconds-since-epoch date format string and overwrite the 
date we so carefully just parsed.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Noticed-by: Hermann Gausterer <git-mailinglist@mrq1.org>
---
 date.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/date.c b/date.c
index 35a5257..5e502da 100644
--- a/date.c
+++ b/date.c
@@ -363,6 +363,11 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 			tm->tm_hour = num;
 			tm->tm_min = num2;
 			tm->tm_sec = num3;
+
+			/* Ignore any possible fractional seconds */
+			if (*end == '.')
+				(void) strtol(end+1, &end, 10);
+
 			break;
 		}
 		return 0;
