From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL
 values
Date: Tue, 19 Aug 2014 02:20:00 -0400
Message-ID: <20140819062000.GA7805@peff.net>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
 <xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
 <20140819051732.GA13765@peff.net>
 <xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:20:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJcmB-00029E-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 08:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbaHSGUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 02:20:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54696 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752635AbaHSGUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 02:20:03 -0400
Received: (qmail 15799 invoked by uid 102); 19 Aug 2014 06:20:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 01:20:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 02:20:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255445>

On Mon, Aug 18, 2014 at 11:03:51PM -0700, Junio C Hamano wrote:

> We already have some code paths that use ((void *)1) as a special
> pointer value, so in that sense I would say it is not the end of the
> world if you added a new one.

No, but if you use it to replace the regexp, you end up having to check
for it in the code paths that regfree() the result. I think a separate
bit is nicer for that reason.

> At the end-user level (i.e. people who write callers to
> set-multivar-in-file function), I actually like your idea of inventing
> our own string syntax and parse it at the place where we strip '!' out
> and remember that the pattern's match status needs to be negated.

I thought at first that "!" by itself might be fine, but that is
actually a valid regex. And we may feed user input directly to the
function, so we have to be careful not to get too clever.

> For example, instead of "a^" (to which
> I cannot say with confidence that no implementation would match the
> not-at-the-beginning caret literally), I would not mind if we taught
> set-multivar-in-file that we use "!*" as a mark to tell "this
> pattern never matches",

That would work, but I think CONFIG_REGEX_NONE or similar is a bit less
cryptic, and not any harder to implement.

Here is the patch I wrote, for reference (I also think breaking the
"matches" function into a series of conditionals, as you showed, is way
more readable):

diff --git a/builtin/config.c b/builtin/config.c
index b9e7dce..7bba516 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -586,7 +586,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, "a^", 0);
+						       argv[0], value,
+						       CONFIG_REGEX_NONE, 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
diff --git a/cache.h b/cache.h
index fcb511d..dcf3a2a 100644
--- a/cache.h
+++ b/cache.h
@@ -1281,6 +1281,8 @@ extern int update_server_info(int);
 #define CONFIG_INVALID_PATTERN 6
 #define CONFIG_GENERIC_ERROR 7
 
+#define CONFIG_REGEX_NONE ((void *)1)
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
diff --git a/config.c b/config.c
index 67a7729..1199faf 100644
--- a/config.c
+++ b/config.c
@@ -1229,6 +1229,7 @@ static struct {
 static int matches(const char *key, const char *value)
 {
 	return !strcmp(key, store.key) &&
+		store.value_regex != CONFIG_REGEX_NONE &&
 		(store.value_regex == NULL ||
 		 (store.do_not_match ^
 		  (value && !regexec(store.value_regex, value, 0, NULL, 0))));
@@ -1493,6 +1494,8 @@ out_free_ret_1:
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
+ *     (only add a new one)
  * if multi_replace==0, nothing, or only one matching key/value is replaced,
  *     else all matching key/values (regardless how many) are removed,
  *     before the new pair is written.
@@ -1576,6 +1579,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
+		else if (value_regex == CONFIG_REGEX_NONE)
+			store.value_regex = CONFIG_REGEX_NONE;
 		else {
 			if (value_regex[0] == '!') {
 				store.do_not_match = 1;
@@ -1607,7 +1612,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		if (git_config_from_file(store_aux, config_filename, NULL)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
-			if (store.value_regex != NULL) {
+			if (store.value_regex != NULL &&
+			    store.value_regex != CONFIG_REGEX_NONE) {
 				regfree(store.value_regex);
 				free(store.value_regex);
 			}
@@ -1616,7 +1622,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		}
 
 		free(store.key);
-		if (store.value_regex != NULL) {
+		if (store.value_regex != NULL &&
+		    store.value_regex != CONFIG_REGEX_NONE) {
 			regfree(store.value_regex);
 			free(store.value_regex);
 		}
