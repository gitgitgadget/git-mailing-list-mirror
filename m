From: Jeff King <peff@peff.net>
Subject: [PATCH] config: teach "git -c" to recognize an empty string
Date: Mon, 4 Aug 2014 17:56:44 -0400
Message-ID: <20140804215644.GA21510@peff.net>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
 <vpqmwbki7h3.fsf@anie.imag.fr>
 <20140804203351.GA12898@peff.net>
 <vpqtx5s7yo4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 04 23:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEQFP-0004UB-U0
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 23:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbaHDV4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 17:56:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:45886 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752723AbaHDV4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 17:56:47 -0400
Received: (qmail 30298 invoked by uid 102); 4 Aug 2014 21:56:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Aug 2014 16:56:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Aug 2014 17:56:44 -0400
Content-Disposition: inline
In-Reply-To: <vpqtx5s7yo4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254788>

On Mon, Aug 04, 2014 at 11:06:03PM +0200, Matthieu Moy wrote:

> > Hmm. Not related to the original patch, but that really looks like a
> > bug. Shouldn't "git -c pretty.my= ..." set pretty.my to the empty string?
> >
> > I'd expect "git -c pretty.my ..." to set it to NULL (i.e., the "implicit
> > true" you get from omitting the "=" in the config files themselves).
> 
> Indeed.
> 
> strbuf_split_buf() does not seem to distinguish between x= and x. No
> time to debug this further, sorry.

Oh, I didn't expect you to work on it. The bug is totally my fault. :)
Your email just made me realize it was there.

Here's a patch to fix it.

-- >8 --
Subject: config: teach "git -c" to recognize an empty string

In a config file, you can do:

  [foo]
  bar

to turn the "foo.bar" boolean flag on, and you can do:

  [foo]
  bar=

to set "foo.bar" to the empty string. However, git's "-c"
parameter treats both:

  git -c foo.bar

and

  git -c foo.bar=

as the boolean flag, and there is no way to set a variable
to the empty string. This patch enables the latter form to
do that.

Signed-off-by: Jeff King <peff@peff.net>
---
This is technically a backwards incompatibility, but I'd consider it a
simple bugfix. The existing behavior was unintentional, made no sense,
and was never documented.

Looking over strbuf_split's interface, I think it's rather
counter-intuitive, and I was tempted to change it. But there are several
other callers that rely on it, and the chance for introducing a subtle
bug is high. This is the least invasive fix (and it really is not any
less readable than what was already there :) ).

 Documentation/git.txt  |  5 +++++
 config.c               | 12 ++++++++++--
 t/t1300-repo-config.sh | 11 +++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1c4f7a..e7783f0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -447,6 +447,11 @@ example the following invocations are equivalent:
 	given will override values from configuration files.
 	The <name> is expected in the same format as listed by
 	'git config' (subkeys separated by dots).
++
+Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
+`foo.bar` to the boolean true value (just like `[foo]bar` would in a
+config file). Including the equals but with an empty value (like `git -c
+foo.bar= ...`) sets `foo.bar` to the empty string.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
diff --git a/config.c b/config.c
index 058505c..fe6216f 100644
--- a/config.c
+++ b/config.c
@@ -162,19 +162,27 @@ void git_config_push_parameter(const char *text)
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
+	const char *value;
 	struct strbuf **pair;
+
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
 		return error("bogus config parameter: %s", text);
-	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=')
+
+	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
 		strbuf_setlen(pair[0], pair[0]->len - 1);
+		value = pair[1] ? pair[1]->buf : "";
+	} else
+		value = NULL;
+
 	strbuf_trim(pair[0]);
 	if (!pair[0]->len) {
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
+
 	strbuf_tolower(pair[0]);
-	if (fn(pair[0]->buf, pair[1] ? pair[1]->buf : NULL, data) < 0) {
+	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
 	}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3f80ff0..46f6ae2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1010,6 +1010,17 @@ test_expect_success 'git -c "key=value" support' '
 	test_must_fail git -c name=value config core.name
 '
 
+# We just need a type-specifier here that cares about the
+# distinction internally between a NULL boolean and a real
+# string (because most of git's internal parsers do care).
+# Using "--path" works, but we do not otherwise care about
+# its semantics.
+test_expect_success 'git -c can represent empty string' '
+	echo >expect &&
+	git -c foo.empty= config --path foo.empty >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'key sanity-checking' '
 	test_must_fail git config foo=bar &&
 	test_must_fail git config foo=.bar &&
-- 
2.1.0.rc0.286.g5c67d74
