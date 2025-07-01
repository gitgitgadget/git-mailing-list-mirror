Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7B218ADC
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348657; cv=none; b=iLI9prnXBwp0Vc7RooiOtOLEvt3llDsmdAj7fFLaodtYB9hC/jST1LKF+tqicjmFQjH7IAWSKXS+Ixc+ZqBl8NRV/6S/CA6OfGfmR4BMZAr+t6vHnEyWI0eKflnIjFsl/6gRZ8VWFZqy1LS4opWrUwTd0FPK1pTjFtG2/32d0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348657; c=relaxed/simple;
	bh=0e9ikefU/ivkyjPh/obC+fabKdOkpXjBSPp0HoPmMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J71FQNq4qAUMZW2H8bOp9G/dtLEZkxp1omyDq+UzkyKRXDBDjE98VG1UxfOUnJ8VVKhWtHtUaMAAuTT7PWOD3UApMGs122Eew24JMeP0UEFBU7Dlz0WoKocqG3v0ctLTY800W/tn01k8OzcmMMBIbK/kaozmRX0XgUp0IDYx0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=GXrXY+u8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="GXrXY+u8"
Date: Tue, 1 Jul 2025 01:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751348651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E328LHJMufBprleWsUkniuLnO3uV52+BKOt/dhbfnj4=;
	b=GXrXY+u8F7qymwq66aI6+9MunnBzMr2y387Y/APwuWp7s0f0o+gjdh0oSfE4IxDK7Lbuu4
	h4vlamrs/ildIkVf+BiIFDCFs4CJ0ifYeCpkSLZQlSt0qbXZIuxjYAa52BZ6hZF3tq0kZg
	6UihYH9ElCSMtk0b5MwaQJZW4Gt13rk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] apply: only write intents to add for new files
Message-ID: <vzkxbwj5khnlzx23p2jz2omf4nfzfaal25gwlovvwgzxi2mmjx@vijooguwndsj>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250628225819.1294068-5-ray@ameretat.dev>
 <xmqq7c0t12oz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c0t12oz.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On 25/06/30 11:53AM, Junio C Hamano wrote:
> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
> > In the "update only the worktree" mode, the index should not be touched
> > except to record intents to add when --intent-to-add is on. Because
> > having --intent-to-add on sets update_index, to indicate that we are
> > touching the index, we can't rely only on that flag to decide whether to
> > write an index entry.
> 
> Does that let us inspect state->ita_only alone and conclude that
> state->update_index is set, though?  IOW ...
> 
> >  	if (patch->conflicted_threeway)
> >  		return add_conflicted_stages_file(state, patch);
> > -	else if (state->update_index)
> > +	else if (state->check_index || (state->ita_only && patch->is_new > 0))
> 
> ... I would have expected the new code to check not just ita_only but
> check ita_only only when update_index is in effect.
> 
> 
> >  		return add_index_file(state, path, mode, buf, size);
> >  	return 0;
> >  }

We're behind a more specific test on state->apply to enter this codepath
at all (the only way in is the call to write_out_results around line
4859). So we're already committed to applying the patch, which is one
half of update_index, but the other half is check_index || ita_only and
we must behave differently depending on which of those is in effect and
causing us to touch the index.
