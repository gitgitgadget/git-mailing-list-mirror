Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD5C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbiC3UQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiC3UQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 16:16:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A46D4E6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 13:15:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B86BC17BB8A;
        Wed, 30 Mar 2022 16:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G/B0Jhyp4DnP
        b8UKLimEajMVyT3IJE+H597r6v4YP0s=; b=BvNGhZOIoP3XFUGoFDEW9J7Vcfah
        qxGO8a8hmqtIzCoEsUiw15HNwl6q3MBiJ9z0nuNP06yQ3rbsgeLRuflNkFS1+ATO
        Om1DUaIW+h0rsp2s8BdQwGJQSJoGSFh6LFl96QM/R9+jjk1lgneepyY3oans5cPU
        fFsDQJ/3enypw+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B00D217BB88;
        Wed, 30 Mar 2022 16:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 171B517BB87;
        Wed, 30 Mar 2022 16:14:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
        <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
        <Yjt6mLIfw0V3aVTO@nand.local>
        <220329.86h77h2ju3.gmgdl@evledraar.gmail.com>
        <YkPBnIt6K0crowpb@nand.local>
        <220330.86ilrvnxb6.gmgdl@evledraar.gmail.com>
Date:   Wed, 30 Mar 2022 13:14:57 -0700
In-Reply-To: <220330.86ilrvnxb6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 Mar 2022 19:38:29 +0200")
Message-ID: <xmqqwngb6vum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1242156E-B066-11EC-8B1C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Or just:
>
>     git mv {repo,global}-settings.c
>
> Since that's what it seems to want to be anyway.

Hmph, care to elaborate a bit more on "seems to"?

Here is my take

 - The code makes extensive use of repo_cfg_bool(), which is a thin
   wrapper around repo_config_get_bool(); despite its name, it is
   not about reading from the configuration file of that repository
   and nowhere else.  It can be affected by global configuration.

 - Other uses of repo_config_get_*() it uses is the same way.

So, it wants to grab a set of configuration that would +apply+ to
this specific instance of "struct repository".

But that is quite different from "give us settings that would apply
in general, I do not have a specific repository in mind", which is
what "global-settings.c" would imply at least to me.

And in order for the "this specific instance" to make sense, the
caller should have made sure that it is indeed a repository.
Lifting that BUG() from the code path not only smells sloppy way to
work around some corner case code that does not prepare the
repository properly, but does not make much sense, at least to me.
In exchange for scrapping the safety to help a caller that forgets
to prepare repository before it is ready to call this function, what
are we gaining?

I went back to the thread-starter message and re-read its
justification.  It talks about:

> Concerns:
>
> Are any callers strictly dependent on having a BUG() here? I suspect
> that the worst that would happen is that rather than this BUG(), the
> caller would later hit its own BUG() or die(), so I do not think this i=
s
> a blocker. Additionally, every builtin that directly calls
> prepare_repo_settings is either marked as RUN_SETUP, which means we
> would die() prior to calling it anyway, or checks on its own before
> calling it (builtin/diff.c). There are several callers in library code,
> though, and I have not tracked down how all of those are used.

Asking for existing callers being dependent on having a BUG() is a
pure nonsense.  The existing callers are there in shipped versions
of Git exactly because they do things correctly not to hit the BUG(),
so BY DEFINITION, they do not care if the BUG() is there or not.

So that is not "a blocker", but is a non-argument to ask if existing
code paths care if the BUG() is gone.

What BUG() is protecting us against is a careless developer who
writes a new code or alters an existing code path that ends up
making the control flow in such a way that a proper set-up of the
repository structure is bypassed by mistake before calling this
function.  The function is call-once by r->settings.initialized
guarding it, calling it and then doing a set-up will result in an
unexplainable bug even if the caller tries to compensate by calling
it twice, as r->settings that is set incorrectly will be sticky.

Having said all that, I can be pursuaded to consider an approach to
allow callers to explicitly ask for running outside repository, just
like the more strict setup_git_directory() for majority of callers
has looser setup_git_directory_gently() counterpart.  The current
callers should retain the "you must have discovered gitdir" there,
but a special purpose code that is not even Git (like fuzzer) can
say

    prepare_repo_settings_gently(r, &nongit_ok);

instead.

diff --git c/repo-settings.c w/repo-settings.c
index b4fbd16cdc..c492bc7671 100644
--- c/repo-settings.c
+++ w/repo-settings.c
@@ -10,15 +10,24 @@ static void repo_cfg_bool(struct repository *r, const=
 char *key, int *dest,
 		*dest =3D def;
 }
=20
-void prepare_repo_settings(struct repository *r)
+void prepare_repo_settings_gently(struct repository *r, int *nongit)
 {
 	int experimental;
 	int value;
 	char *strval;
 	int manyfiles;
=20
-	if (!r->gitdir)
-		BUG("Cannot add settings for uninitialized repository");
+	if (!r->gitdir) {
+		/*
+		 * The caller can pass nongit (out paremeter) to ask if r is already
+		 * initialized (and act on it after this function returns).
+		 */
+		if (!nongit)
+			BUG("Cannot add settings for uninitialized repository");
+		*nongit =3D 1;
+	} else if (nongit) {
+		*nongit =3D 0;
+	}
=20
 	if (r->settings.initialized++)
 		return;
diff --git c/repository.h w/repository.h
index e29f361703..98f6ec12cc 100644
--- c/repository.h
+++ w/repository.h
@@ -222,7 +222,8 @@ int repo_read_index_unmerged(struct repository *);
  */
 void repo_update_index_if_able(struct repository *, struct lock_file *);
=20
-void prepare_repo_settings(struct repository *r);
+#define prepare_repo_settings(r) prepare_repo_settings_gently((r), NULL)
+void prepare_repo_settings_gently(struct repository *r, int *nongit);
=20
 /*
  * Return 1 if upgrade repository format to target_version succeeded,


