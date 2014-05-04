From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sun, 4 May 2014 07:15:11 +0700
Message-ID: <CACsJy8Dr=m5FwmD2gXTM3bN-iYv+fyZ9RBUyvcj3UJJCC1yYtg@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
 <1399091986.5310.20.camel@stross> <CACsJy8B1Q3WEPT+nzDDwS5f7Wx+u5CHfN9JppRHv5VEx5NTxSw@mail.gmail.com>
 <1399150149.5310.47.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun May 04 02:15:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgk5s-00046m-Oh
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 02:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbaEDAPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 20:15:43 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:54209 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbaEDAPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 20:15:42 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so3035958qcv.38
        for <git@vger.kernel.org>; Sat, 03 May 2014 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1GXPhHOSbL9Cn/rI+Xk6nVNqJB5CfN7rwjmL8POngKU=;
        b=NsbV4FUXq3bMkIWxaErh5xuU+JJiFA0yA+xDgVpmRqWI7g0G7xy2BC76JMFGNWSmq3
         rYga5jMrtNl8xmzs9u56ztk4/GmIrYYXrMqqORN4WvnUFWp00c/R3rGV1yI+W8a6uxHW
         mrCVjblhh0kyJbL8Q/sAd2AroxKSbxgZclerfSOkNntYsvfupigjCeDxEaBHsxs0iv0q
         XT9st0fUZjXp6n93lOi93E02YJg4jSKAXj3r7ZqHzPk1UdpTIR/gIi/URrVxqCZ6W+Q+
         YDQO2V0HUiIKb5FoGODd+EsEFlg2rNi3Y/A81HquG80dBXFA7iv3CyRz4ypMSuctGQLZ
         QyAg==
X-Received: by 10.140.18.180 with SMTP id 49mr31245943qgf.105.1399162541292;
 Sat, 03 May 2014 17:15:41 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 3 May 2014 17:15:11 -0700 (PDT)
In-Reply-To: <1399150149.5310.47.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248062>

On Sun, May 4, 2014 at 3:49 AM, David Turner <dturner@twopensource.com> wrote:
> On Sat, 2014-05-03 at 15:49 +0700, Duy Nguyen wrote:
>> On Sat, May 3, 2014 at 11:39 AM, David Turner <dturner@twopensource.com> wrote:
>> >> Index v4 and split index (and the following read-cache daemon,
>> >> hopefully)
>> >
>> > Looking at some of the archives for read-cache daemon, it seems to be
>> > somewhat similar to watchman, right?  But I only saw inotify code; what
>> > about Mac OS?  Or am I misunderstanding what it is?
>>
>> It's mentioned in [1], the second paragraph, mostly to hide index I/O
>> read cost and the SHA-1 hashing cost in the background. In theory it
>> should work on all platforms that support multiple processes and
>> efficient IPC. It can help load watchman file cache faster too.
>
> Yes, that seems like a good idea.
>
> I actually wrote some of a more-complicated, weirder version of this
> idea.  In my version, there was a long-running git daemon process that
> held the index, the watchman file cache, and also objects loaded from
> the object database.  Other git commands would then send their
> command-line and arguments over to the daemon, which would run the
> commands and send stdin/out/err back.  Of course, this is complicated
> because git commands are designed to run then exit, so they often rely
> on variables being initialized to zero, or fail to free memory.  I used
> the Boehm GC to handle the memory freeing problem.  To handle variables
> that needed to be reinitialized, I used __attribute__(section...) to put
> them all into one section, which I could save on daemon startup and
> restore after each command.  I also replaced calls to exit() with a
> function that called longjmp() so the daemon could survive commands
> failing.  Had I continued, I would also have had to track open file
> descriptors to avoid leaking those.
>
> This was a giant mess that only sort-of worked: it was difficult to
> track down all of the variables that needed to be reinitialized.
>
> The advantage of my method is that there was somewhat less data to
> marshall over IPC, and that objects could be easily cached; the
> disadvantage is complexity, massive code changes, and the fact that it
> didn't actually totally work at the time I ran out of time.
>
> So I'm really looking forward to trying your version!

Hm.. I may face the same problem if I'm not careful. So far I think
the daemon only holds index data (with on-disk format, not in-memory),
mainly to cut out SHA-1 hashing cost. This is still at the idea phase
for me though, nothing is materialized yet.

> I would like to merge the feature into master.  It works well for me,
> and some of my colleagues who have tried it out.

Have you tried to turn watchman on by default, then run it with git
test suite? That usually helps.

> I can split the vmac patch into two, but one of them will remain quite
> large because it contains the code for VMAC and AES, which total a bit
> over 100k.  Since the list will probably reject that, I'll post a link
> to a repository containing the patches.

With the read-cache deamon, I think hashing cost is less of an issue,
so new hashing algorithm becomes less important. If you store the file
cache in the deamon's memory only, there's no need to hash anything.
But I guess you already tried this.

> I'm not 100% sure how to split the watchman patch up.  I could add the
> fs_cache code and then separately add the watchman code that populates
> the cache.  Do you think there is a need to divide it up beyond this?

I'll need to have closer look at your patches to give any suggestions.
Although if you don't mind waiting a bit, I can try to put my
untracked cache patches in good shape (hopefully in 2 weeks), then you
can mostly avoid touching dir.c and reuse my work.

I backed away from watchman support because I was worried about its
overhead (of watchman itself, and git/watchman IPC because it's not
designed specifically for git), which led me to try optimizing git as
much as possible without watchman first, then see how/if watchman can
help on top of that. I still think it's a good approach (maybe because
it started to make me doubt if watchman could pull a big performance
win on top to justify the changes to support it)
-- 
Duy
