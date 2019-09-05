Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAC51F461
	for <e@80x24.org>; Thu,  5 Sep 2019 06:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfIEGE3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:04:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:40062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfIEGE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:04:28 -0400
Received: (qmail 24492 invoked by uid 109); 5 Sep 2019 06:04:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 06:04:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24219 invoked by uid 111); 5 Sep 2019 06:06:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 02:06:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 02:04:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] contrib/git-jump: support alias expansion
Message-ID: <20190905060427.GA21450@sigill.intra.peff.net>
References: <cover.1567619579.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567619579.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 01:55:00PM -0400, Taylor Blau wrote:

> I often find myself parsing the output of 'git diff' (which I spell 'g
> di') in less, and then wanting to jump to some specific diff in a file,
> i.e., by running 'git jump diff -- <filename>'.
> 
> But, I am so used to typing 'di' instead of 'diff', that I often write
> the later invocation as 'g jump di -- <filename>', and 'git-jump'
> complains that it doesn't know what 'di' means.

Hmm. I'm not exactly _opposed_ to this patch, but it does feel like it's
weirdly conflating git commands with jump modes. Which just happen to
use some of the same verbs, but not not always (e.g., "mode_ws").

And as you note, aliases may carry along options which do not make any
sense for jump modes (or they might; we pass command-line options to
diff and grep, so it's possible the alias could do something useful).

Your case would be equally helped if the tool allowed any non-ambiguous
prefix to be used. But it wouldn't if somebody had "alias.foo = diff" or
something. So I dunno.

I solved this for myself long ago with a mix of git and shell aliases:

  $ git help vgrep
  'vgrep' is aliased to 'jump grep'
  
  $ type d
  d is aliased to `git jump diff'
  
  $ type m
  m is aliased to `git jump merge'

For fun, here's a patch that does the prefix thing (though the $0
hackery may be too much; we list the modes by hand in the usage, after
all).

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 931b0fe3a9..c2a092806e 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -64,15 +64,35 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+list_modes() {
+	perl -lne '/^mode_([a-z]+)[ (]/ and print $1' "$0"
+}
+
 if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
 mode=$1; shift
 
+if ! type "mode_$mode" >/dev/null 2>&1; then
+	found=
+	for i in $(list_modes | grep "^$mode"); do
+		if test -n "$found"; then
+			echo >&2 "ambiguous mode: $mode (matches $found and $i)"
+			exit 1
+		fi
+		found=$i
+	done
+	if test -n "$found"; then
+		mode=$found
+	else
+		usage >&2
+		exit 1
+	fi
+fi
+
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
 open_editor "$tmp"
