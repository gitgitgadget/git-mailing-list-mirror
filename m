From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Wed, 13 Mar 2013 08:03:32 +0700
Message-ID: <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com> <513FB85C.5010106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 02:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFa7N-0004ow-1K
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 02:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681Ab3CMBEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 21:04:05 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34723 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 21:04:04 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so534799oag.9
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=iWsBfcfys8pdgnSpu4dIH5AnPUxyvnIDwJW0XdypKjg=;
        b=l449wmoeYms9V63qnN5Vwgr+EuVMiJ52diUqRY6ak+KeH0DF+uGy/KWF6SUSVHPCqc
         lpfBGRmNhb4vYAJdmera/JJkuXSwpZhDxUKxD3I3QbAE2OQ7ZzLbQcrrMRQor3pUQSyj
         x1H+R1j1UDnXSdhg3uu01hSDlbPuQ3M0sPSudvuL49Ad8rowIS70vT8IbWNKm9XvR2Lb
         f+8FiscJLYifOCl7mIfODnjk9zdwV+AwaOvj403aYVJtESkuL3sNS62O0oMlyUdzX+uE
         TlP62jbDQQx+dcFf+DANx177aT/Z35oaMYzSt545+UXiAupnJmIQ+oyeWpIxd752EzqP
         Gt2A==
X-Received: by 10.182.43.103 with SMTP id v7mr13880030obl.17.1363136643404;
 Tue, 12 Mar 2013 18:04:03 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 12 Mar 2013 18:03:32 -0700 (PDT)
In-Reply-To: <513FB85C.5010106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218017>

On Wed, Mar 13, 2013 at 6:21 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Hmmm...I don't see how filesystem changes since last invocation can solve the problem, or am I missing something? I think what you mean to say is that the daemon should keep track of the filesystem *state* of the working copy, or alternatively the deltas/changes to some known state (such as .git/index)?

I think git process can keep track of filesystem state (and save it
down if necessary). But when git process is not running, system state
changes and it cannot know about. The daemon helps filling this gap
(and basically keeps git "running" (in a light form) throughout a
development session). For example if we know only 5 files have changed
since the last refresh, we only need to re-stat those 5. The same for
untracked/ignored file checking,

> I'm also still skeptical whether a daemon will improve overall performance. In my understanding its essentially a filesystem cache in user-mode. The difference to using the OS filesystem cache directly (via lstat/readdir) is that we replace ~50k sys-calls with a single IPC call (i.e. the git <--> fswatch daemon communication is less 'chatty'). However, the 'chattyness' is still there between the fswatch daemon and the OS / inotify.

I think it attempts to reduce unnecessary system calls, not eliminate
them all. In the "5 changed files" above, a few IPC calls are done to
retrieve the file list, then 5 lstat will be issued (by git, not the
daemon) instead of thousands of them.

>Consider 'git status; make; make clean; git status'...that's a *lot* of changes to process for nothing (potentially slowing down make).

Yeah. In my opinion, the daemon should realize that at some point
accumulated changes are too much that it's not worth collecting
anymore, and drop them all. Git will do it the normal/slow way. After
that the daemon picks up again. We only optimize for the case when
little changes are made in filesystem.

> Then there's the issue of stale data in the cache. Modifying porcelain commands that use 'git status --porcelain' to compile their changesets will want 100% exact data. I'm not saying its not doable, but adding another platform specific, caching daemon to the tool chain doesn't exactly simplify things...
>
> But perhaps I'm too pessimistic (or just stigmatized by inherently slow and out-of-date TGitCache/TSvnCache on Windows :-)

Thanks. I didn't know about TGitCache. Will dig it up. Maybe we can
learn something from it (or realize the daemon approach is futile
after all).
-- 
Duy
