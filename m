Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0462DC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 22:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF6761042
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhHGWIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 18:08:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53905 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHGWIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 18:08:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A058DDCBF;
        Sat,  7 Aug 2021 18:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/NWlGzjiRga71i1OWvW3SP4aIfBJpkYaTtqo7
        3jp5A=; b=ahSe4AZBZ5v4z++v4NNdKetmlhCmQ/49kTDEZOcrWEzdKPO8eYFOsJ
        DWVUExG6apZzXC4lV00K6B1VZ3KzDoJ07Ry+6kTHr6yWuMcsYfu9RuiaxCWBqPwR
        Xwm/6FtRCfV2OP2j2jAtqWzzOSquMKD2fHzmWA7CZuuGmv3ReC6mc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FA79DDCBE;
        Sat,  7 Aug 2021 18:08:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43334DDCBD;
        Sat,  7 Aug 2021 18:08:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, rn+git@sigpipe.cz
Subject: Re* [PATCH v2] clone: Allow combining --bare and --origin
References: <xmqqv94mtdyj.fsf@gitster.g>
        <20210804133010.25855-1-oystwa@gmail.com> <xmqqbl6dqgvc.fsf@gitster.g>
Date:   Sat, 07 Aug 2021 15:08:02 -0700
In-Reply-To: <xmqqbl6dqgvc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        04 Aug 2021 10:06:31 -0700")
Message-ID: <xmqq4kc0j4cd.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF775F92-F7CB-11EB-8DB1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> It is somewhat unfortunate that we do not say what the name of the
>>> "origin" is anywhere in the resulting configuration file.  The only
>>> way to tell that "--origin somewhere" was used is to notice that there
>>> is only one remote and its name is "somewhere".
>> ...
> But we'd end up treating them the same.  And something like
> remote.originName would help that.  Otherwise, we'd end up sending
> this message:
>
>     Even if we give "--bare --origin yourfavouritename" to you now,
>     unlike how 'origin' is treated in the default case, in the
>     resulting repository, 'yourfavouritename' is not special at all.
>
> Some people may want to treat yourfavouritename is not special at
> all, while some people may want to treat yourfavouritename truly as
> a replacement for 'origin' that is the default.  The message we
> would be sending is that we'd ignore the latter folks.

So, let's illustrate one of the things that is needed after the good
first step to allow --bare --origin=yourfavouritename used together.

There may be other things that needs fixing, of course, but we need
to start from somewhere.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
Subject: [PATCH] remote: fall back on the sole remote when unspecified

Historically, we used hardcoded "origin" as the fallback default for
commands that take a remote (e.g. "git fetch") when the user did not
tell us otherwise.  Since the "--origin=name" option was taught to
"git clone", however, we may not have a remote whose name is
"origin" at all.

Which means that the name given to "git clone --origin" does not
truly replace the hardcoded "origin". An example of such limitation
is that "git fetch" (no other parameters) would fetch happily from
the "origin" repository, but in a repository cloned with the custom
name using "--origin=name", "git fetch" would not fetch from anywhere
and instead fail.

We can fix this by noticing that the repository has one and only one
remote defined, and use that as a replacement for the hardcoded
"origin".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This matters for automation for those who want to use --origin
option.  Imagine you have multiple bare clones and you wanted to use
custom names for 'origin'.  And you want a cron job that goes over
these repositories and run "git fetch" from their upstream before
you come in for work, so that these bare clones can be used as
close-by mirrors of their upstream projects.

Unfortunately, that would not work.  If these repositories use
their own nicknames for their upstream that are not "origin",

	for repo in a b c
	do
		git -C $repo fetch
	done

would just fail.  Of course, you can somehow out-of-band know the
origin's name for each repo, e.g.

	for repoorigin in a:xyzzy b:frotz c:nitfol
	do
		repo=${repoorigin%:*}
                origin=${repoorigin#*:}
		git -C $repo fetch $origin
	done

but that is solving a problem that arises only because we are not
treating the name given to "git clone --origin=name" as a true
replacement for the default "origin".

 remote.c             | 10 +++++++++-
 t/t5512-ls-remote.sh | 10 ++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git c/remote.c w/remote.c
index dfb863d808..8a2fd1ccc9 100644
--- c/remote.c
+++ w/remote.c
@@ -39,6 +39,8 @@ static int remotes_alloc;
 static int remotes_nr;
 static struct hashmap remotes_hash;
 
+static const char *default_remote_name;
+
 static struct branch **branches;
 static int branches_alloc;
 static int branches_nr;
@@ -460,6 +462,12 @@ static void read_config(void)
 	}
 	git_config(handle_config, NULL);
 	alias_all_urls();
+	if (remotes_nr == 1 &&
+	    remotes[0]->configured_in_repo &&
+	    remotes[0]->url)
+		default_remote_name = remotes[0]->name;
+	else
+		default_remote_name = "origin";
 }
 
 static int valid_remote_nick(const char *name)
@@ -483,7 +491,7 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	}
 	if (explicit)
 		*explicit = 0;
-	return "origin";
+	return default_remote_name;
 }
 
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
diff --git c/t/t5512-ls-remote.sh w/t/t5512-ls-remote.sh
index f53f58895a..aa6f14e8fd 100755
--- c/t/t5512-ls-remote.sh
+++ w/t/t5512-ls-remote.sh
@@ -83,8 +83,14 @@ test_expect_success 'ls-remote --sort="-refname" --tags self' '
 	test_cmp expect actual
 '
 
-test_expect_success 'dies when no remote specified and no default remotes found' '
-	test_must_fail git ls-remote
+test_expect_success 'ls-remote falls back to the only remote' '
+	generate_references \
+		refs/tags/mark1.2 \
+		refs/tags/mark1.10 \
+		refs/tags/mark1.1 \
+		refs/tags/mark >expect &&
+	git ls-remote --sort="-refname" --tags >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'use "origin" when no remote specified' '
