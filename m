Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1B01FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163295AbdAITFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:05:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56419 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161689AbdAITFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:05:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53F975E28E;
        Mon,  9 Jan 2017 14:05:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+rz2WM4rwR6wzK+olcD3m8GcbLM=; b=nijzPb
        h7XNuzNJGiEb8Leb29NgAGEorhqR5hTDWxA5wD0IkwQLhnB2nw5Dh6gfYm74Orl+
        YDy2cGccLJCQvM5g9bvHGj/d8RH6b85aP1v6ZMmZlI+nLMu92lbM1NsuAsDOW22e
        VPWg1aLoEO2f73RXeCjh3+yGtX1BsZDDoFYwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0Lvswklj9hPluqxORp7uUIjVmvLF17s
        05fEHC65MDZfNFTkVJW73+tYJXKOtxxtua8sJHkp8HNHq3se2xF4ZJKCd9eXqknR
        hzn2tVyXL20kLUa6+4Y0/WIMMWUT5PxB/n46DuIdF+3kEl5Ji/UvPmplJ5FDU468
        M4lORKbeYRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46D935E28D;
        Mon,  9 Jan 2017 14:05:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A17A25E28C;
        Mon,  9 Jan 2017 14:05:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org,
        sbeller@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere enabled
References: <20170106010945.79382-1-hansenr@google.com>
        <20170109054238.42599-1-hansenr@google.com>
        <20170109054238.42599-14-hansenr@google.com>
        <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 09 Jan 2017 11:05:40 -0800
In-Reply-To: <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 09 Jan 2017 10:12:42 -0800")
Message-ID: <xmqqvatot5ob.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D7D4128-D69E-11E6-8A23-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if it makes more sense to always move to toplevel upfront
> and consistently use path from the toplevel, perhaps like the patch

s/the patch/the attached patch/ I meant.

> does.  The first hunk is what you wrote but only inside MERGE_RR
> block, and the second hunk deals with converting end-user supplied
> paths that are relative to the original relative to the top-level.
>
> The tweaking of $orderfile you have in the first hunk may have to be
> tightened mimicking the way how "eval ... --sq ... ; shift" is used
> in the second hunk to avoid confusion in case orderfile specified by
> the end user happens to be the same as a valid revname
> (e.g. "master").

And here is a squash-able patch to illustrate what I mean.

I removed both of the comment blocks as the code always works with
the worktree-relative pathname after this patch while adjusting
end-user supplied paths from relative to original cwd.  As that is
how the core parts of the system (including the parts written in C)
work, even though an explanation you did in the log message is
needed to explain why the change was needed and what the change
intended to do to readers of "git log", it is not necessary to
explain it to the readers of the latest code, which is what the
in-code comment is about.

The single-liner addition to the test creates a branch whose name is
the same as the specified orderfile to deliberately create a
confusing situation.  I haven't tried, but I am fairly sure that the
test will demonstrate how broken the orderfile=$(...) in the
original is, if you apply the test part of the attached patch,
without the changes to git-mergetool.sh, to your version.


diff --git a/git-mergetool.sh b/git-mergetool.sh
index 22f56c25a2..21f82d5b58 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -454,53 +454,34 @@ main () {
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
+	prefix=$(git rev-parse --show-prefix) || exit 1
+	cd_to_toplevel
+
+	if test -n "$orderfile"
 	then
-		# The pathnames output by the 'git rerere remaining'
-		# command below are relative to the top-level
-		# directory but the 'git diff --name-only' command
-		# further below expects the pathnames to be relative
-		# to the current working directory.  Thus, we cd to
-		# the top-level directory before running 'git diff
-		# --name-only'.  We change directories even earlier
-		# (before running 'git rerere remaining') in case 'git
-		# rerere remaining' is ever changed to output
-		# pathnames relative to the current working directory.
-		#
-		# Changing directories breaks a relative $orderfile
-		# pathname argument, so fix it up to be relative to
-		# the top-level directory.
-
-		prefix=$(git rev-parse --show-prefix) || exit 1
-		cd_to_toplevel
-		if test -n "$orderfile"
-		then
-			orderfile=$(git rev-parse --prefix "$prefix" "$orderfile") || exit 1
-		fi
+		orderfile=$(
+			git rev-parse --prefix "$prefix" -- "$orderfile" |
+			sed -e 1d
+		)
+	fi
 
+	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
+	then
 		set -- $(git rerere remaining)
 		if test $# -eq 0
 		then
 			print_noop_and_exit
 		fi
+	elif test $# -ge 0
+	then
+		eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
+		shift
 	fi
 
-	# Note:  The pathnames output by 'git diff --name-only' are
-	# relative to the top-level directory, but it expects input
-	# pathnames to be relative to the current working directory.
-	# Thus:
-	#   * Either cd_to_toplevel must not be run before this or all
-	#     relative input pathnames must be converted to be
-	#     relative to the top-level directory (or absolute).
-	#   * Either cd_to_toplevel must be run after this or all
-	#     relative output pathnames must be converted to be
-	#     relative to the current working directory (or absolute).
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
 		${orderfile:+"-O$orderfile"} -- "$@")
 
-	cd_to_toplevel
-
 	if test -z "$files"
 	then
 		print_noop_and_exit
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index dfd641d34b..180dd7057a 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -678,6 +678,11 @@ test_expect_success 'diff.orderFile configuration is honored' '
 		b
 		a
 	EOF
+
+	# make sure "order-file" that is ambiguous between
+	# rev and path is understood correctly.
+	git branch order-file HEAD &&
+
 	git mergetool --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
 	test_cmp expect actual
