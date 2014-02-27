From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] shallow: verify shallow file after taking lock
Date: Thu, 27 Feb 2014 04:22:27 -0500
Message-ID: <20140227092227.GA28551@sigill.intra.peff.net>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <20140227090426.GA21892@sigill.intra.peff.net>
 <20140227091012.GB21892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 10:22:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIxAr-0003Q7-7B
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaB0JWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 04:22:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:57910 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751021AbaB0JW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:22:29 -0500
Received: (qmail 12320 invoked by uid 102); 27 Feb 2014 09:22:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 03:22:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 04:22:27 -0500
Content-Disposition: inline
In-Reply-To: <20140227091012.GB21892@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242796>

On Thu, Feb 27, 2014 at 04:10:12AM -0500, Jeff King wrote:

> I also notice that check_shallow_file_for_update returns early if
> !is_shallow. Is that safe? Is it possible for another process to have
> made us shallow since the program began? In that case, we would have to
> stat() the file always, then complain if it exists and !is_shallow.

That patch would look like this:

diff --git a/shallow.c b/shallow.c
index 75da07a..e05a241 100644
--- a/shallow.c
+++ b/shallow.c
@@ -139,13 +139,13 @@ void check_shallow_file_for_update(void)
 {
 	struct stat st;
 
-	if (!is_shallow)
-		return;
-	else if (is_shallow == -1)
+	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
 	if (stat(git_path("shallow"), &st))
 		die("shallow file was removed during fetch");
+	else if (!is_shallow)
+		die("shallow file appeared during fetch");
 	else if (st.st_mtime != shallow_stat.st_mtime
 #ifdef USE_NSEC
 		 || ST_MTIME_NSEC(st) != ST_MTIME_NSEC(shallow_stat)

but again, I'm not really clear on whether this is possible.

-Peff
