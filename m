From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] git_config_set_multivar_in_file: all non-zero returns
 are errors
Date: Sat, 9 Apr 2016 13:42:54 -0400
Message-ID: <20160409174253.GB11873@sigill.intra.peff.net>
References: <20160409173904.GA5127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 19:43:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aowuU-0005JD-UI
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 19:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbcDIRm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 13:42:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:46925 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754452AbcDIRm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 13:42:58 -0400
Received: (qmail 3683 invoked by uid 102); 9 Apr 2016 17:42:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:42:57 -0400
Received: (qmail 12980 invoked by uid 107); 9 Apr 2016 17:43:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:43:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 13:42:54 -0400
Content-Disposition: inline
In-Reply-To: <20160409173904.GA5127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291104>

This function is just a thin wrapper for the "_gently" form
of the function. But the gently form is designed to feed
builtin/config.c, which passes our return code directly to
its exit status, and thus uses positive error values for
some cases. We check only negative values, meaning we would
fail to die in some cases (e.g., a malformed key).

This may or may not be triggerable in practice; we tend to
use this non-gentle form only when setting internal
variables, which would not have malformed keys.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 6b81931..d446315 100644
--- a/config.c
+++ b/config.c
@@ -2222,7 +2222,7 @@ void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *value_regex, int multi_replace)
 {
 	if (git_config_set_multivar_in_file_gently(config_filename, key, value,
-						   value_regex, multi_replace) < 0)
+						   value_regex, multi_replace))
 		die(_("could not set '%s' to '%s'"), key, value);
 }
 
-- 
2.8.1.245.g18e0f5c
