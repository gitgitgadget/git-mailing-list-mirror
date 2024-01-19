Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE757302
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697871; cv=none; b=oNKn0txuUyIhK6LVndngrIWkKa/wbNoWwG/5Cu80aDSlxT8QTWHJUHhxGrjbHn52E+oMV5bjQqaPLf1cP87BU4YB9+F49zYvuVMhfaEQ4B2he2L8dZ/XmtPeYBf30RbKrbDUUI3YCHSmVtenf1HsmSfctN/SGdcc6uF5L1J/DvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697871; c=relaxed/simple;
	bh=YtaxTZqpAUK1zjbG+sc2eAabgv5fUVCLxgr7iITe1uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+2BiGgl30LRrEeEck0GL3GML+TXlKX00Lssdk17s9I7JPNm6hIXFeR2q2x8p16sJ0Pc8HDJZK5eHHc1NuOxbk0IZz7ysC7iTkNpFiQ/IJNBiuOsn5vk+9iFC2MeAOl471L9c2zoD5tU7cF07odMQU8A4h43rW6UG4ekG/nU9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ocLoq2Aq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ocLoq2Aq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F6E320C44;
	Fri, 19 Jan 2024 15:57:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YtaxTZqpAUK1zjbG+sc2eAabgv5fUVCLxgr7iI
	Te1uo=; b=ocLoq2AqsXILjL/PNlEYLiMtIX6VLyPBt4rBe6f5E/Q3dq3NM43YHN
	XdqzcCMPiwjdQW8MriFUNdQkA0CZun/rO0b6YyGSxuxsolFwKKIrA54Kc7FoUsNU
	vM/xFNuXJBqTUf0X7h87TBRy8XXwDsvxqEcZfjk52mr7LunQF1TjQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 580AF20C42;
	Fri, 19 Jan 2024 15:57:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9A7C20C41;
	Fri, 19 Jan 2024 15:57:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] refs: introduce `refs_for_each_all_refs()`
In-Reply-To: <20240119142705.139374-5-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 19 Jan 2024 15:27:04 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-5-karthik.188@gmail.com>
Date: Fri, 19 Jan 2024 12:57:44 -0800
Message-ID: <xmqqsf2thwhj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65757E92-B70D-11EE-A7FF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void add_pseudoref_like_entries(struct ref_store *ref_store,
> +					 struct ref_dir *dir,
> +					 const char *dirname)
> +{
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
> +	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
> +	struct dirent *de;
> +	size_t dirnamelen;
> +	DIR *d;
> +
> +	files_ref_path(refs, &path, dirname);
> +
> +	d = opendir(path.buf);
> +	if (!d) {
> +		strbuf_release(&path);
> +		return;
> +	}
> +
> +	strbuf_addstr(&refname, dirname);
> +	dirnamelen = refname.len;
> +
> +	while ((de = readdir(d)) != NULL) {
> +		unsigned char dtype;
> +
> +		if (de->d_name[0] == '.')
> +			continue;
> +		if (ends_with(de->d_name, ".lock"))
> +			continue;
> +		strbuf_addstr(&refname, de->d_name);
> +
> +		dtype = get_dtype(de, &path, 1);
> +		if (dtype == DT_REG && is_pseudoref_syntax(de->d_name))
> +			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);

This looks more like add_pseudoref_entries() given that the general
direction is to have an "allow" list of pseudo refs (at this point
after the previous step of the series, is_pseudoref_syntax() is the
is_pseudoref() function, and uses ends_with("_HEAD") as a mere
optimization to avoid listing all the possible pseudo refs that
exists or will be added in the future whose name ends with "_HEAD").

Other than the naming, I think these two steps make sense.

Thanks.
