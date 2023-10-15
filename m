Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E179C2
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 09:42:47 PDT
Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5221CAB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 09:42:47 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1qs477-0004Kh-0K
	for git@vger.kernel.org;
	Sun, 15 Oct 2023 18:37:13 +0200
Received: from [10.20.10.233] (port=3054 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96)
	(envelope-from <dev+git@drbeat.li>)
	id 1qs475-0026H6-2s;
	Sun, 15 Oct 2023 18:37:11 +0200
Message-ID: <fd59abd6-49a5-4f6a-8d6c-c608cd3350f7@drbeat.li>
Date: Sun, 15 Oct 2023 18:37:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add x64 SHA-NI implementation to sha1 and sha256 in git ?
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Feiyang Xue <hi@fxue.dev>, git@vger.kernel.org
References: <20231012200447.3553757-1-hi@fxue.dev>
 <ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

On 13.10.23 23:05, brian m. carlson wrote:
> On 2023-10-12 at 20:04:47, Feiyang Xue wrote:
>> Looking for comments on if this is a good idea to add SHA-NI option to git,
>> And if so, what'd be a good implementation.
>>
>> The attached patch is more of a proof of concept,  using a sha-ni example
>> found on internet and have it tapped into git's "hash-ll.h" when it sees make
>> flags "SHA1_SHANI=1" and/or "SHA256_SHANI=1" for sha1/sha256 respectively.
>>
>> "git hash-object" is about 3-ish times faster for me
> 
> You almost certainly don't want to use SHA-1 using native instructions
> because it doesn't detect collisions, unlike the default implementation
> (SHA-1-DC).  Since SHA-1 collisions are relatively cheap (less than USD
> 45,000) to make, not detecting collisions would be a security issue
> worthy of a CVE.
> 
> It's fine for SHA-256, but see below.
> 
>> There are few topics that i'm uncertain about.
>>
>> 1. Is it good idea to have machine-specific asm codes in git. I read there was
>> commit fd1ec82547 which removed assembly implementation for PPC_SHA1. Does that
>> imply maintainers doesn't want machine-specific assembly in source?
> 
> I'd prefer we didn't.
> 
> Nettle has SHA-NI extensions on systems that support it, and so does
> OpenSSL.  OpenSSL can't be used by distros for licensing reasons, but
> Nettle can, and both of those libraries automatically detect the best
> code to use based on the chip.  One of those libraries is almost always
> going to be linked into Git at some point because of libcurl anyway.
> 
> If we ship the code, then someone has to maintain it, and I don't know
> if we have any assembly experts.  We might also have a bug that produced
> incorrect results, which would be pretty disastrous for the affected
> users.  It's much better for maintainability if we push that off onto
> the cryptographic library maintainers who are much more competent in
> that regard than I am (I will not speak for others) and let distro
> maintainers simply link the appropriate library, which, as I said above,
> they're already effectively doing.

In addition to all the valid points brian makes, the patch uses a 
non-standard assembler (yasm, see http://yasm.tortall.net/) that's not 
part of the default GNU toolchain.

Cheers, Beat
