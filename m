From: Jeff King <peff@peff.net>
Subject: Re: Minor bug with help.autocorrect.
Date: Mon, 24 Aug 2015 02:11:33 -0400
Message-ID: <20150824061132.GC14403@sigill.intra.peff.net>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
 <xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
 <20150821162347.GA4828@sigill.intra.peff.net>
 <xmqqmvxk47e5.fsf@gitster.dls.corp.google.com>
 <20150824054327.GB14403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanay Abhra <tanayabh@gmail.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTkyq-0006XQ-Ld
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 08:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbbHXGLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 02:11:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:48894 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751777AbbHXGLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 02:11:36 -0400
Received: (qmail 6027 invoked by uid 102); 24 Aug 2015 06:11:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 01:11:36 -0500
Received: (qmail 20457 invoked by uid 107); 24 Aug 2015 06:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 02:11:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 02:11:33 -0400
Content-Disposition: inline
In-Reply-To: <20150824054327.GB14403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276434>

On Mon, Aug 24, 2015 at 01:43:27AM -0400, Jeff King wrote:

> > I wonder if alias_lookup() and check_pager_config(), two functions
> > that *know* that the string they have, cmd, could be invalid and
> > unusable key to give to the config API, should be doing an extra
> > effort (e.g. call parse_key() with QUIET option and refrain from
> > calling git_config_get_value()).  It feels that for existing callers
> > of parse_key(), not passing QUIET would be the right thing to do.
> > 
> > Of course, I am OK if git_config_get_value() and friends took the
> > QUIET flag and and passed it all the way down to parse_key(); that
> > would be a much more correct approach to address this issue (these
> > two callers do not have to effectively call parse_key() twice that
> > way), but at the same time, that would be a lot more involved
> > change.
> 
> Yeah, I agree these are the only two sane fixes. Plumbing the quiet flag
> through does seem really invasive; every "git_config_get_foo" variant
> would have to learn it. [...]

Here is a patch to do the first. While it seems a little gross to have
to call parse_key twice, I think it does make sense. The alias.* and
pager.* config trees are mis-designed, and we are papering over the
problem for historical reasons.

-- >8 --
Subject: config: silence warnings for command names with invalid keys

When we are running the git command "foo", we may have to
look up the config keys "pager.foo" and "alias.foo". These
config schemes are mis-designed, as the command names can be
anything, but the config syntax has some restrictions. For
example:

  $ git foo_bar
  error: invalid key: pager.foo_bar
  error: invalid key: alias.foo_bar
  git: 'foo_bar' is not a git command. See 'git --help'.

You cannot name an alias with an underscore. And if you have
an external command with one, you cannot configure its
pager.

In the long run, we may develop a different config scheme
for these features. But in the near term (and because we'll
need to support the existing scheme indefinitely), we should
at least squelch the error messages shown above.

These errors come from git_config_parse_key. Ideally we
would pass a "quiet" flag to the config machinery, but there
are many layers between the pager code and the key parsing.
Passing a flag through all of those would be an invasive
change.

Instead, let's provide a config function to report on
whether a key is syntactically valid, and have the pager and
alias code skip lookup for bogus keys. We can build this
easily around the existing git_config_parse_key, with two
minor modifications:

  1. We now handle a NULL store_key, to validate but not
     write out the normalized key.

  2. We accept a "quiet" flag to avoid writing to stderr.
     This doesn't need to be a full-blown public "flags"
     field, because we can make the existing implementation
     a static helper function, keeping the mess contained
     inside config.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 alias.c          |  3 ++-
 cache.h          |  1 +
 config.c         | 39 +++++++++++++++++++++++++++++----------
 pager.c          |  3 ++-
 t/t7006-pager.sh |  9 +++++++++
 5 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/alias.c b/alias.c
index 6aa164a..a11229d 100644
--- a/alias.c
+++ b/alias.c
@@ -5,7 +5,8 @@ char *alias_lookup(const char *alias)
 	char *v = NULL;
 	struct strbuf key = STRBUF_INIT;
 	strbuf_addf(&key, "alias.%s", alias);
-	git_config_get_string(key.buf, &v);
+	if (git_config_key_is_valid(key.buf))
+		git_config_get_string(key.buf, &v);
 	strbuf_release(&key);
 	return v;
 }
diff --git a/cache.h b/cache.h
index 4e25271..8de519a 100644
--- a/cache.h
+++ b/cache.h
@@ -1440,6 +1440,7 @@ extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_key_is_valid(const char *key);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 9fd275f..8adc15a 100644
--- a/config.c
+++ b/config.c
@@ -1848,7 +1848,7 @@ int git_config_set(const char *key, const char *value)
  * baselen - pointer to int which will hold the length of the
  *           section + subsection part, can be NULL
  */
-int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+static int git_config_parse_key_1(const char *key, char **store_key, int *baselen_, int quiet)
 {
 	int i, dot, baselen;
 	const char *last_dot = strrchr(key, '.');
@@ -1859,12 +1859,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
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
 
@@ -1875,7 +1877,8 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	*store_key = xmalloc(strlen(key) + 1);
+	if (store_key)
+		*store_key = xmalloc(strlen(key) + 1);
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
@@ -1886,26 +1889,42 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
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
-		(*store_key)[i] = c;
+		if (store_key)
+			(*store_key)[i] = c;
 	}
-	(*store_key)[i] = 0;
+	if (store_key)
+		(*store_key)[i] = 0;
 
 	return 0;
 
 out_free_ret_1:
-	free(*store_key);
-	*store_key = NULL;
+	if (store_key) {
+		free(*store_key);
+		*store_key = NULL;
+	}
 	return -CONFIG_INVALID_KEY;
 }
 
+int git_config_parse_key(const char *key, char **store_key, int *baselen)
+{
+	return git_config_parse_key_1(key, store_key, baselen, 0);
+}
+
+int git_config_key_is_valid(const char *key)
+{
+	return !git_config_parse_key_1(key, NULL, NULL, 1);
+}
+
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
diff --git a/pager.c b/pager.c
index 070dc11..27d4c8a 100644
--- a/pager.c
+++ b/pager.c
@@ -150,7 +150,8 @@ int check_pager_config(const char *cmd)
 	struct strbuf key = STRBUF_INIT;
 	const char *value = NULL;
 	strbuf_addf(&key, "pager.%s", cmd);
-	if (!git_config_get_value(key.buf, &value)) {
+	if (git_config_key_is_valid(key.buf) &&
+	    !git_config_get_value(key.buf, &value)) {
 		int b = git_config_maybe_bool(key.buf, value);
 		if (b >= 0)
 			want = b;
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
