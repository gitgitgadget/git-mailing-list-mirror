From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] config: eliminate config_exclusive_filename
Date: Thu, 16 Feb 2012 03:09:32 -0500
Message-ID: <20120216080932.GG11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwPL-00046M-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab2BPIJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:09:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38597
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab2BPIJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:09:34 -0500
Received: (qmail 28116 invoked by uid 107); 16 Feb 2012 08:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:16:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:09:32 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190882>

This is a magic global variable that was intended as an
override to the usual git-config lookup process. Once upon a
time, you could specify GIT_CONFIG to any git program, and
it would look only at that file. This turned out to be
confusing and cause a lot of bugs for little gain. As a
result, dc87183 (Only use GIT_CONFIG in "git config", not
other programs, 2008-06-30) took this away for all callers
except git-config.

Since git-config no longer uses it either, the variable can
just go away. As the diff shows, nobody was setting to
anything except NULL, so we can just replace any sites where
it was read with NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
This could be squashed into the last patch (really, all of the last few
patches could be squashed). But I was able to "git grep
config_exclusive_filename" at this state and see that yes, indeed, the
variable is now totally useless.

 cache.h  |    2 --
 config.c |   10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 7cb8874..411c60d 100644
--- a/cache.h
+++ b/cache.h
@@ -1150,8 +1150,6 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
-extern const char *config_exclusive_filename;
-
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
diff --git a/config.c b/config.c
index fbf883d..e1d6857 100644
--- a/config.c
+++ b/config.c
@@ -26,8 +26,6 @@ static config_file *cf;
 
 static int zlib_compression_seen;
 
-const char *config_exclusive_filename = NULL;
-
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -1005,7 +1003,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, config_exclusive_filename);
+	return git_config_with_options(fn, data, NULL);
 }
 
 /*
@@ -1504,8 +1502,7 @@ write_err_out:
 int git_config_set_multivar(const char *key, const char *value,
 			const char *value_regex, int multi_replace)
 {
-	return git_config_set_multivar_in_file(config_exclusive_filename,
-					       key, value, value_regex,
+	return git_config_set_multivar_in_file(NULL, key, value, value_regex,
 					       multi_replace);
 }
 
@@ -1631,8 +1628,7 @@ out:
 
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
-	return git_config_rename_section_in_file(config_exclusive_filename,
-						 old_name, new_name);
+	return git_config_rename_section_in_file(NULL, old_name, new_name);
 }
 
 /*
-- 
1.7.9.1.4.g8ffed
