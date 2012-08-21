From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 02:31:52 -0400
Message-ID: <20120821063152.GD26516@sigill.intra.peff.net>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
 <20120821062219.GB26516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3i0Q-0007io-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab2HUGb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:31:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43448 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab2HUGbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:31:55 -0400
Received: (qmail 28414 invoked by uid 107); 21 Aug 2012 06:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:32:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:31:52 -0400
Content-Disposition: inline
In-Reply-To: <20120821062219.GB26516@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203942>

On Tue, Aug 21, 2012 at 02:22:19AM -0400, Jeff King wrote:

> And this might be a good follow-on:
> 
> -- >8 --
> Subject: [PATCH] gitignore: report access errors of exclude files

And if we are going to do that, then we almost certainly want to do
this.

-- >8 --
Subject: [PATCH] attr: warn on inaccessible attribute files

Just like config and gitignore files, we silently ignore
missing or inaccessible attribute files. An existent but
inaccessible file is probably a configuration error, so
let's warn the user.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index b52efb5..cab01b8 100644
--- a/attr.c
+++ b/attr.c
@@ -352,8 +352,11 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	char buf[2048];
 	int lineno = 0;
 
-	if (!fp)
+	if (!fp) {
+		if (errno != ENOENT)
+			warning(_("unable to access '%s': %s"), path, strerror(errno));
 		return NULL;
+	}
 	res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp))
 		handle_attr_line(res, buf, path, ++lineno, macro_ok);
-- 
1.7.12.4.g4e9f38f
