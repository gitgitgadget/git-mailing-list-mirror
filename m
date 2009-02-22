From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
	commits older than a year
Date: Sun, 22 Feb 2009 18:06:20 -0500
Message-ID: <20090222230620.GB19011@coredump.intra.peff.net>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 23 00:07:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbNQM-0002zU-Rk
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 00:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZBVXGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 18:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbZBVXGX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 18:06:23 -0500
Received: from peff.net ([208.65.91.99]:56106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658AbZBVXGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 18:06:22 -0500
Received: (qmail 18475 invoked by uid 107); 22 Feb 2009 23:06:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Feb 2009 18:06:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Feb 2009 18:06:20 -0500
Content-Disposition: inline
In-Reply-To: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111066>

On Fri, Feb 20, 2009 at 01:23:54PM -0800, eletuchy@gmail.com wrote:

> From: Eugene Letuchy <eugene@facebook.com>
> 
> In the context of sizing the git blame time column, it doesn't make a
> lot of sense to see "12 months ago" next to an exact timestamp +
> timezone for something 13 months ago. This commit makes commits older
> than 12 months display the date only, not the time.

I think this is an improvement, though I was thinking of taking it a
step further:

diff --git a/date.c b/date.c
index d75dff4..6dbb8e8 100644
--- a/date.c
+++ b/date.c
@@ -128,12 +128,14 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
 			return timebuf;
 		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
+		/* Say months for the past 24 months or so */
+		if (diff < 720) {
 			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
 			return timebuf;
 		}
-		/* Else fall back on absolute format.. */
+		/* Otherwise, years. Centuries is probably overkill. */
+		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
+		return timebuf;
 	}
 
 	if (mode == DATE_LOCAL)


but maybe other people actually like seeing the absolute time. I've
always found it jarring when reading relative times (but part of that
_was_ because it was so long and exact).

-Peff
