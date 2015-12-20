From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] symbolic-ref: propagate error code from create_symref()
Date: Sun, 20 Dec 2015 02:27:18 -0500
Message-ID: <20151220072718.GA30662@sigill.intra.peff.net>
References: <20151220072637.GA22102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYOq-0000RE-Vz
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbbLTH1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 02:27:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:44642 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754102AbbLTH1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:27:20 -0500
Received: (qmail 20109 invoked by uid 102); 20 Dec 2015 07:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 01:27:21 -0600
Received: (qmail 11145 invoked by uid 107); 20 Dec 2015 07:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 02:27:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Dec 2015 02:27:18 -0500
Content-Disposition: inline
In-Reply-To: <20151220072637.GA22102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282758>

If create_symref() fails, git-symbolic-ref will still exit
with code 0, and our caller has no idea that the command did
nothing.

This appears to have been broken since the beginning of time
(e.g., it is not a regression where create_symref() stopped
calling die() or something similar).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/symbolic-ref.c  | 2 +-
 t/t1401-symbolic-ref.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index ce0fde7..9c29a64 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -67,7 +67,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "HEAD") &&
 		    !starts_with(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
-		create_symref(argv[0], argv[1], msg);
+		ret = !!create_symref(argv[0], argv[1], msg);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 20b022a..fbb4835 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -92,4 +92,10 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic-ref reports failure in exit code' '
+	test_when_finished "rm -f .git/HEAD.lock" &&
+	>.git/HEAD.lock &&
+	test_must_fail git symbolic-ref HEAD refs/heads/whatever
+'
+
 test_done
-- 
2.7.0.rc1.350.g9acc0f4
