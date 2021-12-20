Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C0C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhLTTcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:32:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62688 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbhLTTcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:32:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DE7BFB7C1;
        Mon, 20 Dec 2021 14:32:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gWBYcBMc9pjSVKfAg8vIfSftm4w4T33nZCmZX/
        xXbEk=; b=nTVFQO1zgeoOh2AfGuihdCmuZx8nWI4+EqE6IdgsimjkBSRgofk2ef
        YydLtyK+DCxe07l6z/3h1yQDrMC52ZH3qhDCKbsgO4bTVHmlP+qHF0rqI/pOVwK1
        QMaGGpJHmuYCupzGJYdqpd7B+RhasC7YXuYFzDnHqfciJyfMtWz7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFF36FB7C0;
        Mon, 20 Dec 2021 14:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E1E4FB7BF;
        Mon, 20 Dec 2021 14:32:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 2/2] git-p4: remove "rollback" verb
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
        <20211217140547.2115095-3-jholdsworth@nvidia.com>
Date:   Mon, 20 Dec 2021 11:32:04 -0800
In-Reply-To: <20211217140547.2115095-3-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Fri, 17 Dec 2021 14:05:47 +0000")
Message-ID: <xmqqlf0fvzrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 839D7544-61CB-11EC-BB9D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> The git-p4 "rollback" verb is described as "A tool to debug the
> multi-branch import. Don't use :)".

;-).

> The implementation provided is of no
> useful benefit to either users or developers.

It is hard to make such a broad "no useful benefit" claim without
giving a bit more analysis [*].  With only that single sentence, it
is far worse justification than saying that "The author tells us not
to use it, and it is not even documented" to convince others why
removal is a good idea.

I'd suggest dropping that sentence (replace it with something we can
objectively verify, like "it is not even documented", if you want to).

Thanks.

[Footnote]

 * what the code tried to do, how it didn't do it well that it was
   clear that it couldn't possibly be useful, etc. etc.


> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> Adds Signed-off-by tag
>
>  git-p4.py | 60 -------------------------------------------------------
>  1 file changed, 60 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index b7ed8e41ff..a7cb321f75 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1532,65 +1532,6 @@ def loadUserMapFromCache(self):
>          except IOError:
>              self.getUserMapFromPerforceServer()
>  
> -class P4RollBack(Command):
> -    def __init__(self):
> -        Command.__init__(self)
> -        self.options = [
> -            optparse.make_option("--local", dest="rollbackLocalBranches", action="store_true")
> -        ]
> -        self.description = "A tool to debug the multi-branch import. Don't use :)"
> -        self.rollbackLocalBranches = False
> -
> -    def run(self, args):
> -        if len(args) != 1:
> -            return False
> -        maxChange = int(args[0])
> -
> -        if "p4ExitCode" in p4Cmd("changes -m 1"):
> -            die("Problems executing p4");
> -
> -        if self.rollbackLocalBranches:
> -            refPrefix = "refs/heads/"
> -            lines = read_pipe_lines("git rev-parse --symbolic --branches")
> -        else:
> -            refPrefix = "refs/remotes/"
> -            lines = read_pipe_lines("git rev-parse --symbolic --remotes")
> -
> -        for line in lines:
> -            if self.rollbackLocalBranches or (line.startswith("p4/") and line != "p4/HEAD\n"):
> -                line = line.strip()
> -                ref = refPrefix + line
> -                log = extractLogMessageFromGitCommit(ref)
> -                settings = extractSettingsGitLog(log)
> -
> -                depotPaths = settings['depot-paths']
> -                change = settings['change']
> -
> -                changed = False
> -
> -                if len(p4Cmd("changes -m 1 "  + ' '.join (['%s...@%s' % (p, maxChange)
> -                                                           for p in depotPaths]))) == 0:
> -                    print("Branch %s did not exist at change %s, deleting." % (ref, maxChange))
> -                    system("git update-ref -d %s `git rev-parse %s`" % (ref, ref))
> -                    continue
> -
> -                while change and int(change) > maxChange:
> -                    changed = True
> -                    if self.verbose:
> -                        print("%s is at %s ; rewinding towards %s" % (ref, change, maxChange))
> -                    system("git update-ref %s \"%s^\"" % (ref, ref))
> -                    log = extractLogMessageFromGitCommit(ref)
> -                    settings =  extractSettingsGitLog(log)
> -
> -
> -                    depotPaths = settings['depot-paths']
> -                    change = settings['change']
> -
> -                if changed:
> -                    print("%s rewound to %s" % (ref, change))
> -
> -        return True
> -
>  class P4Submit(Command, P4UserMap):
>  
>      conflict_behavior_choices = ("ask", "skip", "quit")
> @@ -4353,7 +4294,6 @@ def printUsage(commands):
>      "sync" : P4Sync,
>      "rebase" : P4Rebase,
>      "clone" : P4Clone,
> -    "rollback" : P4RollBack,
>      "branches" : P4Branches,
>      "unshelve" : P4Unshelve,
>  }
