From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/9] archive: pass archiver struct to write_archive callback
Date: Tue, 21 Jun 2011 21:24:07 -0400
Message-ID: <20110622012407.GD30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCAz-0004pw-0h
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843Ab1FVBYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:24:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51545
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757841Ab1FVBYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:24:10 -0400
Received: (qmail 7439 invoked by uid 107); 22 Jun 2011 01:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:24:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:24:07 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176207>

The current archivers are very static; when you are in the
write_tar_archive function, you know you are writing a tar.
However, to facilitate runtime-configurable archivers
that will share a common write function we need to tell the
function which archiver was used.

As a convenience, we also provide an opaque data pointer in
the archiver struct so that individual archivers can put
something useful there when they register themselves.
Technically they could just use the "name" field to look in
an internal map of names to data, but this is much simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
New in v2; before there was magic special-casing of the tar_filter code.

 archive-tar.c |    3 ++-
 archive-zip.c |    3 ++-
 archive.c     |    2 +-
 archive.h     |    3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 930375b..bed9a9b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -234,7 +234,8 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int write_tar_archive(struct archiver_args *args)
+static int write_tar_archive(const struct archiver *ar,
+			     struct archiver_args *args)
 {
 	int err = 0;
 
diff --git a/archive-zip.c b/archive-zip.c
index a776d83..42df660 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -261,7 +261,8 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
 	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
 }
 
-static int write_zip_archive(struct archiver_args *args)
+static int write_zip_archive(const struct archiver *ar,
+			     struct archiver_args *args)
 {
 	int err;
 
diff --git a/archive.c b/archive.c
index f0b4e85..a0a5beb 100644
--- a/archive.c
+++ b/archive.c
@@ -410,5 +410,5 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	parse_treeish_arg(argv, &args, prefix);
 	parse_pathspec_arg(argv + 1, &args);
 
-	return ar->write_archive(&args);
+	return ar->write_archive(ar, &args);
 }
diff --git a/archive.h b/archive.h
index f39cede..b3cf219 100644
--- a/archive.h
+++ b/archive.h
@@ -17,8 +17,9 @@ struct archiver_args {
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
 struct archiver {
 	const char *name;
-	int (*write_archive)(struct archiver_args *);
+	int (*write_archive)(const struct archiver *, struct archiver_args *);
 	unsigned flags;
+	void *data;
 };
 extern void register_archiver(struct archiver *);
 
-- 
1.7.5.4.44.g4b107
