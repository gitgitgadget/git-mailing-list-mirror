Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0E190050
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582051; cv=none; b=gQqw4+u32UpxpXOltM8xibJReUYLR69g57MR6IBc1QviWAXv+73Iw4KkaYI9rd0VN8SCKa/BcPqlNdZ38t/vDoWM/Nou400SKvXUO7nDWi3UNrLGIrKx/vdZreDelv1mD7iVdwRMAp3BqTUyTGlcq7q+tf4aOmB7C7g4vYSDBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582051; c=relaxed/simple;
	bh=UfKUjCR7TjPwHkIXqrFjQsXtrS3e5/izekJZmCembwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuKGE2QpP2rXL9PbG8o6QV1rjj8dSrbUIhevRNnUcCijO6yML4xM6ffnu9njVP+3EifuKcPo5qHz4Fm4gTEemwCvaPMWWN3wNKurq0cDDnJL4oEGY3G8Faf2v9ffIt360dupEGge3EeCAHRJvP+377S6/ScsqOdCeGLL3CVHrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26118 invoked by uid 109); 5 Jun 2024 10:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 10:07:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28606 invoked by uid 111); 5 Jun 2024 10:07:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 06:07:26 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 06:07:28 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <20240605100728.GA3440281@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>

On Mon, Jun 03, 2024 at 11:30:35AM +0200, Patrick Steinhardt wrote:

> +static int for_each_root_ref(struct files_ref_store *refs,
> +			     int (*cb)(const char *refname, void *cb_data),
> +			     void *cb_data)
>  {
>  	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
>  	const char *dirname = refs->loose->root->name;
>  	struct dirent *de;
>  	size_t dirnamelen;
> +	int ret;
>  	DIR *d;

Should we initialize ret to 0 here?

We set it only inside the loop over dir entries:
> @@ -357,14 +355,47 @@ static void add_root_refs(struct files_ref_store *refs,
>  		strbuf_addstr(&refname, de->d_name);
>  
>  		dtype = get_dtype(de, &path, 1);
> -		if (dtype == DT_REG && is_root_ref(de->d_name))
> -			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
> +		if (dtype == DT_REG && is_root_ref(de->d_name)) {
> +			ret = cb(refname.buf, cb_data);
> +			if (ret)
> +				goto done;
> +		}
>  
>  		strbuf_setlen(&refname, dirnamelen);
>  	}

...but if the directory is empty (or only has "." files and ".lock"
files), we won't call "cb" at all, and hence won't ever set "ret".

And then at the end:

> +done:
>  	strbuf_release(&refname);
>  	strbuf_release(&path);
>  	closedir(d);
> +	return ret;
> +}

We return uninitialized garbage.

(Sorry for the late review; this got flagged by coverity since the topic
hit 'next').

-Peff
