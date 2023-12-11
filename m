Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ASW/nK63"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41FDAB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 06:57:30 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A0F021376;
	Mon, 11 Dec 2023 09:57:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v56uT9PhabmgS6sTuP5iO3G81YxchL8PMlT6bb
	bcw1k=; b=ASW/nK631gg9O5VZKTlQ7YJtktZFDRAYJyG8XjuMFXeZexzziNZUnh
	lR6rxSfdvfBf9Pyf42amD961fcT4A6QqmtItdZoDF9gnUYI9Rsc8u77sciSSj4Qu
	f9X44BpgpmW2xc9a+suJllY3Zayf/MqTo5RW+cyooaxSn/488P2dQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01F8221375;
	Mon, 11 Dec 2023 09:57:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9843D21374;
	Mon, 11 Dec 2023 09:57:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
In-Reply-To: <ZXbzzlyWC3HTUyDA@tanuki> (Patrick Steinhardt's message of "Mon,
	11 Dec 2023 12:34:38 +0100")
References: <cover.1701863960.git.ps@pks.im> <xmqq7clmn3w1.fsf@gitster.g>
	<ZXbzzlyWC3HTUyDA@tanuki>
Date: Mon, 11 Dec 2023 06:57:25 -0800
Message-ID: <xmqqmsugvlbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99391096-9835-11EE-A7BB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> An existing test
>> 
>>     $ make && cd t && GIT_TEST_DEFAULT_HASH=sha256 sh t5550-http-fetch-dumb.sh
>> 
>> passes with vanilla Git 2.43, but with these patches applied, it
>> fails the "7 - empty dumb HTTP" step.
> ...
> Before my refactorings we used to fall back to the local default hash
> format with which we've already initialized the repository, which is
> wrong. Now we use the hash format we detected via the remote, which we
> cannot detect because the remote is empty and does not advertise the
> hash function, so we fall back to SHA1 and thus also do the wrong thing.

Yeah, that is why I did *not* say "the series *breaks* existing
tests".  It triggers a failure, and in this case, a test failure
does not mean the behaviour is broken because there is no correct
answer.  ... oh, wait.  There isn't?

I wonder if the right thing to do is to advertise the hash function
even from an absolutely empty repository.  There are no objects in
such a repository, but it should already know what hash function to
use when it creates its first object (determined at the repository
creation time), so that _could_ be advertised.  

> The only correct thing here would be to use the actual hash function
> that the remote repository uses, but we have no to do so.

We have "no way to do so"?  We have "not done so"?

It is possible for the client side to download the $GIT_DIR/config
file from the remote to learn what value extensions.objectFormat is
in use over there instead, I think, but at the same time, I highly
suspect that dumb HTTP outlived its usefulness to warrant such an
additional investment of engineering resource.

The simplest "fix" might be to leave what happens in this narrow
case (i.e. cloning over dumb HTTP from an empty repository)
undefined by not testing (or not insisting on one particular
outcome), but ...

> +Cc brian, as he's the author of [2].

... of course I trust Brian more than I trust myself in this area ;-)

> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/jobs/5723052108
> [2]: ac093d0790 (remote-curl: detect algorithm for dumb HTTP by size, 2020-06-19)

Thanks.
