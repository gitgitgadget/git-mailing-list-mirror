Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B4C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355056AbiDZUoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355152AbiDZUoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:44:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE98CD92
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:40:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98AC61283D2;
        Tue, 26 Apr 2022 16:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WCnMz9sVFBz34354scouv+bzvqvgHcom92hRyti7bEE=; b=Jsyr
        0GDLTWazpnHxtOSkYWhQ92TTQcyly3WXIdC9KXe4lcvqkAvs1fOIIBMwCoVMLlSw
        348rTAUDGqkyrtk9CqZhDbEuWnHh7AHktUbJyqtwGYGAc58RuEkwlax5ixHg/z6r
        s57R6vXv0rc9vk1U8WFq7TGqOqOwFFv5GoFEI1I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DD711283D0;
        Tue, 26 Apr 2022 16:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E02361283CF;
        Tue, 26 Apr 2022 16:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bertin Philippe via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bertin Philippe <tumata.codes@gmail.com>
Subject: Re: [PATCH] git-p4: properly initialize the largefiles
References: <pull.1253.git.git.1650999569737.gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 13:40:53 -0700
Message-ID: <xmqqr15jpoh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B5A1F56-C5A1-11EC-B97D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bertin Philippe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: tumata <tumata.codes@gmail.com>
>
> This commit takes care of initializing the largeFiles
> with the already existing files referenced in the .gitattributes
> instead of initializing with an empty set by default.
>
> This makes it so that the 'git p4 sync' command works as
> expected with git-lfs.

Why is this change needed?  How well did the old code work, and how
does the code with this patch work, and what's the difference
between them?

To answer such questions better, we prefer certain flow of logic in
our proposed commit log message.  We start by talking about what the
current code does, e.g.

    The LargeFileSystem class initializes the .largeFile attribute
    to an empty set, ignoring the paths that are already known to be
    X.  This causes "git p4 sync" subcommand to do Y.

    But "git p4 sync" subcommand needs to do Z instead.  For that,
    populate the .largeFile attribute upfront by readind W from V.

I have little idea what problem this patch is trying to address, so
there are many placeholders in the above, but hopefully you get the
idea.

    ... the reviewer goes and looks ahead; sees a lot more plausible
    explanation below ...

> Signed-off-by: tumata <tumata.codes@gmail.com>

Name mismatch that should have said Bertin Philippe instead?

As Documentation/SubmittingPatches says, the Signed-off-by: line
wants the patch author's real name, and the From: line wants to show
the same name-address that is on the Signed-off-by: line.

> ---
>     git-p4: Properly initialize the largeFiles set so that it includes the
>     already existing large files
>     
>     git-p4 sync isn't taking into account existing files that are managed by
>     git-lfs. This is fine when doing git p4 clone but doing git p4 sync
>     needs to take into account the files that are already managed by
>     git-lfs.
>     
>     This change reads-in the .gitattributes and re-generate the data so that
>     sync can iteratively add files to the git-lfs. It takes care of
>     initializing the largeFiles with the already existing files referenced
>     in the .gitattributes instead of initializing with an empty set by
>     default.
>     
>     We had issues cloning the first commit, then syncing the remaining
>     commits of a really large Perforce repo (making hundreds of smaller sync
>     instead of one massive sync). The sync was deleting the git-lfs each
>     time. We were able to fix this issue by first reading the current
>     content of git-lfs instead of initializing to an empty set.

That sounds more like what we want to record in the commit, but
writing them after the three-dash line does not help anybody.

>  git-p4.py | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index a9b1f904410..576e923a1de 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1195,9 +1195,28 @@ class LargeFileSystem(object):
>      """Base class for large file system support."""
>  
>      def __init__(self, writeToGitStream):
> -        self.largeFiles = set()
> +        self.largeFiles = self.parseLargeFiles()
>          self.writeToGitStream = writeToGitStream

OK, we can see that it used to be an empty set, but now we are
computing something.

> +    def parseLargeFiles(self):
> +        """Parse large files in order to initially populate 'largeFiles'"""
> +        paths = set()
> +        try:
> +            cmd = ['git', 'show', 'p4/master:.gitattributes']

Curious.  How is 'p4/master' branch so special?  Is it always, no
matter what branch you are on, correct to read from that branch?
Shouldn't you be reading from the current branch instead?

> +            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
> +            if p.returncode:
> +                print("Failed to read .gitattributed - error code: " + p.returncode)

ted -> tes???

> +                raise
> +            out = p.stdout.readlines()
> +            for line in out:

So, we read the contents of .gitattributes file line-by-line, and ...

> +                if line.startswith('/'):
> +                    path = line[1:].split(' ', 1)[0]
> +                    path = path.replace('[[:space:]]', ' ')
> +                    paths.add(path)

... without checking what attribute each line is setting, we collect
the first token (the "pattern" to match paths, for which attributes
are given to) and add it to the "paths" set.  The code does not care
what attribute the line was trying to add, and it just collects the
patterns that appear on each line.

I am having a hard time to see how this could possibly be correct.

    * The first token on .gitattributes file could be '/*'
      (i.e. match everything at the top of this working tree); is
      the set in the .largeFiles attribute prepared to take such a
      pattern, instead of concrete paths?  Judging from the way the
      set is used (e.g. isLargeFile() is fed a path and checks the
      set membership, not pattern matching), I do not think so.

    * The first token may happen to be the name of a single file but
      it may be setting an attribute that has nothing to do with
      LFS (e.g. "/hello.txt    text").  What good does it do to add
      "hello.txt" to the set of largeFiles?

    * The first token may happen to be the name of an existing file
      that indeed is under LFS, but the path may not be in the
      current branch at all, even though it appears in the p4/master
      branch.  What good does it do to add such a non-existent path
      to the set of largeFiles?

> +        except:
> +            print("parseLargeFiles: .gitattributes does not appear to exist.")
> +        return paths
> +
>      def generatePointer(self, cloneDestination, contentFile):
>          """Return the content of a pointer file that is stored in Git instead of
>             the actual content."""

In any case, if this is a patch to fix existing breakage, it should
come with a new test that demonstrates how the corrected command
("git p4 sync"?) behaves.

Thanks.
