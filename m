Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C11C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiFGRA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbiFGRA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:00:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275E1021F0
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:00:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE36E1A70EC;
        Tue,  7 Jun 2022 13:00:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m6W/7tP9jmlu
        nnsEis0OmMaALEOa4tHMnrWdfX5gJe8=; b=dkkEARpD17NY2UfficpglAD8eoXj
        6ViNMFxvd9FryB+CwdC21T41SxRRC87QZoV8bfGJ0VNgzX5rH0uK7Mq3e0DJUGJg
        iHm1+s3yd82xq/u0gf08FK2dOwCfA27g5eI0a95UWanmCjpcHJiEVKIsEYKCq22e
        ahjwOXozRZLuvfE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A916F1A70EA;
        Tue,  7 Jun 2022 13:00:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 421241A70E1;
        Tue,  7 Jun 2022 13:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] fsmonitor: query watchman with right valid json
References: <CAL3xRKev_KHvAFuviG7RxsxA_786K4QY5F08a8D23M9MLM81+g@mail.gmail.com>
        <20220607111419.15753-1-sluongng@gmail.com>
Date:   Tue, 07 Jun 2022 10:00:18 -0700
In-Reply-To: <20220607111419.15753-1-sluongng@gmail.com> (Son Luong Ngoc's
        message of "Tue, 7 Jun 2022 13:14:19 +0200")
Message-ID: <xmqqmteoz9wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4FA36CAC-E683-11EC-B3F1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Son Luong Ngoc <sluongng@gmail.com> writes:

> In rare circumstances where the current git index does not carry the
> last_update_token, the fsmonitor v2 hook will be invoked with an
> empty string which would caused the final rendered json to be invalid.
>
>   ["query", "/path/to/my/git/repository/", {
>           "since": ,
>           "fields": ["name"],
>           "expression": ["not", ["dirname", ".git"]]
>   }]
>
> Which will left user with the following error message

"left" -> "leave" (or "give")

>   > git status
>   failed to parse command from stdin: line 2, column 13, position 67: u=
nexpected token near ','
>   Watchman: command returned no output.
>   Falling back to scanning...
>
> Hide the "since" field in json query when "last_update_token" is empty.
>
> Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>

It looked more like Helped-by to me, but I dunno.

> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> ---
>  templates/hooks--fsmonitor-watchman.sample | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hoo=
ks--fsmonitor-watchman.sample
> index 14ed0aa42d..23e856f5de 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -86,12 +86,13 @@ sub watchman_query {
>  	# recency index to select candidate nodes and "fields" to limit the
>  	# output to file names only. Then we're using the "expression" term t=
o
>  	# further constrain the results.
> +	my $last_update_line =3D "";
>  	if (substr($last_update_token, 0, 1) eq "c") {
>  		$last_update_token =3D "\"$last_update_token\"";
> +		$last_update_line =3D qq[\n"since": $last_update_token,];
>  	}
>  	my $query =3D <<"	END";
> -		["query", "$git_work_tree", {
> -			"since": $last_update_token,
> +		["query", "$git_work_tree", {$last_update_line
>  			"fields": ["name"],
>  			"expression": ["not", ["dirname", ".git"]]
>  		}]

OK.  Compared to v1, this looks much more reasonable.

This is totally unrelated to the "hide invalid since" topic, but I
wonder if $git_work_tree needs a bit more careful quoting.  It comes
directly from get_working_dir() but can it contain say a double quote
character, to make the resulting string in the variable $query not
quite well formed?
