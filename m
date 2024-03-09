Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CF1D69E
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981282; cv=none; b=UwWfsD6JMQ96P9v6+nY5Oa9afAYmXft/GY7njLR9faQQ/s0sZe2/qBF5hm/MP+3/HekHCpxx+eJ3amgKsp+v7JXsAxY+/qkTBj5Q7ODHBxeH44Mtbo4XXnlou+IwEjOCmVDZo27q91wJr2DVK7zUr7DAMtXykEkn0Ku3LivZWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981282; c=relaxed/simple;
	bh=LXbMpBVPXEClIq4yHwqkKW4k7Wq0L1MxcpMMemOaDMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=PB3KGxxwj+5k5mH4ZA69DRrj8oustvoKDoapYl37VhMMu+S4u6LqfkZQ0wTIlI9eLHrCongczqtqO7PrQ5+x813cvQWsIUNw36m4PYv/sc3q5MDCfbPhUp0+xsSbhwOQaOuuzehO2wx/jH4mi0iR9vRwShyu/HKRXWoDCAspCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=TFyN9qKg; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="TFyN9qKg"
Message-ID: <01a9baa2-b36b-4b4e-8e54-7645e35d1a47@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1709981277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCppz4H/N4zBf7ilYJY1U525/AlNOntcpNjoZwSCZR0=;
	b=TFyN9qKg7zswF8YaFS6zi0aQ8m2JB1HwNX84vlc+YxY5GG/wRxsvSC/RC8yuW9NZ1As/xE
	h7gLig/lhegYht4OTkNxb5ewlND2G1P+s4yEIXL0XJ0CIoyUAWH5k/DL6CBvlH8yosCtEt
	Z4VRnhavdB97Tzsr4mFFKFpKn0EfcxR0iwwDcZKUpmCoLP67Rqh0ImuhD77Cw7N8a4a0gu
	21xLWIunFjXqsgKtlGxUdo5Y7kakeYUIsl06LqA/r1PwXUNv6rjnu+ldUqP7sY9prp/aQ2
	ocQHzZUXY4HEL59cQPaXupXNPkTL6O5ooZABtxtTJQ2RkZ4LKARCClbTuOfl2A==
Date: Sat, 9 Mar 2024 11:47:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] config: learn the "hostname:" includeIf condition
To: Junio C Hamano <gitster@pobox.com>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240307205006.467443-2-ignacio@iencinas.com> <xmqqil1xk9fv.fsf@gitster.g>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqil1xk9fv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/3/24 22:40, Junio C Hamano wrote:
> Ignacio Encinas <ignacio@iencinas.com> writes:
> 
>> Currently, customizing the configuration depending on the machine running
>> git has to be done manually.
>>
>> Add support for a new includeIf keyword "hostname:" to conditionally
>> include configuration files depending on the hostname.
>>
>> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
>> ---
>>  Documentation/config.txt  |  9 +++++++++
>>  config.c                  | 16 ++++++++++++++++
>>  t/t1305-config-include.sh | 22 ++++++++++++++++++++++
>>  3 files changed, 47 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e3a74dd1c1..9a22fd2609 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
>>  a naming scheme that supports more variable-based include conditions,
>>  but currently Git only supports the exact keyword described above.
> 
>> +`hostname`::
>> +	The data that follows the keyword `hostname:` is taken to be a
>> +	pattern with standard globbing wildcards. If the current
>> +	hostname matches the pattern, the include condition is met.
>> +
> 
> OK.  This seems to copy its phrasing from the existing text for
> "gitdir" and "onbranch", which greatly helps the description for
> these features consistent.
> 
>> diff --git a/config.c b/config.c
>> index 3cfeb3d8bd..e0611fc342 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -317,6 +317,20 @@ static int include_by_branch(const char *cond, size_t cond_len)
>>  	return ret;
>>  }
>>  
>> +static int include_by_hostname(const char *cond, size_t cond_len)
>> +{
>> +	int ret;
>> +	char my_host[HOST_NAME_MAX + 1];
>> +	struct strbuf pattern = STRBUF_INIT;
>> +	if (xgethostname(my_host, sizeof(my_host)))
>> +		return 0;
>> +
>> +	strbuf_add(&pattern, cond, cond_len);
>> +	ret = !wildmatch(pattern.buf, my_host, 0);
>> +	strbuf_release(&pattern);
>> +	return ret;
>> +}
> 
> Have a blank line between the end of the decl block (our codebase
> frowns upon decl-after-statement) and the first statement,
> i.e. before "if (xgethostname...".
> 
> Otherwise this looks reasonable to me.

Got it. 
 
>> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
>> index 5cde79ef8c..ee78d9cade 100755
>> --- a/t/t1305-config-include.sh
>> +++ b/t/t1305-config-include.sh
>> @@ -357,4 +357,26 @@ test_expect_success 'include cycles are detected' '
>>  	grep "exceeded maximum include depth" stderr
>>  '
>>  
>> +test_expect_success 'conditional include, hostname' '
>> +	echo "[includeIf \"hostname:$(hostname)a\"]path=bar12" >>.git/config &&
>> +	echo "[test]twelve=12" >.git/bar12 &&
>> +	test_must_fail git config test.twelve &&
> 
> Emulating other tests in this file that uses here document may make
> it a bit easier to read?  E.g.,
> 
> 	cat >>.gitconfig <<-EOF &&
> 	[includeIf "hostname:$(hostname)a"]
> 		path = bar12
> 	EOF

Thanks for pointing that out. I just read the last tests from that file
where they used the echo "..." >> approach. Do you think it is
worthwhile rewriting those tests to use the approach you suggested?

By the way, before contributing, I saw there is some work on moving to
unit tests. I wasn't sure how to test this particular feature there, so
I went with the "old" approach as it seemed more natural. Is this ok?

>> +	echo "[includeIf \"hostname:$(hostname)\"]path=bar12" >>.git/config &&
> 
> Ditto for the remainder of the patch.
> 
> Thanks.

Thank you for the review.
