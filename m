Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAD369
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="avjf0y+N"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24DD54
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 04:39:38 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AEE1239B6;
	Sun, 12 Nov 2023 07:39:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6WIrOBF7C0S5qKLK4CZfo9CyuzMxAMbLU3sGZX
	NvfO4=; b=avjf0y+NfU1CX7fCWiHnr7INYzK+qPklg2gza+Ai7F3ZsLjMQFSYn4
	jwWzkS9jSZtRNzwT1j88og5LeLGjC/nZc7flkXLZolLU6vIxNZcJ6eBp01c4EdhW
	yHzowy6H+5v72pEai4NQCJ+XwIVkfQxgIgzUdoNaaX25B7N/O93oQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 843C7239B5;
	Sun, 12 Nov 2023 07:39:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2ECD1239B0;
	Sun, 12 Nov 2023 07:39:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH] fuzz: add new oss-fuzz fuzzer for date.c / date.h
In-Reply-To: <xmqqfs1bo6l4.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	12 Nov 2023 14:59:03 +0900")
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
	<xmqqfs1bo6l4.fsf@gitster.g>
Date: Sun, 12 Nov 2023 21:39:32 +0900
Message-ID: <xmqq7cmnno1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 887D1E9E-8158-11EE-990D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> As I used the first byte to fuzz dmtype and .local, let's use the
> next three bytes to allow feeding overly wild timezone values to the
> machinery and see what breaks, perhaps like so:
>
> 	tz = *data++; /* int tz; */
> 	tz = (tz << 8) | *data++;
> 	tz = (tz << 8) | *data++;
> 	size -= 3;

Just this part.  As data points at unsigned char, the above would
not give us any negative number.  We'd need to sign-extend the
24-bit resulting value if we are going to adopt the above approach.
