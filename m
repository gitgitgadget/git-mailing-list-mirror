From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Tue, 24 Feb 2009 00:42:16 -0500
Message-ID: <20090224054216.GD4615@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net> <7v8wnxun8e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: eletuchy@gmail.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbq54-0003eY-VT
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbZBXFmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZBXFmU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:42:20 -0500
Received: from peff.net ([208.65.91.99]:56104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZBXFmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:42:19 -0500
Received: (qmail 11311 invoked by uid 107); 24 Feb 2009 05:42:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 00:42:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 00:42:16 -0500
Content-Disposition: inline
In-Reply-To: <7v8wnxun8e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111213>

On Mon, Feb 23, 2009 at 08:33:37AM -0800, Junio C Hamano wrote:

> Yes, "75 months" is unacceptable.  I suspect people's mind would not work
> well with anything larger than 60 months.  I've actually thought about
> "don't care about months" point, but 12 months is a long time.  You
> certainly remember there still was a noticeable maturity difference
> between classmates who were born in the earliest months of the school year
> and in the last months before graduating grade school.  Perhaps after 20
> years.

I'm not sure human and code development necessarily follow the same
timelines. Git wouldn't even be in kindergarten yet. ;)

> > Another option would to give higher resolution in number of years, like
> > "3.5 years" or even "3.1 years".
> 
> But I do not think people think of years in terms of decimal fraction.

I think decimal fraction is overkill. Halves or quarters are more
reasonable.

But after sleeping on it, I think "Y years, M months" is not that bad.
So here is a patch (Eugene, note that this conflicts with your "fall
back to DATE_SHORT" patch).

-- >8 --
Subject: [PATCH] never fallback relative times to absolute

Previously, for dates older than 12 months we fell back to
just giving the absolute time. This can be a bit jarring
when reading a list of times. Instead, let's switch to "Y
years, M months" for five years, and then just "Y years"
after that.

No particular reason on the 5 year cutoff except that it
seemed reasonable to me.

Signed-off-by: Jeff King <peff@peff.net>
---
Please feel free to mark the 5 years up to 20, or whatever
you think is appropriate.

I think this should produce good output in all cases. There
are a surprising number of corner cases, and I spent an
embarrassing amount of time looking at the output of "git
log --pretty=tformat:'%ai / %ar'".

You could also argue for splitting this into "support N
years, M months" and then still fall back to absolute time
eventually (whether DATE_SHORT or not).

 date.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index d75dff4..1165d30 100644
--- a/date.c
+++ b/date.c
@@ -133,7 +133,25 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
 			return timebuf;
 		}
-		/* Else fall back on absolute format.. */
+		/* Give years and months for 5 years or so */
+		if (diff < 1825) {
+			unsigned long years = (diff + 183) / 365;
+			unsigned long months = (diff % 365 + 15) / 30;
+			int n;
+			n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
+					years, (years > 1 ? "s" : ""));
+			if (months)
+				snprintf(timebuf + n, sizeof(timebuf) - n,
+					", %lu month%s ago",
+					months, (months > 1 ? "s" : ""));
+			else
+				snprintf(timebuf + n, sizeof(timebuf) - n,
+					" ago");
+			return timebuf;
+		}
+		/* Otherwise, just years. Centuries is probably overkill. */
+		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
+		return timebuf;
 	}
 
 	if (mode == DATE_LOCAL)
-- 
1.6.2.rc1.269.ga7d41
