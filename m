Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453F181D06
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213158; cv=none; b=lHCgH7AOZGzlMXmBm3QogRgBVQ4UjKKS3csATdVVyKrDoHfWpzc0eZRzK+P2PyGyeG+uGp2Ze8Z5RPTjOEmq1OMuBx/NF4GNp+8Hf3ITBVEe3GQG3FkvRFw5/dVALHdvUPpafA/dzYWt7GxRMUafxQ+wkoplJQ4oZZkAeICGaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213158; c=relaxed/simple;
	bh=u5GqwBtwICp2qUJVD++mXYIDLeVWOh9HjYIqI3FRNIM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pU8uozEu/089vFJ8VmOhI6pktpFdfb3dNhyqQj5xK0AqRWIJhbNPfDfvc7RPBEsmPD9R9dHMjFEazc0wqtgzjfzTtjqTAdvRhlxcVeSSW8JU/Pb0WKFkx488WHDiGK+rqKz9qVRm2QAltnDqA4/492/ScYg/sRmzjNLCNy5lkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xgmABl07; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xgmABl07"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718213151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DAvqWfR/jpY1OP65yJXTfCqt6MH5HfSrZoP+Mv1ILw=;
	b=xgmABl07pVMizoIo5wy2samEZ4nk6UVVBDb8xNsYZEVmVxzehuRHBN6MK9fg5a4bYiPwhL
	WF6FK8CcQWga4wzs6Ic/1yCUq1QT8V5nfLGHjizbAHIIaoCkm/Uk5fAtiKZv77pGdw/9Ju
	OkrWi/pKFInONsUuWrDDJLtUKYYZpOlXqpeaZ+oH25Hw95mOrat/EQXn2GU45rfEE4dAYl
	hCD6HxpbvQdEDFVZ45ous7CDpimVlxVoPHk27iRxApo/krZpXqlrvx6Gi2TeqSTPlIHNLy
	ZQCbbwgZvtpZ7Iw7LjDiBVdo2v9nW/zLz1cSBYTLAQmij6Kn7EYD64/NIYXPiQ==
Date: Wed, 12 Jun 2024 19:25:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [RFC] Avaiable disk space when automatic garbage collection kicks
 in
In-Reply-To: <123401dabcea$8fe50110$afaf0330$@nexbridge.com>
References: <950d4ad3bcee79df1424faee09eb6b00@manjaro.org>
 <164fc547afd66caf58019b6c614b5134@manjaro.org>
 <123401dabcea$8fe50110$afaf0330$@nexbridge.com>
Message-ID: <4951aa9acafcbb723c64ed0df9b5fe41@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Randall,

On 2024-06-12 19:04, rsbecker@nexbridge.com wrote:
> On Wednesday, June 12, 2024 12:25 PM, Dragan Simic wrote:
>> [Maybe this RFC deserves a "bump", so let me try.]
>> On 2024-04-08 18:29, Dragan Simic wrote:
>>> A few days ago I've noticed a rather unusual issue, but still a
>>> realistic one.  When automatic garbage collection kicks in, as a
>>> result of gc.auto >= 0, which is also the default, the local
>>> repository can be left in a rather strange state if there isn't 
>>> enough
>>> free space available on the respective filesystem for writing the
>>> objects, etc.
>>> 
>>> It might be a good idea to estimate the required amount of free
>>> filesystem space before starting the garbage collection, be it
>>> automatic or manual, and refuse the operation if there isn't enough
>>> free space available.
>>> 
>>> As a note, the need_to_gc() function already does something a bit
>>> similar with the available system RAM.
>>> 
>>> Any thoughts?
> 
> I am not sure there is a good portable way of reliably doing this using 
> OS
> APIs, particularly with virtual disks and shared file sets. An edge
> condition would be setting up a separate file set for content inside 
> .git
> for massive repositories, so taking an estimate in the working index 
> would
> not fix the above.
> 
> It might be useful to add a configuration item like:
> 
> gc.reserve = size   # possibly with mb, kb, gb, tb, or some other 
> suffix
> indicating how much space must be available to reserve prior to 
> starting the
> operation.
> 
> Then creating a file (with real content) inside .git (or .git/objects) 
> with
> the reserved size. If the file cannot be constructed, gc gets 
> suppressed.
> This can happen for more than size issue - permissions, for example. 
> Note
> also that some file systems to not actually allocate the entire space 
> just
> setting EOF, so that technique, while fast, will also not work 
> portably.
> 
> After the reserve works, it can be removed (and hopefully NFS will 
> properly
> close it), providing a lock is put in place, followed by gc running. It
> might be useful to do this even on a non-auto gc. While this can be
> expensive (writing a block of stuff twice), it is safer this way.

Thanks for your response!

One of the troubles with the introduction of "gc.reserve" is that it 
would
be probably used by advanced users only, which may already turn 
automatic
garbage collection off for their repositories on filesystems without 
enough
free space for the garbage collection to succeed.  Another issue is that 
the
on-disk footprint of large repositories can grow significantly over 
time,
so rather frequent updates to the "gc.reserve" values would be needed.

There are aven more issues, which you already mentioned...  One of them 
is
the additional time required to create a large file, and another is the
additional wear that creating a large temporary file puts on flash-based
storage.  Moreover, if the total block usage of an underlying SSD gets 
close
to 100% after the large temporary file is created, we'd be putting that 
SSD
in a rather unfavorable position because no TRIM operation may be 
performed
on that large file when it gets removed, and we'd then "hammer" the SSD
with a whole lot of small writes.
