Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E716430FF
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Roaho3Yr"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F09D5D
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:25:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A56B22E137;
	Tue, 17 Oct 2023 16:25:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Vmdv8v4yxpmA9H3MMQewcLj5g/PVyHlYEEHtIR
	FWfls=; b=Roaho3Yrt77HUuz7hylomWPfafNH+t/JJZHWHVdQtauG6O487h+p4Z
	4mfsemdVVbkV4XSIhYBr4QuhdKliMObv1Zc7FXA+brQQTgaZAzPsx3OQgE9cVG9s
	K51HgzefwKL3b0B7K4UZXnlQu2Tc36TF/NkGESpue53FpJoDCm2f0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D7C32E136;
	Tue, 17 Oct 2023 16:25:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 23FAE2E131;
	Tue, 17 Oct 2023 16:25:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  ks1322@gmail.com,  peff@peff.net
Subject: Re: [PATCH] grep: die gracefully when outside repository
In-Reply-To: <f8a2abc0f610912af3eb56536ed217b8f90db2f9.1697571664.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Tue, 17 Oct 2023 21:51:08 +0200")
References: <xmqqmswhjj48.fsf@gitster.g>
	<f8a2abc0f610912af3eb56536ed217b8f90db2f9.1697571664.git.code@khaugsbakk.name>
Date: Tue, 17 Oct 2023 13:25:53 -0700
Message-ID: <xmqqcyxdgfn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FB2BC4E-6D2B-11EE-B415-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> On Tue, Oct 17, 2023, at 18:42, Junio C Hamano wrote:
>> It is curious that the original has two sources of hint_path (i.e.,
>> get_git_dir() is used as a fallback for get_git_work_tree()).  Are
>> we certain that the check is at the right place?  If we do not have
>> a repository, then both would fail by returning NULL, so it should
>> not matter if we add the new check before we check either or both,
>> or even after we checked both before dying.
>>
>> I wonder if
>>
>> 	const char *hint_path = get_git_work_tree();
>>
>> 	if (!hint_path)
>> 	        hint_path = get_git_dir();
>> 	if (hint_path)
>> 		die(_("%s: '%s' is outside repository at '%s'"),
>> 		    elt, copyfrom, absolute_path(hint_path));
>> 	else
>> 		die(_("%s: '%s' is outside the directory tree"),
>> 		    elt, copyfrom);
>>
>> makes the intent of the code clearer.
>
> That doesn't work since `get_git_dir()` triggers `BUG` instead of
> returning `NULL`.

Ah, interesting.

> The `hint_path` declaration has to be at the start because of style
> rules. But we can initialize it after.

Yes, what you have below (but please leave a blank line between the
last line of decl and the first line of statement for readablility)
looks very readable and sensible.

> I can also have a second look at the test since I am using `grep` to
> test the failure output and not the translation string variant.

That is not necessary, as we no longer run under phoney i18n that
required us to use test_i18ngrep.  It is OK to assume that the tests
are run under "C" locale.

Thanks.

> -- >8 --
> Subject: [PATCH] fixup! grep: die gracefully when outside repository
>
> ---
>  pathspec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index e115832f17a..0c1061fad11 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -467,10 +467,11 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  		match = prefix_path_gently(prefix, prefixlen,
>  					   &prefixlen, copyfrom);
>  		if (!match) {
> -			const char *hint_path = get_git_work_tree();
> +			const char *hint_path;
>  			if (!have_git_dir())
>  				die(_("'%s' is outside the directory tree"),
>  				    copyfrom);
> +			hint_path = get_git_work_tree();
>  			if (!hint_path)
>  				hint_path = get_git_dir();
>  			die(_("%s: '%s' is outside repository at '%s'"), elt,
