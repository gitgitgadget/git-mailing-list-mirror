From: Mike Botsko <botsko@gmail.com>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Tue, 3 Mar 2015 13:31:39 -0800
Message-ID: <CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
	<20150303210900.GP890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:31:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSuPp-0004Be-M6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 22:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbbCCVbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 16:31:41 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:38721 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbbCCVbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 16:31:40 -0500
Received: by mail-qg0-f48.google.com with SMTP id q107so21878794qgd.7
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 13:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vCzqBUcXKzMB28U05BsMlUs9K2iaTjYBO2y3cwsDSAc=;
        b=nz2U5cd4KHNMXAvKv4WtofbG+r+zNdp53jZh1+Qau8lU9tVYuRUXxFGFxr+L3FQ19h
         KiBhVqx4OjcIpGzmRU/k0n/YSMCwuYvLPkRrUDsivWXMGtr7UPjAq6Ii4GFADhRqKmTb
         eBpTwnFBHa0f0NoPJO+wvDyGxwalej5q2i6SmgIBJ6mYFZeQpUjuj6mkcBR1sXmLX4iR
         w0WMvO2UJD2khFaLJ3hAvw9CmgWDmRstKeE5buG/G/t5yZIzaHAoJB52g6WK+Qbveqh1
         N6n0hHvclKe6VbrI6RQYINpjFmyO1Odo0UDIbHWbDMYSPV+Osj5GSwaUx8I8B3/lMRaZ
         FqgA==
X-Received: by 10.140.107.166 with SMTP id h35mr1314757qgf.71.1425418299835;
 Tue, 03 Mar 2015 13:31:39 -0800 (PST)
Received: by 10.140.80.203 with HTTP; Tue, 3 Mar 2015 13:31:39 -0800 (PST)
In-Reply-To: <20150303210900.GP890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264693>

I'm using git 2.2.1 on Mac OS X Yosemite.

I just tried the git rebase with "--fork-point" added, and it works properly:

$ git rebase upstream/our-branch-name --fork-point
First, rewinding head to replay your work on top of it...
Applying: B-07241

While discussing with someone else, he mentioned "poking about a bit
more, git rebase began defaulting to --fork-point in git 1.9, so one
might expect it to be there in that version" - but we figured it might
be related to https://github.com/git/git/commit/1e0dacdbdb751caa5936b6d1510f5e8db4d1ed5f.
I upgraded my version of git, but it wasn't fixed.

I assume he was incorrect in that git rebase uses --fork-point by default?

On Tue, Mar 3, 2015 at 1:09 PM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 03, 2015 at 12:39:31PM -0800, Mike Botsko wrote:
>> I'm seeing unexpected behavior between "git pull --rebase" and "git
>> rebase" commands, which are supposed to be (and always described as)
>> synonymous:
>>
>> git pull --rebase upstream our-branch-name
>>
>> and
>>
>> git fetch upstream
>> git rebase upstream/our-branch-name
>>
>> We have a situation where the upstream/our-branch-name was rebased, to
>> incorporate changes from master. Somehow, the person who did the
>> rebase discarded a merge commit:
>>
>> 634b622 Sue Merge pull request #254 from bob/B-07290
>> bc76e5b Bob [B-07290] Order Parts Ship To/Comments
>>
>> became:
>>
>> c1452be Sue [B-07290] Order Parts Ship To/Comments
>>
>>
>> A developer who had a local branch tried to rebase their work (a
>> single commit on top of that feature branch).
>>
>> At the moment, his now-out-of-date branch looks like this:
>>
>> 92b2194 Rick B-07241
>> 634b622 Sue Merge pull request #254 from dboyle/B-07290
>> bc76e5b Bob [B-07290] Order Parts Ship To/Comments
>>
>> I've done some debugging, and the above "git pull" command generates
>> the following and sends it to eval():
>>
>> git-rebase --onto c1452be62cf271a25d3d74cc63cd67eca51a127d
>> 634b622870a1016e717067281c7739b1fe08e08d
>>
>> This process works perfectly. The old commits are discarded and his
>> branch now correctly reflects upstream/our-branch-name, with his
>> single new commit at the top.
>>
>>
>> However, if he runs the "git rebase" command above, several of the
>> commits that have changed hashes (they've also changed patch id
>> slightly, because during the rebase someone fixed a merge conflict)
>> are treated as new work, and git tries to re-apply them and we get
>> tons of merge conflicts.
>>
>> The git rebase command above is trying to rebase onto:
>>
>> revisions = c1452be62cf271a25d3d74cc63cd67eca51a127d..92b2194e3adc29eb3fadd93ddded0ed34513d587
>>
>>
>> These two features should work the same, yet one is choosing a
>> different commit hash than the other.
>>
>> If this is not a bug, I can't find anyone who can explain what's
>> happening. I'm using git 2.2.1 on mac, but other people on our team
>> have a variety of older versions and we're all seeing the same result.
>
> What version of Git are you using?
>
> Does it work if you add the `--fork-point` argument to git-rebase?  If
> so, does it do the same if you just do "git rebase" with no arguments
> (see the documentation of `--fork-point` in git-rebase(1) for details of
> this)?



-- 
Mike Botsko
Lead Dev @ Helion3
Ph: 1-(503)-897-0155
