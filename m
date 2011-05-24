From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] git_config: don't peek at global config_parameters
Date: Tue, 24 May 2011 18:49:45 -0400
Message-ID: <20110524224945.GB24527@sigill.intra.peff.net>
References: <20110524224903.GA16265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:49:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0QD-0004Er-LZ
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603Ab1EXWts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:49:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36211
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078Ab1EXWtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:49:47 -0400
Received: (qmail 22743 invoked by uid 107); 24 May 2011 22:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 18:49:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 18:49:45 -0400
Content-Disposition: inline
In-Reply-To: <20110524224903.GA16265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174356>

The config_parameters list in config.c is an implementation
detail of git_config_from_parameters; instead, that function
should tell us whether it found anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 46aeb9c..fb88839 100644
--- a/config.c
+++ b/config.c
@@ -850,7 +850,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	for (ct = config_parameters; ct; ct = ct->next)
 		if (fn(ct->name, ct->value, data) < 0)
 			return -1;
-	return 0;
+	return config_parameters != NULL;
 }
 
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
@@ -882,9 +882,16 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	ret += git_config_from_parameters(fn, data);
-	if (config_parameters)
-		found += 1;
+	switch (git_config_from_parameters(fn, data)) {
+	case -1: /* error */
+		ret--;
+		break;
+	case 0: /* found nothing */
+		break;
+	default: /* found at least one item */
+		found++;
+		break;
+	}
 
 	return ret == 0 ? found : ret;
 }
-- 
1.7.4.5.7.g2e01
