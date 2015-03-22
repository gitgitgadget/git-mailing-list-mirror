From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] submodule: use strbuf_read_cmd
Date: Sun, 22 Mar 2015 06:08:59 -0400
Message-ID: <20150322100858.GE11615@peff.net>
References: <20150322095924.GA24651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZctD-00014N-Vg
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 11:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbbCVKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 06:13:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:36715 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752182AbbCVKJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 06:09:01 -0400
Received: (qmail 32621 invoked by uid 102); 22 Mar 2015 10:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:09:01 -0500
Received: (qmail 7017 invoked by uid 107); 22 Mar 2015 10:09:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 06:09:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 06:08:59 -0400
Content-Disposition: inline
In-Reply-To: <20150322095924.GA24651@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266065>

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
index d37d400..d85f1bb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -576,12 +576,10 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 		cp.env = local_repo_env;
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
-		cp.out = -1;
 		cp.dir = path;
-		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
+		if (!strbuf_read_cmd(&buf, &cp, 1024) && !buf.len)
 			is_present = 1;
 
-		close(cp.out);
 		strbuf_release(&buf);
 	}
 	return is_present;
-- 
2.3.3.618.ga041503
