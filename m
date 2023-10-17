Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9A2E3F6
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5GgIC84"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA05C92
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:39:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 100811B8738;
	Tue, 17 Oct 2023 16:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u94wPMFfVCZtJ2EaggWZsKvUpmG2zTWuISu5Ne
	4FEic=; b=i5GgIC84/ncdKDEubPwCEs6ZqqbxRzPt2vJybI0VV0E06ge0G7fp+a
	VxcA6xm4tlU0m0JxUMnwUItPzmgy48QYQMzqFKqLYaBeRmTnJEh1FRgQKvNH013R
	OUiXJBBzyowkXeC5K/1/oFbJ/U9UdJ0zfly3rn3VjG3hZ9oQl8rKQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBAD71B8737;
	Tue, 17 Oct 2023 16:39:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C1C71B8736;
	Tue, 17 Oct 2023 16:39:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  ks1322@gmail.com
Subject: Re: [PATCH] grep: die gracefully when outside repository
In-Reply-To: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sat, 14 Oct 2023 23:02:38 +0200")
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
	<087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
Date: Tue, 17 Oct 2023 13:39:19 -0700
Message-ID: <xmqqzg0hf0g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F9D0F16-6D2D-11EE-B9BF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 39d6d713ecb..b976f81a166 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -1234,6 +1234,19 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
>  	)
>  '
>  
> +test_expect_success 'outside of git repository with pathspec outside the directory tree' '
> +	test_when_finished rm -fr non &&
> +	rm -fr non &&
> +	mkdir -p non/git/sub &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		test_expect_code 128 git grep --no-index search .. 2>error &&
> +		grep "is outside the directory tree" error
> +	)
> +'
> +

So you create non/git/sub, go to non/git (so there is sub/ directory),
and try running "..".

If you had a directory non/tig next to non/git and used ../tig
instead of .. as the path given to "git grep", it would also
correctly fail.  Searching in a non-existing path, ../non, dies in a
different error, with an error message that is not technically
wrong, but it probably can be improved.  It has been a while since I
looked at the pathspec matching code, but if we are lucky, it might
be just the matter of swapping the order of checking (in other
words, check "is it outside" first and then "does it exist" next, or
something like that)?

 t/t7810-grep.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git c/t/t7810-grep.sh w/t/t7810-grep.sh
index b976f81a16..84838c0fe1 100755
--- c/t/t7810-grep.sh
+++ w/t/t7810-grep.sh
@@ -1234,16 +1234,30 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
 	)
 '
 
-test_expect_success 'outside of git repository with pathspec outside the directory tree' '
+test_expect_success 'no repository with path outside $cwd' '
 	test_when_finished rm -fr non &&
 	rm -fr non &&
-	mkdir -p non/git/sub &&
+	mkdir -p non/git/sub non/tig &&
 	(
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_expect_code 128 git grep --no-index search .. 2>error &&
 		grep "is outside the directory tree" error
+	) &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search ../tig 2>error &&
+		grep "is outside the directory tree" error
+	) &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search ../non 2>error &&
+		grep "no such path in the working tree" error
 	)
 '
 
