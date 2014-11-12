From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: Improving startup time and interactivity
Date: Wed, 12 Nov 2014 09:35:38 -0500
Message-ID: <CAFuPQ1Lm95ztfa3wOZ4LQD05XdV-30UKr4Y9+HoHYbQyw9qj-g@mail.gmail.com>
References: <20141111085014.GA26147@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 15:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoZ1h-0002Za-39
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 15:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbaKLOgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 09:36:00 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35595 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbaKLOf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 09:35:59 -0500
Received: by mail-ie0-f175.google.com with SMTP id y20so13692395ier.20
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=UBtOslmzcnT7Mf1r6uHo8ER/JtCaEQI37Ah8SseIETs=;
        b=dIx9Z2/B34A69EQ9rrOz7lDr7u6D1mQACjCWBm59KeW36320mSvRUOzVBUdyJvSRDZ
         CRNtUSMpi1cbEL10WWDxjdH+I/wmdx/8nVYTf0vaZx53ssLdJNSRk5OWpSJc3Qh4TkOt
         s1Rd1Fmw9Lqsl9RfxUKI8mAz54d+4QI4iVjCv+14jO23PR/f6gIJQGDWAS+hUsdNC2B8
         RA7Jtg9A6L8aZ3eWxdQOdOPr8SsQif3nk/Y4hgexgwTq1KLmXHUG/GWzhDXSjf0HxsPX
         6AoZuVcEgFYJ5VK83Wp8KQtR3EhZ/Pt1lFy4+ccdVSLhzGXlhRHJiXiSZKH7T654hcp/
         Hqhw==
X-Received: by 10.42.179.195 with SMTP id br3mr3332080icb.37.1415802958986;
 Wed, 12 Nov 2014 06:35:58 -0800 (PST)
Received: by 10.107.8.6 with HTTP; Wed, 12 Nov 2014 06:35:38 -0800 (PST)
In-Reply-To: <20141111085014.GA26147@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 3:50 AM, Dominik Vogt <vogt@linux.vnet.ibm.com> wrote:
> Hi Jonas,

HI Dominik,

Good to hear from you.

> working on a relatively old machine with a crypted disk, there are
> really two performance problems with tig on large repos like gcc
> or the Linux kernel.  I wonder what would be necessary to improve
> these two problems:
>
>  1) Firing up tig for the first time in the kernel repo, the screen
>     goes blank for about a minute.  After that it comes up
>     quickly.  This is probably caused by decrypting lots of
>     on-disk-objects.

You are not alone at reporting this problem. The main reason is that
when the revision graph is enabled, tig automatically passes
--topo-order to git-log. This commit order seems to cause quite a slow
down before the first commits are available in the output in the Linux
kernel repo, I assume, due to its many merges.

I recently added an option to disable the automatic forcing of
topological commit order. So assuming you are using tig from current
master, you can do this using `set main-view-commit-title-graph =
no-topo`, but I will probably move this setting to another option
before the next release (so if it breaks take a look at the NEWS
file). Alternatively you can disable the revision graph completely
using `set main-view-commit-title-graph = no`.

Before the next commit I plan to also investigate whether tig can
first load a screen full of commits without --topo-order and then
restart git-log, so the main view has content faster.

>  2) When I cherry pick commits inside tig, it reloads the whole
>     commit history of the active branch before tig accepts new
>     commands.

This should should be able to disable this behaviour using `set
refresh-mode = manual` if you don't want tig to automatically reload
the view.

> I guess both issues are caused by tig reading the whole commit
> history before user input is allowed.  Is there a way to do that
> in the background, or interrupt loading when the user presses a
> key, or to load the history in small chunks?

The loading should already happen while also accepting user input
(modulo any bugs).

> After all, you're
> usually interested only in the last 100 commits or so, and there's
> no need to block the UI while loading the rest.

True. Well,  The only part of the loading that is blocking is the
.git/index refreshing that takes place when display of work tree
changes is enabled in the main view (when `set show-changes = yes`).

I will review this again.

> Could you point me to the right source file?  I'm not used to the
> sources split into multiple files yet.  :-)

Try: tig grep main_open

> Ciao

Have a great day.

-- 
Jonas Fonseca
