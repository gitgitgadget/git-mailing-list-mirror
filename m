Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C3156669
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098778; cv=none; b=SazFyDRcS1Isrwt17p9sqqa9GIAP0TVC10J1rDDwNk5Eis9rLE8XZKSQu7KprzsE4X0DnPia8hnnQ6ETkKlmFaCvRv3gwNHr08be0HmSSA0nYmPLCDWtQVnuYJGk2gLb4E/mQbB+QXX7Z/K7OGI+8hn/6nBTWDX/Tw5WrETyGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098778; c=relaxed/simple;
	bh=tUm6YD1yhFmS+x5xTWpcb54V34G7varxcX4K4oVWjIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGyV/ITWfodbyW/Gfk/2gTlT/FAPPMZyrEADXqsG+Udyb115l7brKSbuX+Ny+XX/MwbY6NQhDOwl/LojFZQ9+dzRfpsR/7ScZ9wON87HMguwqznQhC6rbfC7uGRO786OD/h5QRi8fRksdlg3+RLVwG6iV6PKKjg5zGTrtRuZVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=PvdPYgHC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="PvdPYgHC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732098771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=856pGL7UCjwxE+0oK/S8CzxMV91ezEOe6PWXTlQKPxI=;
	b=PvdPYgHC+YmHYFFXwit6IxWclJ9N9IxIaYr07XM/XFcg+IFLoksm1VH0YkDztQ4kX21jXF
	lZGc/KXMsGv3Rr92mCLaSWNWXcMjd4HWJsmCZhHDaRrbmewdntj8fHFg+z+pywgtCZBv3K
	QD74y3yn+ASCnmgbav8ZbwG5WPY1Sk4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 07/27] bisect: fix various cases where we leak commit
 list items
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-7-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-7-6154bf91f0b0@pks.im>
Date: Wed, 20 Nov 2024 11:32:31 +0100
Message-ID: <875xoitcu8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> There are various cases where we leak commit list items because we
> evict items from the list, but don't free them. Plug those.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  bisect.c                    | 35 +++++++++++++++++++++++++++--------
>  t/t6030-bisect-porcelain.sh |  1 +
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..0e804086cbf6a02d42bda98b62fb86daf099b82d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -440,11 +440,19 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  			free_commit_list(list->next);
>  			best = list;
>  			best->next = NULL;
> +		} else {
> +			for (p = list; p != best; p = next) {
> +				next = p->next;
> +				free(p);
> +			}

This makes the code do:

    if (!something) {
        // ...
    } else {
        // ...
    }

I find it odd reading code like that. Would you mind swapping them
around? Or is there a reason we type it like this, because I see this
also being done like this around line 393?

More on the functional side of this code, I'd like to understand better
what's happening here.
It's clear to me when `best` is NULL we want to free the whole
commit_list. And when `best` is set with FIND_BISECTION_ALL flag set, we
want to free the commit_list up to `best`. But when the
FIND_BISECTION_ALL flag is not set, we want to do the opposite, free
from `best->next` till the end? But what has this to do with
FIND_BISECTION_ALL? 

--
Toon
