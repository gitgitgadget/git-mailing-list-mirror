Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85A38BDD4
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990492; cv=none; b=T1pVYcWmfCfjYLJKN1jO44LHQ3/qfymyqiT2UrBtAk3wHxJnkx+6el/x19N1E4lSa6JREXcx0+fOoJx81X2MDwsa4mJPkrpAbV6StR02EsSS+/jaLvvfvDF4264ENOXcwybDp+WYCVgi/uL3kyPOGQeJDQsGYN3h2jYU8QuqMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990492; c=relaxed/simple;
	bh=5SWEv96ySaEOM70shlqAYgTLHoWl/6l5PD4jfmsv9ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHGCrJ1GEBlwT3Vkr4Rs585A0c80YxNkC9wlU+pcVjYGSuV3skfuuK9wW3Dia3vGHyMzatOdnkcptOqDd2vrT/IHphe1xSfpxob7hIO5FbEK1F+4xrvOHF6AZ/sUKrh2Ti8pXnxtBehdrc1Ir2+1BVLHI/TXrMQbUcIRIuG9IN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dx0Rg2rRLzRnlW;
	Wed, 21 Jan 2026 11:14:39 +0100 (CET)
Message-ID: <bd725e17-b9bf-49d2-8d59-a479e30ceb76@kdbg.org>
Date: Wed, 21 Jan 2026 11:14:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
To: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?=
 <tboegi@web.de>, "Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
 Patrick Steinhardt <ps@pks.im>, Paulo Casaretto <pcasaretto@gmail.com>
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
 <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
 <20260121071344.GA570838@coredump.intra.peff.net>
 <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 21.01.26 um 09:13 schrieb Eric Sunshine:
> On Wed, Jan 21, 2026 at 2:15 AM Jeff King <peff@peff.net> wrote:
>> I don't think it's wrong, but the cleanup is redundant between the "out"
>> path and the others.
>>
>> Did you mean this:
>>
>> diff --git a/lockfile.c b/lockfile.c
>> @@ -122,14 +122,10 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
>>         strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
>>         if (write_in_full(fd, content.buf, content.len) < 0) {
>>                 warning_errno(_("could not write lock pid file '%s'"), pid_path);
>> -               close(fd);
>> -               fd = -1;
>>                 unlink(pid_path);
>>                 goto out;
>>         }
>>
>> -       close(fd);
>> -       fd = -1;
>>         pid_tempfile = register_tempfile(pid_path);
>>
>>  out:
>>
>> which would just let the close after the out label handle all cases?
> 
> Correct me if I'm wrong, but wouldn't this suggested change be
> problematic on Microsoft Windows? Specifically, if I recall correctly,
> Windows won't allow a file to be deleted if any processes still have
> it open, and this change eliminates the call to close() preceding the
> call to unlink(), so the file would still be held open when the
> attempt is made to remove it.
You analysis is correct. I was just about to point this out, too.

-- Hannes

