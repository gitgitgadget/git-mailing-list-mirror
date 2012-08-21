From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 02:26:07 -0400
Message-ID: <20120821062607.GC26516@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Tue Aug 21 08:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3hur-0004he-NR
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab2HUG0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:26:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43444 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765Ab2HUG0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:26:10 -0400
Received: (qmail 28375 invoked by uid 107); 21 Aug 2012 06:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:26:07 -0400
Content-Disposition: inline
In-Reply-To: <20120821062219.GB26516@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203941>

On Tue, Aug 21, 2012 at 02:22:19AM -0400, Jeff King wrote:

> And this might be a good follow-on:
> 
> -- >8 --
> Subject: [PATCH] gitignore: report access errors of exclude files

...and it would probably help if I gave you the version that actually
compiled.

-- >8 --
Subject: [PATCH] gitignore: report access errors of exclude files

When we try to access gitignore files, we check for their
existence with a call to "access". We silently ignore
missing files. However, if a file is not readable, this may
be a configuration error; let's warn the user.

For $GIT_DIR/info/excludes or core.excludesfile, we can just
use access_or_warn. However, for per-directory files we
actually try to open them, so we must add a custom warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 240bf0c..ea74048 100644
--- a/dir.c
+++ b/dir.c
@@ -397,6 +397,8 @@ int add_excludes_from_file_to_list(const char *fname,
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
+		if (errno != ENOENT)
+			warning(_("unable to access '%s': %s"), fname, strerror(errno));
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
@@ -1311,9 +1313,9 @@ void setup_standard_excludes(struct dir_struct *dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
-	if (!access(path, R_OK))
+	if (!access_or_warn(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access(excludes_file, R_OK))
+	if (excludes_file && !access_or_warn(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
-- 
1.7.12.4.g4e9f38f
