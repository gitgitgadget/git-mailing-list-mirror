Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5E27EC7C
	for <git@vger.kernel.org>; Fri, 15 May 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834690; cv=none; b=ITGlK4bZ4I/R3J2XsNrWi3rHbE7PLPuYZ/foZCcwwwiTkpb3IZ2t71Wqj/vIhb/R+rTYALGV2DXPZ1VqL0zU0/YYb1vmW8PE1XLprDIanS3thhcM5Q4YeNUqagPM9pAvnj0CSRkJwe5EEPZej8MgLPLwmv+MF+MEjVBxzMCumN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834690; c=relaxed/simple;
	bh=iBvCbmyHCCysnc/Daoi7xEp7W2jKgXT44xepbbocfbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVxV59FArKGle+kqZ80wAkAXGBG7mPjx08NBg+C6mQaq+oH5vwj/qpC9ywUV3ElmSVFM536gpKWs45iCTIm4X1VtFI50pJ6KfTmbBMkWH2KkXiJxqY+gwQVmrBfCW1eYg1nYB+pGDknvIz4e3BNb4PJW1PbNEgk+drekxdZfqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=f3Zve5Jx; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="f3Zve5Jx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778834686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H7C6t3W8mMHkCCOLmFFsfgWPAxNvPHohdAo+VTMkvvg=;
	b=f3Zve5Jxyb3N1b83+DUpRCI++YltRThcUoN0y0C01KdKvbRXREkBeMXUqfSHaZVJS9ogDN
	6HzSTwuUAE9ZjdmKgwjPALUZLS/Z1qtrDA7upCgeIhiLl0VHWObSggHmlcnc8UJfGY5MRk
	6k7I7eHDc+BWqWM9AyVTxvB9s0VBNhQ=
From: Toon Claes <toon@iotcl.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] generate-configlist: collapse depfile for older Ninja
In-Reply-To: <0557838b-214d-4e8f-9cbd-bc342563e9ba@gmail.com>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
 <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
 <0557838b-214d-4e8f-9cbd-bc342563e9ba@gmail.com>
Date: Fri, 15 May 2026 10:44:40 +0200
Message-ID: <87wlx59i4n.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Phillip Wood <phillip.wood123@gmail.com> writes:

> I don't think this use of '\n' portable. The sed man page [1] says that 
> '\n' matches a newline in the pattern space, but does not mention it 
> being supported in the replacement string. We do have an existing use in 
> t4150-am.sh:"am newline in subject" which does
>
> 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
>
> However if I add "cat patchnl" it shows the subject line is
>
> 	Subject: [PATCH] second \n foo
>
> so sed has inserted "\n" rather than a newline. Indeed looking at the 
> commit message for that test it is testing a fix that c escapes are 
> printed verbatim introduced by 4b7cc26a74 (git-am: use printf instead of 
> echo on user-supplied strings, 2007-05-25).
>
> I've not tested it but I think
>
> 	sed 's/ $/\
> /'
>
> will insert a newline. Alternatively we could do
>
> 	printf '%s' "$QUOTED_OUTPUT: "
> 	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>   			"$SOURCE_DIR"/Documentation/config/*.adoc |
> 		sed -e 's/[# ]/\\&/g' |
> 		tr '\n' ' '
> 	printf '\n'

Whoops, I somehow archived your reply without addressing it. Thanks for
finding this. I've sent out v3 with this suggestion.

--
Toon

