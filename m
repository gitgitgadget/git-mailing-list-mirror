Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5512F5A3
	for <git@vger.kernel.org>; Fri, 31 May 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198825; cv=none; b=aPED3NvKtF+5O6ijvF69jZ6iSQAUdV8sSurzpO5ZWpMnwOrNKXrCsd7dE1acWdaOMr38dhcUckhTixlCUY8kzJN+LesE7coIjbNX4pC2NdyWSM99b1GNzvS26ObUJAUWxRKebaN0mz1W2LYFlFTjs/HdNxV1QoUgQdSaBWeiC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198825; c=relaxed/simple;
	bh=kvY2uuG821PsXLGVq1ehs2UdqPXwQf1bzv3wumf2yBY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YrRd3YMjxXs9fa3P5h3P5D8Cy4r4QOh6X0gyBLIJ4ojQxug5S4WIcf3YnZT7SEzRNJ71rZfVRV0T8Zz0U0xQR6G+uo7t3DLi9H+p73D4iWhdood07mhMhhBnEOog4+Cn3+YFXMbLFwVXczBtPw3D7MAmIFQZi907uKsfKgD7ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 44VNaABQ3931149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:36:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Curley Joe'" <m48cv7wg9w@liamekaens.com>
Cc: <git@vger.kernel.org>
References: <16919-1717194882-875013@sneakemail.com> <xmqqplt1d0k0.fsf@gitster.g>
In-Reply-To: <xmqqplt1d0k0.fsf@gitster.g>
Subject: RE: git fetch --prune fails with "fatal: bad object"
Date: Fri, 31 May 2024 19:36:04 -0400
Organization: Nexbridge Inc.
Message-ID: <000501dab3b3$51779400$f466bc00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI043XPFU/F/QSjVTElGNn+CpOJywIXTw4bsOzkd0A=
Content-Language: en-ca

On Friday, May 31, 2024 7:28 PM, Junio C Hamano wrote:
>"Curley Joe" <m48cv7wg9w@liamekaens.com> writes:
>
>> git fetch --prune fails with "fatal: bad object" for refs that have =
an
>> invalid sha1 pointer. It would be nice if "git fetch --prune" could
>> prune these refs, because it is a hassle to do it manually. ("git
>> fetch --prune" only shows the first invalid ref, and you have to run
>> "git fsck" and parse it to find the rest.) If it seems like adding
>> this functionality to --prune is a bad idea, then how about adding an
>> option like "--prune-invalid" ?
>
>A question and a comment.
>
> - Why did the repository got into this state in the first place?
>   It seems that it would be much better solution to prevent refs
>   from having garbage values in them or to prevent objects that are
>   necessary from going away than any "prune invalid refs" feature.

I agree. However, there are some configurations where disk write caches =
are enabled and require a sync or some other flush operation to force a =
complete write to disk. In such situations, corruptions are always =
possible despite the best efforts by the application.

> - "fetch" still feels a wrong place to have the feature, if it is
>   about fixing a local repository corruption.  You should be able
>   to recover from such a broken ref even if you are only working
>   locally without fetching from anybody.

I think fsck would be a better place for this.

>If you can somehow _enumerate_ such broken refs, you could drive =
update-ref to
>remove them.  Na=C3=AFvely, an obvious place to add such a feature =
might be the "for-
>each-ref" command that is used to list refs with various criteria, so =
it might look like:
>
>   $ git for-each-ref --format=3D'%(refname)' --broken |
>     xargs git update-ref -d
>
>or something?

