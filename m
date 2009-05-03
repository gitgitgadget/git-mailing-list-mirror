From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] Remove return undef from validate_patch
Date: Sun, 3 May 2009 15:46:00 -0400
Message-ID: <20090503194600.GB20468@coredump.intra.peff.net>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 03 21:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0hde-0002Qz-Sd
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 21:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZECTqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 15:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbZECTqE
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 15:46:04 -0400
Received: from peff.net ([208.65.91.99]:43067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbZECTqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 15:46:01 -0400
Received: (qmail 14228 invoked by uid 107); 3 May 2009 19:46:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 03 May 2009 15:46:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 May 2009 15:46:00 -0400
Content-Disposition: inline
In-Reply-To: <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118187>

On Wed, Apr 29, 2009 at 09:12:18AM -0400, Bill Pemberton wrote:

> Returning undef is rarely the correct way to return a failure.
> Replace it with return 0

No, it's the right way to return failure here. The function returns
either an error string, prefixed with the problematic line number, or
undef. So 'undef' is working as a sentinel value here, not as part of a
boolean.

That being said, the _calling_ code is a bit sloppy in checking "$error"
instead of "defined($error)". It is not an actual bug because the
beginning of the string is always a line number >= 1, so it always
triggers as desired. However, it would probably be more clear to write
it like this:

---
diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..168b2c2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -495,7 +495,7 @@ if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-			$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+			defined($error) and die "fatal: $f: $error\nwarning: no patches were sent\n";
 		}
 	}
 }
