From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH v2 04/23] contrib/subtree: Teach push and pull to use
 .gittrees for defaults
Date: Sun, 24 Mar 2013 21:22:30 +0000
Message-ID: <CALeLG_=pV1Y0Qabw9C=3PACWUWPw2=ajacFG++djBxaO4S6z7g@mail.gmail.com>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
	<1362958891-26941-5-git-send-email-pcampbell@kemitix.net>
	<7vobeqbobz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	bibendi <bibendi@bk.ru>, Avery Pennarun <apenwarr@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsNY-0004ZT-FW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3CXVWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:22:32 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56640 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab3CXVWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:22:31 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so5706369oag.22
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 14:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=tTn8R0H1I5vl5r6OsAzpAn5//eXJGC9lecgw2Z5QTBo=;
        b=ELRmGQjwjKUVDcTCije5JV4RaCL+kIawHWu+rTMi6CdiCFQz+HtGU/Cvee4Lp1dkYQ
         aTCThB5to3hHKLUwMsEju3JEAEsqaTDzCQAnsv65FRbnYu8TmcYL+FZxDAqsciSUir8s
         2VOYNtrtKD5+Ey7iI1ydix7ZOXM6k2lIjzQaRRYBGi3H+eeQD5dci2UUGqV5baekyWt4
         lU+VUYmk/Mvi8Oba+INkCwSjF64gGEBkFvFTIaMlGd2xf5Ek37RV946KpBm3HA/DGVFD
         mnPDkNA96+y2n4kXzgnQamJf1weJ6UloFHURBd0wFlLsFGdO15mlBcTdeLXfClOvO+bX
         TDFQ==
X-Received: by 10.60.172.36 with SMTP id az4mr8956611oec.29.1364160150076;
 Sun, 24 Mar 2013 14:22:30 -0700 (PDT)
Received: by 10.76.13.2 with HTTP; Sun, 24 Mar 2013 14:22:30 -0700 (PDT)
X-Originating-IP: [2.102.87.178]
In-Reply-To: <7vobeqbobz.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQm8Y9pRKxNq/rdu/i9IruQUeAZDJKRlVScjYiuICY5/FF2jvnjHVSz1so823k73FThz8Vax
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218988>

On Mon, Mar 11, 2013 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> From: bibendi <bibendi@bk.ru>
>>
>> Look in the config file .gittrees for a default repository and
>> refspec or commit when they are not provided on the command line.
>>
>> Uses the .gittrees config file in a similar way to how git-submodule
>> uses the .gitmodules file.
>
> What the patch does can be read from the code, but what benefit
> would users get by the extra file?

How about:

"Usually push and pull are to the same repository/branch that they were
originally added from. Add stores the repository/branch in .gittrees
which push and pull can now default to if not provided on the command
line."

>>  cmd_pull()
>>  {
>> -     ensure_clean
>> -     git fetch "$@" || exit $?
>> -     revs=FETCH_HEAD
>> -     set -- $revs
>> -     cmd_merge "$@"
>> +    if [ $# -ne 1 ]; then
>
> Broken indentation?
>
>> +         die "You must provide <branch>"
>> +     fi
>
> It used to allow "git fetch $there" and let the configured
> remote.$there.fetch refspec to decide what gets fetched, and also it
> used to allow "git fetch $there $that_branch" to explicitly fetch
> the named branch.  But this change insists that the user has to give
> what gets fetched from the command line and forbids the user from
> giving where to fetch from, it seems.  Isn't it a regression?  Why
> is it a good idea to forbid such uses that the script used to
> accept?
>
> The proposed log message does not explain why it is not a
> regression, or why accepting some use patterns that the script used
> to allow was a bug that needs to be diagnosed with this new
> conditional.

I think the patch was based on an older version of git-subtree before
"git fetch $there" support was added. Will need to update it.

>> +     if [ -e "$dir" ]; then
>> +         ensure_clean
>> +         repository=$(git config -f .gittrees subtree.$prefix.url)
>> +         refspec=$1
>> +         git fetch $repository $refspec || exit $?
>> +         echo "git fetch using: " $repository $refspec
>
> Why are these variable references outside the dq pair?
>

They're inside now.

Rerolling once I figure out the update for "git fetch $there" support.

-- 
Paul [W] Campbell
