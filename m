Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC2DC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BD320782
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgKXJGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:06:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:39998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgKXJGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 04:06:06 -0500
Received: (qmail 1194 invoked by uid 109); 24 Nov 2020 09:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 09:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12903 invoked by uid 111); 24 Nov 2020 09:06:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 04:06:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 04:06:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] submodule: fix fetch_in_submodule logic
Message-ID: <X7zM/d1CVuyCstZo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a fix on top of ab/retire-parse-remote, which is now in next. I
think submodule fetching is pretty broken, so we should do this or
something like it soon.

-- >8 --
Commit 1c1518071c (submodule: use "fetch" logic instead of custom remote
discovery, 2020-11-14) rewrote the logic in fetch_in_submodule to do:

  elif test "$2" -ne ""

But this is nonsense in shell: -ne is for numeric comparisons. This
should be "=" or more idiomatically:

  elif test -n "$2"

But once we fix that, many tests start failing. Because that commit
introduced another problem. The caller that passes 3 arguments looks
like this:

    fetch_in_submodule "$sm_path" $depth "$sha1"

Note the unquoted $depth parameter. When it isn't set, the function will
see only 2 arguments, and the function has no idea if what it sees in $2
is an option to go on the command line, or a refspec to pass on stdin.
In the old code before that commit:

   fetch_in_submodule () (
        sanitize_submodule_env &&
        cd "$1" &&
  -     case "$2" in
  -     '')
  -             git fetch ;;
  -     *)
  -             shift
  -             git fetch $(get_default_remote) "$@" ;;
  -     esac

we treated those the same, so it didn't matter. But in the new logic
(with my fix above):

  +     if test $# -eq 3
  +     then
  +             echo "$3" | git fetch --stdin "$2"
  +     elif test -n "$n"
  +     then
  +             git fetch "$2"
  +     else
  +             git fetch
  +     fi

we use the number of parameters to distinguish the two. Let's insist
that the caller pass an empty string for positional parameter two if
they want to have a third parameter after it.

But that still leaves one problem. In the --stdin block, we
unconditionally pass "$2" to git-fetch, even if it's the empty string.
Rather than add another conditional, we can use :+ parameter expansion
to include it only if it's non-empty. In fact, we can do the same for
the elif, too, simplifying it further. Technically this is overkill,
since we know the --depth parameter will not have whitespace (and
indeed, most callers do not bother quoting it), but it doesn't hurt for
the function to be careful.

It's somewhat amazing that no tests were failing. I think what happened
is that:

  - the 3-arg form rarely triggered; any call with a non-empty $depth
    and a $sha1 would work, but one with an empty $depth would only have
    2 arguments

  - because of the wrong arguments to "test", the shell would complain
    and exit non-zero. So we never ran the middle conditional at all

  - that left every call running "git fetch" with no arguments. A
    well-written test could have detected the distinction here, but in
    practice omitting --depth just means fetching more commits, and
    fetching everything (rather than a single sha1) works as long as the
    commit in question is reachable

Signed-off-by: Jeff King <peff@peff.net>
---
A few side notes:

  - I imagine the mixup between "ne" and "=" is because they have the
    opposite meaning in perl. :)

  - it probably wouldn't hurt to beef up the tests, especially around
    fetching an unreachable sha1, but after getting lost for an hour in
    the spaghetti of the submodule code and its tests, I gave up. I do
    at least feel this code is being exercised (because once the initial
    problem is fixed, tons of things fail).

 git-submodule.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 86ad60c05c..eb90f18229 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -412,17 +412,17 @@ is_tip_reachable () (
 	test -z "$rev"
 )
 
+# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
+# Because arguments are positional, use an empty string to omit <depth>
+# but include <sha1>.
 fetch_in_submodule () (
 	sanitize_submodule_env &&
 	cd "$1" &&
 	if test $# -eq 3
 	then
-		echo "$3" | git fetch --stdin "$2"
-	elif test "$2" -ne ""
-	then
-		git fetch "$2"
+		echo "$3" | git fetch --stdin ${2:+"$2"}
 	else
-		git fetch
+		git fetch ${2:+"$2"}
 	fi
 )
 
@@ -603,7 +603,7 @@ cmd_update()
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
 				is_tip_reachable "$sm_path" "$sha1" ||
-				fetch_in_submodule "$sm_path" $depth "$sha1" ||
+				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
 				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
-- 
2.29.2.784.g3af989cc94
