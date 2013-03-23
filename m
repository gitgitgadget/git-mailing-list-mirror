From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Sat, 23 Mar 2013 18:48:41 +0530
Message-ID: <CALkWK0npDrfcSDCX2OrUh1yNnKDa--04YT5UjAkbbG9HO4g-Zw@mail.gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-5-git-send-email-artagnon@gmail.com> <20130322212159.GJ12223@google.com>
 <7vli9f5bho.fsf@alter.siamese.dyndns.org> <20130322234108.GL12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 14:19:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJOM6-0004iX-UD
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 14:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3CWNTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 09:19:03 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35531 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab3CWNTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 09:19:02 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so5906837ieb.1
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SUIdkRVI6czbKKnnptFO+n+G4mLp9pZgIADdufP373o=;
        b=yBSztNl8o9ziBxbuVzssxF6Ni9WBRG9l+M+WluqOYCZYX7n4zCFQSR8iIZebu7KQpR
         ew5G8REYtAPQT8M5T+k9wwErCSEKt5Tc7UWpI18RjjzpE3LMmZYUPpf2MAnbYKbe844E
         Pk136OPVN2tbqEDiQBNQP/6QkuyBcStzyWdGV5+CtefsyPB+PGtlMoM2/aEaHl9KtTmG
         ESP+WbpvG04YIpU94o5i8hIJFaGZD1D29N09UESUlOJfU/wiFb2Ls4C8TuX53MqipVJG
         gQG0474vum0QbnA8vWsRcKhbPYZIv2tV7Dj/2f62audLkqlyeM2eoONvXjmWG39foKmy
         OQ8w==
X-Received: by 10.50.50.71 with SMTP id a7mr7125263igo.14.1364044741230; Sat,
 23 Mar 2013 06:19:01 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 06:18:41 -0700 (PDT)
In-Reply-To: <20130322234108.GL12223@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218916>

Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>>> -   struct remote *remote = remote_get(repo);
>>>> +   struct remote *remote = pushremote_get(repo);
>>>
>>> "struct remote" has url and pushurl fields.  What do they mean in the
>>> context of these two accessors?  /me is confused.
>>>
>>> Is the idea that now I should not use pushurl any more, and that I
>>> should use pushremote_get and use url instead?
> [...]
>>               At the programming level, you would still ask what the
>> URL to be pushed to to the remote obtained here, and would use
>> pushurl if defined, or url otherwise.
>
> Ah, I think I see.  It might be more convenient to the caller if
> pushremote_get returned a remote with url set to the pushurl, but
> that would prevent sharing the struct with other callers that want
> that remote for fetching.

We started off with a generic "remote" (for both fetching and
pushing), then added .pushurl on top of this remote.  Now we've
introduced something called a pushremote, a logically distinct remote
from "remote"; pushremote_get() is meant to return this logically
different remote, falling back to the remote_get() codepath if not
present.  This is a perfect migration that trivially preserves
backward compatibility.


> So instead, the idea is something like
>
>         remote: support a different default remote for pushing
>
>         Teach remote_get() to accept an argument FOR_FETCH or FOR_PUSH
>         that determines, when no remote is passed to it, whether to use
>         the default remote for fetching or the default for pushing.
>
>         The default remote for fetching is stored in the static var
>         "default_remote_name", while the default for pushing, if set,
>         is in "default_push_remote_name".
>
>         Currently there is never a different default for pushing set
>         but later patches will change that.
>
> If remote_get() gained a new required parameter, that would force all
> call sites to be examined (even any potential call sites added by new
> patches in flight) and there would no longer be need for the
> remote_get_1() function.

I like this, but let's save it for a future patch as it requires some
extensive refactoring.
