Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88321477287
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872503; cv=none; b=DoCj3Fy2KZCiL6z9zLXIRcXNo5cmZb3bD+2yHKwTnf/eErNgoNdYM5XZL2NyTeshZ0qRgysPdG10M365HRvfQs5DvQR9gBDBk5hfdTw5XcVn8xHKS5iGWH6RibT+KrNSNGJ/iw1tsKf5cR0enzsRTSsMGVuNnLq5Eqt6PSvUPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872503; c=relaxed/simple;
	bh=MBbAnf0F7nPWHuzKeXU+thGfXoCo/RumBp0LXBxg9qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Kq9tBmYoCJOmUCsGr+vBVUbnxh/qs3vtNFZVKJZ6cokga8fMXakae23ahjY1YCaCrv+7Dkm4mTXEVRiy03qrfheArDvn/Ys9x/Pme4dCT3Xlr9BE4GeH+sjWfsa1onybWk07kt8QThUS0kHiZeLJdhlQB8Fk/lBm3NF7FjV7gBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4j3jhB0HCmz7Qv0K
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:34:34 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4j3jh05jb0zRnlS;
	Tue, 13 Oct 2026 07:34:24 +0200 (CEST)
Message-ID: <3b36c428-6d67-45ef-9f6f-e78da33646ac@kdbg.org>
Date: Tue, 13 Oct 2026 07:34:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when
 conversion is active
To: tboegi@web.de
References: <xmqqwm1no29m.fsf@gitster.g> <20261012175638.3712-1-tboegi@web.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, curtis.allen.smith@gmail.com
In-Reply-To: <20261012175638.3712-1-tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.10.26 um 19:56 schrieb tboegi@web.de:
> @@ -438,6 +439,27 @@ int ie_match_stat(struct index_state *istate,
>  	return changed;
>  }
>  
> +/*
> + * A difference between the size of the file in the working tree and the
> + * size recorded for it in the index proves that the contents changed
> + * only as long as the two are byte-for-byte comparable.  That stops
> + * being true as soon as the path is run through a clean filter:

I cannot agree with this reasoning. The index is a cache of the stat
information. The size recorded in the index is only used as a clue
whether the file was changed or not. It does *not* record the size of
the data that the object database holds for the blob.

If your analysis found that, after the content was `git add`-ed, the
size in the index is *not* identical to the size taken from the
filesystem, then the problem is that an incorrect size was put into the
index, and not that the size between the blob data in the database and
the filesystem's file are different (and unusable).

> + * rewriting a file with CRLF endings under "text eol=lf", for example,
> + * changes its size in the working tree without changing the blob Git
> + * would record for it.  For such a path the only way to tell is to read
> + * the contents and convert them, which is what we already do when only
> + * the mtime changed.
> + */

-- Hannes

