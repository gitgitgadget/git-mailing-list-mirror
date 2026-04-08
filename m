Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F59242D89
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678950; cv=none; b=byzdtvCgHkCRtmASTe/dWO8BhC/eorqhLe/JRgiCzX+W+seuDc6fijjoebZ8kytaDHstdb03bucWraRL0Y96Wy88zuNcp3jIgk/rxtJ2UQvBM3KzALj7szBBcIAVFNGjN0HgP7eBoqb5ko1Pk2sBYuPAJ8Y1vbNFqhWpcKPA2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678950; c=relaxed/simple;
	bh=97tTaY+TPbYnhTgxu3VWYT5uESHGqkbJ3DqmUu6w69o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MZZaTxWP3BuDvmDYhvYu7pKOf5hsEbZGnvCaeF+FjK7QMRqUywv13hl1jTV9eI9q9972Ke0RPnHx3uoyuGWuNmpg0dFwbui9JYr5bRfLBRY5BeeJyK8erU6WtUh4E7oZURjSOIeAuZNCV5CjtsnzDVr0SE+6+QTnwDvGEeEKtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (ip6-212.eyrkonaeac07.dialup.ca.telus.com [209.29.97.212])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638K90L23356171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 20:09:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>	<20260408041716.GA1324339@coredump.intra.peff.net>	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>	<20260408173949.GB2850002@coredump.intra.peff.net> <xmqq4illz5g9.fsf@gitster.g>
In-Reply-To: <xmqq4illz5g9.fsf@gitster.g>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 16:08:55 -0400
Organization: Nexbridge Inc.
Message-ID: <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMsCTyy1LAGZ2yzlAlGDzHe1LGLVIA==
X-Antivirus: Norton (VPS 260408-8, 4/8/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 2:13 PM, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>> On Wed, Apr 08, 2026 at 12:25:47PM -0400, rsbecker@nexbridge.com wrote:
>>
>>> This is also impacting t5608 and t7700. Anywhere where writev() is
>>> used, seemingly. We went through MAX_IO_SIZE issues years ago,
>>> instead of using ssize_t as a basis of how big communication is. I
>>> think
>>> writev() is not valid. It worked on Lunix, but had issues elsewhere.
>>> This broke the compat layer.
>>
>> I wondered briefly if the problem could be that we're violating
>> MAX_IO_SIZE here, as our use of writev() does not respect it at all.
>> But the only spot that uses it is feeding pkt-line packets, which max
>> out at 64k. So unless your MAX_IO_SIZE is smaller than that, I doubt
>> that is the problem.
>
>Good point.  The original did not use write(2) directly but used
write_or_die(), that
>is write_in_full(), that loops over xwrite(), so it would have worked even
with a lot
>lower MAX_IO_SIZE limit.
>
>According to man7.org, writev() is allowed to transfer fewer bytes than
requested,
>so our use of writev() may have to be a bit more careful, though.

On my box, I have the following note:

Specifying  the sum of the iov_len values in the iov array greater than
the OSS I/O size limit for that open causes the  writev()  function  to
return  -1  and  set errno to [EINVAL].

This can be either 52K (SSIZE_MAX) or 868K depending on the build settings.
We are currently stuck with 32-bit builds, with large file support, so
really no
limit on the file sizes, but due to dependencies that are stuck at 32-bit
until I
convince the powers that be to fix those. Please, can we be compliant with
MAX_IO_SIZE?

