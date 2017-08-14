Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D789020899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdHNTvg (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:51:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64509 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750896AbdHNTvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F1B1AEA02;
        Mon, 14 Aug 2017 15:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YFRI77RAjLDm+78Lfpnn4yVMcr8=; b=gq19RE
        srYA6JKOd9J+3TgfNoOPAYNttODz8A4A/O8PGTIfqCsZIo4MnDlmB1wTOWiOTN9G
        ciFoGmPffdTlImsf69wDLaNDODfDqR2bnfSWaGK7Za20gNkZJ2NHYtv4DRtcdISl
        rkfz43o3/HI/j8VC/Qq4meeMRLqQ6PtnMFckg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AKAp9xh7OSmqv7ifQ+sf50y/lpis+uR0
        9I3uYHsNH5q5iKHGYfA5XA2AP1v3GlAJp9DP6T7lzmkTsxZ2yqhODaEhxbFqQPi9
        5rilIZt88Y+c7WtkKBsqSyyd+dGpXVK6mVZ1gUu27Nxgn3a1lYsEyBi09s10r4KQ
        oSgdDkOxZnA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28236AEA00;
        Mon, 14 Aug 2017 15:51:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 917DDAE9FF;
        Mon, 14 Aug 2017 15:51:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: prevent warning about null bytes in input
References: <20170814050801.7158-1-me@ikke.info>
Date:   Mon, 14 Aug 2017 12:51:26 -0700
In-Reply-To: <20170814050801.7158-1-me@ikke.info> (Kevin Daudt's message of
        "Mon, 14 Aug 2017 07:08:01 +0200")
Message-ID: <xmqq7ey6udvl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5D4AFD8-8129-11E7-82EC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> The no_changes function calls the untracked_files function through
> command substitution. untracked_files will return null bytes because it
> runs ls-files with the '-z' option.
>
> Bash since version 4.4 warns about these null bytes. As they are not
> required for the test that is being done, remove null bytes from the
> input.

That's an interesting one ;-)

I wonder if you considered giving an option to untracked_files
helper function, though.  After all, it has only two callers,
and it feels a bit suboptimal to ask the command to do a special
thing (i.e. "-z") only to clean it up with a pipe.

IOW, something along the lines of (totally untested)...

 git-stash.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9b6c2da7b4..5f09a47f0a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -43,9 +43,16 @@ no_changes () {
 }
 
 untracked_files () {
+	if test "$1" = "-z"
+	then
+		shift
+		z=-z
+	else
+		z=
+	fi
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt -- "$@"
+	git ls-files -o $z $excl_opt -- "$@"
 }
 
 clear_stash () {
@@ -114,7 +121,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files "$@" | (
+			untracked_files -z "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&


