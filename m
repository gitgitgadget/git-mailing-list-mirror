From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_open_noatime: return with errno=0 on success
Date: Wed, 05 Aug 2015 09:27:12 -0700
Message-ID: <xmqqvbct4s67.fsf@gitster.dls.corp.google.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com>
	<CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
	<20150804082429.GA22271@musxeris015.imu.intel.com>
	<xmqqfv3y6a24.fsf@gitster.dls.corp.google.com>
	<CA+55aFx-WXxCbVTWdJHFf4WA2MNXS3UMerv4cD1wtsZGaQkJLw@mail.gmail.com>
	<20150805143600.GA3111@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Martin =?utf-8?Q?Schr=C3=B6der?= <martin.h.schroeder@intel.com>
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN1XE-0000DE-LN
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 18:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbbHEQ1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 12:27:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34741 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbHEQ1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 12:27:16 -0400
Received: by pawu10 with SMTP id u10so39654411paw.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=n2ZV6ucfVgQupwjVQ3a3LrSKC5cWF009Tt4QKsxCPwg=;
        b=WCTdJxdiCkfU6qNuodfaFKeifd0jRzIiGMYCgrx43UgfKAd8hDVJvNHmVotZFdnG8Z
         UbNsa0/NAfdbpUrIxaKnMlfyelY1aYBu0VQW0vqiJFWxbzKjCrJeEzafxt1vh+/LG0ll
         Of8qyfyeRFdbYHfql5jhtQkv5twn8rhiRj8CJvZaSn1R/LGTJy6PVRo/iTRyuOa6/ZrF
         ZboPhDvvpBmPiSj2LTLRb9J9dz9CDCb1KTlbLQ1iUe3lj7gTmONkdSdpAKcFbnksezbW
         nOkiWzN+tlAxQjOEF5MTXIIyjmyMTsr0XXYCGxXzYczlrZ3p9gmpQU0hMHUMbQM0eKZD
         42cg==
X-Received: by 10.68.134.169 with SMTP id pl9mr21201419pbb.164.1438792035558;
        Wed, 05 Aug 2015 09:27:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id oe7sm3407258pbb.66.2015.08.05.09.27.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 09:27:14 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275373>

Clemens Buchacher <clemens.buchacher@intel.com> writes:

> On Wed, Aug 05, 2015 at 10:59:09AM +0200, Linus Torvalds wrote:
> ...
>> A stale 'errno' generally shouldn't matter, because we either
>> 
>>  (a) return success (and nobody should look at errno)
>> 
>> or
>> 
>>  (b) return an error later, without setting errno for that _later_ error.
>> 
>> and I think either of those two situations are the real bug, and this
>> "clear stale errno" is just a workaround.
>
> I agree. But I do not see how to get there easily.
>
> We are trying to read an object. We first try to read from a pack. We
> may encounter broken pack files, missing index files, unreadable files,
> but those errors are not necessarily fatal since we may still be able to
> read the object from the next pack file or from a sha1 file.
>
> If finally we do not find the object anywhere, in
> read_sha1_file_extended we try our best to die with an appropriate error
> message, for example by looking at errno, and otherwise we just return
> NULL. Most callers seem to die explicitly or they dereference the null
> pointer.
>
> I think we should instead output error messages closer to the source,
> like for example in map_sha1_file, but continue anyway.

Hmm, if we find one data source unreadable but an alternative
usable, do we really want that error message?  What should it say?
"error: cannot read from pack"?  Such a message, unless we later
give "info: but we managed to read it from elsewhere" and make sure
these two messages are clearly associated with each other, would
make things unnecessarily alarming, wouldn't it?

Perhaps we should not rely so heavily on 'errno', but explicitly
pass around error code (or enough information to formulate an
intelligent message at the end) in the callchain instead.

Then the earlier part can notice EPERM on a pack, for example, and
return to the caller, and after consulting an alternate data source
(e.g. loose object file), the caller can then choose to say "we
managed to read the data, but FYI, you may want to check the
permission bits of this pack", or choose to stay silent.
