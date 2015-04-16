From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] config: use getc_unlocked when reading from file
Date: Thu, 16 Apr 2015 04:51:18 -0400
Message-ID: <20150416085118.GD17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifWJ-00026W-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 10:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbbDPIvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 04:51:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:46101 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756609AbbDPIvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 04:51:20 -0400
Received: (qmail 21694 invoked by uid 102); 16 Apr 2015 08:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 03:51:20 -0500
Received: (qmail 23462 invoked by uid 107); 16 Apr 2015 08:51:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:51:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 04:51:18 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267265>

We read config files character-by-character from a stdio
handle using fgetc(). This incurs significant locking
overhead, even though we know that only one thread can
possibly access the handle. We can speed this up by taking
the lock ourselves, and then using getc_unlocked to read
each character.

On a silly pathological case:

  perl -le '
    print "[core]";
    print "key$_ = value$_" for (1..1000000)
  ' >input
  git config -f input core.key1

this dropped the time to run git-config from:

  real    0m0.263s
  user    0m0.260s
  sys     0m0.000s

to:

  real    0m0.159s
  user    0m0.152s
  sys     0m0.004s

for a savings of 39%.  Most config files are not this big,
but the savings should be proportional to the size of the
file (i.e., we always save 39%, just of a much smaller
number).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 66c0a51..8b297fc 100644
--- a/config.c
+++ b/config.c
@@ -49,7 +49,7 @@ static struct config_set the_config_set;
 
 static int config_file_fgetc(struct config_source *conf)
 {
-	return fgetc(conf->u.file);
+	return getc_unlocked(conf->u.file);
 }
 
 static int config_file_ungetc(int c, struct config_source *conf)
@@ -1088,7 +1088,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 	f = fopen(filename, "r");
 	if (f) {
+		flockfile(f);
 		ret = do_config_from_file(fn, filename, filename, f, data);
+		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
-- 
2.4.0.rc2.384.g7297a4a
