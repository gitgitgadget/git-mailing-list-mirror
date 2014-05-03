From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sat, 3 May 2014 15:49:23 +0700
Message-ID: <CACsJy8B1Q3WEPT+nzDDwS5f7Wx+u5CHfN9JppRHv5VEx5NTxSw@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com> <1399091986.5310.20.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat May 03 10:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgVdx-0007Qx-1M
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 10:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbaECIt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 04:49:56 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38342 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaECIty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 04:49:54 -0400
Received: by mail-qa0-f53.google.com with SMTP id ih12so1288381qab.12
        for <git@vger.kernel.org>; Sat, 03 May 2014 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BiJ1b9zbDc1ZUmWdpVxWaPC0gMDzKrYgoDK5Bc2DFQU=;
        b=n1AA0VuHnDVMoTYNQTZupejYds/u+jpTv55986UUyJHDQ4v0stQdf9MEAeCgV+XJXl
         1DddMn8uoCtVOjcSAt8s8hqoLnPaL9K0x26+yKQJxYfb5koVGSWdfaiZ+tXBbitLkWmC
         695D5EjRx6hZuToqlqcS+1hukcvFKIPZdMxonuN2lXMGFcUqR1EbdUdmI0JkCVI+i0FM
         2ji8yzmUNzvRPP7YE9tfpcE/eWiWcoeXRfeSg3/mVXMFXCdk0Q/FWQGjFwjLT1h2YIHO
         0cyKvR3DYdbANLBFFPJeWJiB4U/nV5Z20047XhM/gPvvJGMjHKLYlCEQ77GbBSXePcct
         VRSQ==
X-Received: by 10.224.138.3 with SMTP id y3mr28665224qat.78.1399106993572;
 Sat, 03 May 2014 01:49:53 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 3 May 2014 01:49:23 -0700 (PDT)
In-Reply-To: <1399091986.5310.20.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248028>

On Sat, May 3, 2014 at 11:39 AM, David Turner <dturner@twopensource.com> wrote:
>> Index v4 and split index (and the following read-cache daemon,
>> hopefully)
>
> Looking at some of the archives for read-cache daemon, it seems to be
> somewhat similar to watchman, right?  But I only saw inotify code; what
> about Mac OS?  Or am I misunderstanding what it is?

It's mentioned in [1], the second paragraph, mostly to hide index I/O
read cost and the SHA-1 hashing cost in the background. In theory it
should work on all platforms that support multiple processes and
efficient IPC. It can help load watchman file cache faster too.

>> The last line could be a competition between watchman and my coming
>> "untracked cache" series. I expect to cut the number in that line at
>> least in half without external dependency.
>
> I hadn't seen the "untracked cached" work (I actually finished these
> patches a month or so ago but have been waiting for some internal
> reviews before sending them out).  Looks interesting.  It seems we use a
> similar strategy for handling ignores.

Yep, mostly the same at the core, except that I exploit directory
mtime while you use inotify. Each approach has its own pros and cons,
I think. Both should face the same traps in caching (e.g. if you "git
rm --cached" a file, that file could be come either untracked, or
ignored).

>> Patch 2/3 did not seem to make it to the list by the way..
>
> Thanks for your comments.  I just tried again to send patch 2/3.  I do
> actually see the CC of it in my @twitter.com mailbox, but I don't see it
> in the archives on the web.  Do you know if there is a reason the
> mailing list would reject it?

Probably its size, 131K, which is also an indicator to split it (and
the third patch) into smaller patches if you want to merge this
feature in master eventually.

>   At any rate, the contents may be found
> at
> https://github.com/dturner-tw/git/commit/cf587d54fc72d82a23267348afa2c4b60f14ce51.diff

Good enough for me :)

>
>> initial
>> reaction is storing the list of all paths seems too much, but I'll
>> need to play with it a bit to understand it.
>
> I wonder if it would make sense to use the untracked cache as the
> storage strategy, but use watchman as the update strategy.

I'm afraid not. If a directory mtime is changed, which means
files/dirs have been added or deleted, the untracked code would fall
back to the opendir/readdir/is_excluded dance again on that directory.
If we naively do the same using watchman, we lose its advantage that
it knows exactly what files/dirs are added/removed. That kind of
knowledge can help speed up the dance, which is not stored anywhere in
the untracked cache.

We could extend the "read-cache daemon" mentioned above though, to
hide all the hard work in the background and present a good view to
git: when a file/dir is added, read-cache daemon classifies the new
files/dirs as tracked/untracked/ignore and update its untracked cache
in memory. When "git status" asks about the index and untracked cache,
it will receive the _updated_ cache (not the on disk version any more)
with latest dir mtime so git can verify the cache is perfect and skip
opendir/.... All git does is to write the index down in the end to
make the updated data permanent. It sounds interesting. But I'm not so
sure if it's worth the complexity.

[1] http://article.gmane.org/gmane.comp.version-control.git/247268
-- 
Duy
