Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bu306drx"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C1D65
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 17:57:56 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B44501C3461;
	Wed, 22 Nov 2023 20:57:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x0RrTRPAk/Uu0soOONdNFhPF6FeESYyuN2hwYZ
	Pw1R8=; b=bu306drx6hgIqA63Re/j3lS9hGxeg4iWbIJ2xTbRhry5RG5Sf3JRl+
	k95Mi77B7qadud3imbpYUUNJCgCG6ZLCCtiAaGUmuyOTLz0lD2G/0mJCchKwcBBF
	F23v3LjIJoA2s9m/FPovow/9/1tzVno8ljPNYGqOsKLZLxE9xFeNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC4D21C3460;
	Wed, 22 Nov 2023 20:57:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 171C41C345F;
	Wed, 22 Nov 2023 20:57:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alisha Kim via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alisha Kim <pril@pril.cc>
Subject: Re: [PATCH] git-p4: fix fast import when empty commit is first
In-Reply-To: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com> (Alisha
	Kim via GitGitGadget's message of "Wed, 22 Nov 2023 07:56:03 +0000")
References: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 10:57:53 +0900
Message-ID: <xmqq1qchcjtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B730010E-89A3-11EE-8476-25B3960A682E-77302942!pb-smtp2.pobox.com

"Alisha Kim via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alisha Kim <pril@pril.cc>
>
> When executing p4 sync by specifying an excluded path, an empty commit
> will be created if there is only a change in the excluded path in
> revision.
> If git-p4.keepEmptyCommits is turned off and an empty commit is the
> first, fast-import will fail.

The above describe under what condition a failure gets triggered,
but there is no description on what approach the proposed solution
takes.  You could teach "fast-import" to deal with an empty commit
properly, you could ignore empty commits and not produce input for
the fast-import command, you could probably turn these initial empty
commits into non-empty commits by adding dummy contents, etc.  We
want to see in our proposed log messages what solution was taken and
how the solution was designed to satisfy what requirements.  This is
to help future developers who will have to change the code that is
given by this patch, so that their updates can still adhere to what
ever design criteria you had in working on this change [*].

    Side note: Your solution might be to ignore empty commits
    despite keepEmptyCommits option is set (as I said, you did not
    describe it at all in the above, so this is a hypothetical
    example).  If the reason behind choosing that design were "I
    just do not want it to fail---I do not care if the resulting
    history coming out of fast-import is crappy (I lose the p4 CL
    descriptions for these commits, even though the user wants to
    keep them)", then future developers can safely "fix" your fix
    here by turning the initial empty commits into non-empty ones by
    adding fake contents.

> @@ -3876,10 +3878,12 @@ class P4Sync(Command, P4UserMap):
>                              self.commit(description, filesForCommit, branch, parent)
>                  else:
>                      files = self.extractFilesFromCommit(description)
> -                    self.commit(description, files, self.branch,
> +                    isCommitted = self.commit(description, files, self.branch,
>                                  self.initialParent)
>                      # only needed once, to connect to the previous commit
> -                    self.initialParent = ""
> +                    if isCommitted:
> +                        self.initialParent = ""

"is" does not sound grammatically correct.  "didCommit" (i.e., "we
made a commit"), "haveCommitted" (i.e., "we have made a commit")
might be more understandable.

>              except IOError:
>                  print(self.gitError.read())
>                  sys.exit(1)
>
> base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
