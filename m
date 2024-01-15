Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8815BB
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wbMmLPaY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7579C331D3;
	Sun, 14 Jan 2024 21:09:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O+0rnoYbfTyB4u1GceK8P7nXMfcKiUq7ABvwcP
	f0rC4=; b=wbMmLPaYUbKMLgBGPsK6ZRdGMCGpRWWqFaNalyaW+DH+W+MsqEkmxq
	FofRKADNACdQRGTLumDNXhrwaC6Jt+fFynHwvJvFE3pY3I51DAM1RkrDvpDEXw6b
	u4X54XfTShRWTITSjMUCVR+IrdMsSsrk0e0mFOyCaPKi/4YWZj/kg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DE68331D2;
	Sun, 14 Jan 2024 21:09:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B385331D0;
	Sun, 14 Jan 2024 21:09:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Nikolay
 Edigaryev <edigaryev@gmail.com>
Subject: Re: [PATCH] clone: support cloning of filtered bundles
In-Reply-To: <xmqqcyu35rg9.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	14 Jan 2024 17:13:42 -0800")
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
	<xmqqcyu35rg9.fsf@gitster.g>
Date: Sun, 14 Jan 2024 18:09:24 -0800
Message-ID: <xmqq8r4r5ovf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1B8DD20E-B34B-11EE-9031-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index c6357af9498..4b3fedf78ed 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -1227,9 +1227,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  
>>  		if (fd > 0)
>>  			close(fd);
>> +
>> +		if (has_filter) {
>> +			strbuf_addf(&key, "remote.%s.promisor", remote_name);
>> +			git_config_set(key.buf, "true");
>> +			strbuf_reset(&key);
>> +
>> +			strbuf_addf(&key, "remote.%s.partialclonefilter", remote_name);
>> +			git_config_set(key.buf, expand_list_objects_filter_spec(&header.filter));
>> +			strbuf_reset(&key);
>> +		}
>> +
>
>> -# NEEDSWORK: 'git clone --bare' should be able to clone from a filtered
>> -# bundle, but that requires a change to promisor/filter config options.
> ...
> But a bundle that were created with objects _omitted_ already?
> ... the source of this clone operation, i.e. the bundle file that is
> pointed at by "remote.$remote_name.url", cannot be that promisor.

Extending the above a bit, one important way a bundle is used is as
a medium for sneaker-net.  Instead of making a full clone over the
network, if you can create a bundle that records all objects and all
refs out of the source repository and then unbundle it in a
different place to create a repository, you can tweak the resulting
repository by either adding a separete remote or changing the
remote.origin.url so that your subsequent fetch goes over the
network to the repository you took the initial bundle from.

The "tweak the resulting repository" part however MUST be done
manually with the current system.  If we can optionally record the
publically reachable URL of the source repository when we create a
bundle file, and "git clone" on the receiving side can read the URL
out of the bundle and act on it (e.g., show it to the user and offer
to record it as remote.origin.url in the resulting repository---I do
not think it is wise to do this silently without letting the user
know from security's point of view), then the use of bundle files as
a medium for sneaker-netting will become even easier.

And once that is done, perhaps allowing a filtered bundle to act as
a sneaker-net medium to simulate an initial filtered clone would
make sense.  The promisor as well as the origin will be the network
reachable URL and subsequent fetches (both deliberate ones via "git
fetch" as well as lazy on-demand ones that backfills missing objects
via the "promisor" access) would become possible.

But without such a change to the bundle file format, allowing
"clone" to finish and pretend the resulting repository is usable is
somewhat irresponsible to the users.  The on-demand lazy fetch would
fail after this code cloned from such a filtered bundle, no?
