From: Jeff King <peff@peff.net>
Subject: [PATCHv2 6/9] archive: refactor file extension format-guessing
Date: Tue, 21 Jun 2011 21:25:25 -0400
Message-ID: <20110622012525.GF30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:25:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCCC-0005Ni-N9
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822Ab1FVBZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:25:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51559
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757798Ab1FVBZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:25:27 -0400
Received: (qmail 7520 invoked by uid 107); 22 Jun 2011 01:25:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:25:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:25:25 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176209>

Git-archive will guess a format from the output filename if
no format is explicitly given.  The current function just
hardcodes "zip" to the zip format, and leaves everything
else NULL (which will default to tar). Since we are about
to add user-specified formats, we need to be more flexible.
The new rule is "if a filename ends with a dot and the name
of a format, it matches that format". For the existing "tar"
and "zip" formats, this is identical to the current
behavior. For new user-specified formats, this will do what
the user expects if they name their formats appropriately.

Because we will eventually start matching arbitrary
user-specified extensions that may include dots, the strrchr
search for the final dot is not sufficient. We need to do an
actual suffix match with each extension.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to v1, except we don't need to special case tar-filter code
anymore.

 archive.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index 7d0ca32..41065a8 100644
--- a/archive.c
+++ b/archive.c
@@ -419,13 +419,26 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	return ar->write_archive(ar, &args);
 }
 
+static int match_extension(const char *filename, const char *ext)
+{
+	int prefixlen = strlen(filename) - strlen(ext);
+
+	/*
+	 * We need 1 character for the '.', and 1 character to ensure that the
+	 * prefix is non-empty (k.e., we don't match .tar.gz with no actual
+	 * filename).
+	 */
+	if (prefixlen < 2 || filename[prefixlen-1] != '.')
+		return 0;
+	return !strcmp(filename + prefixlen, ext);
+}
+
 const char *archive_format_from_filename(const char *filename)
 {
-	const char *ext = strrchr(filename, '.');
-	if (!ext)
-		return NULL;
-	ext++;
-	if (!strcasecmp(ext, "zip"))
-		return "zip";
+	int i;
+
+	for (i = 0; i < nr_archivers; i++)
+		if (match_extension(filename, archivers[i]->name))
+			return archivers[i]->name;
 	return NULL;
 }
-- 
1.7.5.4.44.g4b107
