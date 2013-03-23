From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Sat, 23 Mar 2013 18:27:03 +0530
Message-ID: <CALkWK0nhOa-xJDzx7K7W7ZsRjkMJwqEyy32Q-R_ApZV-=BWKSQ@mail.gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-5-git-send-email-artagnon@gmail.com> <20130322212159.GJ12223@google.com>
 <7vli9f5bho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:58:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJO1R-0000Ep-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001Ab3CWM5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:57:24 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:59628 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3CWM5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:57:24 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so4350232iag.31
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KEswmlVN95miYCd41GbpZKLLzvcQ/0bNC8A18PjxrRs=;
        b=UK8atv6B0G23BxeT3zlJsQylcYT/Xw+DbW2S7w/a/I/gl4UrIk8nd1Feyfq828tTdi
         Aq3JhVviEsDB4J4QbTKjWeOW3J4vyK+uH7IwuW72E/iS1IJn4Y4GV5sGd62rt7IYQN6c
         VBzXfFl3spP8WoSFgs54h90wq8bPudQgsgZ9SSe0HH/u1WayScWRWy/5J+6L0GgSwdVT
         Jg+oHo4NJZiQDVDTi4KfdFvoFDuqxR34zveUOX2/skSLq4L6xjUidUh+jpNTmGdNw4T6
         KHsroVMpTmnIlTRALJkMXMqRry/I1fBwo5ng67WkR8TTRNeh8+7gNvv0ropBQPpiWGRi
         iXpg==
X-Received: by 10.42.204.79 with SMTP id fl15mr2979003icb.57.1364043443490;
 Sat, 23 Mar 2013 05:57:23 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 05:57:03 -0700 (PDT)
In-Reply-To: <7vli9f5bho.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218914>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> --- a/builtin/push.c
>>> +++ b/builtin/push.c
>>> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>>>  static int do_push(const char *repo, int flags)
>>>  {
>>>      int i, errs;
>>> -    struct remote *remote = remote_get(repo);
>>> +    struct remote *remote = pushremote_get(repo);
>>
>> "struct remote" has url and pushurl fields.  What do they mean in the
>> context of these two accessors?  /me is confused.
>>
>> Is the idea that now I should not use pushurl any more, and that I
>> should use pushremote_get and use url instead?
>
> I thought the basic idea from the user-level is:
>
>  - If you have to use different URL to push to and fetch from the
>    logically same location (e.g. git://k.org/pub/scm/git/git.git
>    used for fetch, k.org:/pub/scm/git/git.git/ used for push), use
>    url for fetch, pushurl for push and you don't have to bother with
>    per-branch pushremote at all.  You are logically working with the
>    same remote, perhaps called 'origin'.
>
>  - If you push to and fetch from logically different repositories,
>    (e.g. fetch from https://github.com/gitster/git, push to
>    github.com:artagnon/git), you may want to call your upstream
>    'origin' and your publishing repository 'mine'.  You set the
>    remote.pushdefault to 'mine', perhaps like:
>
>         [remote "mine"]
>                 url = github.com:artagnon/git
>
>    (this can also be written with remote.mine.pushurl).
>
> By splitting remote_get() used for fetch and pushremote_get() used
> for push, the latter function can return 'origin' and 'mine' for
> these two cases, while remote_get() will return 'origin' for both of
> these cases.  At the programming level, you would still ask what the
> URL to be pushed to to the remote obtained here, and would use
> pushurl if defined, or url otherwise.
>
> Ram, am I following your thoughts correctly?

Exactly.  I couldn't have said it better myself.
