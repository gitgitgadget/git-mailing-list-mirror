Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BA156C0
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C0zqYDLm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F1BEE2276F;
	Tue,  2 Jan 2024 12:33:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gCR/droiqAyR
	rC9Qg4kD9B/LB2D4G3BBXvH2vSEw2q4=; b=C0zqYDLmNX0gm943keOs42R/1EFT
	um4oUYC1GQHdnmjUKwGDpJI7MuZEACQQ0RIGonv4L1oIjUBxDVhpWtta+PujJRNI
	pPBGtXUt29KloI9VhO9nchGHcnAU9MIg5MxVptIgXodFwoozM5HcglIH1xYKih7w
	HAQpt+icC9JRUz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E98EF2276E;
	Tue,  2 Jan 2024 12:33:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8FDC72276D;
	Tue,  2 Jan 2024 12:33:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/1] Replace SID with domain/username
In-Reply-To: <xmqqplyjg10l.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	02 Jan 2024 08:20:42 -0800")
References: <20231229120319.3797-1-soekkle@freenet.de>
	<20231229120319.3797-2-soekkle@freenet.de>
	<xmqqplyjg10l.fsf@gitster.g>
Date: Tue, 02 Jan 2024 09:33:10 -0800
Message-ID: <xmqqy1d7ej3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 00F0568E-A995-11EE-AEF4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> S=C3=B6ren Krecker <soekkle@freenet.de> writes:
>
>> Replace SID with domain/username in erromessage, if owner of repositor=
y
>> and user are not equal on windows systems.
>
> "erromessage" -> "error messages" or something?
>
> This may not be a question raised by anybody who know Windows, but
> because I do not do Windows, it makes me wonder if this is losing
> information.  Can two SID for the same user be active at the same
> time, which would cause user_sid_to_user_name() potentially yield
> the same string for two different SID?
>
> In any case, I am reasonably sure that Dscho will say yes or no to
> this patch (the above "makes me wonder" does not need to be
> resolved) and I can wait until then.
>
> Thanks.

Another thing I forgot to mention (but did wonder).  The new helper
function does allow LookupAccountSidA() to fail.  Should it fall
back to ConvertSidToStringSidA() that the original has been using?

In any case, I do not think a failure to convert will result in an
attempt to format ("%s", NULL) thanks to the existing code that uses
the stringified SID, which is good.
