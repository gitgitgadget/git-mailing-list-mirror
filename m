From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] refs: support negative transfer.hideRefs
Date: Tue, 28 Jul 2015 15:59:34 -0400
Message-ID: <20150728195934.GB13795@peff.net>
References: <20150728195747.GA13596@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 21:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB2P-0004fc-TL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbbG1T7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:59:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:35982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbbG1T7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:59:36 -0400
Received: (qmail 32417 invoked by uid 102); 28 Jul 2015 19:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 14:59:36 -0500
Received: (qmail 20382 invoked by uid 107); 28 Jul 2015 19:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 15:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jul 2015 15:59:34 -0400
Content-Disposition: inline
In-Reply-To: <20150728195747.GA13596@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274826>

If you hide a hierarchy of refs using the transfer.hideRefs
config, there is no way to later override that config to
"unhide" it. This patch implements a "negative" hide which
causes matches to immediately be marked as unhidden, even if
another match would hide it. We take care to apply the
matches in reverse-order from how they are fed to us by the
config machinery, as that lets our usual "last one wins"
config precedence work (and entries in .git/config, for
example, will override /etc/gitconfig).

There are two alternatives that were considered and
rejected:

  1. A generic config mechanism for removing an item from a
     list. E.g.: (e.g., "[transfer] hideRefs -= refs/foo").

     This is nice because it could apply to other
     multi-valued config, as well. But it is not nearly as
     flexible. There is no way to say:

       [transfer]
       hideRefs = refs/secret
       hideRefs = refs/secret/not-so-secret

     Having explicit negative specifications means we can
     override previous entries, even if they are not the
     same literal string.

  2. Adding another variable to override some parts of
     hideRefs (e.g., "exposeRefs").

     This solves the problem from alternative (1), but it
     cannot easily obey the normal config precedence,
     because it would use two separate lists. For example:

       [transfer]
       hideRefs = refs/secret
       exposeRefs = refs/secret/not-so-secret
       hideRefs = refs/secret/not-so-secret/no-really-its-secret

     With two lists, we have to apply the "expose" rules
     first, and only then apply the "hide" rules. But that
     does not match what the above config intends.

     Of course we could internally parse that to a single
     list, respecting the ordering, which saves us having to
     invent the new "!" syntax. But using a single name
     communicates to the user that the ordering _is_
     important. And "!" is well-known for negation, and
     should not appear at the beginning of a ref (it is
     actually valid in a ref-name, but all entries here
     should be fully-qualified, starting with "refs/").

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  5 +++++
 refs.c                   | 18 +++++++++++++-----
 t/t5512-ls-remote.sh     | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 448eb9d..a7fbd0a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2540,6 +2540,11 @@ transfer.hideRefs::
 	excluded, and is hidden when responding to `git push` or `git
 	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
 	program-specific versions of this config.
++
+You may also include a `!` in front of the ref name to negate the entry,
+explicitly exposing it, even if an earlier entry marked it as hidden.
+If you have multiple hideRefs values, later entries override earlier ones
+(and entries in more-specific config files override less-specific ones).
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
diff --git a/refs.c b/refs.c
index 7ac05cf..68f2cb0 100644
--- a/refs.c
+++ b/refs.c
@@ -4159,17 +4159,25 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 
 int ref_is_hidden(const char *refname)
 {
-	struct string_list_item *item;
+	int i;
 
 	if (!hide_refs)
 		return 0;
-	for_each_string_list_item(item, hide_refs) {
+	for (i = hide_refs->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs->items[i].string;
+		int neg = 0;
 		int len;
-		if (!starts_with(refname, item->string))
+
+		if (*match == '!') {
+			neg = 1;
+			match++;
+		}
+
+		if (!starts_with(refname, match))
 			continue;
-		len = strlen(item->string);
+		len = strlen(match);
 		if (!refname[len] || refname[len] == '/')
-			return 1;
+			return !neg;
 	}
 	return 0;
 }
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3bd9759..728a1dc 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -128,6 +128,11 @@ test_expect_success 'Report match with --exit-code' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up some extra tags for ref hiding' '
+	git tag magic/one &&
+	git tag magic/two
+'
+
 for configsection in transfer uploadpack
 do
 	test_expect_success "Hide some refs with $configsection.hiderefs" '
@@ -138,6 +143,16 @@ do
 		sed -e "/	refs\/tags\//d" >expect &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "Override hiding of $configsection.hiderefs" '
+		test_when_finished "test_unconfig $configsection.hiderefs" &&
+		git config --add $configsection.hiderefs refs/tags &&
+		git config --add $configsection.hiderefs "!refs/tags/magic" &&
+		git config --add $configsection.hiderefs refs/tags/magic/one &&
+		git ls-remote . >actual &&
+		verbose grep refs/tags/magic/two actual
+	'
+
 done
 
 test_done
-- 
2.5.0.rc3.557.g17a1555
