From: Nico Williams <nico@cryptonector.com>
Subject: Re: Should branches be objects?
Date: Thu, 19 Jun 2014 19:25:06 -0500
Message-ID: <CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
References: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
	<20140619234614.GY8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 02:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxmdn-0001Wv-RN
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 02:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022AbaFTAZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 20:25:09 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:34554 "EHLO
	homiemail-a102.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756765AbaFTAZI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 20:25:08 -0400
X-Greylist: delayed 10050 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2014 20:25:08 EDT
Received: from homiemail-a102.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a102.g.dreamhost.com (Postfix) with ESMTP id D09F82006D30C
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=1BxvXQmuVQ/beRW69hd9
	YQSASa0=; b=VrmWYFaicHbY3tp5FAkc+bXdhwR50N9XmMIez7vlqOf9CFRnQkwI
	W1Vt8HXJT29h8F1wBLbuUnbMaJvA3nOR7N6lfVrNlRm+pUPyRza9oGFJTWQBYTnK
	53NbKmyfdSgVVCQXYyZPcVdKOeD2NKAEGAbVosTHHSfMcdO/hAH6bbI=
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com [209.85.212.178])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a102.g.dreamhost.com (Postfix) with ESMTPSA id 867DE2006D30A
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:25:07 -0700 (PDT)
Received: by mail-wi0-f178.google.com with SMTP id n15so3658766wiw.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:25:06 -0700 (PDT)
X-Received: by 10.180.75.212 with SMTP id e20mr99420wiw.5.1403223906284; Thu,
 19 Jun 2014 17:25:06 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Thu, 19 Jun 2014 17:25:06 -0700 (PDT)
In-Reply-To: <20140619234614.GY8557@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252199>

On Thu, Jun 19, 2014 at 6:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Nico Williams wrote:
>
>>  - one could see the history of branches, including
>
> Interesting.  'git log -g' is good for getting that information
> locally, but the protocol doesn't have a way to get it from a remote
> server so you have to ssh in.  Ronnie (cc-ed) and I were talking
> recently about whether it would make sense to update git protocol to
> have a way to get at the remote reflogs more easily --- would that be
> useful to you?

Yes and no.  I've thought about that some concept, but:

a) reflogs include information about what's done to the workspace
(checkout...) that's not relevant to any branch,

b) reflogs aren't objects, which ISTM has caused transactional issued
(even if they are fixed or soon to be),

c) the fewer kinds of things, the more elegant the design, so maybe
reflogs ought to be objects themselves, which is one thought that led
me to "branches should be objects".

Another thought that led me there is that I often do:

$ git checkout -b ${branch}-rebase1
$ git rebase -i master
...
$ git checkout -b ${branch}-rebase2
$ git rebase -i master
...

I iterate through this until a set of commits is the way the upstream wants it.

No one really needs that history, except me: possibly to show my
boss/customer, possibly to put together a list of changes I've done to
show the upstream maintainer, ...   Yes, this is in the reflog, but...
it's mixed up with unrelated stuff.

Also, I'd like to be able to git diff
<branch-version>..<same-branch-diff-branch-version>.  Again, for my
own purposes in collating changes I've done to previously submitted
PRs.

Now, I can do that as I always have, but it litters my branch namespace.

Lastly, there are people who just don't get rebasing.  They think it's
horrible because it changes the truth.  You've met them, I'm certain.
Branches as objects might help mollify them.

>>  - how commits were grouped when pushed/pulled (push 5 commits, and
>> the branch object will record that its head moved by those five
>> commits at once)
>
> The reflog on the server (if enabled) records this.

Yeah, though as you point out I can't see it.

>>  - rebase history (git log <branch-object> -> better than git reflog!)
>
> The local reflog ('git log -g <branch>') records this.

See above.

>>  - object transactional APIs would be used to update branches
>
> Ronnie's recent ref-transaction code does this.

Speaking of which: are there any power failure corruption cases left
in git?  How is this tested?

Nico
--
