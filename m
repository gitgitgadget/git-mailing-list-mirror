From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Sat, 03 May 2014 16:49:09 -0400
Organization: Twitter
Message-ID: <1399150149.5310.47.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com>
	 <1399091986.5310.20.camel@stross>
	 <CACsJy8B1Q3WEPT+nzDDwS5f7Wx+u5CHfN9JppRHv5VEx5NTxSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 22:49:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wggs9-0007Gm-Uo
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbaECUtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:49:15 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41060 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbaECUtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 16:49:14 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so907654pdb.13
        for <git@vger.kernel.org>; Sat, 03 May 2014 13:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=vIHYG36RbHYbC4VR463dI82exit58Q6PYdLc3fD690Y=;
        b=BXkFac+4lGt5F+QYYxqYiw8Oqt97hFNq9vPSpxMuAGwqBvK+jcgK+pMnreUVq+O/ph
         oEqhi14klB2V4b3O3fn874kPv+qNV7sQaFwzozMWB1ltHN7ukpUm827fCJcPtHQ/TJta
         5hR0kSVP8eEBtIRiLhgt/EUNn47RHdQnGm2ynnnkZIcaxeSNIt2DUPVrVzo9unWQ+I0w
         hPKZDgfpYFZR87AZkGl8rxTkGDnh5Eqh7KHd47CkMZjMsOqRv3UOYmT7MDIu/3kZwOUX
         Vvz0xoI19D3ovR0LZwpKGP1fbk5zenspbSF4Cn/tmA4qIl560HOsiiwu96403irxXKoC
         fYPQ==
X-Gm-Message-State: ALoCoQld3q8ETn3reh0MDTHWnjNIphMMgQwltESjpL8Iqs5QaoT+3lwsY2xaXj+oIkiYj2Ky5dYE
X-Received: by 10.66.149.7 with SMTP id tw7mr51843052pab.72.1399150153987;
        Sat, 03 May 2014 13:49:13 -0700 (PDT)
Received: from [10.0.1.149] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id qh2sm27179874pab.13.2014.05.03.13.49.11
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 03 May 2014 13:49:13 -0700 (PDT)
In-Reply-To: <CACsJy8B1Q3WEPT+nzDDwS5f7Wx+u5CHfN9JppRHv5VEx5NTxSw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248058>

On Sat, 2014-05-03 at 15:49 +0700, Duy Nguyen wrote:
> On Sat, May 3, 2014 at 11:39 AM, David Turner <dturner@twopensource.com> wrote:
> >> Index v4 and split index (and the following read-cache daemon,
> >> hopefully)
> >
> > Looking at some of the archives for read-cache daemon, it seems to be
> > somewhat similar to watchman, right?  But I only saw inotify code; what
> > about Mac OS?  Or am I misunderstanding what it is?
> 
> It's mentioned in [1], the second paragraph, mostly to hide index I/O
> read cost and the SHA-1 hashing cost in the background. In theory it
> should work on all platforms that support multiple processes and
> efficient IPC. It can help load watchman file cache faster too.

Yes, that seems like a good idea.

I actually wrote some of a more-complicated, weirder version of this
idea.  In my version, there was a long-running git daemon process that
held the index, the watchman file cache, and also objects loaded from
the object database.  Other git commands would then send their
command-line and arguments over to the daemon, which would run the
commands and send stdin/out/err back.  Of course, this is complicated
because git commands are designed to run then exit, so they often rely
on variables being initialized to zero, or fail to free memory.  I used
the Boehm GC to handle the memory freeing problem.  To handle variables
that needed to be reinitialized, I used __attribute__(section...) to put
them all into one section, which I could save on daemon startup and
restore after each command.  I also replaced calls to exit() with a
function that called longjmp() so the daemon could survive commands
failing.  Had I continued, I would also have had to track open file
descriptors to avoid leaking those.

This was a giant mess that only sort-of worked: it was difficult to
track down all of the variables that needed to be reinitialized. 

The advantage of my method is that there was somewhat less data to
marshall over IPC, and that objects could be easily cached; the
disadvantage is complexity, massive code changes, and the fact that it
didn't actually totally work at the time I ran out of time. 

So I'm really looking forward to trying your version!

> >> The last line could be a competition between watchman and my coming
> >> "untracked cache" series. I expect to cut the number in that line at
> >> least in half without external dependency.
> >
> > I hadn't seen the "untracked cached" work (I actually finished these
> > patches a month or so ago but have been waiting for some internal
> > reviews before sending them out).  Looks interesting.  It seems we use a
> > similar strategy for handling ignores.
> 
> Yep, mostly the same at the core, except that I exploit directory
> mtime while you use inotify. Each approach has its own pros and cons,
> I think. Both should face the same traps in caching (e.g. if you "git
> rm --cached" a file, that file could be come either untracked, or
> ignored).
> 
> >> Patch 2/3 did not seem to make it to the list by the way..
> >
> > Thanks for your comments.  I just tried again to send patch 2/3.  I do
> > actually see the CC of it in my @twitter.com mailbox, but I don't see it
> > in the archives on the web.  Do you know if there is a reason the
> > mailing list would reject it?
> 
> Probably its size, 131K, which is also an indicator to split it (and
> the third patch) into smaller patches if you want to merge this
> feature in master eventually.

I would like to merge the feature into master.  It works well for me,
and some of my colleagues who have tried it out.

I can split the vmac patch into two, but one of them will remain quite
large because it contains the code for VMAC and AES, which total a bit
over 100k.  Since the list will probably reject that, I'll post a link
to a repository containing the patches.

I'm not 100% sure how to split the watchman patch up.  I could add the
fs_cache code and then separately add the watchman code that populates
the cache.  Do you think there is a need to divide it up beyond this?
