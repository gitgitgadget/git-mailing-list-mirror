From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Mon, 6 Jul 2015 19:33:19 -0700
Message-ID: <CA+P7+xofoxdgQUng1N1NpXyALzjjmAYe++GJoA6qD+zUbZk-vg@mail.gmail.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
 <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com> <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 04:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCIir-0000Cd-2K
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 04:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbbGGCdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 22:33:41 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33170 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbGGCdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 22:33:39 -0400
Received: by obbgp5 with SMTP id gp5so7573277obb.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v/IgzgoUD7icE6qnNJTu3RO6kVxzAqefFy/tFZBzjOo=;
        b=IonKtT94d/hxQ5ZizJqKXamwuWA2xWc9eqYwMh8Iyc1Lu29bueZGkg/j6U4GMoZFdj
         ycmbQwoJ9AzukvJ2UMQThigFSja2VNfax2N5nlBPsAKff76HPDrN9DunNkr22dKGEINw
         E7byfGC1vOBSSp+2zc/31/FGQJR+YxupAZgKu0ZqmBfAzRb0utUoZ9WsuQfft0eA7STv
         47FeEiJEs6jR0xFKu1uMSvcEDcuvveEd8JoOnEB8TrXM/kLLMixLSQovjx/fJNM2LoA4
         8tLcJ+xCrUS9b9l7S32epUu0MzVxkWZcy4A7sPs7AMVxBnY+nRbFY7QeLncqSVR7FxuQ
         Vzsw==
X-Received: by 10.60.115.1 with SMTP id jk1mr1817997oeb.2.1436236418845; Mon,
 06 Jul 2015 19:33:38 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Mon, 6 Jul 2015 19:33:19 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273474>

On Mon, Jul 6, 2015 at 7:20 PM, Daniel Barkalow
<barkalow@iabervon.iabervon.org> wrote:
> On Mon, 6 Jul 2015, Junio C Hamano wrote:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>> > I've been looking at the refspecs for git fetch, and noticed that
>> > globs are partially supported. I wanted to use something like:
>> >
>> > refs/tags/some-prefix-*:refs/tags/some-prefix-*
>> >
>> > as a refspec, so that I can fetch only tags which have a specific
>> > prefix. I know that I could use namespaces to separate tags, but
>> > unfortunately, I am unable to fix the tag format. The specific
>> > repository in question is also generating several tags which are not
>> > relevant to me, in formats that are not really useful for human
>> > consumption. I am also not able to fix this less than useful practice.
>> >
>> > However, I noticed that refspecs only support * as a single component.
>> > The match algorithm works perfectly fine, as documented in
>> > abd2bde78bd9 ("Support '*' in the middle of a refspec")
>> >
>> > What is the reason for not allowing slightly more arbitrary
>> > expressions? Obviously no more than one *...
>>
>> I cannot seem to be able to find related discussions around that
>> patch, so this is only my guess, but I suspect that this is to
>> discourage people from doing something like:
>>
>>       refs/tags/*:refs/tags/foo-*
>>
>> which would open can of worms (e.g. imagine you fetch with that
>> pathspec and then push with refs/tags/*:refs/tags/* back there;
>> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
>> tag?) we'd prefer not having to worry about.
>
> That wouldn't be it, since refs/tags/*:refs/tags/foo/* would have the same
> problem, assuming you didn't set up the push refspec carefully.
>
> I think it was mostly that it would be too easy to accidentally do
> something you don't want by having some other character instead of a
> slash, like refs/heads/*:refs/heads-*.
>
> Aside from the increased risk of hard-to-spot typos leading to very weird
> behavior, nothing actually goes wrong; in fact, I've been using git with
> that check removed for ages because I wanted a refspec like
> refs/heads/something-*:refs/heads/*. And it works fine as a local patch,
> since you don't need your refspec handling to interoperate with other
> repositories.
>
>         -Daniel
> *This .sig left intentionally blank*


Which is why I suggested a patch that adds this behavior conditionally
and only for fetch. This way you don't have to use a local patch, and
it wouldn't hit normal users. Ideally we can add a flag that only
enables it for refspecs that don't interoperate.

Does this seem ok? If so I will go ahead and try to work up a patch

Regards,
Jake
