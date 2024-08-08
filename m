Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E24A1E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148078; cv=none; b=NtAmH+eWRkZSR0fpGLfnWfBEOF8WAmkd+iLesQVv8ZdjwA8l3ROmr9NbFRnwvElCNtNtF79AysiagEHkP8Fu2fDux5Niq0+f+wQ6G/A1HWDuu7IV8J8qBgYKaQ5JlN3dPhi48REmyeX1xuZVZnEJjs6GeGgk1GXT5EiYD28MP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148078; c=relaxed/simple;
	bh=18LJVNo0I4dyITd2RfcjeYzk7D1A+rFzeFMXuKwld+I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=te0Au/7F8xnOrnIaTqENaADjLt+dka1WDGPTFYCLn3Tv7k10UgQKV32sAYhlRl0j/h7bWK4sPdKIESZPzrGF22biTHdnVQbBViLtRe0W8yrkueKhFHImXlmpseu7O5DIHmc/a2PcM7uzU0T8RR93j77o4b/G4jMpuAUB1F2l7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 478KEOw2743072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 20:14:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Josh Steadmon'" <steadmon@google.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>, <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>
References: <cover.1723054623.git.steadmon@google.com>	<9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>	<ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>	<0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>	<zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>	<0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com>	<bs36iyp3yzb5l52t6yw5364odvugrt22jfeypqohtzdwp22ecj@kurf4p62qibu>	<00d901dae9c2$dc9c29c0$95d47d40$@nexbridge.com> <xmqqcymihjny.fsf@gitster.g>
In-Reply-To: <xmqqcymihjny.fsf@gitster.g>
Subject: RE: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
Date: Thu, 8 Aug 2024 16:14:19 -0400
Organization: Nexbridge Inc.
Message-ID: <00e901dae9cf$9065e570$b131b050$@nexbridge.com>
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
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAGPn9K4AelD3ekBSZ9iqwHkOcN8AlLsGwwBugQaPAJKDmKJAsPNt5qy0LVL0A==
Content-Language: en-ca

On Thursday, August 8, 2024 3:58 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I got to:
>>
>> ld -r contrib/cgit-rs/public_symbol_export.o libgit.a
>> reftable/libreftable.a xdiff/lib.a -o
>> contrib/cgit-rs/partial_symbol_export.o
>> /usr/bin/c89: illegal option -- r
>>
>> The -r option is not supported on NonStop. I think we had discussed this.
>
>Does it happen to call the feature under different name?  'r' stands for
relocatable
>output, but some linkers may call the feature as incremental linking and
use '-i'.

Well... depends on some factors. ld should not be run directly. Other links
are done
via the CC setting in config.mak.uname. That would invoke c99 for us for the
linker
as with the rest of git C, and that would make thinks somewhat easier as the
linker
is either xld or eld depending on the hardware.

The -Wr option to c99 creates a load file in this situation, which might or
might not
work. I need to look at it after built. I don't think it is what we want.
What I think
we need is -Wxld=unres_symbols ignore which builds an object that can be
linked to other objects even with undefined link symbols - although maybe
not.
I need to be able to select a different option on ia64, but that may not
matter
much. I still worry that we are depending on non-portable linker semantics
that
may not give the result we ultimately want.

Would not the build option be best selected in config.mak.uname?

Maybe GITRS_LINKER= or GITRS_CFLAGS=, etc.

