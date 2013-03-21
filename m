From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] wt-status: fix possible use of uninitialized variable
Date: Thu, 21 Mar 2013 07:05:28 -0400
Message-ID: <20130321110527.GA18819@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 12:06:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdJq-0003IZ-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab3CULFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:05:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33662 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab3CULFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:05:35 -0400
Received: (qmail 20695 invoked by uid 107); 21 Mar 2013 11:07:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:07:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20130321110338.GA18552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218708>

In wt_status_print_change_data, we accept a change_type flag
that is meant to be either WT_STATUS_UPDATED or
WT_STATUS_CHANGED.  We then switch() on this value to set
the local variable "status" for each case, but do not
provide a fallback "default" label to the switch statement.

As a result, the compiler realizes that "status" might be
unset, and complains with a warning. To silence this
warning, we use the "int status = status" trick.  This is
correct with the current code, as all callers provide one of
the two expected change_type flags. However, it's also a
maintenance trap, as there is nothing to prevent future
callers from passing another flag, nor to document this
assumption.

Instead of using the "x = x" hack, let's handle the default
case in the switch() statement with a die("BUG"). That tells
the compiler and any readers of the code exactly what the
function's input assumptions are.

We could also convert the flag to an enum, which would
provide a compile-time check on the function input. However,
since these flags are part of a larger enum, that would make
the code unnecessarily complex (we would have to make a new
enum with just the two flags, and then convert it to the old
enum for passing to sub-functions).

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index ef405d0..7555817 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -264,7 +264,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 {
 	struct wt_status_change_data *d = it->util;
 	const char *c = color(change_type, s);
-	int status = status;
+	int status;
 	char *one_name;
 	char *two_name;
 	const char *one, *two;
@@ -292,6 +292,9 @@ static void wt_status_print_change_data(struct wt_status *s,
 		}
 		status = d->worktree_status;
 		break;
+	default:
+		die("BUG: unhandled change_type %d in wt_status_print_change_data",
+		    change_type);
 	}
 
 	one = quote_path(one_name, -1, &onebuf, s->prefix);
-- 
1.8.2.rc2.8.g2161951
