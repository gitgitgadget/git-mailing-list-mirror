From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] config: teach git_config_set_multivar_in_file a default
 path
Date: Thu, 16 Feb 2012 03:04:05 -0500
Message-ID: <20120216080405.GC11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:04:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwK5-0000RC-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab2BPIEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:04:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38583
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab2BPIEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:04:08 -0500
Received: (qmail 27998 invoked by uid 107); 16 Feb 2012 08:11:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:11:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:04:05 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190878>

The git_config_set_multivar_in_file function takes a
filename argument to specify the file into which the values
should be written. Currently, this value must be non-NULL.
Callers which want to write to the default location must use
the regular, non-"in_file" version, which will either write
to config_exclusive_filename, or to the repo config if the
exclusive filename is NULL.

Let's migrate the "default to using repo config" logic into
the "in_file" form. That will let callers get the same
default-if-NULL behavior as one gets with
config_exclusive_filename, but without having to use the
global variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index e3fcf75..a9eec58 100644
--- a/config.c
+++ b/config.c
@@ -1300,6 +1300,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	int fd = -1, in_fd;
 	int ret;
 	struct lock_file *lock = NULL;
+	char *filename_buf = NULL;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
@@ -1308,6 +1309,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 
 	store.multi_replace = multi_replace;
 
+	if (!config_filename)
+		config_filename = filename_buf = git_pathdup("config");
 
 	/*
 	 * The lock serves a purpose in addition to locking: the new
@@ -1477,6 +1480,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
+	free(filename_buf);
 	return ret;
 
 write_err_out:
@@ -1488,19 +1492,9 @@ write_err_out:
 int git_config_set_multivar(const char *key, const char *value,
 			const char *value_regex, int multi_replace)
 {
-	const char *config_filename;
-	char *buf = NULL;
-	int ret;
-
-	if (config_exclusive_filename)
-		config_filename = config_exclusive_filename;
-	else
-		config_filename = buf = git_pathdup("config");
-
-	ret = git_config_set_multivar_in_file(config_filename, key, value,
-					value_regex, multi_replace);
-	free(buf);
-	return ret;
+	return git_config_set_multivar_in_file(config_exclusive_filename,
+					       key, value, value_regex,
+					       multi_replace);
 }
 
 static int section_name_match (const char *buf, const char *name)
-- 
1.7.9.1.4.g8ffed
