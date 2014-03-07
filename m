From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show_ident_date: fix always-false conditional
Date: Fri, 7 Mar 2014 12:15:01 -0500
Message-ID: <20140307171501.GA23587@sigill.intra.peff.net>
References: <1394156124-3953-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:15:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLyMa-0002lX-NC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 18:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaCGRPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 12:15:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:34841 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbaCGRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 12:15:03 -0500
Received: (qmail 27592 invoked by uid 102); 7 Mar 2014 17:15:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Mar 2014 11:15:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Mar 2014 12:15:01 -0500
Content-Disposition: inline
In-Reply-To: <1394156124-3953-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243617>

On Thu, Mar 06, 2014 at 08:35:24PM -0500, Eric Sunshine wrote:

> 1dca155fe3fa (log: handle integer overflow in timestamps, 2014-02-24)
> assigns the result of strtol() to an 'int' and then checks it against
> LONG_MIN and LONG_MAX, indicating underflow or overflow, even though
> 'int' may not be large enough to represent those values.
> 
> On Mac, the compiler complains:
> 
>     warning: comparison of constant 9223372036854775807 with
>       expression of type 'int' is always false
>       [-Wtautological-constant-out-of-range-compare]
>       if (<<tz == LONG_MAX>> || tz == LONG_MIN)
> 
> Similarly for the LONG_MIN case. Fix this.

Yeah, this is definitely a potential bug. When I added the overflow
check, I blindly assumed that the existing code was at least using a
sufficiently large type to store the result of strtol, but it's not.

I don't think your fix catches all overflow, though:

> +	else if (ident->tz_begin && ident->tz_end) {
> +		errno = 0;
> +		tz = strtol(ident->tz_begin, NULL, 10);
> +		if (errno)

Errno will trigger if we overflowed a "long", but then we assign the
result into an int, possibly truncating the result.

> Alternately, the result of strtol() could be assigned temporarily to a
> 'long', compared against LONG_MIN and LONG_MAX, and then assigned to the
> 'int' "tz" variable.

That catches overflow from strtol, but we'd then truncate when we pass
it as an int to show_date.

I think we want this instead:

-- >8 --
Subject: show_ident_date: fix tz range check

Commit 1dca155fe3fa (log: handle integer overflow in
timestamps, 2014-02-24) tried to catch integer overflow
coming from strtol() on the timezone field by comparing against
LONG_MIN/LONG_MAX. However, the intermediate "tz" variable
is an "int", which means it can never be LONG_MAX on LP64
systems; we would truncate the output from strtol before the
comparison.

Clang's -Wtautological-constant-out-of-range-compare notices
this and rightly complains.

Let's instead store the result of strtol in a long, and then
compare it against INT_MIN/INT_MAX. This will catch overflow
from strtol, and also overflow when we pass the result as an
int to show_date.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3b811ed..6e266dd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -397,7 +397,7 @@ static const char *show_ident_date(const struct ident_split *ident,
 				   enum date_mode mode)
 {
 	unsigned long date = 0;
-	int tz = 0;
+	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
 		date = strtoul(ident->date_begin, NULL, 10);
@@ -406,7 +406,7 @@ static const char *show_ident_date(const struct ident_split *ident,
 	else {
 		if (ident->tz_begin && ident->tz_end)
 			tz = strtol(ident->tz_begin, NULL, 10);
-		if (tz == LONG_MAX || tz == LONG_MIN)
+		if (tz >= INT_MAX || tz <= INT_MIN)
 			tz = 0;
 	}
 	return show_date(date, tz, mode);
-- 
1.8.5.2.500.g8060133
