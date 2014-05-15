From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 28/29] Added guilt.reusebranch configuration option.
Date: Thu, 15 May 2014 09:37:05 +0200
Message-ID: <CAP=KgsR66gX6WduCE8-GXDF7qZ=zV=X_CjLRh-PRb7CJoRTqjA@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-29-git-send-email-cederp@opera.com>
	<20140514155324.GE1582@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu May 15 09:37:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkqE6-0002Iq-6e
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 09:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbaEOHhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 03:37:08 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36386 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbaEOHhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 03:37:07 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so7608650igd.7
        for <git@vger.kernel.org>; Thu, 15 May 2014 00:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Sp4lkHoZZagjG5KnG1qr0bfb8nw107+iixEiPmFILW0=;
        b=ZAZAXBFWrguaxcdeInGEBIRSKanAj8Frys40/iZMopwi2kofIYXCK8GV3FCE2XPWO8
         FrFtSWLD0JczvvXMjdq2t1lcxWLLNxJPP4JvbZixhBukX/Jmpxs4j/skqyHjJNMZkmXk
         H6xzaj2/idjB1TMgmj3hXMcHCXrU+BWR49CUGPqkgC3X6vKNyOCA/Cs6P5AP9dGajkFe
         vb4FHYWhQ8wcBChMycMP2CdhX2h0wFZtSg0fPZK/8AZ2GtkZOPWNPXpMxFzVpofoGOcx
         bM0VCCLTyvLpX6dAxRJ+y+gN7co6dvhIzJ1Lqmspdr1FBwFaFw8JAwXMnm0IaUtfgvEk
         cASg==
X-Gm-Message-State: ALoCoQleEOsbCiA5dN4BFkRMuicwEIvCTtc0vNXB+OHgza/TmVARlbrtoGcuGBGVIeBvLIk48agH
X-Received: by 10.42.85.206 with SMTP id r14mr114116icl.86.1400139426001; Thu,
 15 May 2014 00:37:06 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Thu, 15 May 2014 00:37:05 -0700 (PDT)
In-Reply-To: <20140514155324.GE1582@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249065>

On Wed, May 14, 2014 at 5:53 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 10:31:04PM +0200, Per Cederqvist wrote:
>> When the option is true (the default), Guilt does not create a new Git
>> branch when patches are applied.  This way, you can switch between
>> Guilt 0.35 and the current version of Guilt with no issues.
>>
>> At a future time, maybe a year after Guilt with guilt.reusebranch
>> support is released, the default should be changed to "false" to take
>> advantage of the ability to use a separate Git branch when patches are
>> applied.
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt                |  28 +++-
>>  regression/scaffold  |   1 +
>>  regression/t-062.out | 441 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-062.sh  | 137 ++++++++++++++++
>>  4 files changed, 601 insertions(+), 6 deletions(-)
>>  create mode 100644 regression/t-062.out
>>  create mode 100755 regression/t-062.sh
> ...
>> diff --git a/guilt b/guilt
>> index 9947acc..7c830eb 100755
>> --- a/guilt
>> +++ b/guilt
> ...
>> @@ -928,13 +935,22 @@ else
>>       die "Unsupported operating system: $UNAME_S"
>>  fi
>>
>> -if [ "$branch" = "$raw_git_branch" ] && [ -n "`get_top 2>/dev/null`" ]
>> -then
>> -    # This is for compat with old repositories that still have a
>> -    # pushed patch without the new-style branch prefix.
>> -    old_style_prefix=true
>> +if [ -n "`get_top 2>/dev/null`" ]; then
>> +     # If there is at least one pushed patch, we set
>> +     # old_style_prefix according to how it was pushed.  It is only
>> +     # possible to change the prefix style while no patches are
>> +     # applied.
>> +     if [ "$branch" = "$raw_git_branch" ]; then
>> +             old_style_prefix=true
>> +     else
>> +             old_style_prefix=false
>> +     fi
>>  else
>> -    old_style_prefix=false
>> +     if $reuse_branch; then
>> +             old_style_prefix=true
>> +     else
>> +             old_style_prefix=false
>> +     fi
>
> I don't know if this is a good idea or not, but:
>
>         old_style_prefix="$reuse_branch"

It saves a few lines. I'll use that construct in v3.

>>  fi
>>
>>  _main "$@"
>> diff --git a/regression/scaffold b/regression/scaffold
>> index e4d7487..e4d2f35 100644
>> --- a/regression/scaffold
>> +++ b/regression/scaffold
>> @@ -93,6 +93,7 @@ function setup_git_repo
>>       git config log.date default
>>       git config log.decorate no
>>       git config guilt.diffstat false
>> +     git config guilt.reusebranch false
>>  }
>>
>>  function setup_guilt_repo
> ...
>> diff --git a/regression/t-062.sh b/regression/t-062.sh
>> new file mode 100755
>> index 0000000..85596ca
>> --- /dev/null
>> +++ b/regression/t-062.sh
>> @@ -0,0 +1,137 @@
> ...

Hidden here was a broken comment.  The new one at the start
of the file will say:

# Test that the guilt.reusebranch=true setting works.

This entire file is mostly a copy of t-061.sh, but slightly
adjusted to use guilt.reusebranch=true.  I'm not sure it
covers all that should be tested. On the other hand, I'm
not sure how much that setting needs to be tested.

>> +function fixup_time_info
>> +{
>> +     touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
>> +}
>> +
>> +cmd setup_repo
>> +
>> +cmd git config guilt.reusebranch true
>> +
>> +cmd guilt push -a
>> +cmd list_files
>> +cmd git for-each-ref
>> +
>> +cmd git for-each-ref
>> +
>> +cmd list_files
>
> duplicate list_files & for-each-ref

Fixed.

>> +
>> +for i in `seq 5`; do
>> +     if [ $i -ge 5 ]; then
>> +             shouldfail guilt pop
>> +     else
>> +             cmd guilt pop
>> +     fi
>> +     cmd git for-each-ref
>> +     cmd guilt push
>> +     cmd git for-each-ref
>> +     cmd guilt pop
>> +     cmd git for-each-ref
>> +done
>> +
>> +# Check that "pop -a" does the right thing.
>
> What exactly is the right thing?  no-op since the above loop poped
> everything?  (I'd make the comment say what the "right thing" is.)

I'll rephrase that block of code like this:

# Check that "pop -a" properly pops all patches.
cmd guilt push -a
cmd git for-each-ref
cmd guilt pop -a
cmd git for-each-ref

Is that more clear? The test pushes all patches, checks that they
are applied, removes them, checks that it worked.

> Jeff.
>
> --
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                 - Linus Torvalds
