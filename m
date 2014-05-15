From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Thu, 15 May 2014 15:42:51 -0400
Organization: Twitter
Message-ID: <1400182971.14179.49.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
	 <1400024691.14179.40.camel@stross>
	 <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:43:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1YS-0003is-Qj
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbaEOTm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:42:56 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:57751 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbaEOTmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:42:55 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so2618658qga.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=B/O5txEWyRY22TMl/XzVsbS3WorKQmVHLLHiE2rr5Vg=;
        b=gQeH+kpstk2cUrlj0AKqdGFd7q/nAmVLOzZpll+0jFB3PyIQW2j2t7uJOLRaB4M4Pm
         FfB4zYcqdhUZ83afbhHWA/30eUFj6WzGah3+qdLK20bxkX5L6/LG6cG1ZtzUz7goliEz
         ju40TLpHFC4meM9oUPOSwvgZZxeSO5hTSWH7dwM0Q9aood+WXbsAYeDF63xnFVtmcjgv
         SDdOQBu2UGKzzhvnePJhYBKCBLJZoreDYn0+P/tGe31UCsBdj4hEv8nxxDd4K/ZBPBw+
         Fois/WGC3ZaodIqcO+FuXrH/aDs9qQ36fWvdUNUL4a0gCQP7tL62SAQX3cxXEpoP2PBY
         oQXg==
X-Gm-Message-State: ALoCoQkx40oHnqrhN2od8oAH6g0ZjE+3wDc6RUEVhcyMU67qfQE/pTK1evpAg1X7peGK1po3Woi/
X-Received: by 10.229.125.130 with SMTP id y2mr19053746qcr.22.1400182975135;
        Thu, 15 May 2014 12:42:55 -0700 (PDT)
Received: from [172.18.25.129] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 60sm3724973qgr.29.2014.05.15.12.42.52
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:42:53 -0700 (PDT)
In-Reply-To: <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249193>

On Wed, 2014-05-14 at 17:36 +0700, Duy Nguyen wrote:
> >>  With that in
> >> mind, I think you don't need to keep a fs cache on disk at all. All
> >> you need to store (in the index) is the clock value from watchman.
> >> After we parse the index, we perform a "since" query to get path names
> >> (and perhaps "exists" and "mode" for later). Then we set CE_VALID bit
> >> on entries that are _not_ in the query result. The remaining items
> >> will be lstat'd by git (see [1] and read-cache.c changes on the next
> >> few patches). Assuming the number of updated files is reasonably
> >> small, we won't  be punished by lookup time.
> >
> > I considered this, but rejected it for a few reasons:
> > 1. We still need to know about the untracked files.  I guess we could
> > do an index extension for just that, like your untracked cache.
> 
> Yes. But consider that the number of untracked files is usually small
> (otherwise 'git status' would look very messy). And your fscache would
> need to store excluded file list too, which could be a lot bigger (one
> pair of  .[ch] -> one .o). _But_ yours would make 'git status
> --ignored' work. I don't consider that a major use case for
> optimization, but people may have different opinions.

I don't think --ignored is a major use case.  But I do think it's nice
to get as much mileage as possible out of a change like this.  

> > 2. That doesn't eliminate opendir/readdir, I think.  Those are a major
> > cost. I did not thoroughly review your patches from January/February,
> > but I didn't notice anything in there about this part of dir.c.
> > Also the cost of open(nonexistent .gitignore) to do ignore processing.
> 
> Assuming untracked cache is in use, opendir/readdir is replaced with
> lstat. And cheap lstat can be solved with watchman without storing
> anything extra. I solve open(.gitignore) too by checking its stat data
> with the one in index. If matches, I reuse the version in tree. This
> does not necessarily make it cheaper, but it increases locality so it
> might be. _Modified_ .gitignore files have to go through
> open(.gitignore), but people don't update .gitignore often.

Interesting -- if all that actually works, then it's probably the right
approach.  

> > 3. Changing a file in the index (e.g. git add) requires clearing
> > the CE_VALID bit; this means that third-party libraries (e.g. jgit)
> > that change the git repo need to understand this extension for correct
> > operation.  Maybe that's just the nature of extensions, but it's not
> > something that my present patch set requires.
> 
> I don't store CE_VALID on disk. Instead I store a new bit CE_WATCHED.
> Only after loading and validating against watchman that I turn
> CE_WATCHED to CE_VALID in memory. So JGit, libgit2 are not confused.
> 
> I assume you won't change your mind about this. Which is fine to me. I
> will still try out my approach with your libwatchman though. Just
> curious about its performance and complexity, compared to your
> approach.

I am open-minded here. This code is really the first time I have looked
at git's internals, and I accept that your way might be better.  If
you're going to try the watchman version of your approach, then we do a
direct comparison.  Let me know if there is something I can do to help
out on that.

> A bit off topic, but msys fork has another "fscache" in compat/win32.
> If you could come up with a different name, maybe it'll be less
> confusing for them after merging. But this is not a big deal, as this
> fscache won't work on windows anyway.

Does wtcache sounds like a better name?
