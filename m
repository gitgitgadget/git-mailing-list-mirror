From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] git-config: do not complain about duplicate entries
Date: Tue, 23 Oct 2012 18:41:00 -0400
Message-ID: <20121023224100.GG17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn9x-0003NM-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755Ab2JWWlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:41:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2JWWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:41:04 -0400
Received: (qmail 23416 invoked by uid 107); 23 Oct 2012 22:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:41:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:41:00 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208268>

If git-config is asked for a single value, it will complain
and exit with an error if it finds multiple instances of
that value. This is unlike the usual internal config
parsing, however, which will generally overwrite previous
values, leaving only the final one. For example:

  [set a multivar]
  $ git config user.email one@example.com
  $ git config --add user.email two@example.com

  [use the internal parser to fetch it]
  $ git var GIT_AUTHOR_IDENT
  Your Name <two@example.com> ...

  [use git-config to fetch it]
  $ git config user.email
  one@example.com
  error: More than one value for the key user.email: two@example.com

This overwriting behavior is critical for the regular
parser, which starts with the lowest-priority file (e.g.,
/etc/gitconfig) and proceeds to the highest-priority file
($GIT_DIR/config). Overwriting yields the highest priority
value at the end.

Git-config solves this problem by implementing its own
parsing. It goes from highest to lowest priorty, but does
not proceed to the next file if it has seen a value.

So in practice, this distinction never mattered much,
because it only triggered for values in the same file. And
there was not much point in doing that; the real value is in
overwriting values from lower-priority files.

However, this changed with the implementation of config
include files. Now we might see an include overriding a
value from the parent file, which is a sensible thing to do,
but git-config will flag as a duplication.

This patch drops the duplicate detection for git-config and
switches to a pure-overwrite model (for the single case;
--get-all can still be used if callers want to do something
more fancy).

As is shown by the modifications to the test suite, this is
a user-visible change in behavior. An alternative would be
to just change the include case, but this is much cleaner
for a few reasons:

  1. If you change the include case, then to what? If you
     just stop parsing includes after getting a value, then
     you will get a _different_ answer than the regular
     config parser (you'll get the first value instead of
     the last value). So you'd want to implement overwrite
     semantics anyway.

  2. Even though it is a change in behavior for git-config,
     it is bringing us in line with what the internal
     parsers already do.

  3. The file-order reimplementation is the only thing
     keeping us from sharing more code with the internal
     config parser, which will help keep differences to a
     minimum.

Going under the assumption that the primary purpose of
git-config is to behave identically to how git's internal
parsing works, this change can be seen as a bug-fix.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c       | 27 +++++++++------------------
 t/t1300-repo-config.sh |  6 ++++--
 t/t9700/test.pl        |  3 +--
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 08e83fc..77efa69 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -107,7 +107,6 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	char value[256];
 	const char *vptr = value;
 	int must_free_vptr = 0;
-	int dup_error = 0;
 	int must_print_delim = 0;
 
 	if (!use_key_regexp && strcmp(key_, key))
@@ -126,8 +125,6 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		strbuf_addstr(buf, key_);
 		must_print_delim = 1;
 	}
-	if (values->nr > 1 && !do_all)
-		dup_error = 1;
 	if (types == TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
 	else if (types == TYPE_BOOL)
@@ -149,16 +146,12 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		vptr = "";
 		must_print_delim = 0;
 	}
-	if (dup_error) {
-		error("More than one value for the key %s: %s",
-				key_, vptr);
-	}
-	else {
-		if (must_print_delim)
-			strbuf_addch(buf, key_delim);
-		strbuf_addstr(buf, vptr);
-		strbuf_addch(buf, term);
-	}
+
+	if (must_print_delim)
+		strbuf_addch(buf, key_delim);
+	strbuf_addstr(buf, vptr);
+	strbuf_addch(buf, term);
+
 	if (must_free_vptr)
 		/* If vptr must be freed, it's a pointer to a
 		 * dynamically allocated buffer, it's safe to cast to
@@ -263,14 +256,12 @@ static int get_value(const char *key_, const char *regex_)
 	if (!do_all && !values.nr && system_wide)
 		git_config_from_file(fn, system_wide, data);
 
-	if (do_all)
-		ret = !values.nr;
-	else
-		ret = (values.nr == 1) ? 0 : values.nr > 1 ? 2 : 1;
+	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
 		struct strbuf *buf = values.items + i;
-		fwrite(buf->buf, 1, buf->len, stdout);
+		if (do_all || i == values.nr - 1)
+			fwrite(buf->buf, 1, buf->len, stdout);
 		strbuf_release(buf);
 	}
 	free(values.items);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 74a297e..8cb45f1 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -252,8 +252,10 @@ test_expect_success 'non-match value' '
 	test wow = $(git config --get nextsection.nonewline !for)
 '
 
-test_expect_success 'ambiguous get' '
-	test_must_fail git config --get nextsection.nonewline
+test_expect_success 'multi-valued get returns final one' '
+	echo "wow2 for me" >expect &&
+	git config --get nextsection.nonewline >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'multi-valued get-all returns all' '
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 3b9b484..0d4e366 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -46,8 +46,7 @@ BEGIN
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
 open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
-eval { $r->config("test.dupstring") };
-ok($@, "config: duplicate entry in scalar context fails");
+is($r->config("test.dupstring"), "value2", "config: multivar");
 eval { $r->config_bool("test.boolother") };
 ok($@, "config_bool: non-boolean values fail");
 open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
-- 
1.8.0.3.g3456896
