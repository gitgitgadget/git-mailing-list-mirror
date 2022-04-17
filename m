Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C096DC433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiDQSTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiDQSTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 14:19:51 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C75FD0
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ADU6qJoPJeb0TOZSRVPofS2Xgh/EvkiyBGOsb3hCzYo=; b=okJmupTbmFCI5VqT3pQEIdhu4T
        VgyXiu4krD8v9+MDnivoBlEyG/YlEbeN2ZbuXLGUK/EieEyw5Xv3d9Za9LlTexz+AsIuAxvXf6NjQ
        xU5XxW9jRy7a7CWBMfJbcEUeH/C4xDkYrM+6Qz5Mj15kKtC2cjL7dvQ6ErX03MX2orng=;
Received: from [2a00:23c7:899b:e701:24a7:3fe7:3574:d405]
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1ng9SR-0005J3-7F; Sun, 17 Apr 2022 18:17:11 +0000
Message-ID: <80e83d8e-1f68-16be-6d68-fbc4aadfc78d@adoakley.name>
Date:   Sun, 17 Apr 2022 19:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
Content-Language: en-US
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
 <20220413214109.48097ac1@ado-tr.dyn.home.arpa>
 <CAPMMpoiXNKNnARhJ2n+nzOj==-27YA68OvMmUyYnSaoLbfE4xw@mail.gmail.com>
From:   Andrew Oakley <andrew@adoakley.name>
In-Reply-To: <CAPMMpoiXNKNnARhJ2n+nzOj==-27YA68OvMmUyYnSaoLbfE4xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/2022 10:57, Tao Klerks wrote:
> On Wed, Apr 13, 2022 at 10:41 PM Andrew Oakley <andrew@adoakley.name> wrote:
>>
>> On Wed, 13 Apr 2022 06:24:29 +0000
>> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>>> Make the changelist-description- and user-fullname-handling code
>>> python-runtime-agnostic, introducing three "strategies" selectable via
>>> config:
>>> - 'legacy', behaving as previously under python2,
>>> - 'strict', behaving as previously under python3, and
>>> - 'fallback', favoring utf-8 but supporting a secondary encoding when
>>> utf-8 decoding fails, and finally replacing remaining unmappable
>>> bytes.
>>
>> I was thinking about making the config option be a list of encodings to
>> try.  So the options you've given map something like this:
>> - "legacy" -> "raw"
>> - "strict" -> "utf8"
>> - "fallback" -> "utf8 cp1252" (or whatever is configured)
>>
>> This doesn't handle the case of using a replacement character, but in
>> reality I suspect that fallback encoding will always be a legacy 8bit
>> codec anyway.
>>
>> I think what you've proposed is fine too, I'm not sure what would end
>> up being easier to understand.
> 
> I'm not sure I understand the proposal... Specifically, I don't
> understand how "raw" would work in that scheme.
> 
> In "my" current scheme, there is a big difference between "legacy" and
> the other two strategies: the legacy strategy reads "raw", but also
> *writes* "raw".
> 
> The other schemes read whatever encoding, and then write utf-8. In the
> case of strict, that actually works out the same as "raw", as long as
> the input bytes were valid utf-8 (and otherwise nothing happens
> anyway). In the case of fallback, that's a completely different
> behavior to legacy's read-raw write-raw.

The way I look at it is that you both read and write bytes, and you may 
attempt to decode and re-encode text on the way.  Both the decoding and 
the encoding are done in metadata_stream_to_writable_bytes, so nothing 
else needs to know about the raw option being different.

Perhaps it's easier to explain with a bit of (untested) code.  I was 
thinking of something like this:

def metadata_stream_to_writable_bytes(s):
     if not isinstance(s, bytes):
         return s.encode('utf-8')

     for encoding in gitConfigList('git-p4.metadataEncoding') or 
['utf-8', 'cp1252']:
         if encoding == 'passthrough':
             return s  # do not try to correct text encoding
         else:
             try:
                 return s.decode(encoding).encode('utf-8')
             except UnicodeDecodeError:
                 pass  # try the next configured encoding

     raise MetadataDecodingException(s)
> Is your proposal to independently specify the read encodings *and* the
> write encoding, as separate parameters? That was actually my original
> approach, but it turned out to, in my opinion, be harder to understand
> (and implement :) )

I don't think it's important to be able specify the encoding to be used 
in git.  I've not spotted anyone asking for that feature.  I think it 
could be added later if someone needs it.

>>>       * Does it make sense to make "fallback" the default decoding
>>> strategy in python3? This is definitely a change in behavior, but I
>>> believe for the better; failing with "we defaulted to strict, but you
>>> can run again with this other option if you want it to work" seems
>>> unkind, only making sense if we thought fallback to cp1252 would be
>>> wrong in a substantial proportion of cases...
>>
>> The only issue I can see with changing the default is that it might
>> lead to a surprising loss of data for someone migrating to git.  Maybe
>> print a warning the first time git-p4 encounters something that can't be
>> decoded as UTF-8, but then continue with the fallback to cp1252?
> 
> Honestly, I'm not sure how much a warning does. In my perforce repo,
> for example, any new warnings during the import would get drowned out
> by the mac metadata ignoring warnings.

FWIW in the perforce repository I work with this doesn't happen much and 
I would notice the additional warning about text encodings.  I suspect 
this will be another thing which varies a lot between repositories.

> I understand and share the data loss concern.
> 
> As I just answered Ævar, I *think* I'd like to address the data loss
> concern by escaping all x80+ bytes if something cannot be interpreted
> even using the fallback encoding. In a commit message there could also
> be a suffix explaining what happened, although I suspect that's
> pointless complexity. The advantage of this approach is that it makes
> it *possible* to reconstruct the original bytestream precisely, but
> without creating badly-encoded git commit messages that need to be
> skirted around.

I think this gets pretty messy though.  In my opinion it's not any nicer 
than putting the raw bytes in the commit message.

Git does not make any attempt enforce the commit metadata encoding, so I 
think that tools really should make an attempt to handle invalid data in 
a somewhat sensible fashion.

I don't think there is really a "right" answer, anything reasonable 
would be better than what we've got now.
