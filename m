From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Mon, 31 Aug 2009 00:27:25 -0400
Message-ID: <20090831042724.GA16646@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
 <20090830095509.GB30922@coredump.intra.peff.net>
 <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 06:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhyVW-0002Zz-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 06:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbZHaE12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 00:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZHaE11
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 00:27:27 -0400
Received: from peff.net ([208.65.91.99]:41969 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbZHaE11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 00:27:27 -0400
Received: (qmail 20725 invoked by uid 107); 31 Aug 2009 04:27:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 00:27:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 00:27:25 -0400
Content-Disposition: inline
In-Reply-To: <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127457>

On Sun, Aug 30, 2009 at 01:01:11PM -0700, Junio C Hamano wrote:

> > And all of this while they are trying to quickly switch contexts to
> > whatever it was that caused them to stash in the first place.
> 
> Ok, then probably the "how about" patch would be a part of the right
> solution.

And then something like this on top (assuming you cut the change to
git-stash.sh from yours).

My concerns are:

  - "-f" is kind of vague. Would people expect it to force aspects of
    the stash? Should it be "--intent-as-empty"?

  - the error message is still a bit muddled, because you get the "not
    yet added" files _first_, then some failure cruft from write-tree,
    and _then_ the trying-to-be-helpful message

I dunno. Honestly I am a bit lukewarm about this whole thing, as it
seems like something that just wouldn't come up that often, and while
the current error message is a bit disorganized, I think a user who has
used "git add -N" can figure out that it is related (the only report we
have is from Yann, who _did_ figure it out, but wanted to know how to
make git handle the situation better).

diff --git a/git-stash.sh b/git-stash.sh
index d61c9d0..963cad0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -20,6 +20,7 @@ TMP="$GIT_DIR/.git-stash.$$"
 trap 'rm -f "$TMP-*"' 0
 
 ref_stash=refs/stash
+force=
 
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
@@ -63,7 +64,14 @@ create_stash () {
 	msg=$(printf '%s: %s' "$branch" "$head")
 
 	# state of the index
-	i_tree=$(git write-tree) &&
+	if ! i_tree=$(git write-tree ${force:+--intent-as-empty}); then
+		case "$force" in
+		t) die 'Cannot save the current index state';;
+		*) echo >&2 'fatal: unable to create tree; if some files are marked as'
+		   echo >&2 '"not added yet", you may override with "git stash save -f"'
+		   exit 1
+		esac
+	fi
 	i_commit=$(printf 'index on %s\n' "$msg" |
 		git commit-tree $i_tree -p $b_commit) ||
 		die "Cannot save the current index state"
@@ -104,6 +112,9 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		-f|--force)
+			force=t
+			;;
 		*)
 			break
 			;;
diff --git a/t/t3904-stash-intent.sh b/t/t3904-stash-intent.sh
new file mode 100755
index 0000000..ec7dd12
--- /dev/null
+++ b/t/t3904-stash-intent.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='stash with intent-to-add index entries'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo content >base &&
+	git add base &&
+	git commit -m base &&
+	echo foo content >foo &&
+	echo bar content >bar &&
+	git add foo &&
+	git add -N bar
+'
+
+test_expect_success 'stash save refuses intent-to-add entry' '
+	test_must_fail git stash save
+'
+
+test_expect_success 'stash save -f allows intent-to-add' '
+	git stash save -f &&
+	git show stash^2:foo >foo.stash &&
+	echo foo content >expect &&
+	test_cmp expect foo.stash &&
+	>expect &&
+	git show stash^2:bar >bar.stash &&
+	test_cmp expect bar.stash
+'
+
+test_done
