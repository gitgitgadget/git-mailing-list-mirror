From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] refs: support negative transfer.hideRefs
Date: Tue, 28 Jul 2015 16:23:26 -0400
Message-ID: <20150728202326.GA14916@peff.net>
References: <20150728195747.GA13596@peff.net>
 <20150728195934.GB13795@peff.net>
 <xmqqwpxkca4o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBPS-0004tF-JL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbG1UX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:23:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752572AbbG1UX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:23:29 -0400
Received: (qmail 2220 invoked by uid 102); 28 Jul 2015 20:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 15:23:28 -0500
Received: (qmail 20709 invoked by uid 107); 28 Jul 2015 20:23:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 16:23:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jul 2015 16:23:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpxkca4o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274837>

On Tue, Jul 28, 2015 at 01:14:47PM -0700, Junio C Hamano wrote:

> I notice that the only time you said that you chose '!' prefix as
> the way to express this new "negative" is as a side note to the
> rejected second variant ;-).  The first paragraph would have been a
> good place to say that, because the first thing I wondered after
> reading three lines (including the subject) into the log was "ok, it
> makes sense and I know what alternatives were considered and
> discarded for what reasons without reading the rest, now did he use
> prefix '-', prefix '~', prefix '^', or prefix '!' for the new
> syntax, or did he use something else?"

Yeah, I agree it should come earlier, probably as an example. Below is a
re-roll. I also realized I do not explicitly test that mixing and
matching transfer.* and uploadpack.* works (they should override each
other as if they are part of the same list). It does work, and the
re-roll below has an extra test.

> It would have been very nice if you chose an invalid ref character
> as the negative prefix, and unfortunately '!', which would also have
> been my first choice for this prefix, is not an invalid character,
> which is a bit sad.

Yeah, I considered "^" for that reason, but IMHO it doesn't _quite_ mean
negation. Here "!" means the same thing as it does in .gitignore and
elsewhere. And since the refs are fully qualified, I think it is
effectively invalid (we do not look at "$GIT_DIR/!refs/" in the ref
advertisement, after all).

-- >8 --
Subject: refs: support negative transfer.hideRefs

If you hide a hierarchy of refs using the transfer.hideRefs
config, there is no way to later override that config to
"unhide" it. This patch implements a "negative" hide which
causes matches to immediately be marked as unhidden, even if
another match would hide it. We take care to apply the
matches in reverse-order from how they are fed to us by the
config machinery, as that lets our usual "last one wins"
config precedence work (and entries in .git/config, for
example, will override /etc/gitconfig).

So you can now do:

  $ git config --system transfer.hideRefs refs/secret
  $ git config transfer.hideRefs '!refs/secret/not-so-secret'

to hide refs/secret in all repos, except for one public bit
in one specific repo. Or you can even do:

  $ git clone \
      -u "git -c transfer.hiderefs="!refs/foo" upload-pack" \
      remote:repo.git

to clone remote:repo.git, overriding any hiding it has
configured.

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
 t/t5512-ls-remote.sh     | 22 ++++++++++++++++++++++
 3 files changed, 40 insertions(+), 5 deletions(-)

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
index 3bd9759..afde495 100755
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
@@ -138,6 +143,23 @@ do
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
 
+test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs' '
+	test_config uploadpack.hiderefs refs/tags &&
+	test_config transfer.hiderefs "!refs/tags/magic" &&
+	git ls-remote . >actual &&
+	verbose grep refs/tags/magic actual
+'
+
 test_done
-- 
2.5.0.rc3.557.g17a1555
