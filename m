Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC331FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422829AbdAISMu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:12:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932317AbdAISMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:12:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC2415D1E1;
        Mon,  9 Jan 2017 13:12:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gsKVesToe/HesdPRuzPAipv5bFo=; b=MJp4Sf
        lQumgZXnWc43AgS40J7Tw160PnjH5NK5QBT/oggJUUE54rT4okSzuA8RwTbsfukb
        9Mp0dqKp+/4opNGmyw2o7Qgxv63VBZr8UspRUMCJBWrfSDKdz4PVD3hsqFnJlu6W
        bQPfmkNSwG3kR1d9nMeUZ81CaNSpYdbF0SAHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZPLZxCRJ1WOUVOaTcQAqzr3249I64pi2
        qtid+BM33XqToskx2GpxgtVO73ZKbgd4MkRu9xuKemMMp8aXrnwJP5ujLIVNFNU3
        RvL9qUjJGwyktfmn2uXDu93Pyaryesc8AZmzbKEKBxoP1V71UL25wJIlGEFullwQ
        92OjGi9xGdE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEF225D1E0;
        Mon,  9 Jan 2017 13:12:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D0B75D1DF;
        Mon,  9 Jan 2017 13:12:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, j6t@kdbg.org,
        sbeller@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 13/13] mergetool: fix running in subdir when rerere enabled
References: <20170106010945.79382-1-hansenr@google.com>
        <20170109054238.42599-1-hansenr@google.com>
        <20170109054238.42599-14-hansenr@google.com>
Date:   Mon, 09 Jan 2017 10:12:42 -0800
In-Reply-To: <20170109054238.42599-14-hansenr@google.com> (Richard Hansen's
        message of "Mon, 9 Jan 2017 00:42:38 -0500")
Message-ID: <xmqq4m18ump1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3785D9C2-D697-11E6-A6E7-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

> If rerere is enabled and no pathnames are given, run cd_to_toplevel
> before running 'git diff --name-only' so that 'git diff --name-only'
> sees the files named by 'git rerere remaining', which outputs
> pathnames relative to the top-level directory.
>
> The cd_to_toplevel command could be run after 'git rerere remaining',
> but it is run before just in case 'git rerere remaining' is ever
> changed to print pathnames relative to the current working directory
> rather than relative to the top-level directory.
>
> An alternative approach would be to unconditionally convert all
> relative pathnames (including the orderfile pathname) to be relative
> to the top-level directory and then run cd_to_toplevel before 'git
> diff --name-only', but unfortunately 'git rev-parse --prefix' requires
> valid pathnames, which would break some valid use cases.
>
> This fixes a regression introduced in
> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>
> Signed-off-by: Richard Hansen <hansenr@google.com>
> ---
>  git-mergetool.sh     | 32 ++++++++++++++++++++++++++++++++
>  t/t7610-mergetool.sh |  2 +-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index b506896dc..22f56c25a 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -456,6 +456,28 @@ main () {
>  

While doing the extra cd_to_toplevel added by this patch may not
break anything that comes after the existing cd_to_toplevel, I find
the result of applying this patch unnecessarily confusing.  As "if
the user didn't give any pathnames from the command line, ask rerere
what paths it thinks are necessary to be handled" is merely a
laziness fallback, it feels conceptually wrong to use different
invocations of -O$orderfile when rerere is and is not in effect.

I wonder if it makes more sense to always move to toplevel upfront
and consistently use path from the toplevel, perhaps like the patch
does.  The first hunk is what you wrote but only inside MERGE_RR
block, and the second hunk deals with converting end-user supplied
paths that are relative to the original relative to the top-level.

The tweaking of $orderfile you have in the first hunk may have to be
tightened mimicking the way how "eval ... --sq ... ; shift" is used
in the second hunk to avoid confusion in case orderfile specified by
the end user happens to be the same as a valid revname
(e.g. "master").


diff --git a/git-mergetool.sh b/git-mergetool.sh
index b506896dc1..adbbeceb47 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -454,6 +454,14 @@ main () {
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
+	prefix=$(git rev-parse --show-prefix) || exit 1
+	cd_to_toplevel
+
+	if test -n "$orderfile"
+	then
+		orderfile=$(git rev-parse --prefix "$prefix" "$orderfile") || exit 1
+	fi
+
 	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
 	then
 		set -- $(git rerere remaining)
@@ -461,14 +469,16 @@ main () {
 		then
 			print_noop_and_exit
 		fi
+	elif test $# -ge 0
+	then
+		eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
+		shift
 	fi
 
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
 		${orderfile:+"-O$orderfile"} -- "$@")
 
-	cd_to_toplevel
-
 	if test -z "$files"
 	then
 		print_noop_and_exit
