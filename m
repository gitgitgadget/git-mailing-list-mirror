Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83913AD32
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488862; cv=none; b=Vpe4K+Ryi/NN1I3LNoHl1YRLv8GZ+C89xRPlBuGUyZaRIuIxZZ6g4uXnZoL3hCcxnKXf/J12BKV54cxHeJBcw7hrFpdOCQe9Wc6xGr8fkcXss74dCyvI6az1NhuKdINJt992GQuD46+lLt/mkeAL+Wpx0/H5E2DlsfekS3KYbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488862; c=relaxed/simple;
	bh=HpEMee89BgHChM1os9QhBZdOemxHRnwM2Cabar4qCDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rd5zgfWj3+r1LtYbFn/pHuNrKMIoFIOVk/HtaS3cUw9wn+F1jIaN/Kupdppw+77X3YYtUzzcacVgyIAU4lSiyAyY17EEIZK0s6HMdmIq27l6hVptv0Djnd5VTyqIMtJ5v2R+PzaJZPZ/G8JANLo86L92O0Cq3lMZXZoqHBDZxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sINXwy+g; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sINXwy+g"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1CFB1A4D9;
	Wed,  4 Sep 2024 18:27:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HpEMee89BgHChM1os9QhBZdOemxHRnwM2Cabar
	4qCDI=; b=sINXwy+gy9ehBq17Bv97lFGq/q9n2ylXyVRJAVV9l0p+h3jPlEM0k3
	+Sm6h0Zrxg6EZBeAW47dLORyRXP7an5lS/pLagnb6oSkNjUzcLrMZczNHPnsCi4s
	2klF86zlT399EI3rlJz2mBecyVA3qKTzS1InA/+OxqA4+Yn6APoyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C99E11A4D8;
	Wed,  4 Sep 2024 18:27:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D3D31A4D7;
	Wed,  4 Sep 2024 18:27:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/22] builtin/repack: fix leaking line buffer when
 packing promisors
In-Reply-To: <19eb9073482144d0983de1ff9529fe050b3fc6a0.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:24 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<19eb9073482144d0983de1ff9529fe050b3fc6a0.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:27:37 -0700
Message-ID: <xmqqikvb6ome.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4B57992-6B0C-11EF-85DE-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `repack_promisor_objects()` we read output from git-pack-objects(1)
> line by line, using `strbuf_getline_lf()`. We never free the line
> buffer, causing a memory leak. Plug it.
>
> This leak is being hit in t5616, but plugging it alone is not
> sufficient to make the whole test suite leak free.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 8bb875532b4..a382754feee 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -425,9 +425,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  
>  		free(promisor_name);
>  	}
> +
>  	fclose(out);
>  	if (finish_command(&cmd))
>  		die(_("could not finish pack-objects to repack promisor objects"));
> +	strbuf_release(&line);
>  }

Obviously correct.

Thanks.
