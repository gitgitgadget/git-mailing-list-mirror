Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345333ADB0
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415682; cv=none; b=YbcIIeH4uxqxCgcBGg2NsHdicUM6GHEip9ektLyNrxPMHlrq0UsKFHM/t3GXiGlSEepu6H8iUnplggq5EUXssTPfSW1CXpHkfi89hdwGZayBXcyzWfJF2OJWl3hJRtl0L+BFUCpZC+9CdhM5Oo9hvb7pRFJSB4mCo5zuM5JLuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415682; c=relaxed/simple;
	bh=t17HcDg2aqPoUoqZPI7zI/1YWAU3fMz3LLKhIdmN1vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHlcSs+1xzyKYR6lYKIWNTpXPt0DfEXzGz6kKSEyAsHcdmna6EZ1B87HLDTcyVay0dP3pyBdWoM8KY0/PNxrklF8IoGzP8sWrOcYVq6doNJLPzRU36pUMOAG5lxDU5in0ROyeJUHlZpB2b+WMB8NhT2mp96rfbnQESdwCgdRdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=p3xtR37a; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="p3xtR37a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785415676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtyUXK0ErkqnZ2p5kwAB0D/FHo/RYE+GQcToynfwLNQ=;
	b=p3xtR37a7VpGqZvRAqoU4aNwnyiUcERYH7V+Gc1/LSwYpaLUngDzMtdf9WMGgb9V08Ceyi
	2HtIoWiczYmjwkti+HLvtBjyiozwi6yZ6AvmUqcsY1CuVAuWdxZUDkARuGXRwQhh4E7wY9
	ZHWtowNB0E+EqiDczrxIP3Oqy22Q1xs=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] loose: load loose object map for the correct source
In-Reply-To: <amkMipjGA_7cwpOR@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
 <amkMipjGA_7cwpOR@denethor>
Date: Thu, 30 Jul 2026 14:47:50 +0200
Message-ID: <87tspgd4p5.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> On 26/07/24 05:48AM, Patrick Steinhardt wrote:
>> When loading the loose object map via `load_one_loose_object_map()` we
>> pass in both a repository and the corresponding source. We ultimately
>> don't really respect the passed-in source though as we instead always
>> load the map via the common directory. This doesn't make any sense
>> though, as the function is called in a loop through all sources, and as
>> such the expectation is that we'll load the map that belongs to the
>> given source.
>> 
>> Fix this bug by instead loading the map via the loose source's path.
>
> IIUC the primary source is always being used, does this mean that
> repositories using a compat hash and alternates are currently broken?

Yeah, the commit message seems to undersell this fix.

I think it wouldn't hurt to add a small test for this:

    test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
    	test_when_finished rm -rf alt borrow &&
    
    	git init --object-format=sha256 alt &&
    	git -C alt config extensions.compatObjectFormat sha1 &&
    	test_commit -C alt A &&
    
    	git init --object-format=sha256 borrow &&
    	git -C borrow config extensions.compatObjectFormat sha1 &&
    	echo "$PWD/alt/.git/objects" >borrow/.git/objects/info/alternates &&
    
    	oid=$(git -C alt rev-parse HEAD) &&
    	git -C alt    rev-parse --output-object-format=sha1 "$oid" >expect &&
    	git -C borrow rev-parse --output-object-format=sha1 "$oid" >actual &&
    	test_cmp expect actual
    '

-- 
Cheers,
Toon
