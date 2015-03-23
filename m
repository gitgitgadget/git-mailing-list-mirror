From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/7] submodule: use capture_command
Date: Sun, 22 Mar 2015 23:53:56 -0400
Message-ID: <20150323035356.GE30337@peff.net>
References: <20150323035302.GA30279@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 04:54:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZtRE-00058c-F1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 04:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbbCWDx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 23:53:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:37025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752108AbbCWDx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 23:53:58 -0400
Received: (qmail 14610 invoked by uid 102); 23 Mar 2015 03:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 22:53:58 -0500
Received: (qmail 12246 invoked by uid 107); 23 Mar 2015 03:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 23:54:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 23:53:56 -0400
Content-Disposition: inline
In-Reply-To: <20150323035302.GA30279@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266121>

In is_submodule_commit_present, we call run_command followed
by a pipe read, which is prone to deadlock. It is unlikely
to happen in this case, as rev-list should never produce
more than a single line of output, but it does not hurt to
avoid an anti-pattern (and using the helper simplifies the
setup and cleanup).

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index d37d400..c0e6c81 100644
--- a/submodule.c
+++ b/submodule.c
@@ -576,12 +576,10 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 		cp.env = local_repo_env;
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
-		cp.out = -1;
 		cp.dir = path;
-		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
+		if (!capture_command(&cp, &buf, 1024) && !buf.len)
 			is_present = 1;
 
-		close(cp.out);
 		strbuf_release(&buf);
 	}
 	return is_present;
-- 
2.3.3.618.ga041503
