From: Jeff King <peff@peff.net>
Subject: [PATCH] update-index: fix segfault with missing --cacheinfo argument
Date: Wed, 4 Jun 2014 03:11:11 -0400
Message-ID: <20140604071110.GA22158@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 09:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws5Lx-0004iE-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 09:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbaFDHLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 03:11:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:37109 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755489AbaFDHLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 03:11:13 -0400
Received: (qmail 12886 invoked by uid 102); 4 Jun 2014 07:11:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jun 2014 02:11:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2014 03:11:11 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250717>

Running "git update-index --cacheinfo" without any further
arguments results in a segfault rather than an error
message. Commit ec160ae (update-index: teach --cacheinfo a
new syntax "mode,sha1,path", 2014-03-23) added code to
examine the format of the argument, but forgot to handle the
NULL case.

Returning an error from the parser is enough, since we then
treat it as an old-style "--cacheinfo <mode> <sha1> <path>",
and complain that we have less than 3 arguments to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-index.c        | 3 +++
 t/t2107-update-index-basic.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba54e19..ebea285 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -637,6 +637,9 @@ static int parse_new_style_cacheinfo(const char *arg,
 	unsigned long ul;
 	char *endp;
 
+	if (!arg)
+		return -1;
+
 	errno = 0;
 	ul = strtoul(arg, &endp, 8);
 	if (errno || endp == arg || *endp != ',' || (unsigned int) ul != ul)
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index fe2fb17..1bafb90 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -29,6 +29,10 @@ test_expect_success 'update-index -h with corrupt index' '
 	test_i18ngrep "[Uu]sage: git update-index" broken/usage
 '
 
+test_expect_success '--cacheinfo complains of missing arguments' '
+	test_must_fail git update-index --cacheinfo
+'
+
 test_expect_success '--cacheinfo does not accept blob null sha1' '
 	echo content >file &&
 	git add file &&
-- 
2.0.0.rc1.436.g03cb729
