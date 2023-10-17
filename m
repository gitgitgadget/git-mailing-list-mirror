Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1496430EE
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tDA0y9fI"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9616FB0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:14:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E90E2E041;
	Tue, 17 Oct 2023 16:14:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dfi+pnLMZKAu5JEZSmG2BZgty820yqpdwgMNbF
	9mV0I=; b=tDA0y9fImse+cF0XwNDzsqBTyyrZWxyh8jiLIWwV6hk/rKjKiPKWRU
	Yo6ttH0J0+02x6+4PVyxvNXmwiVEFvATEQfCQcusfxafLnA6K6dG2Bcze+XeC3Sv
	39S8/6Npowh1zZGqIrScTSwa2nvLAk/gInqvLIeEWoaMUWOe46csY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0858C2E040;
	Tue, 17 Oct 2023 16:14:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81D112E03F;
	Tue, 17 Oct 2023 16:13:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  stolee@gmail.com
Subject: Re: [PATCH 2/8] t7900: setup and tear down clones
In-Reply-To: <e3987cda75e4db72393f85de4bbb71d2ebaa097b.1697319294.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sat, 14 Oct 2023 23:45:53 +0200")
References: <cover.1697319294.git.code@khaugsbakk.name>
	<e3987cda75e4db72393f85de4bbb71d2ebaa097b.1697319294.git.code@khaugsbakk.name>
Date: Tue, 17 Oct 2023 13:13:54 -0700
Message-ID: <xmqqwmvlgg71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B35EB80E-6D29-11EE-B2BB-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Test `loose-objects task` depends on the two clones setup in `prefetch
> multiple remotes`.
>
> Reuse the two clones setup and tear down the clones afterwards in both
> tests.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  t/t7900-maintenance.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ca86b2ba687..ebc207f1a58 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -145,6 +145,12 @@ test_expect_success 'run --task=prefetch with no remotes' '
>  '
>  
>  test_expect_success 'prefetch multiple remotes' '
> +	test_when_finished rm -r clone1 &&
> +	test_when_finished rm -r clone2 &&
> +	test_when_finished git remote remove remote1 &&
> +	test_when_finished git remote remove remote2 &&
> +	test_when_finished git tag --delete one &&
> +	test_when_finished git tag --delete two &&
>  	git clone . clone1 &&
>  	git clone . clone2 &&
>  	git remote add remote1 "file://$(pwd)/clone1" &&

As I already said in my response to the cover letter, while I am
surprised that the series managed to make each step (and it alone)
succeed after the set-up (applaud!), I am not sure if it is really
worth doing.  As the business of test scripts is to test git, and it
means that we should always assume that we are dealing with a
potentially broken version of git.  By running so many git
subcommands in test_when_finished, each of them may be from a buggy
implementation of git, we cannot be really sure that we are
resetting the environment to the pristine state.  We should strive
to do as little as possible in test_when_finished.

> @@ -175,6 +181,22 @@ test_expect_success 'prefetch multiple remotes' '
>  '
>  
>  test_expect_success 'loose-objects task' '
> +	test_when_finished rm -r clone1 &&
> +	test_when_finished rm -r clone2 &&
> +	test_when_finished git remote remove remote1 &&
> +	test_when_finished git remote remove remote2 &&
> +	test_when_finished git tag --delete one &&
> +	test_when_finished git tag --delete two &&

Ditto.

> +	git clone . clone1 &&
> +	git clone . clone2 &&
> +	git remote add remote1 "file://$(pwd)/clone1" &&
> +	git remote add remote2 "file://$(pwd)/clone2" &&
> +	git -C clone1 switch -c one &&
> +	git -C clone2 switch -c two &&
> +	test_commit -C clone1 one &&
> +	test_commit -C clone2 two &&
> +	git fetch --all &&

This is even worse; it has to redo much of what the previous test
did.  Developers cannot be reasonably expected to maintain this
duplication when we need to change the earlier test.

While I am impressed that "set-up + individual single test" was made
to work, I am not convinced that the changes that took us to get
there are reasonable.  The end result looks much less maintainable
and more wasteful with duplicated steps.

Thanks.
