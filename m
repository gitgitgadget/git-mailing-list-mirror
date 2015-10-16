From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/12] git submodule update: Use its own list implementation.
Date: Fri, 16 Oct 2015 14:08:22 -0700
Message-ID: <CAGZ79kY+_MH5Y9RF7ZdY1j7WQFpM+97_GROwuMFO6034SCvf6Q@mail.gmail.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-6-git-send-email-sbeller@google.com>
	<xmqqy4f2cysl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnCEo-0007qu-1W
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 23:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbbJPVIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 17:08:24 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34633 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbbJPVIX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 17:08:23 -0400
Received: by ykfy204 with SMTP id y204so96716754ykf.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v0fRZ5QqkI39TOGfUGuAmwHoAXdE8pgltnkBPzq7krk=;
        b=Z/acbUpya9NB+rsKyifqdVcjVOqz7jO11bBUj5wwQIvdgO7sUkWXAFoFuxgoarm8ng
         T3LdXkRo0TuoDLTei6V7B3iXFEiPG4aQsfdg2QVJYuhIn1Lb452JTXor0Tmjz6/sjad8
         dZ8wsECgdLKQix+QLLvZ/DUkdWvaxNl3hKVj66a868OsLofn/9TuJBmx69j1ZkpARl1b
         NbNIvWblfHvVISu/WHy1Rtc6pMkv6QBSUfmuNLhK6vm/2Ed+3/js+/w+Mltxj0ZkQUQa
         9uT6GNUd2kjp4qbBIRwLEOVHg8xy5pH4UMitR6Ex/5ZhjBUbK6I5T/qMUgDezwLJUZWO
         9w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=v0fRZ5QqkI39TOGfUGuAmwHoAXdE8pgltnkBPzq7krk=;
        b=H/wazuB6+h0CYWDXvEoGNC/fjpsM5Jjr4VLRkfdNL8xp20Ei/ZqoOo86LxKW5N0XUB
         XpNYNA/Jjbs9C7hS2wr8fDKtzJPLAbBMYb7jr27Q3K5eDj7sBJqGcvi56xIN/O+rDAxS
         BMrd2+3cOkZnwfSN901nfAspYlr9cg4Jbsbj7KWitbdfpQJ5AeMxt52FOJscrnDFMdHx
         xFyXlXcUpRJOgx8V+2Hk7e+0UTCgJ+IqCU0npB7X+skPp/E9t4BR8h9qznEKXW3xIhUS
         1auAFqlxNgVbNhZJyFl/kgZwCOtZ2Y1yPFem3qLrrig7ujxYj6SoqBALYBw66LEwM4Ky
         gblw==
X-Gm-Message-State: ALoCoQlwPTxaS11LxE3xmuCRS3+ngVJQUlHJwq62KkQSDYwD0Wp6idTTtu6iMDQWQ3NN2Vmbudf+
X-Received: by 10.129.75.2 with SMTP id y2mr12946060ywa.48.1445029702987; Fri,
 16 Oct 2015 14:08:22 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 16 Oct 2015 14:08:22 -0700 (PDT)
In-Reply-To: <xmqqy4f2cysl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279771>

On Fri, Oct 16, 2015 at 2:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Discussions turned out that we cannot parallelize the whole loop below
>> `git submodule--helper list` in `git submodule update`, because some
>> changes should be done only one at a time, such as messing up a submodule
>> and leave it up to the user to cleanup the conflicted rebase or merge.
>>
>> The submodules which are need to be cloned however do not expect to create
>> problems which require attention by the user one at a time, so we want to
>> parallelize that first.
>>
>> To do so we will start with a literal copy of `git submodule--helper list`
>> and port over features gradually.
>
> I am not sure what you mean by this.
>
> Surely, the current implementation of "update" does the fetching and
> updating as a single unit of task and iterate over these tasks, and
> we would rather want to instead have one iteration of submodules to
> do the fetching part (without doing other things that can fail and
> have to get attention of the end user), followed by another
> iteration that does the "other things", in order to get closer to
> the end goal of doing the fetch in parallel and then doing the
> remainder one-module-at-a-time sequencially.

I differentiated a bit more and moved the clone parts only.
Fetching should also be no problem. I initially assumed that to be a
problem too.

>
> I would imagine that the logical first step towards the end goal, if
> I understood you correctly, would be to split that single large loop
> that does a fetch and other things for a single module in each
> iteration into two, one that iterates and fetches all, followed by a
> new one that does the checkout/merge.

That was also one of the patch series I wrote (not sent to list)
1) split up into 2 phases
2) rewrite first phase in C
3) parallelize the first phase.

This series merges 1 and 2, so you don't have to review
the same functionality two times.

>
> What I do not understand is why that requires a different kind of
> enumerator (unless this is a kind of premature optimization, knowing
> that the set of modules iterated by these two loops are slightly
> different or something).

It is just moving all code before the clone step into the C part, so
we can call the clone in C.

>
>>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index bb8b2c7..d2d80e2 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -656,7 +656,7 @@ cmd_update()
>>       fi
>>
>>       cloned_modules=
>> -     git submodule--helper list --prefix "$wt_prefix" "$@" | {
>> +     git submodule--helper list-or-clone --prefix "$wt_prefix" "$@" | {
>>       err=
>>       while read mode sha1 stage sm_path
>>       do
