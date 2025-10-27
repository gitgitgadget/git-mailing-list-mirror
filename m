Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62F239573
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580146; cv=none; b=tz2pQHQh7JWBD0ae11tV9vj9vX7bvq82Obu604kyXNPla5gvQqoqUOq6HpieHl+lwA3bxjWzQQ9fvhAWeXSaKixlWBYpq3DjB9F3r3STRjDyE3hyue2L8FTDgfzqJSGBCzZBmkcRCBbRa+Oryxtdp/26rZWZ76F24ItsIemfHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580146; c=relaxed/simple;
	bh=llstWfmFUVL3nXt15wYTscg8/BOBwURlrdhXuGlp5ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eiJLSHtSh0xQkrQfc6RNEqlDXxcTbZ2igRg3pSyLFY8aNyup/gUYhJw40e1e+/4H6FxeO1dpLsMH/nPlk6ag4ALR6fx7+Ay8YZuBGBJ8jw/oC/qgfNZ7TwDOVvDLPOIu8AebzBRMPNs466oj08Fwryj5bavE3HFLw5H/ssLxKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=bajSVzdA; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="bajSVzdA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761580139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbLE/xPHygtz4kZM3ZiI7HzById9a5oNS3XeDFCJmxI=;
	b=bajSVzdAv40+T9UEbbixG/zjfVa/yHDVlTa3xm2TcRQcBHK6imPuaCNGkk6REPRSKiGDiI
	MAPuBYzn52wrw98Jnz9196mABAWqshC78iGlkyMOhgYFViDmpvHXTMTflQQMuMMYPprzeD
	ToVA3sTFtXdPszlpA1qJepzSfa8sCc8=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <aPrAyJYvWtlvmiEx@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local> <87jz0tu3yh.fsf@iotcl.com>
 <aPrAyJYvWtlvmiEx@nand.local>
Date: Mon, 27 Oct 2025 16:48:45 +0100
Message-ID: <87ms5cpcpu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

>> Ahha, that might be a good idea. This might allow us to get rid of the
>> hashmap, which stops us from storing the paths twice. Not sure what the
>> impact on the performance would be, because the hashmap now is valuable
>> for path_idx() lookups.
>
> Looking at this a little further, I don't think I consider this worth
> doing. Using a strvec here is awkward since last_modified_init() really
> wants to assign lm->all_paths based on each entry's diff_idx, which is
> not what strvec.h is designed for.

Yeah, I decided to leave it as is for now.

> You *could* use a string_list, and shove a pointer to the
> last_modified_entry struct in the ->util field, but that is also
> inefficient since we remove paths from our hashmap as we mark them, and
> repeating that in a string_list would be wasteful.

There was another idea I had. Instead of giving each commit a bitmap,
give each commit a hashmap, and pass the hashmap entries across commits.
This allows us to store paths only in once place and removes the need to
allocate a fixed array `all_paths` again.

But in my measurements, this was about 30% slower than the solution I've
submitted in v3. And it also complicates the memory management. So I've
abandonned this idea.

-- 
Cheers,
Toon
