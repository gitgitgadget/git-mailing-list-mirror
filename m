Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE12199A7
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schlueters.de header.i=@schlueters.de header.b="UZfsuWZ/"
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 05:18:05 PST
Received: from mail.toneristzuen.de (mail.toneristzuen.de [84.19.169.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CA5A7
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 05:18:05 -0800 (PST)
Received: from [192.168.11.7] (133-32-227-85.east.xps.vectant.ne.jp [133.32.227.85])
	by mail.toneristzuen.de (Postfix) with ESMTPSA id 4A64B45B09
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:12:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schlueters.de;
	s=schluetersde202305; t=1700053978;
	bh=R/SN7Mml/ED6VVCRqEJDOrqfdzTlmhAqT9T82lQ4bCA=;
	h=Date:To:From:Subject:From;
	b=UZfsuWZ/o/3Nnmb2ClCLf87Fp/nG0L/aGSdAc2G4W/wS1oTZxCI9/ZqUfPF39mrFe
	 0ABEl1LJgduJf/0jzgrIeMEERyfJOTgroM1KjYoAfe/lihyKpTW+8x7pbxlp0/WgTK
	 Z5NkPHK5qaVZbf2n2aVJi0pcRY0pk1f1eJ7iKrL4/SNkDM6AESU+1TBhveWqpilork
	 F16F1lBe2BhScUe59wMwkOyiOAMY6nVKM1J50UITxBcfto/Lrm+/d653yrWSZHk8Bs
	 3spA5mQ1fOaHBURvt18nkHELCv6Qm7+ML9adDM9s+c4MZQoPHtCD+M7BncSsaOLO3h
	 LbLHHEw8upqhQ==
Message-ID: <f06d2964-3af2-425c-a68d-803ede45ee08@schlueters.de>
Date: Wed, 15 Nov 2023 22:12:49 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Tobias_Schl=C3=BCter?= <tobi@schlueters.de>
Subject: Shallow clones becomes not-shallow when cloning to a different drive
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I reported this on github but I was asked to take it here [*].  I had to 
deal with the following scenario today (on Windows, but not OS-specific):

$ git clone  --single-branch --branch feature/bla --depth 200 
~/source/Repos/bla ${PATH_ON_DOFFERENT_DRIVE}/bla
Cloning into './bla'...
warning: --depth is ignored in local clones; use file:// instead.
... run out of disk space because it does a full clone ...

Doing something different than the user asked for, and in a way that can 
lead to dangerous scenarios, is a bad choice.  In this case I was 
copying to a USB stick, but it could also be a system drive that runs 
out of space.

Additionally, the suggestion to use "file://" instead turned out to be 
impractical, as it is very slow.  I started the operation with 
"file://..." replacing the repository path on the command line before my 
lunch break.  When I came back it had copied a mere 100MB.

I would suggest to not imply "--local" when copying to a different 
device, and I would suggest to avoid doing something different than what 
the user asked for.  In this case I specifically asked for a shallow 
copy to save resources, the logic that a local copy using hard links 
actually saves more resources simply didn't apply.  Additionally, I 
would suggest investigating potential performance issues in the case of 
a shallow clone with file:// paths.

Please consider changing these choices and defaults.

Best regards,
- Tobi

[*] https://github.com/git-for-windows/git/issues/4693
