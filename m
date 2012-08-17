From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 00/12] git p4: submit conflict handling
Date: Fri, 17 Aug 2012 07:04:37 +0100
Message-ID: <502DDEF5.4090405@diamand.org>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:05:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Fgp-00029w-O8
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab2HQGFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:05:42 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47580 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab2HQGFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 02:05:40 -0400
Received: by wgbdr13 with SMTP id dr13so3045580wgb.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 23:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=4DbGckQ5fFYgOCsInLk1P02iPbkz9YpstmLMlFFyGdQ=;
        b=Q26FNLaSCZXPnBs9mwCueBlxXr0LSZF9c2AzQk+JlP7ecEGnPp+SZVL5m3N2OvIXXQ
         On4c82gbZimZ2MVp5EvQIYM5YwlmHdZNJw0ciEY6S4e9wXh7gICh44CRiT9AcoBpjvO7
         jU7W6efSFDmUlC/ijHa6yveN1gxTsWLAMzhXBD7WNgUp+Zvr5iQALU3T994ZBAmhCIvu
         y75EfRx1GFAJPptou4zyNuu0g4OJLBBdYS19taBWsnRGOXyr+jma2eFL5uL5Ze5UVPSx
         6nEx03s0aHpSj0YYnAPoYn6wPRaonv8d6/0dtEo4WD2s4qo9v+M/g6zH8ysDOAYu/wTO
         U3YQ==
Received: by 10.180.99.133 with SMTP id eq5mr2230169wib.0.1345183538535;
        Thu, 16 Aug 2012 23:05:38 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id fu8sm7865089wib.5.2012.08.16.23.05.37
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 23:05:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQmvEVcQleqELX9wCjC6bfHDLGgkq67dou01/2TAre17Yrfus6vSggi3it/D6S5jJMdCQfU7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/12 00:35, Pete Wyckoff wrote:
> These patches rework how git p4 deals with conflicts that
> arise during a "git p4 submit".  These may arise due to
> changes that happened in p4 since the last "git p4 sync".
>
> Luke: I especially wanted to get this out as you suggested
> that you had a different way of dealing with skipped commits.
>
> The part that needs the most attention is the interaction
> loop that happens when a commit failed.  Currently, three
> options are offered:
>
>      [s]kip this commit, but continue to apply others
>      [a]pply the commit forcefully, generating .rej files
>      [w]rite the commit to a patch.txt file
>      and the implicit<ctrl-c>  to stop
>
> After this series, it offers two:
>
>      [c]ontinue to apply others
>      [q]uit to stop
>
> This feels more natural to me, and I like the term "continue" rather
> than "skip" as it matches what rebase uses.  I'd like to know what
> others think of the new flow.

The skip is still needed. In my workflow, git-p4 gets run periodically 
and does the usual sync+rebase on behalf of all the people who have 
pushed to the git repo.

If someone pushes a change which conflicts with something from Perforce 
land, then what I want to happen is for the script to discard the 
offending commit (git rebase --skip) and then carry on with the others.

In 99% of cases this does exactly what I need, as conflicting commits 
are usually caused by people committing the same fix to both p4 and git 
at around the same time (someone breaks top-of-tree with an obvious 
error, two separate people check in slightly different fixes). 
Discarding the git commit then means that everything carries on working.

I've got a small patch which makes skipping work non-interactively; the 
thing it's missing is reporting the commits which are skipped.

>
> Other observable changes are new command-line options:
>
> Alias -v for --verbose, similar to other git commands.
>
> The --dry-run option addresses Luke's concern in
>
>      http://thread.gmane.org/gmane.comp.version-control.git/201004/focus=201022
>
> when I removed an unused "self.interactive" variable
> that did a similar thing if you edited the code.  It prints
> commits that would be applied to p4.
>
> Option --prepare-p4-only is similar to --dry-run, in that
> it does not submit anything to p4, but it does prepare the
> p4 workspace, then prints long instructions about how to submit
> everything properly.  It also serves, perhaps, as a replacement for
> the [a]pply option in the submit-conflict loop.
>
> Pete Wyckoff (12):
>    git p4 test: remove bash-ism of combined export/assignment
>    git p4 test: use p4d -L option to suppress log messages
>    git p4: gracefully fail if some commits could not be applied
>    git p4: remove submit failure options [a]pply and [w]rite
>    git p4: move conflict prompt into run, use [c]ontinue and [q]uit
>    git p4: standardize submit cancel due to unchanged template
>    git p4: test clean-up after failed submit, fix added files
>    git p4: rearrange submit template construction
>    git p4: revert deleted files after submit cancel
>    git p4: accept -v for --verbose
>    git p4: add submit --dry-run option
>    git p4: add submit --prepare-p4-only option
>
>   Documentation/git-p4.txt           |  13 +-
>   git-p4.py                          | 213 +++++++++++++++------
>   t/lib-git-p4.sh                    |  10 +-
>   t/t9805-git-p4-skip-submit-edit.sh |   2 +-
>   t/t9807-git-p4-submit.sh           |  65 +++++++
>   t/t9810-git-p4-rcs.sh              |  50 +----
>   t/t9815-git-p4-submit-fail.sh      | 367 +++++++++++++++++++++++++++++++++++++
>   7 files changed, 612 insertions(+), 108 deletions(-)
>   create mode 100755 t/t9815-git-p4-submit-fail.sh
>
