From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] git_config_set_multivar_in_file: handle "unset" errors
Date: Sat, 9 Apr 2016 13:43:54 -0400
Message-ID: <20160409174353.GC11873@sigill.intra.peff.net>
References: <20160409173904.GA5127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 19:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aowvS-00063t-KP
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 19:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbcDIRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 13:43:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:46930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754308AbcDIRn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 13:43:57 -0400
Received: (qmail 3744 invoked by uid 102); 9 Apr 2016 17:43:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:43:57 -0400
Received: (qmail 13001 invoked by uid 107); 9 Apr 2016 17:44:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:44:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 13:43:54 -0400
Content-Disposition: inline
In-Reply-To: <20160409173904.GA5127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291105>

We pass off to the "_gently" form to do the real work, and
just die() if it returned an error. However, our die message
de-references "value", which may be NULL if the request was
to unset a variable. Nobody using glibc noticed, because it
simply prints "(null)", which is good enough for the test
suite (and presumably very few people run across this in
practice). But other libc implementations (like Solaris) may
segfault.

Let's not only fix that, but let's make the message more
clear about what is going on in the "unset" case.

Reported-by: "Tom G. Christensen" <tgc@jupiterrise.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index d446315..3fe40c3 100644
--- a/config.c
+++ b/config.c
@@ -2221,9 +2221,13 @@ void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *key, const char *value,
 				     const char *value_regex, int multi_replace)
 {
-	if (git_config_set_multivar_in_file_gently(config_filename, key, value,
-						   value_regex, multi_replace))
+	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
+						    value_regex, multi_replace))
+		return;
+	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
+	else
+		die(_("could not unset '%s'"), key);
 }
 
 int git_config_set_multivar_gently(const char *key, const char *value,
-- 
2.8.1.245.g18e0f5c
