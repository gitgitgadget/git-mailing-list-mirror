Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02BB20248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCUW67 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:58:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63163 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUW67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:58:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x2LMwtFk077079
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 18:58:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFC] git stash --snapshot
Date:   Thu, 21 Mar 2019 18:58:47 -0400
Message-ID: <002101d4e039$a7cd8a10$f7689e30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdTgN9J4WhLeuAq7Rk2YEnzueIN6+A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About two weeks ago there was a discussion about building an undo stack. 
https://public-inbox.org/git/000401d4d6c8$f68bb020$e3a31060$@nexbridge.com/

it had me thinking about whether a stash --snapshot might be useful. Below
is a conceptual change - by no means even close to complete. This would
allow scripting to wrap critical commands with a "git stash push --snapshot"
without changing the working directory. For symmetry, a "git stash pop
--force" is needed if --include-untracked were used to stash everything in
the first place. It might be more useful also to wait until stash is
converted to C, I suppose. I'm wondering whether to pursue this or drop it.
Thoughts? (and I beg forgiveness for what my mailer might do to the wrapping
of this patch, and I already know the indent is wrong between 329 and 370,
and that the granularity of the --force option is wrong).

diff --git a/git-stash.sh b/git-stash.sh
index 789ce2f41d..7741192980 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -5,12 +5,13 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="list [<options>]
    or: $dashless show [<stash>]
    or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [-f|--force]
[<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
                      [-u|--include-untracked] [-a|--all] [<message>]
    or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
                       [-u|--include-untracked] [-a|--all] [-m <message>]
+                      [--snapshot]
                       [-- <pathspec>...]]
    or: $dashless clear"

@@ -252,6 +253,7 @@ push_stash () {
        patch_mode=
        untracked=
        stash_msg=
+       snapshot=
        while test $# != 0
        do
                case "$1" in
@@ -286,6 +288,9 @@ push_stash () {
                --message=*)
                        stash_msg=${1#--message=}
                        ;;
+               --snapshot)
+                       snapshot=t
+                       ;;
                --help)
                        show_help
                        ;;
@@ -329,6 +334,8 @@ push_stash () {
        die "$(gettext "Cannot save the current status")"
        say "$(eval_gettext "Saved working directory and index state
\$stash_msg")"

+       if test -z "$snapshot"
+       then
        if test -z "$patch_mode"
        then
                test "$untracked" = "all" && CLEAN_X_OPTION=-x ||
CLEAN_X_OPTION=
@@ -363,6 +370,7 @@ push_stash () {
                        git reset -q -- "$@"
                fi
        fi
+       fi
 }

 save_stash () {
@@ -490,6 +498,7 @@ parse_flags_and_rev()

        FLAGS=
        REV=
+       FORCE_OPTION=
        for opt
        do
                case "$opt" in
@@ -499,6 +508,9 @@ parse_flags_and_rev()
                        --index)
                                INDEX_OPTION=--index
                        ;;
+                       -f|--force)
+                               FORCE_OPTION=--force
+                       ;;
                        --help)
                                show_help
                        ;;
@@ -607,7 +619,7 @@ apply_stash () {
        if test -n "$u_tree"
        then
                GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
-               GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
+               GIT_INDEX_FILE="$TMPindex" git checkout-index --all
$FORCE_OPTION &&
                rm -f "$TMPindex" ||
                die "$(gettext "Could not restore untracked files from stash
entry")"
        fi
@@ -688,7 +700,7 @@ apply_to_branch () {
        set -- --index "$@"
        assert_stash_like "$@"

-       git checkout -b $branch $REV^ &&
+       git checkout -b $branch $FORCE_OPTION $REV^ &&
        apply_stash "$@" && {
                test -z "$IS_STASH_REF" || drop_stash "$@"
        }

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



