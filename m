Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CC144D3E
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805477; cv=none; b=bj9p+BQbIZCLzQbxGMMKW8GrS5IaxQHIITuo168EaYL0t+tKvXoz4TSRAueVLsr0Eu41fIzisM1rtxKEglvCOxywqfwEI3iV4WHsVc149mfMUDHQYTHnR80aiOgOGuiqIcmExL6sNkw8vEjkSUBPMw1UTgxS1+W1OwB0Z+eRq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805477; c=relaxed/simple;
	bh=r4IPC1pslvtQi0hC1ETSGRn0fRV2J7PdUVhdlNEL8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNgt6fsuPBj9PaSqszuiskkPLlxF3/1GR5YvHjDRKQESu+0ooAA62O3RQTB6/Q/uRlqQNSLTCywfo2HzCs+mi9Wuw14KULcYI/14ouuE4ZAnytd9HHmaMjQFNb2dUHQo3bPcMZs4x9v8ui+n8aUX1vyl+ZTvkHVBt/2vTEVADkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9402 invoked by uid 109); 19 Jun 2024 13:57:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 13:57:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21677 invoked by uid 111); 19 Jun 2024 13:57:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 09:57:54 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 09:57:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] attr: notice and report read failure of
 .gitattributes files
Message-ID: <20240619135754.GB943023@coredump.intra.peff.net>
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com>
 <20240618234436.4107855-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618234436.4107855-3-gitster@pobox.com>

On Tue, Jun 18, 2024 at 04:44:33PM -0700, Junio C Hamano wrote:

> The code that reads .gitattributes files was careless in dealing in
> unusual circumstances.
> 
>  - It let read errors silently ignored.
> 
>  - It tried to read ".gitattributes" that is a directory on
>    platforms that allowed open(2) to open directories.
> 
> To make the latter consistent with what we do for fopen() on
> directories ("git grep" for FREAD_READS_DIRECTORIES for details),
> check if we opened a directory, silently close it and return
> success.  Catch all read errors before we close and report as
> needed.

Makes sense, but...

> diff --git a/attr.c b/attr.c
> index 300f994ba6..9ab9cf1551 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -747,6 +747,11 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
>  		fclose(fp);
>  		return NULL;
>  	}
> +	if (S_ISDIR(st.st_mode)) {
> +		/* On FREAD_READS_DIRECTORIES platforms */
> +		fclose(fp);
> +		return NULL;
> +	}

I don't know that this is really consistent with callers of fopen(),
since they tend to complain noisily. Usually via warn_on_fopen_errors(),
which we ourselves call above.

I.e., if we were using fopen() here rather than open()+fdopen(), our
call would likewise complain noisily. And we even did so prior to
2ef579e261 (attr: do not respect symlinks for in-tree .gitattributes,
2021-02-16)! We had to switch to open() then to use O_NOFOLLOW.

And I notice that every caller of open_nofollow() does an fdopen()
anyway. So I wonder if the better solution would be to make an
fopen_nofollow() that handles the FREAD_READS_DIRECTORIES stuff itself,
just like fopen() does?


That is also an interesting data point regarding the "is it sane to have
directory .gitattributes" question. Older versions would definitely
complain about it (once per file in the diff even):

  $ mkdir .gitattributes
  $ git.v2.31.0 show >/dev/null
  warning: unable to access '.gitattributes': Is a directory
  warning: unable to access '.gitattributes': Is a directory

-Peff
