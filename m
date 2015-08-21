From: Jeff King <peff@peff.net>
Subject: Re: Minor bug with help.autocorrect.
Date: Fri, 21 Aug 2015 12:23:48 -0400
Message-ID: <20150821162347.GA4828@sigill.intra.peff.net>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
 <xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSp6i-0002Wg-2U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbbHUQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 12:23:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:48226 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751344AbbHUQXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 12:23:50 -0400
Received: (qmail 4445 invoked by uid 102); 21 Aug 2015 16:23:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 11:23:50 -0500
Received: (qmail 2670 invoked by uid 107); 21 Aug 2015 16:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 12:23:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 12:23:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276308>

On Fri, Aug 21, 2015 at 09:10:35AM -0700, Junio C Hamano wrote:

> > $ git \#fetch
> > error: invalid key: pager.#fetch
> > error: invalid key: alias.#fetch
> > git: '#fetch' is not a git command. See 'git --help'.
> >
> > Did you mean this?
> >         fetch
> 
> Thanks.  I somehow thought that we had some discussion on this
> earlier, perhaps
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/263416/focus=263438
> 
> Peff, do you remember what (if anything) we decided to do about
> this?  I unfortunately don't X-<.

I think the plan is:

  1. squelch the warning message from the config code; even if we change
     the config format to pager.*.command, we will have to support
     pager.* for historical reasons.

  2. introduce pager.*.command so that "git foo_bar" can use
     pager.foo_bar.command.

We should do (1) in the near-term. We do not have to do (2) at all (and
people with funny command names are simply out of luck), but it would be
nice in the long run.

The patch from Tanay in $gmane/263888 accomplishes (1), but there was a
minor cleanup needed (checking the individual bit in "flags", rather
than the whole variable). Here it is with that fix:

-- >8 --
From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] add a flag to supress errors in git_config_parse_key()

`git_config_parse_key()` is used to sanitize the input key.
Some callers of the function like `git_config_set_multivar_in_file()`
get the pre-sanitized key directly from the user so it becomes
necessary to raise an error specifying what went wrong when the entered
key is syntactically malformed.

Other callers like `configset_find_element()` get their keys from git
itself so a return value signifying error would be enough.  The error
output shown to the user is useless and confusing in this case, so add a
flag to suppress errors in such cases.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c |  2 +-
 cache.h          |  4 +++-
 config.c         | 21 ++++++++++++++-------
 t/t7006-pager.sh |  9 +++++++++
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 7188405..f6cfb10 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -200,7 +200,7 @@ static int get_value(const char *key_, const char *regex_)
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
+		if (git_config_parse_key(key_, &key, NULL, 0)) {
 			ret = CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
diff --git a/cache.h b/cache.h
index 4e25271..4b95d7e 100644
--- a/cache.h
+++ b/cache.h
@@ -1410,6 +1410,8 @@ extern int update_server_info(int);
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
+#define CONFIG_ERROR_QUIET 0x0001
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
@@ -1439,7 +1441,7 @@ extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_parse_key(const char *, char **, int *, unsigned int);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 9fd275f..dd0cb52 100644
--- a/config.c
+++ b/config.c
@@ -1314,7 +1314,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
+	ret = git_config_parse_key(key, &normalized_key, NULL, CONFIG_ERROR_QUIET);
 
 	if (ret)
 		return NULL;
@@ -1847,11 +1847,14 @@ int git_config_set(const char *key, const char *value)
  *             lowercase section and variable name
  * baselen - pointer to int which will hold the length of the
  *           section + subsection part, can be NULL
+ * flags - we respect CONFIG_ERROR_QUIET to toggle whether the function raises
+ *         an error on a syntactically malformed key
  */
-int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+int git_config_parse_key(const char *key, char **store_key, int *baselen_, unsigned int flags)
 {
 	int i, dot, baselen;
 	const char *last_dot = strrchr(key, '.');
+	int quiet = flags & CONFIG_ERROR_QUIET;
 
 	/*
 	 * Since "key" actually contains the section name and the real
@@ -1859,12 +1862,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 */
 
 	if (last_dot == NULL || last_dot == key) {
-		error("key does not contain a section: %s", key);
+		if (!quiet)
+			error("key does not contain a section: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
-		error("key does not contain variable name: %s", key);
+		if (!quiet)
+			error("key does not contain variable name: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -1886,12 +1891,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error("invalid key: %s", key);
+				if (!quiet)
+					error("invalid key: %s", key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error("invalid key (newline): %s", key);
+			if (!quiet)
+				error("invalid key (newline): %s", key);
 			goto out_free_ret_1;
 		}
 		(*store_key)[i] = c;
@@ -1943,7 +1950,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	size_t contents_sz;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 0);
 	if (ret)
 		goto out_free;
 
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 947b690..6ea7ac4 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -447,4 +447,13 @@ test_expect_success TTY 'external command pagers override sub-commands' '
 	test_cmp expect actual
 '
 
+test_expect_success 'command with underscores does not complain' '
+	write_script git-under_score <<-\EOF &&
+	echo ok
+	EOF
+	git --exec-path=. under_score >actual 2>&1 &&
+	echo ok >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0.685.g0ca4974
