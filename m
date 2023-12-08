Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNomIcBS"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB779A
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 15:09:34 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C5761C98A5;
	Fri,  8 Dec 2023 18:09:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cWXifAW5QbxJL6GOt6F7IbyUyhMEQQFlWRu1dJ
	Mtw3c=; b=DNomIcBSHr8GY5xJsLRLUoRokx/sXLi3Blp1PRnwS3lkvk6Edp00T2
	Dt9G889R11co+oENOqFilwsG54haNpNqy5ARpCByfUzX9+ENLFBoKZ2NvMCpQ9Qy
	h6J6wpuEKXjdXQBY2xYnyRIbN+Mb29mJQ8BVfW1cIr4bp9xz1iXb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0245A1C98A2;
	Fri,  8 Dec 2023 18:09:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64CB51C98A1;
	Fri,  8 Dec 2023 18:09:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] remote-curl: rediscover repository when fetching refs
In-Reply-To: <a1b86a0cbbedcc6610b2c563e9e38d439338869d.1701863960.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 6 Dec 2023 13:39:57 +0100")
References: <cover.1701863960.git.ps@pks.im>
	<a1b86a0cbbedcc6610b2c563e9e38d439338869d.1701863960.git.ps@pks.im>
Date: Sat, 09 Dec 2023 08:09:32 +0900
Message-ID: <xmqqmsukz3yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D951FADA-961E-11EE-A989-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're about to change git-clone(1) so that we set up the reference
> database at a later point. This change will cause git-remote-curl(1) to
> not detect the repository anymore due to "HEAD" not having been created
> yet at the time it spawns, and thus causes it to error out once it is
> asked to fetch the references.
>
> We can address this issue by trying to re-discover the Git repository in
> case none was detected at startup time. With this change, the clone will
> look as following:
>
>   1. git-clone(1) sets up the initial repository, excluding the
>      reference database.
>
>   2. git-clone(1) spawns git-remote-curl(1), which will be unable to
>      detect the repository due to a missing "HEAD".
>
>   3. git-clone(1) asks git-remote-curl(1) to list remote references.
>      This works just fine as this step does not require a local
>      repository
>
>   4. git-clone(1) creates the reference database as it has now learned
>      about the object format.

Sorry, but I am not sure I understand this step.  I assume you mean
by "the object format" what hash function is used to index the
objects (which can be learned from the remote "origin" in step 2 and
we can choose to use the one they use), not what ref backend is used
(which is purely a local matter and we do not need to know what is
used at the "origin").  Why do we need to wait initializing ref
backend until we learn what hash is being in use?

>   5. git-clone(1) asks git-remote-curl(1) to fetch the remote packfile.
>      The latter notices that it doesn't have a repository available, but
>      it now knows to try and re-discover it.
>
> If the re-discovery succeeds in the last step we can continue with the
> clone.

OK.
