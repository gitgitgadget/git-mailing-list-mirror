From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: sharing .git/config
Date: Tue, 12 Mar 2013 01:01:08 +0530
Message-ID: <CALkWK0kZiYmbh-dSr-c2mzK2Mzhf3iZ_T3hFNuR57F0b5tptGw@mail.gmail.com>
References: <CALkWK0npW6TLdMNd5_zw-RAB0bjF9DDoyAVSx4Zx=7AmvdEo3w@mail.gmail.com>
 <CACsJy8Ch70gZMkT7ScY3R-FNQU4QjtUe8UhoGRzE27cH9mu0HA@mail.gmail.com> <20130219153600.GA5338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF8S2-0004ht-2e
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab3CKTba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:31:30 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59278 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3CKTb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:31:28 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so5333884ied.30
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QnFy9CuP3LrDQy0rRC0q68r3LFvsdFomzoSfj+QuyBQ=;
        b=iOxdWXQkDb6g4xC/Ht092nDOYAsrzdbe9tqZ4TdCwiqLUvWFViJmwE3Ouy2q16pmCZ
         TOT4ogU1VzKVgGXPrLIHjvb5Y7qXcC/Yd9X3DiAuZ4RvQz/C0h8rn9M2oTYBLD3BMduq
         70axexrEoqKnM+fopOUPz6lsBSE5/s7vt3DXQ7IsbPzYhvBhxcrJlb61MHJe4OBFWfkL
         3q235wan7RlxeUmj1Tnkw0pnIIi3IqZ3bDQ6GxStwQta/oO/LHWuRKNRAZnAWjIJzuUP
         oA1sDQJFEn4kQj85+Dyy9i4cKZj7wTyCVBu5GUecpN5etukHTQO+V62KRZclsHyDJ5PF
         rqSg==
X-Received: by 10.42.67.10 with SMTP id r10mr9813268ici.7.1363030288390; Mon,
 11 Mar 2013 12:31:28 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 11 Mar 2013 12:31:08 -0700 (PDT)
In-Reply-To: <20130219153600.GA5338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217902>

Jeff King wrote:
> On Tue, Feb 19, 2013 at 05:34:43PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Tue, Feb 19, 2013 at 4:25 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>> > Hi,
>> >
>> > I have this itch where I want to share my remotes config between
>> > machines.  In my fork, I should be able to specify where my upstream
>> > sources are, so remotes get set up automatically when I clone.  There
>> > are also other things in .git/config that would be nice to share, like
>> > whether to do a --word-diff (why isn't it a configuration variable
>> > yet?) on the repository.  The only problem is that I have no clue how
>> > to implement this: I'm currently thinking a special remote ref?
>>
>> If you check out the config file, then include.path should work. You
>> could add include.ref to point to a ref, but you need to deal with the
>> attached security implications. This has been proposed before (and
>> turned down, I think).
>
> Here's the patch:
>
>   http://article.gmane.org/gmane.comp.version-control.git/189144
>
> The basic argument against it is that you would _not_ want to do:
>
>   $ git config include.ref origin/config
>
> because it's unsafe (you immediately start using config fetched from the
> remote, before you even get a chance to inspect it). So the recommended
> way to use it is:
>
>   $ git config include.ref config
>   $ git show origin/config ;# make sure it looks reasonable
>   $ git update-ref refs/config origin/config
>
>   [time passes...]
>
>   $ git fetch
>   $ git diff config origin/config ;# inspect changes
>   $ git update-ref refs/config origin/config
>
> But it was pointed out that you could also just do:
>
>   $ git config include.ref upstream-config
>   $ git show origin/config ;# make sure it looks reasonable
>   $ git show origin/config >.git/upstream-config
>
> and so forth. There are some ways that a pure ref can be more
> convenient (e.g., if you are carrying local changes on top of the
> upstream config and want to merge), but ultimately, you can replicate
> any include.ref workflow with include.path by adding a "deploy" step
> where you copy the file into $GIT_DIR.

This seems to be unnecessarily complex and inelegant.  Maybe this
functionality is best managed as a separate git repository: `repo`
from depot_tools uses a manifest repository containing all the project
metadata.  Maybe we can extend it/ write an more general version?
