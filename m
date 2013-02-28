From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [BUG/PATCH] contrib/subtree: allow addition of remote branch with
 name not locally present
Date: Thu, 28 Feb 2013 21:37:00 +0000
Message-ID: <CALeLG_mryWOE_KrFDAf6Z7=w6kdaXii4rHzPYBfRbsjt4TZTAw@mail.gmail.com>
References: <CALeLG_ndDWyPWRBQtKV4WswZUKRpNQzCAXmB0f0yoKGsAYMUig@mail.gmail.com>
	<7vwqtti91k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	David Greene <greened@obbligato.org>,
	Jesper Lyager Nielsen <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:37:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBAO-0005h3-W9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 22:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760632Ab3B1VhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 16:37:03 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:32981 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759901Ab3B1VhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 16:37:01 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so4445957oag.25
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 13:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=rZQ+r3/3l6pFnApKd+gWjUMFsEobfgmDHvOTPYqsbWE=;
        b=DU5f/PY+FhCU8NrqjryfsGCrmADs9COvhMbhIhqFrYf38TatsVwMWaNLbDwB1HJVzA
         q4YXVHcfEW8kg69UCTilqFeUlbWqdbAdZpl0cO5ZRZwQUGuBJ6SNkUxKCDphUT4edD/l
         Qddk/oXgYtxYqnc/is0dLZDh9VN8KH6/uefWAW8aMKyOkKAMR5qwj5N2k8+VfQeztxx5
         LHm5PmcufAUkzP/w5WDkjYPHb/P6vnRnKEnJxNBS7NOsFxpUqjo2M1eHvor6MqvOMLYt
         SEfR8oTVWHenUVx/iUKP/WxUrfh2vLtsuTDNulLpxwZ67wQQ6bu+MKAEOgRM/Jm3tiDt
         1Lig==
X-Received: by 10.60.25.4 with SMTP id y4mr6590240oef.114.1362087420715; Thu,
 28 Feb 2013 13:37:00 -0800 (PST)
Received: by 10.76.132.234 with HTTP; Thu, 28 Feb 2013 13:37:00 -0800 (PST)
X-Originating-IP: [92.28.176.38]
In-Reply-To: <7vwqtti91k.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkHJt4ObU3tFe6vML9TiAekESvo+hmkhDUnteswbi3n8Yq0eWXimdMLH28PzxzgnCETWpze
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217255>

On Thu, Feb 28, 2013 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> cmd_add() attempts to check for the validity of refspec for the repository
>> it is about to add as a subtree. It tries to do so before contacting the
>> repository. If the refspec happens to exist locally (say 'master') then
>> the test passes and the repo is fetched. If the refspec doesn't exist
>> locally then the test fails and the remote repo is never contacted.
>>
>> Removing the tests still works as the git fetch command fails with the
>> perfectly accurate error:
>>
>>   fatal: Couldn't find remote ref <refspec>
>>
>> Signed-off-by: Paul Campbell <pcampbell@carnegiecollege.ac.uk>
>> ---
>>
>> I must confess to not understanding the comment preceding the
>> rev-parse test. Given that it is against the rev-parse and not the
>> cmd_add_repository call I'm assuming it can be removed.
>
> This is contrib/ material and I do not use the command, so anything
> I say should be taken with a moderate amount of salt, but I think
> the comment is talking about _not_ accepting a full storing refspec,
> or worse yet wildcard, e.g.
>
>         refs/heads/topic:refs/remotes/origin/topic
>         refs/heads/*:refs/remotes/origin/*
>
> which will not make sense given that you are only adding a single
> commit via "cmd_add".  Also, if you have already fetched from the
> remote, "rev-parse $2^{commit}" at this point will protect against
> a typo by the end user.
>
> As you noticed, checking if $2 is a commit using rev-parse _before_
> fetching $2 from the remote repository is not a valid way to check
> against such errors.  So I tend to agree that removing the "die"
> will be a good idea.
>
> Typing "tipoc" when the user meant "topic" will error out at the
> "git fetch" done in cmd_add_repository, but that fetch will happily
> fetch and store whatever a refspec specifies, so you might want to
> replace the bogus "rev-parse before fetching" check to "reject
> refspec" with something else.

Thanks for the feedback.

Checking for a ':' or a '*' in the refspec should stop the storage
name and wildcards getting through.

Rerolling the patch with new test.

-- 
Paul [W] Campbell
