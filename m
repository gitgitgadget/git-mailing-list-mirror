From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Tue, 14 May 2013 00:22:00 -0700
Message-ID: <CAJDDKr7hYvDMWLo6VWNuS0E2FYdKqmuDrLEG6CPr+6f0uCS9_g@mail.gmail.com>
References: <1368433419-24065-1-git-send-email-davvid@gmail.com>
	<1368433419-24065-2-git-send-email-davvid@gmail.com>
	<CAPig+cQwhhwyt+XHXz2_PLqmZ=goy7pz-GC3kFqOHm1R6=70YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 14 09:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc9Ym-00056H-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 09:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab3ENHWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 03:22:04 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:64476 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab3ENHWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 03:22:02 -0400
Received: by mail-we0-f175.google.com with SMTP id p57so150710wes.6
        for <git@vger.kernel.org>; Tue, 14 May 2013 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oa2rJMf2DTvPpgqZhjnkCviYL87qpqUrRgoqXb0sJU0=;
        b=01N+iR/vRteuqaQrvt/pFGN++pkl9UphbuMyiv2gTX0A24sNnocApNtOWHybPb1NXf
         g9qIgtgC9sx2j7fJ2SqyBpBYXU6AIw8bVQnEBL5kunva3BM/LVkgdi7509gUQLM2ZLqV
         e/+8y6HZ2ohYtQCKkHlMs9ntbAnK+tdvGkKcgDZmHuVZkN66D5v9SsuDyzqHiwekbVxz
         xiAUU9HBCCAfZv4x9BbenWtOqlw7xTVYaqoTi8oSR1AW2LgNqmGJ3tkLK4LYHsutnSf8
         Et9hKN971oSL9QcXHeyfIeA7ubP8KBriJ2VXv16Q1GZ4XWxxYIdb5dkedGIbZ9R6D3KZ
         FBNw==
X-Received: by 10.180.105.195 with SMTP id go3mr3644846wib.2.1368516120624;
 Tue, 14 May 2013 00:22:00 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Tue, 14 May 2013 00:22:00 -0700 (PDT)
In-Reply-To: <CAPig+cQwhhwyt+XHXz2_PLqmZ=goy7pz-GC3kFqOHm1R6=70YA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224284>

On Mon, May 13, 2013 at 6:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 13, 2013 at 4:23 AM, David Aguilar <davvid@gmail.com> wrote:
>> Mac OS X Mountain Lion prints warnings when building git:
>>
>>         warning: 'SHA1_Init' is deprecated
>>         (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by using the CommonCrytpo SHA-1
>> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>>
>> Add a COMMON_DIGEST_SHA1 option to the Makefile to allow
>> choosing this implementation and define it by default on Darwin.
>
> The approach of adding a Makefile option for each CommonCrypto
> facility does not really scale well. For instance, these days, I
> generally build git against OpenSSL from MacPorts, which gives me a
> warning-free git build since MacPorts/OpenSSL lacks those
> Apple-specific deprecation flags. With this patch series introducing
> several Makefile knobs, people wishing to use MacPorts/OpenSSL will
> have to tweak each knob. These patches already introduce two knobs
> (COMMON_DIGEST_SHA1, COMMON_DIGEST_HMAC). Adding more knobs to silence
> the remaining 29 deprecation warnings will make the build more
> cumbersome for those who prefer OpenSSL. Instead, introducing a single
> knob (such as APPLE_COMMON_CRYPTO) would avoid this problem.

That sounds like a good idea.  In the very least these patches should
be redone to do that.

> More generally, is the approach of trying to figure out CommonCrypto
> replacements for DIGEST, HMAC, and the other 29 warnings worthwhile?
> After all, Apple introduced deprecation warnings due to the
> ABI-instability of OpenSSL, not due to any particular flaw in OpenSSL
> or its API. A more manageable approach might simply be to disable that
> particular warning on Darwin (via CFLAGS or perhaps '#pragma GCC
> diagnostic ignored' for more fine-grained control).

My only fear would be that these deprecation warnings would one day
become errors due to the functions being removed.  I don't know how
else to interpret "deprecated".

If we can accomplish the same thing without deprecated APIs (and not
harm other platforms) then that is a good thing.  I doubt we can find
1:1 replacements.  It'll probably have to be fleshed out in compat/.

Warnings in 1 file (imap-send.c) is much better than warnings in 20
files (git grep -l SHA1_Final), which is the itch I'm currently
scratching.  I'll be mindful of making sure that the users can still
plug in their own compliant OpenSSL.
--
David
