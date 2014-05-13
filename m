From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Tue, 13 May 2014 19:44:51 -0400
Organization: Twitter
Message-ID: <1400024691.14179.40.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:45:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkMNe-0003jy-42
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaEMXpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:45:01 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:45765 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaEMXpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:45:00 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so1556951qge.36
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=NWmjP3G6eNoiLCF3oKxMLyZLkq7B7oRZekxYGOo29/Y=;
        b=ZsV+PYqZmM9xSQqSTmDJEjpGQph0zvKEWj2UiO1X6GBDfH4kS3jPQfVzXpUEk97h3G
         nMZmN9ngqXCdY8OHu0S6eJq4UCRvhXM+a5mnM5Mjreq+MzdD8uX4t9OjJX/gipHUnggC
         1eAmBD4QVcNL4kY6QU9WwdlNilWiXA3zlz4Ybh9sryfam69CHugu1kcqk41AdqqoFMV8
         0lu2lN1VOv8qThg5wsuIVh1H5pY00IpNe6fxp05pgxJXD3Mkh9LXZ8JUJ0h4ZJIgvGf8
         87SPxbtM9ANa+ZxrQAiy/ll+6Yyzf3dwIDLv5zq7x50g8dWX+jrCbaS+NfQdImx30Wjx
         3Sgw==
X-Gm-Message-State: ALoCoQlPxXlK10n3y31QoBdkUg5GAnBgnNqlpLNgHLFT1XbWm62m0gcf1u3T1VuBUqfdHNuUQ2tZ
X-Received: by 10.229.58.68 with SMTP id f4mr374706qch.18.1400024694260;
        Tue, 13 May 2014 16:44:54 -0700 (PDT)
Received: from [172.17.2.145] ([38.104.173.198])
        by mx.google.com with ESMTPSA id q16sm43439qga.42.2014.05.13.16.44.52
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 16:44:53 -0700 (PDT)
In-Reply-To: <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248890>

On Sat, 2014-05-10 at 15:16 +0700, Duy Nguyen wrote:
> On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> > The most sigificant patch uses Facebook's watchman daemon[1] to monitor
> > the repository work tree for changes.  This makes allows git status
> > to avoid traversing the entire work tree to find changes.
> 
> Some comments on this series. I still haven't been able to run it with
> watchman so there are many guesses from my side.
> 
> First of all, when I set USE_WATCHMAN=Yes in config.mak I expect it to
> work out of the box, provided that all dependencies are installed. I
> still need to set WATCHMAN_LIBS for it to build because you only set
> it with configure script. Would be nice to have a default value for
> non-configure people too.

I'll fix that, thanks.

> I'm not so happy that git now needs to link to libjansson.so and
> libwatchman.so. I would load libwatchman.so at runtime only when
> core.usewatchman is on, but this is more of personal taste.

I assume you mean something with dlopen? I don't really like that because
(a) nothing else in git works that way and
(b) you would still need the libwatchman headers to build git (or the
structs could be copied, but that is ugly).

> I still prefer my old tracking model, where the majority of lstat() is
> done by refresh operation and we only need to optimize those lstat
> calls, not every single lstat statement in the code base.

The lstat calls are only one of the problems.  The others are
opendir/readdir and open(.gitignore). 

>  With that in
> mind, I think you don't need to keep a fs cache on disk at all. All
> you need to store (in the index) is the clock value from watchman.
> After we parse the index, we perform a "since" query to get path names
> (and perhaps "exists" and "mode" for later). Then we set CE_VALID bit
> on entries that are _not_ in the query result. The remaining items
> will be lstat'd by git (see [1] and read-cache.c changes on the next
> few patches). Assuming the number of updated files is reasonably
> small, we won't  be punished by lookup time. 

I considered this, but rejected it for a few reasons:
1. We still need to know about the untracked files.  I guess we could 
do an index extension for just that, like your untracked cache.

2. That doesn't eliminate opendir/readdir, I think.  Those are a major 
cost. I did not thoroughly review your patches from January/February, 
but I didn't notice anything in there about this part of dir.c.  
Also the cost of open(nonexistent .gitignore) to do ignore processing.

3. Changing a file in the index (e.g. git add) requires clearing
the CE_VALID bit; this means that third-party libraries (e.g. jgit) 
that change the git repo need to understand this extension for correct
operation.  Maybe that's just the nature of extensions, but it's not
something that my present patch set requires.
