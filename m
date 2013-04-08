From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] bundle: Accept prerequisites without commit messages
Date: Sun, 7 Apr 2013 21:06:10 -0400
Message-ID: <20130408010610.GB24030@sigill.intra.peff.net>
References: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
 <7va9pa5k9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5rn-0000sy-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934535Ab3DHBGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 21:06:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33168 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934503Ab3DHBGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 21:06:13 -0400
Received: (qmail 6496 invoked by uid 107); 8 Apr 2013 01:08:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Apr 2013 21:08:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Apr 2013 21:06:10 -0400
Content-Disposition: inline
In-Reply-To: <7va9pa5k9u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220399>

On Sun, Apr 07, 2013 at 10:21:33AM -0700, Junio C Hamano wrote:

> As to the order of comparison to match the order on the number line,
> e.g. write "0 < something" or "negative < 0" to let readers more
> easily visualize in what relation on the number line the quantity of
> each side of the comparison stands, here is a reference to a long
> and amusing thread:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=3912

I do not necessarily agree with the "always use less-than" style, but as
a reviewer of this series, it took me an extra minute to figure out what
was going on because two things changed. If the diff instead looked
like:

diff --git a/bundle.c b/bundle.c
index 505e07e..a9c1335 100644
--- a/bundle.c
+++ b/bundle.c
@@ -57,7 +57,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		 * followed by SP and subject line.
 		 */
 		if (get_sha1_hex(buf.buf, sha1) ||
-		    (40 <= buf.len && !isspace(buf.buf[40])) ||
+		    (40 < buf.len && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
 			if (report_path)
 				error(_("unrecognized header: %s%s (%d)"),

then it is immediately obvious that we are only impacting the case where
buf.len is exactly 40 (and it is even more obvious if you happen to use
the diff-highlight script, which highlights the single changed
character).

Just my two cents as a reader of the patch. Other than that, it looks
correct to me. :)

-Peff
