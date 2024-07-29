Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F47188CDA
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289068; cv=none; b=NCJGPap6C3eFUNgvT9KtsAg2XrrcNG3F6T+ma1lPFt5067jq/+6FzCZkYi+aGKgfAhTJNWhWMtM1gS05h6OC0vNuKo19c98dJeHQ64Ye1X02Z6c0B0NxaiWMxg99nZXvNB4VcdUgxI6oj+KO2G9Rwof0uYW25LxI0RLPbuAkR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289068; c=relaxed/simple;
	bh=Dmyq2rlAR961hYCz7Rm2sj4aL38r+Gw3Ngd7uzrSdY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edhobxy9YJDVAVY9eYmWbCsAUCGQ+vDgoTldQgerhECSTaUaBcvQQeply3uSl7nh176QY/HfnACyMGqNh5gxdVYxpZFUpzwzXdI1mFrhKem94u58qOVHafT6olN/i0e94P4Cz9nwwpiZYXx2OCZSLlX4PUE1ORsF4vsmqkqrg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELBidQBY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELBidQBY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 82A1C2EA3F;
	Mon, 29 Jul 2024 17:37:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dmyq2rlAR961hYCz7Rm2sj4aL38r+Gw3Ngd7uz
	rSdY8=; b=ELBidQBYELBzwDomYS1SIqtzhj+Vj8P835dEEE5q0wROL89qDj5ZdY
	5ytNWvVdxCZzg6xcnWMltN7Sjv8MVJNUNbyZVKqXJvTCq4C94OEMxJ+jPBE2VLSB
	ttwra/wnsxWdyaMTcpwONLkUcMWdG6N6VtvrUNV8QCtrkPRiRP28I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B05E2EA3E;
	Mon, 29 Jul 2024 17:37:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11F422EA3D;
	Mon, 29 Jul 2024 17:37:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: David Disseldorp <ddiss@suse.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] notes: do not trigger editor when adding an
 empty note
In-Reply-To: <20240729151639.19192-2-ddiss@suse.de> (David Disseldorp's
	message of "Mon, 29 Jul 2024 17:14:00 +0200")
References: <20240729151639.19192-1-ddiss@suse.de>
	<20240729151639.19192-2-ddiss@suse.de>
Date: Mon, 29 Jul 2024 14:37:35 -0700
Message-ID: <xmqqed7bhobk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C5FCFE26-4DF2-11EF-8167-92D9AF168FA5-77302942!pb-smtp20.pobox.com

David Disseldorp <ddiss@suse.de> writes:

> Restore the original behaviour of "git note" that takes the contents
> given via the "-m", "-C", "-F" options without invoking an editor, by
> checking for any prior parameter callbacks, indicated by a non-zero
> note_data.msg_nr.  Remove the now-unneeded note_data.given flag.
>
> Add a test for this regression by checking whether GIT_EDITOR is
> invoked alongside "git notes add -C $empty_blob --allow-empty"

Makes perfect sense.

A #leftoverbit that we may want to look into after this topic
settles is to teach the "-e" option, similar to "git commit" and
"git tag", so that messages seeded with -m/-F can still be edited.
In a sense, supporting both "-c/-C" was unnecessary if these
commands supported "-e" in the first place, and that mistake has
been inherited from "git commit" and "git tag" into this command.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 536bd11ff4..c0dbacc161 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by git log' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'empty notes do not invoke the editor' '
> +	test_commit 18th &&
> +	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
> +'
> +
>  test_done

I am tempted to squash in

        diff --git i/t/t3301-notes.sh w/t/t3301-notes.sh
        index c0dbacc161..99137fb235 100755
        --- i/t/t3301-notes.sh
        +++ w/t/t3301-notes.sh
        @@ -1559,7 +1559,12 @@ test_expect_success 'empty notes are displayed by git log' '

         test_expect_success 'empty notes do not invoke the editor' '
                test_commit 18th &&
        -	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
        +	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty &&
        +	git notes remove HEAD &&
        +	GIT_EDITOR="false" git notes add -m "" --allow-empty &&
        +	git notes remove HEAD &&
        +	GIT_EDITOR="false" git notes add -F /dev/null --allow-empty &&
        +	git notes remove HEAD
         '

         test_done

to make sure that all three options mentioned in the proposed commit
log message are tested.  It is not too much more effort to do so.

Will queue.

Thanks.

