From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: A few "linked checkout" niggles
Date: Thu, 16 Jul 2015 01:40:18 -0400
Message-ID: <CAPig+cQ9V0rmZZrhB=dCu01kiCGpyNVmx7PeXQqBQ=zvk_DF3g@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
	<CACsJy8CLYz7HqScS5Bxo47kTbrNj=qsaZnkKQ9ob4UVbjGG62Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 07:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFbuD-0001M5-4S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 07:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbbGPFkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 01:40:20 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35969 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbGPFkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 01:40:19 -0400
Received: by ykay190 with SMTP id y190so55830460yka.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WanafuG96i31dMZsVv+gUjWKYgyfTH8fKldcYWCcLzU=;
        b=YceT7OA2CYsiCaUeg1DipIIviqeXiiD0SEzJEAEI/3evkpoVKcpzC7PO+sujA5Xof2
         B89mD9qUYfmCCzeVfxJIKnJIvDaeB8jJWamQMSiDIhhmHdJw93CY8GYw/V7+zw7QLN+e
         swxlyhwOdUNaJhmYqYS4b2c9pyLwZ8n2uacEir2lEuFOs65+f02wA9Pg2XcydkSc2JxF
         wVnvoxsbX3DMLJX1P3WDN5oeza6GtJBZiqq8ZypcqUIGl85KHZv/vu07EJXwuyiu5ggL
         dnqzWO4LhR/sWr09xFEkHY/fqrIIjrmHnUugvWKDkRxAskzEyCjNvSXnjp9dopJ4ANnd
         GQSg==
X-Received: by 10.170.233.10 with SMTP id z10mr7828368ykf.71.1437025218452;
 Wed, 15 Jul 2015 22:40:18 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 15 Jul 2015 22:40:18 -0700 (PDT)
In-Reply-To: <CACsJy8CLYz7HqScS5Bxo47kTbrNj=qsaZnkKQ9ob4UVbjGG62Q@mail.gmail.com>
X-Google-Sender-Auth: qMr2XrUvUjWbZxx-DSKP4yxX9cU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274007>

On Thu, Jul 16, 2015 at 1:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 16, 2015 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I've tried to set up a non-bare clone of git.git at ~/w/src and
>> attached one of its branches to a separate work tree at ~/w/rerere
>>
>>  ~/w/src$ git worktree add ../rerere jc/rerere
>>
>> Then I tried the "multiple checkout not allowed".
>>
>>  ~/w/src$ git checkout jc/rerere
>>  fatal: 'jc/rerere' is already checked out at '/home/gitster/w/rerere/.git'
>>
>> You see the first "niggle" above.  Do we need "/.git" at the end?
>> That is hopefully merely cosmetic and I am guessing that we can
>> unconditionally drop "/.git" from the end, but maybe there are
>> subtle reasons why it may not be a good idea (e.g. introduces some
>> ambiguities?)

I can't think of any ambiguities which might arise from stripping the
.git suffix. Even when playing with GIT_COMMON_DIR and GIT_WORK_TREE,
I don't notice any ambiguities.

Since I'm already touching this code and am wrapping up v2 of [1], I
can easily plop in a fix for this cosmetic issue.

>> There is another, a more serious one.
>>
>>  ~/w/src$ git fetch ../git.git jc/rerere:jc/rerere
>>
>> This succeeds, without checking if there is a work tree that has it
>> checked out.  I think the safety in "git fetch" that can be disabled
>> by "--update-head-ok" option should be updated to reuse the same
>> protection used by the updated "git checkout".
>>
>> Something to work on for 2.5.x maintenance track, aiming for 2.5.1.
>
> To keep things clear, Eric if you want these they are yours :-) I'll
> focus on the submodule support after i'm done with all my bug fix
> patches.

I want to focus on getting v2 of [1] out and finalized. After that, I
might be able to take a look at the git-fetch issue (but I won't
complain if you get to it first).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273856
