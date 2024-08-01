Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B97143897
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538291; cv=none; b=QJcHSKI8aRWj2Uv2tqkfesTBlMk4DmTYvT1xt/6GbMBfDNP5JkhAV2SfX5ycXy+MtGQgDykb+0tBes3C2DPS6NvPO6dYJqHYQKl+B8DMPjUSc5BdYh2KzXbAhRUOjxxkeFCOERUtWa9xZb5iqX0n+8ow09ce+3CuosSEWrWrm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538291; c=relaxed/simple;
	bh=hHQ1MnYPaF6DOpJmMrQN+m5s/I/bIqynEDH1gOmKzCc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LX1/d2j9h9MaHeWdfgljJKnvuj9wAgscq4FPyEyrTGqQFhTLGFek/Ld8hT102k/d7OEHPx32BIzRnDx3byZmi32nwNtofmFxrhp4Tlx2fMjhqrRo+ZiSG/EV1RvFtv1RQHlUkvDhdK6smHh0a2zOYmMDHOS+6IAk3kTwoANg/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471IpQeh3506143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 18:51:26 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <02d401dae43e$c076b000$41641000$@nexbridge.com> <xmqqbk2cum5o.fsf@gitster.g>
In-Reply-To: <xmqqbk2cum5o.fsf@gitster.g>
Subject: RE: [Bug] Temp file use in t0018.6
Date: Thu, 1 Aug 2024 14:51:17 -0400
Organization: Nexbridge Inc.
Message-ID: <02e101dae443$d01575a0$704060e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGnznpkW75Rul6Kx/55mvNhpy8eIgI+lrsvsmbzywA=

On Thursday, August 1, 2024 2:35 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> In the 2.46.0 test suite on NonStop I'm getting the following surprise
>> error:
>>
>> expecting success of 0018.6 'advice should be printed when GIT_ADVICE
>> is set to true':
>>         q_to_tab >expect <<-\EOF &&
>>         On branch trunk
>>
>>         No commits yet
>>
>>         Untracked files:
>>           (use "git add <file>..." to include in what will be committed)
>>         QREADME
>>
>>         nothing added to commit but untracked files present (use "git
add"
>> to track)
>>         EOF
>>
>>         test_when_finished "rm -fr advice-test" &&
>>         git init advice-test &&
>>         (
>>                 cd advice-test &&
>>                 >README &&
>>                 GIT_ADVICE=true git status
>>         ) >actual &&
>>         cat actual > /tmp/actual &&
>>         test_cmp expect actual
>
>Sheesh.
>
>We should *not* be assuming what is in /tmp.  Our TMPDIR may not even be
set to
>point at /tmp.  Anybody can create directory 'actual'
>there and break this test.
>
>I thought this was a left-over debugging copy while reviewing the patch,
and I
>thought I had pointed it out to the author and/or I removed it while
queuing it.  The
>copy to /tmp/actual with cat should be removed.
>
>Thanks for noticing.  Are there other reference to /tmp in our test suite I
have to
>wonder...

Other than t0018...
* t0060 references /tmp but only for a synthetic repo path
* t1300 extensively uses /tmp with hard-coded file names for cookies.
* t7400 appears to work with submodules in /tmp but that may only be a
reference
* t9902 hard-codes a reference to the user home directory ~/tmp, which might
be fine
   but prevents parallel tests
The clar infrastructure assumes tests are done in /tmp (in find_tmp_path)
except
   for Windows, so that should be resolved also.

Regards,
Randall

