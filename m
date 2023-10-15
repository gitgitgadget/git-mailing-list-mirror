Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC87461
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92CD9
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 10:30:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 39FHRarM3865437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Oct 2023 17:27:36 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Beat Bolli'" <dev+git@drbeat.li>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Feiyang Xue'" <hi@fxue.dev>, <git@vger.kernel.org>
References: <20231012200447.3553757-1-hi@fxue.dev> <ZSmxFopwJyBGmZY-@tapette.crustytoothpaste.net> <fd59abd6-49a5-4f6a-8d6c-c608cd3350f7@drbeat.li>
In-Reply-To: <fd59abd6-49a5-4f6a-8d6c-c608cd3350f7@drbeat.li>
Subject: RE: [PATCH] Add x64 SHA-NI implementation to sha1 and sha256 in git ?
Date: Sun, 15 Oct 2023 13:30:28 -0400
Organization: Nexbridge Inc.
Message-ID: <022101d9ff8d$4dc63fd0$e952bf70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2Bk5iqPNAmCiGRENBCqeXA9sosQKJ8qoeApaFbsWvagkiIA==
Content-Language: en-ca
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sunday, October 15, 2023 12:37 PM, Beat Bolli wrote:
>On 13.10.23 23:05, brian m. carlson wrote:
>> On 2023-10-12 at 20:04:47, Feiyang Xue wrote:
>>> Looking for comments on if this is a good idea to add SHA-NI option
>>> to git, And if so, what'd be a good implementation.
>>>
>>> The attached patch is more of a proof of concept,  using a sha-ni
>>> example found on internet and have it tapped into git's "hash-ll.h"
>>> when it sees make flags "SHA1_SHANI=3D1" and/or "SHA256_SHANI=3D1" =
for
>sha1/sha256 respectively.
>>>
>>> "git hash-object" is about 3-ish times faster for me
>>
>> You almost certainly don't want to use SHA-1 using native =
instructions
>> because it doesn't detect collisions, unlike the default
>> implementation (SHA-1-DC).  Since SHA-1 collisions are relatively
>> cheap (less than USD
>> 45,000) to make, not detecting collisions would be a security issue
>> worthy of a CVE.
>>
>> It's fine for SHA-256, but see below.
>>
>>> There are few topics that i'm uncertain about.
>>>
>>> 1. Is it good idea to have machine-specific asm codes in git. I read
>>> there was commit fd1ec82547 which removed assembly implementation =
for
>>> PPC_SHA1. Does that imply maintainers doesn't want machine-specific =
assembly
>in source?
>>
>> I'd prefer we didn't.
>>
>> Nettle has SHA-NI extensions on systems that support it, and so does
>> OpenSSL.  OpenSSL can't be used by distros for licensing reasons, but
>> Nettle can, and both of those libraries automatically detect the best
>> code to use based on the chip.  One of those libraries is almost
>> always going to be linked into Git at some point because of libcurl =
anyway.
>>
>> If we ship the code, then someone has to maintain it, and I don't =
know
>> if we have any assembly experts.  We might also have a bug that
>> produced incorrect results, which would be pretty disastrous for the
>> affected users.  It's much better for maintainability if we push that
>> off onto the cryptographic library maintainers who are much more
>> competent in that regard than I am (I will not speak for others) and
>> let distro maintainers simply link the appropriate library, which, as
>> I said above, they're already effectively doing.
>
>In addition to all the valid points brian makes, the patch uses a =
non-standard
>assembler (yasm, see http://yasm.tortall.net/) that's not part of the =
default GNU
>toolchain.

Aside from that, not everyone uses the GNU toolchain. I would suggest =
that if someone needs ASM support for SHA-1, they could reimplement =
SHA-1-DC using rotate ASM primitives instead of directly using SHA1 =
assembly, but I question whether that is significantly faster than =
having the compiler optimizer generate the equivalent rotates. Still, =
maintaining any ASM code requires out of box skillsets that are unlikely =
sustainable.
--Randall

