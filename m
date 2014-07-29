From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/6] revision: drop useless string offset when parsing
 "--pretty"
Date: Tue, 29 Jul 2014 13:53:40 -0400
Message-ID: <20140729175339.GA31181@peff.net>
References: <20140729175300.GA21536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBau-0007yQ-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaG2Rxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:53:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:42606 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751205AbaG2Rxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:53:44 -0400
Received: (qmail 2306 invoked by uid 102); 29 Jul 2014 17:53:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:53:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:53:40 -0400
Content-Disposition: inline
In-Reply-To: <20140729175300.GA21536@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254452>

Once upon a time, we parsed pretty options by looking for
"--pretty" at the start of the string, and then feeding the
rest (including an "=") to get_commit_format. Later, commit
48ded91 (log --pretty: do not accept bogus "--prettyshort",
2008-05-25) split this into a separate check for "--pretty"
versus "--pretty=".

However, when parsing "--pretty", we still passed "arg+8" to
get_commit_format. This is useless, since it will always
point to the NUL terminator at the end of the string. We can
simply pass NULL instead; both parameters are treated the
same by get_commit_format.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2571ada..615535c 100644
--- a/revision.c
+++ b/revision.c
@@ -1825,7 +1825,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(arg+8, revs);
+		get_commit_format(NULL, revs);
 	} else if (starts_with(arg, "--pretty=") || starts_with(arg, "--format=")) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=X")
-- 
2.1.0.rc0.286.g5c67d74
