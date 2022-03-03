Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiCCXVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiCCXVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 18:21:38 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1E169232
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 15:20:51 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67576127C99;
        Thu,  3 Mar 2022 18:20:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UY43sikpKNV4sG07X71+l/TEBY1vXanjla3ODf
        sONQk=; b=eqyVcnRH5IzfOPSq30Fth8wSH4gI6iK5BTdpgAxWCsK/iUw1kSbYD2
        iqMX5jEVNCn6s5Hk8JXpmcaP26enw3/Rbwn9XZZ/yddRG/f29nhVzHzwXTX/tuu5
        PQk77HpI8WoIh44+96qxc2Cc6KkI8FVYz49MRZlQ4XFhXML4VEmeI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DE21127C98;
        Thu,  3 Mar 2022 18:20:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB1FE127C93;
        Thu,  3 Mar 2022 18:20:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        derrickstolee@github.com, avarab@gmail.com
Subject: Re: [PATCH v3 2/2] builtin/remote.c: show progress when renaming
 remote references
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
        <cover.1646346286.git.me@ttaylorr.com>
        <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
Date:   Thu, 03 Mar 2022 15:20:48 -0800
In-Reply-To: <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 3 Mar 2022 17:25:18 -0500")
Message-ID: <xmqqk0da7hdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FFB5250-9B48-11EC-971B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Instead of a more complex modification to the ref transaction code,
> display a progress meter when running verbosely in order to convince the
> user that Git is doing work while renaming a remote.

Is it still "when running verbosely"?

I thought that tying this to --[no-]progress was the whole point of
iterating another round.

	... when the standard error output is connected to a
	terminal, so that user knows Git is not completely stuck.

> This is mostly done as-expected, with the minor caveat that we
> intentionally count symrefs renames twice, since renaming a symref takes
> place over two separate calls (one to delete the old one, and another to
> create the new one).

That's a nice note to leave here, as it is a bit tricky to reason about.

> [1]: https://lore.kernel.org/git/572367B4.4050207@alum.mit.edu/
>
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---



>  Documentation/git-remote.txt |  2 +-
>  builtin/remote.c             | 30 +++++++++++++++++++++++++-----
>  t/t5505-remote.sh            |  4 +++-
>  3 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 2bebc32566..cde9614e36 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git remote' [-v | --verbose]
>  'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
> -'git remote rename' <old> <new>
> +'git remote rename' [--[no-]progress] <old> <new>
>  'git remote remove' <name>
>  'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
>  'git remote set-branches' [--add] <name> <branch>...

Do we already have an entry for the --progress option in the
description part of the documentation?  I think the way progress
works in the context of this command is pretty much bog-standard
one that we may not have to, once the user has seen how progress
options work elsewhere.

If not, then we'd want something like this squashed in, perhaps?

 Documentation/git-remote.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/Documentation/git-remote.txt w/Documentation/git-remote.txt
index cde9614e36..e04810ee70 100644
--- c/Documentation/git-remote.txt
+++ w/Documentation/git-remote.txt
@@ -83,7 +83,10 @@ will always behave as if `--mirror` was passed.
 'rename'::
 
 Rename the remote named <old> to <new>. All remote-tracking branches and
-configuration settings for the remote are updated.
+configuration settings for the remote are updated.  When used interactively
+(i.e. the standard error stream is connected to a terminal),
+a progress bar may be shown while remote-tracking branches are renamed,
+which can be silenced by passing the `--no-progress` option.
 +
 In case <old> and <new> are the same, and <old> is a file under
 `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
