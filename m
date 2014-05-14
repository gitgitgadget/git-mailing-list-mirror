From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Wed, 14 May 2014 17:36:40 +0700
Message-ID: <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com> <1400024691.14179.40.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 14 12:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkWYn-0000YK-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 12:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaENKhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 06:37:14 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48435 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbaENKhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 06:37:11 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so2435832qcq.15
        for <git@vger.kernel.org>; Wed, 14 May 2014 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VRFuCoi79Tc9GfKsZRxiAwOCLqAbe///h6nTQQbnMDQ=;
        b=j5XO1WZ1ZArwj0030RFhVf6LgBab4IFpkYvCr+xmlHBSJ7S1cFlFZS7TvCHeyqROEt
         XiFA28R0JGwQ80dozZzBfWJOUmCodX630uggDeFsl5ZZwFywSezSG1LWPyQgSw7wqp85
         K2+Gs4TW+eBbqfuMrEuG9FpbBqvDuBATorXNmGgrQ6kjosMA2I6LZlDMYiPv3xeI03f+
         yPLPP3O9bA5u6EOVMCgZuKeCiwOizHRkPwobzrUdK2kmONqHMAf1Cb2tgDae0UyZCuMX
         /DeSLmExQS/zZjBvQDvGJ/tidGjLpXLjXdQaa/J5Bn4rwNEtBeG3m2hLrI7s9mSFVx0K
         84ag==
X-Received: by 10.224.23.5 with SMTP id p5mr1943417qab.88.1400063830320; Wed,
 14 May 2014 03:37:10 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Wed, 14 May 2014 03:36:40 -0700 (PDT)
In-Reply-To: <1400024691.14179.40.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248908>

On Wed, May 14, 2014 at 6:44 AM, David Turner <dturner@twopensource.com> wrote:
>> I'm not so happy that git now needs to link to libjansson.so and
>> libwatchman.so. I would load libwatchman.so at runtime only when
>> core.usewatchman is on, but this is more of personal taste.
>
> I assume you mean something with dlopen? I don't really like that because
> (a) nothing else in git works that way and
> (b) you would still need the libwatchman headers to build git (or the
> structs could be copied, but that is ugly).

And because we don't link to libdl.so anyway, using dlopen means
trading libjansson.so and libwatchman.so for libdl.so. And it's
uglier. So forget what I wrote.

>>  With that in
>> mind, I think you don't need to keep a fs cache on disk at all. All
>> you need to store (in the index) is the clock value from watchman.
>> After we parse the index, we perform a "since" query to get path names
>> (and perhaps "exists" and "mode" for later). Then we set CE_VALID bit
>> on entries that are _not_ in the query result. The remaining items
>> will be lstat'd by git (see [1] and read-cache.c changes on the next
>> few patches). Assuming the number of updated files is reasonably
>> small, we won't  be punished by lookup time.
>
> I considered this, but rejected it for a few reasons:
> 1. We still need to know about the untracked files.  I guess we could
> do an index extension for just that, like your untracked cache.

Yes. But consider that the number of untracked files is usually small
(otherwise 'git status' would look very messy). And your fscache would
need to store excluded file list too, which could be a lot bigger (one
pair of  .[ch] -> one .o). _But_ yours would make 'git status
--ignored' work. I don't consider that a major use case for
optimization, but people may have different opinions.

> 2. That doesn't eliminate opendir/readdir, I think.  Those are a major
> cost. I did not thoroughly review your patches from January/February,
> but I didn't notice anything in there about this part of dir.c.
> Also the cost of open(nonexistent .gitignore) to do ignore processing.

Assuming untracked cache is in use, opendir/readdir is replaced with
lstat. And cheap lstat can be solved with watchman without storing
anything extra. I solve open(.gitignore) too by checking its stat data
with the one in index. If matches, I reuse the version in tree. This
does not necessarily make it cheaper, but it increases locality so it
might be. _Modified_ .gitignore files have to go through
open(.gitignore), but people don't update .gitignore often.

> 3. Changing a file in the index (e.g. git add) requires clearing
> the CE_VALID bit; this means that third-party libraries (e.g. jgit)
> that change the git repo need to understand this extension for correct
> operation.  Maybe that's just the nature of extensions, but it's not
> something that my present patch set requires.

I don't store CE_VALID on disk. Instead I store a new bit CE_WATCHED.
Only after loading and validating against watchman that I turn
CE_WATCHED to CE_VALID in memory. So JGit, libgit2 are not confused.

I assume you won't change your mind about this. Which is fine to me. I
will still try out my approach with your libwatchman though. Just
curious about its performance and complexity, compared to your
approach.

A bit off topic, but msys fork has another "fscache" in compat/win32.
If you could come up with a different name, maybe it'll be less
confusing for them after merging. But this is not a big deal, as this
fscache won't work on windows anyway.
-- 
Duy
