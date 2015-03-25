From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] gc: save log from daemonized gc --auto and print it next time
Date: Wed, 25 Mar 2015 07:58:54 +0700
Message-ID: <CACsJy8Acw8u8mbW6ivoUN10462xJDZxK984Vc2E3eypTc3qJ7A@mail.gmail.com>
References: <1427199448-28278-1-git-send-email-pclouds@gmail.com> <xmqqy4mm3v8l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaZfQ-0001ee-8v
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 01:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbbCYA71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 20:59:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32982 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbCYA7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 20:59:25 -0400
Received: by ignm3 with SMTP id m3so62122523ign.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 17:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g3/JXVhF4Q3AGgBlkp1lHLGs3Y8u219pViepdkOEtXw=;
        b=0MsEG18UbH0xcHzVbGr9hTEVcEf2H7ky7PfTyMwe/GH/8gF9NSXSoIgbjjHUGY1670
         UF0bBH5a77+j0VKNYuCP+FjbD29HMVgHCfdqkiBmmYllrpe193a7hZ40ASoU0v5NvWf7
         Hvmwb9pAyFah7kYq7XVTFlhCMWsh7u5G86XDVj52a46/GpqBAMyeoLjpoG6JH7teqbYY
         QvPCTlLMqRRchv2KlFn1pQCjlYpZ2/jaoKGrT3CBEioIAnFcdpWAstko5aeiH0SUQMeG
         SHxSYrEo0YmPb4FGThFjpunivQW1K7raZctUgZhAFnU0UY0LbZOht4d5PLj3PbTUkLw4
         zpzA==
X-Received: by 10.107.47.216 with SMTP id v85mr10390576iov.86.1427245164677;
 Tue, 24 Mar 2015 17:59:24 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 17:58:54 -0700 (PDT)
In-Reply-To: <xmqqy4mm3v8l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266245>

On Wed, Mar 25, 2015 at 5:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +             LANG=C git gc --auto &&
>> +             sleep 1 && # give it time to daemonize
>> +             while test -f .git/gc.pid; do sleep 1; done &&
>
> Yuck...

Yeah.. it's hard to test daemon things. I'm not even sure if we should
add a test, but I tried anyway.

>> +             grep "too many unreachable loose objects" .git/gc.log &&
>> +             LANG=C git gc --auto 2>error &&
>> +             grep skipped error &&
>> +             grep "too many unreachable loose objects" error &&
>> +             ! test -f .git/gc.log
>> +     )
>> +'
>
> For that "17/ has very many loose objects that are still young and
> unreachable" issue, I wonder if the right solution is somehow to
> flag the repository and prevent "gc --auto" from running until the
> situation improves.  "I checked at this time and found too many in
> 17/"; upon finding that flag file (with a timestamp), if there are
> new files in 17/ or if there are other reasons to do a gc (perhaps
> there are too many packfiles to be consolidated?), then do the gc
> but otherwise quit silently before spending too many cycles on it,
> or something along that line?

That's a separate problem that's being discussed in another thread. I
think Jeff's idea of storing the number of estimated loose objects may
be more reliable than timestamps..
-- 
Duy
