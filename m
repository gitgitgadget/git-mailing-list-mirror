Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEA49620
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347426; cv=none; b=eLN+l2rlVBG7AheDPVxgfZ52ZY//pCtAntOUX2Jta5kcVX3LyFoZLRlxLUVUIIOYPNIEXZDRdMRATRPlfP6q0E9JPwMFX41+4j2nkW/v4mlaDKAxuaTebuMc++mbcw9wXJ/UvstzDk2WA3eqygwrp4tQDuLK/2l6MQxjYxGyUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347426; c=relaxed/simple;
	bh=q+svhHNcwLRvAVErhNdNUrQ2lJ/tIy5Lt5ZV5Y6gjg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdGVcpjyOd/WWbaWTqS+5HM0eGEBt1E3wjNUfbmHpK32x5Na414QQQlupcNFFHjz+qzmxIO5ycTtKRxvgRwrkMsWKEXeITjed/kLTP3xx+0TXeO0VUm/YbBBwzsPWGQt0gIwZXeqBJy20roqCCpPSI4hUNj6MYBl4bW7TtYj44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=myS+9tHK; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="myS+9tHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202608070029; t=1786347422;
	bh=HmnxmXhqSa6dBzqiArO4O4LTTlz5tpNpR2u/r+eTA+s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=myS+9tHKCL4aoivPBxEYGnRqHzCXc7u+VyNJ8riY4eMt0SEFaU7mGn0zRJwVxxZgp
	 dW68u9N/yToHnhIvkhJAPXoIvxiVGWaSB6NcTWet/fZx/1pkjKrZ9H06nlkS01DRCI
	 tzzEt7MZCSAwmZFprfMVNdnID8SJDo5zOWXOW/I1TShgOx5S6yr6RJ0PdtnNQic9VM
	 abJiHvEl4DwZHcNPAYIc0tMAj8o0qFCYQfp8hUoD3ulRX7KdyhxdhJRNDT+tTPfqaM
	 aFPY6RiI5XP18pt7arH2bUd0fmVsyJfbamFO/AZ4KdC8QEoBpKKZgH1MtM2uyNlZHc
	 cInoDaHhrDI4A==
Received: from [192.168.42.64] (66-97-142-46.pool.kielnet.net [46.142.97.66])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id D75393C3C68;
	Mon, 10 Aug 2026 09:37:01 +0200 (CEST)
Message-ID: <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>
Date: Mon, 10 Aug 2026 09:37:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
 <anlfk0P7UillhlUd@pks.im>
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <anlfk0P7UillhlUd@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 10.08.26 07:20, Patrick Steinhardt wrote:

> Git commands should just work with concurrent maintenance, and if they
> don't then it's worth to have a deeper look at why it doesn't.

That was my point; in lazygit's test suite I was getting errors when
executing simple commands such as "create a bunch of files, git add,
git commit". I had cases where the commit fails with

  error: invalid object 100644 50d5612... for 'file09.txt'
  error: Error building trees

> The reason why it's not fine for the Git test suite is that in lots of
> cases we assume a lot about the on-disk state of the repository. We are
> often reaching into internals to verify that it looks as expected, and
> that is of course racing with concurrent maintenance.

Yes, I understand why git's test suite has reasons to disable concurrent
maintenance. My point was that lazygit doesn't have any such reasons,
and shouldn't have to disable maintenance just so that the commands it
invokes don't error.

Stefan
