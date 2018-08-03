Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5941F597
	for <e@80x24.org>; Fri,  3 Aug 2018 20:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeHCWuB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 18:50:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:42288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728139AbeHCWuB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 18:50:01 -0400
Received: (qmail 21941 invoked by uid 109); 3 Aug 2018 20:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 20:52:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8319 invoked by uid 111); 3 Aug 2018 20:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 16:52:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 16:52:05 -0400
Date:   Fri, 3 Aug 2018 16:52:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add a script to diff rendered documentation
Message-ID: <20180803205204.GA3790@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After making a change to the documentation, it's easy to
forget to check the rendered version to make sure it was
formatted as you intended. And simply doing a diff between
the two built versions is less trivial than you might hope:

  - diffing the roff or html output isn't particularly
    readable; what we really care about is what the end user
    will see

  - you have to tweak a few build variables to avoid
    spurious differences (e.g., version numbers, build
    times)

Let's provide a script that builds and installs the manpages
for two commits, renders the results using "man", and diffs
the result. Since this is time-consuming, we'll also do our
best to avoid repeated work, keeping intermediate results
between runs.

Some of this could probably be made a little less ugly if we
built support into Documentation/Makefile. But by relying
only on "make install-man" working, this script should work
for generating a diff between any two versions, whether they
include this script or not.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote this up for my own use after our discussion in [1]. I'm not sure
if it's too ugly for inclusion, or if it might be helpful to others.
I've only just written it, but my plan is to try to run it on anything I
submit to check the formatting. So it _seems_ useful and appears to
work, but only after a few minutes of playing with it. :)

[1] https://public-inbox.org/git/20180720223608.GE18502@genre.crustytoothpaste.net/

 Documentation/.gitignore |   1 +
 Documentation/doc-diff   | 100 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100755 Documentation/doc-diff

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index c7096f11f1..3ef54e0adb 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -12,3 +12,4 @@ cmds-*.txt
 mergetools-*.txt
 manpage-base-url.xsl
 SubmittingPatches.txt
+tmp-doc-diff/
diff --git a/Documentation/doc-diff b/Documentation/doc-diff
new file mode 100755
index 0000000000..61deb2579e
--- /dev/null
+++ b/Documentation/doc-diff
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+OPTIONS_SPEC="\
+doc-diff <from> <to> [-- diff options]
+--
+j	parallel argument to pass to make
+f	force rebuild; do not rely on cached results
+"
+SUBDIRECTORY_OK=1
+. "$(git --exec-path)/git-sh-setup"
+
+parallel=8
+force=
+while test $# -gt 0
+do
+	case "$1" in
+	-j)
+		parallel=${1#-j} ;;
+	-f)
+		force=t ;;
+	--)
+		shift; break ;;
+	*)
+		usage ;;
+	esac
+	shift
+done
+
+test $# -gt 1 || usage
+from=$1; shift
+to=$1; shift
+
+from_oid=$(git rev-parse --verify "$from") || exit 1
+to_oid=$(git rev-parse --verify "$to") || exit 1
+
+cd_to_toplevel
+tmp=Documentation/tmp-doc-diff
+
+if test -n "$force"
+then
+	rm -rf "$tmp"
+fi
+
+# We'll do both builds in a single worktree, which lets make reuse
+# results that don't differ between the two trees.
+if ! test -d "$tmp/worktree"
+then
+	git worktree add --detach "$tmp/worktree" "$from" &&
+	dots=$(echo "$tmp/worktree" | sed 's#[^/]*#..#g') &&
+	ln -s "$dots/config.mak" "$tmp/worktree/config.mak"
+fi
+
+# generate_render_makefile <srcdir> <dstdir>
+generate_render_makefile () {
+	find "$1" -type f |
+	while read src
+	do
+		dst=$2/${src#$1/}
+		printf 'all:: %s\n' "$dst"
+		printf '%s: %s\n' "$dst" "$src"
+		printf '\t@echo >&2 "  RENDER $(notdir $@)" && \\\n'
+		printf '\tmkdir -p $(dir $@) && \\\n'
+		printf '\tMANWIDTH=80 man -l $< >$@+ && \\\n'
+		printf '\tmv $@+ $@\n'
+	done
+}
+
+# render_tree <dirname> <committish>
+render_tree () {
+	# Skip install-man entirely if we already have an installed directory.
+	# We can't rely on make here, since "install-man" unconditionally
+	# copies the files (spending effort, but also updating timestamps that
+	# we then can't rely on during the render step). We use "mv" to make
+	# sure we don't get confused by a previous run that failed partway
+	# through.
+	if ! test -d "$tmp/installed/$1"
+	then
+		git -C "$tmp/worktree" checkout "$2" &&
+		make -j$parallel -C "$tmp/worktree" \
+			GIT_VERSION=omitted \
+			SOURCE_DATE_EPOCH=0 \
+			DESTDIR="$PWD/$tmp/installed/$1+" \
+			install-man &&
+		mv "$tmp/installed/$1+" "$tmp/installed/$1"
+	fi &&
+
+	# As with "installed" above, we skip the render if it's already been
+	# done.  So using make here is primarily just about running in
+	# parallel.
+	if ! test -d "$tmp/rendered/$1"
+	then
+		generate_render_makefile "$tmp/installed/$1" "$tmp/rendered/$1+" |
+		make -j$parallel -f - &&
+		mv "$tmp/rendered/$1+" "$tmp/rendered/$1"
+	fi
+}
+
+render_tree $from_oid "$from" &&
+render_tree $to_oid "$to" &&
+git -C $tmp/rendered diff --no-index "$@" $from_oid $to_oid
-- 
2.18.0.912.g3ccaa4d859
