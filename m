From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC] On watchman support
Date: Mon, 17 Nov 2014 19:25:36 -0500
Organization: Twitter
Message-ID: <1416270336.13653.23.camel@leckie>
References: <20141111124901.GA6011@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 01:25:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqWc5-0006YB-LV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 01:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbaKRAZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 19:25:42 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:45259 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbaKRAZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 19:25:41 -0500
Received: by mail-qa0-f52.google.com with SMTP id dc16so709330qab.25
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 16:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=+BNhXi2/vSt8V6PUeCzEgoUdUvO+l0Tkx0tb4X7H8Ic=;
        b=OXceo8W29HT6tUQGx8UEPwLrVlYbwwnlPBnsIZv9FFZqX8P9D1QFSb9NfRwJN3zKCt
         Myo+S/mcJ6C7Eu/iX6/sVe1dQglmlGtEaeIRNHOcL5G3+klN7zcUKK1khzuZB8E5UTLK
         8x31IR96oLMXNeJeLyf+r/0ZAGsn9jCsBs5BpMQEamWm8wWSIN/OrGkVLuSkMzHeI4mP
         uQ6InkSPCRt//KYIZuBzNFLpNL9n1GR5x/7m0Kw3ahndLi5zXVUuVUxHRCF6DBONwCEW
         mUwW7rXFsI0aXtdUlq5ZFxYFaNS9XX5KkF2hlvJ0mO7xglVQRuugSQbf4kfCxw7WyRa2
         HDgw==
X-Gm-Message-State: ALoCoQkoIbjJBA1vfSuMCgjmTiY9oBeRENBRQ1uHp4ZO9qFSCkGqsCt9x3RJplAxP8/AsUCb+cYt
X-Received: by 10.224.136.194 with SMTP id s2mr11277163qat.82.1416270340366;
        Mon, 17 Nov 2014 16:25:40 -0800 (PST)
Received: from [172.18.25.176] ([8.25.196.25])
        by mx.google.com with ESMTPSA id t44sm658877qgd.39.2014.11.17.16.25.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2014 16:25:39 -0800 (PST)
In-Reply-To: <20141111124901.GA6011@lanh>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-11 at 19:49 +0700, Duy Nguyen wrote:
> I've come to the last piece to speed up "git status", watchman
> support. And I realized it's not as good as I thought.
> 
> Watchman could be used for two things: to avoid refreshing the index,
> and to avoid searching for ignored files. The first one can be done
> (with the patch below as demonstration). And it should keep refresh
> cost to near zero in the best case, the cost is proportional to the
> number of modified files.
> 
> For avoiding searching for ignored files. My intention was to build on
> top of untracked cache. If watchman can tell me what files are added
> or deleted since last observed time, then I can invalidate just
> directories that contain them, or even better, calculate ignore status
> for those files only.
> 
> This is important because in reality compilers and editors tend to
> update files by creating a new version then rename them, updating
> directory mtime and invalidating untracked cache as a consequence. As
> you edit more files (or your rebuild touches more dirs), untracked
> cache performance drops (until the next "git status"). The numbers I
> posted so far are the best case.
> 
> The problem with watchman is it cannot tell me "new" files since the
> last observed time (let's say 'T'). If a file exists at 'T', gets
> deleted then recreated, then watchman tells me it's a new file. I want
> to separate those from ones that do not exist before 'T'.
> 
> David's watchman approach does not have this problem because he keeps
> track of all entries under $GIT_WORK_TREE and knows which files are
> truely new. But I don't really want to keep the whole file list around,
> especially when watchman already manages the same list.
> 
> So we got a few options:
> 
> 1) Convince watchman devs to add something to make it work

Based on the thread on the watchman github it looks like this won't
happen. 

> 2) Fork watchman
> 
> 3) Make another daemon to keep file list around, or put it in a shared
>    memory.
> 
> 4) Move David's watchman series forward (and maybe make use of shared
>    mem for fs_cache).
> 
> 5) Go with something similar to the patch below and accept untracked
>    cache performance degrades from time to time
> 
> 6) ??
> 
> I'm working on 1). 2) is just bad taste, listed for completeness
> only. If we go with 3) and watchman starts to support Windows (seems
> to be in their plan), we'll need to rework some how. And I really
> don't like 3)
> 
> If 1-3 does not work out, we're left without 4) and 5). We could
> support both, but proobably not worth the code complexity and should
> just go with one.
> 
> And if we go with 4) we should probably think of dropping untracked
> cache if watchman will support Windows in the end. 4) also has another
> advantage over untracked cache, that it could speed up listing ignored
> files as well as untracked files.
> 
> Comments?

I don't think it would be impossible to add Windows support to watchman;
the necessary functions exist, although I don't know how well they work.
My experience with watchman is that it is something of a stress test of
a filesystem's notification layer.  It has exposed bugs in inotify, and
caused system instability on OS X.

My patches are not the world's most beautiful, but they do work.  I
think some improvement might be possible by keeping info about tracked
files in the index, and only storing the tree of ignored and untracked
files separately.  But I have not thought this through fully.  In any
case, making use of shared memory for the fs_cache (as some of your
other patches do for the index) would definitely save time.
