From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Fwd: Seems to be pushing more than necessary
Date: Fri, 20 Mar 2015 09:20:18 +0000
Message-ID: <CAABECY1vOre+RbXKCnZqHr4rZSHHpYA=tnRK6fSnkjeyFv2ZAg@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
	<CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
	<xmqq3850kf6d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYt6Q-00035k-Ua
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 10:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbbCTJUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 05:20:22 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34626 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbCTJUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 05:20:19 -0400
Received: by obbgg8 with SMTP id gg8so73780340obb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rz3dR7KPkT37QW0eBjdZQn86+DmyGGvOxwFQzzwKWro=;
        b=f0rrveP1xsAQgIG8Qy5taIR4k49yUpfkbhvS6Z7lsOQe/07rvvHwvq3b18O9fIYX4+
         GEMvSZJtNqiqc7f/tZYA2A6EOu/SyuvACuia6QG40iBieHKwPM9vLvnU1j6olj3lwoaB
         bnkg+xPnY5db2lCnBGgWdmKUFhHvHPSkhVXwk5+MYeWCaPhFsVRevTt4WnWe8yL2+N2E
         emFpKEBewwgfFBI0Eh10ArHvKRmfRSozdTz1NFo3OQFsls97MiVss0uaVQ3R1Nr2OTKG
         Izasw4Ph/uz/ZBULKJJ8aM0yNrRJKKvFdu8tEUNkrlXNCCh+CzqZk8kmoZVeeDqXwCns
         81zA==
X-Received: by 10.182.221.193 with SMTP id qg1mr7971269obc.57.1426843218977;
 Fri, 20 Mar 2015 02:20:18 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Fri, 20 Mar 2015 02:20:18 -0700 (PDT)
In-Reply-To: <xmqq3850kf6d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265873>

That all seems quite reasonable, and is what I would expect to happen.

However at the moment, if I create a branch from master and edit one
line in one file,
with no other changes on the remote, it takes me over an hour to push
the new branch.

On 19 March 2015 at 18:36, Junio C Hamano <gitster@pobox.com> wrote:
> Graham Hay <grahamrhay@gmail.com> writes:
>
>> We have a fairly large repo (~2.4GB), mainly due to binary resources
>> (for an ios app). I know this can generally be a problem, but I have a
>> specific question.
>>
>> If I cut a branch, and edit a few (non-binary) files, and push, what
>> should be uploaded? I assumed it was just the diff (I know whole
>> compressed files are used, I mean the differences between my branch
>> and where I cut it from). Is that correct?
>
> If you start from this state:
>
>  (the 'origin')                    (you)
>     ---Z---A         clone ->    ---Z---A
>
> and edit a few files, say, a/b, a/c and d/e/f, and committed to make
> the history look like this:
>
>  (the 'origin')                    (you)
>     ---Z---A                     ---Z---A---B
>
> i.e. "git diff --name-only A B" would show these three files, then
> the next push from you to the origin, i.e.
>
>  (the 'origin')                    (you)
>     ---Z---A---B    <- push      ---Z---A---B
>
> would involve transferring from you to the origin of the following:
>
>  * The commit object that holds the message, authorship, etc. for B
>  * The top-level tree object of commit B (as that is different from
>    that of A)
>  * The tree object for 'a', 'd', 'd/e' and the blob object for
>    'a/b', 'a/c', and 'd/e/f'.
>
> However, that assumes that nothing is happening on the 'origin'
> side.
>
> If the 'origin', for example, rewound its head to Z before you
> attempt to push your B, then you may end up sending objects that do
> not exist in Z that are reachable from B.  Just like the above
> bullet points enumerated what is different between A and B, you
> can enumerate what is different between Z and A and add that to the
> above set.  That would be what will be sent.
>
> If the 'origin' updated its tip to a commit you do not even know
> about, normally you will be prevented from pushing B because we
> would not want you to lose somebody else's work.  If you forced such
> push, then you may end up sending a lot more.
