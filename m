Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A961DDE4
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="re5qC4/U"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0884A2CAB0;
	Wed,  3 Jan 2024 17:23:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EeiLY5omU4fJ
	xZw6+3R5wK224JDmKPazKUdsOrY6DVQ=; b=re5qC4/UvMWeFi7VqRJvOsiR0f4C
	eztv9i0fGAszzc2PpGtGB/+A4Q+We8b9LZ0rB6KbRxjWj8tMoJo7EWSYmkz1N7dl
	WfvXDCaW/myHTqibbakk8IdgLzPqQOqE9ZLy10FLpwk4toNrN4wZQK88uSo8PlHn
	abzYzBsXKTEUf7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01BFC2CAAF;
	Wed,  3 Jan 2024 17:23:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4CEC2CAAC;
	Wed,  3 Jan 2024 17:22:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  sunshine@sunshineco.com
Subject: Re: [PATCH V4 1/1] Replace SID with domain/username
In-Reply-To: <DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Wed, 3 Jan 2024
 09:21:16 +0100
	(CET)")
References: <xmqqsf3feilq.fsf@gitster.g>
	<20240102191514.2583-1-soekkle@freenet.de>
	<20240102191514.2583-2-soekkle@freenet.de>
	<xmqqa5pnckm4.fsf@gitster.g>
	<DB9P250MB0692C8B4D93ED92FEE680AA9A560A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Wed, 03 Jan 2024 14:22:58 -0800
Message-ID: <xmqqil4a83b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A6E6CF04-AA86-11EE-86C1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> This patch only changes the output of our error message, though.
> It does not change what ownership information we actually compare.
> So if we had a hypothetical user Bob that was part of the  domain
> example.com (SID S-1-5-21-100000001-1000000001-10000001-1001) and
> had been moved over from the example.org domain (old SID S-1-5-21-
> 2000000002-2000000002-20000002-2002) and we would detect a repository
> owned by bobs old SID, we would now lookup the old SID, find it
> attached to a user named example.com\Bob, look up Bobs  current SID,
> find it belongs to a user named example.com\Bob and print a confusing
> error message.

Yup, that is exactly the kind of breakage I was worried about.

Perhaps we should do something along the lines of ...

 - The erroring out should be done purely by SID comparison, as that
   is what we have been doing to protect the users.

 - When creating a message, use LookupAccountSidA() to come up with
   a pair of domain\user strings for the directory and the process
   to be used in the error message:

   - If they are different (which is expected to be the normal
     case), we just use the pair of strings.

   - If they are the same, show old and new SID in stringified form
     (hopefully different SIDs would strigify to different
     strings?), and optionally we give the domain\user string next
     to it.

... then?  Then we would emit an error message (in the best case)

    'directory' is owned by:
    'bob@example.org'
    but the current user is:
    'charlie@example.com'

and in a bad case we would instead see something like:

    'directory' is owned by:
    SID S-1-5-21-100000001-1000000001-10000001-1001 ('bob@example.org')
    but the current user is:
    SID S-1-5-21-200000002-2000000002-20000002-2002 ('bob@example.org')

which may still be serviceable.  I dunno.

