From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [HELP] Corrupted repository
Date: Fri, 21 Jun 2013 22:14:06 +0530
Message-ID: <CALkWK0mTZqtGFp-BW9XBjX4Cm2hCZ1=P5M0a4cMBuE0v__LpZw@mail.gmail.com>
References: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
 <7v7ghno2lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4SB-00086V-A5
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161613Ab3FUQor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:44:47 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55798 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161585Ab3FUQoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:44:46 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so20052502iec.36
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UsdfCZAygFclr0LL7BHFvhLgfSRpSANy12kjFFb7t70=;
        b=CZst0Zst9fa79tVkRJf52C/BpSIjoV4qJ/SB3Q5Yf0sjX7+ejaPufNv6rCI6m4Uo1i
         JD9wNNK+BrDxMsF/daz9ZAG0ThHCwq+r/91xxp/C3d4f7QpS6xxZeRqsfa2FsMWMT+9I
         xF11+ySnfYrcwTimHeB9NiePp0LLaI4StjKkgYIryPCSLwcDX1ZvPdLbAZAtSy85BrJH
         Hr+Y5hj8BPgSddB+0WZ7/+iXdcctuLnBnkZrRFboLnr8/O9Q1heOOHJBmETMdXsZEvBU
         0jLko0FBjeMVxD+f0GKCV9gwYODTjSt4+M8yvcldgQGvF7ETQItYyEUhkLCij8pNdtu4
         jCzQ==
X-Received: by 10.42.190.74 with SMTP id dh10mr6515614icb.35.1371833086364;
 Fri, 21 Jun 2013 09:44:46 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 09:44:06 -0700 (PDT)
In-Reply-To: <7v7ghno2lz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228630>

Junio C Hamano wrote:
>>   $ ~/src/git
>>   error: object file
>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>   error: object file
>> .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
>>   fatal: loose object 8e6a6dda24b017915449897fcc1353a9b848fd2f (stored
>> in .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f) is corrupt
>
> So fsync() and close() thought that the filesystem stored this loose
> object safely, but it turns out that the data is not on disk.

Where should I start digging if I want to fix this?  Actually you just
need to tell me how to build reduced-case corruptions to test: I can
trace and figure out the rest.

>>   artagnon|remote-cruft*+:~/src/git$ git prune
>>   artagnon|remote-cruft*+:~/src/git$ git status
>>   fatal: bad object HEAD
>>   fatal: bad object HEAD
>
> And the value in the HEAD was???

ref: refs/heads/remote-cruft.  That's why I included my prompt :)

>>   artagnon|remote-cruft*+:~/src/git$ git symbolic-ref HEAD refs/heads/master
>>   artagnon|master*+=:~/src/git$ git status
>>   ## master
>>   MM Documentation/git-ls-remote.txt
>>   MM remote.c
>>   MM t/t5505-remote.sh
>>   MM t/t5510-fetch.sh
>>   MM t/t5515-fetch-merge-logic.sh
>>   MM t/t5516-fetch-push.sh
>>   ?? lib/
>>   ?? outgoing/
>>
>> That status is completely bogus, by the way.
>
> ... which may suggest that your index file may have been corrupted
> on the filesystem.

Yeah, my question pertains to why is the index half-corrupted.  Is
there no checksum to say "index corrupted; do not display bogus
nonsense"?

>>   artagnon|master*+=:~/src/git$ git checkout remote-cruft
>>   fatal: reference is not a tree: remote-cruft
>>   artagnon|master=:~/src/git$ git reflog
>>   21ff915 HEAD@{10 minutes ago}: rebase -i (finish): returning to
>> refs/heads/remote-cruft
>>
>> What happened to the rest of my reflog?!
>
> On the filesystem known to not record the last consistent state of
> the repository, the answer to that question may be rather obvious,
> no?

I didn't understand.  What does .git/logs/HEAD have to do with any of
this?  Why is it truncated?

>>   artagnon|master=:~/src/git$ git branch -D remote-cruft
>>   error: Couldn't look up commit object for 'refs/heads/remote-cruft'
>
> The command would want to report what was at the tip, so it is
> understandable it may want to look up that commit before removing
> the ref.

I would have expected it to display a warning and remove the ref
anyway.  Or error out, and override with a force-flag?

>> Fine, let's fetch.
>
> Why?
>
> "fetch" walks the ancestry graph on both ends to minimize transfers.
> It's not something you would expect to work when you know refs at
> your end does not even record what you do have.  It _may_ appear to
> work if your refs are intact but you are missing objects, as they
> will not be transferred again from the good copy if you let your
> repository's ref claim that you have _all_ objects behind it when
> you actually don't.

Right.  I expected it to figure out that I have a broken history and
fetch everything (which is what happened the second time, no?).

> What would have been a better starting point to untangle is to make
> a separate clone, pretending as if this repository did not even
> exist, and copy the resulting packfile into this repository.  That
> would at least give you a known good copies of objects that you
> already have pushed out.

Yeah, I deliberately avoided doing that: apart from the config and
refs, I had no real unpushed work in ~/src/git anyway (I push _very_
frequently, which explains my "resolve HEAD early in current" patch).
The most important part of what I did was running unpack-objects by
hand: that fixed everything.  I shouldn't have had to run that by hand
though: why isn't there an in-built way to unpack everything, remove
corruptions, and repack the good stuff?

> And the next step would have been (without doing any of the above
> "remove this branch, recreate this one anew") to compare the tips
> of refs in this broken repository and the clone.  The same ones you
> can trust, and different ones you dig further.

Right.  I didn't have local data in this case, so I didn't bother.

>> Was I being stupid, or is fixing corrupted repositories really this
>> non-trivial?  Comments appreciated.
>
> I think "Let's fetch first" was the step that took you in a wrong
> direction that requires unnecessary work.

This was mainly a learning exercise for me: I wanted to see how good
git was at working with corrupted repositories.  I did my surgery
fairly quickly, and avoided large network transfers (I have a slow
connection).
