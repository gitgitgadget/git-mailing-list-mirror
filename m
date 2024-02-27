Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64A51C4D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060703; cv=none; b=gCayBGrS1lBH2tqC9B6NVAgFKzGHs5Klgx8emIYUnCeKLHMNaqccM56XzDIcRD4YTwSuBmCD1hwi1JNJp+kYv9EgbVvwc7XWKQFrmXRnnzWy4NqEzMrPMdHwY3CT0Unr2zQKD0K41ZJ/OcFoNKowkmhoiujgSdeBME5gsJsGOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060703; c=relaxed/simple;
	bh=hzDSJumqD5QFqZNBfbTjLAYNUZpWjZwCGJySQmR+ETQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5vB1WTv3m26hhczM5ogfTBXyT39okOWEk7ou3lvYwpmyX4mNogxv71lrhLNizF5nI4m278l4Hrna/MVbPRc+YdW5AKbpDdZV1e33l6TnuPNubK4DCfweokZdEnxonmtfnvXUUT29oTlgZCQwSo1UumGa3aAH+C8cjCc7c5qPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41RJ4peq2417406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 19:04:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>
Cc: <git@vger.kernel.org>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>	<20240227150934.7950-4-randall.becker@nexbridge.ca> <xmqq1q8xspht.fsf@gitster.g>
In-Reply-To: <xmqq1q8xspht.fsf@gitster.g>
Subject: RE: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to write_in_full avoid truncation.
Date: Tue, 27 Feb 2024 14:04:46 -0500
Organization: Nexbridge Inc.
Message-ID: <03be01da69af$d8366e10$88a34a30$@nexbridge.com>
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
Thread-Index: AQGTtmWLBzH5H5YYc4gTr69qQSdMrgGN4n36AkbyxfqxjUuIIA==

On Tuesday, February 27, 2024 1:59 PM, Junio C Hamano wrote:
>"Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>
>> This change is required because some platforms do not support file
>> writes of arbitrary sizes (e.g, NonStop). xwrite ends up truncating
>> the output to the maximum single I/O size possible for the destination
>> device if the supplied len value exceeds the supported value.
>> Replacing xwrite with write_in_full corrects this problem. Future
>> optimisations could remove the loop in favour of just calling
write_in_full.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  builtin/unpack-objects.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c index
>> e0a701f2b3..6935c4574e 100644
>> --- a/builtin/unpack-objects.c
>> +++ b/builtin/unpack-objects.c
>> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char
>> **argv, const char *prefix UNUSED)
>>
>>  	/* Write the last part of the buffer to stdout */
>>  	while (len) {
>> -		int ret = xwrite(1, buffer + offset, len);
>> +		int ret = write_in_full(1, buffer + offset, len);
>>  		if (ret <= 0)
>>  			break;
>>  		len -= ret;
>
>Why do we need this with a retry loop that is prepared for short
>write(2) specifically like this?
>
>If xwrite() calls underlying write(2) with too large a value, then your
MAX_IO_SIZE is misconfigured, and the fix should go there, not
>here in a loop that expects a working xwrite() that is allowed to return on
short write(2), I would think.

I experimented with using write_in_full vs. keeping xwrite. With xwrite in
this loop, t7704.9 consistently fails as described in the other thread. With
write_in_full, the code works correctly. I assume there are side-effects
that are present. This change is critical to having the code work on
NonStop. Otherwise git seems to be at risk of actually being seriously
broken if unpack does not work correctly. I am happy to have my series
ignored as long as the problem is otherwise corrected.

