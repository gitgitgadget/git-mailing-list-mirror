Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4018649
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tz5UQG6S"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A9E11D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 12:30:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B8391C177E;
	Wed, 18 Oct 2023 15:30:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B/YG1OzggwyTZE+k/fRbVxhvDSy61cPCmkHvEx
	NoWSg=; b=tz5UQG6SrveEnsgdxE+eH++zS9Joaavu9045DIxbwUoZA1lRa7IR4i
	qAuypsN89ktOqNesDtDohErEFA6EYPlCwRS+6eVsqFOwIFIo6Br+3PaCmE3Z19GX
	4sc6LHw1qxMNdyySVMLMQBBKz4wJmgkqFiBrgFpEkfa2KXMsqzUAU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4E2F1C177C;
	Wed, 18 Oct 2023 15:30:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 282B71C1778;
	Wed, 18 Oct 2023 15:30:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew McClain <mmcclain@noprivs.com>
Cc: git@vger.kernel.org, "brian m. carlson" <bk2204@github.com>
Subject: Re: [PATCH] git-p4 shouldn't attempt to store symlinks in LFS
In-Reply-To: <20231018185854.857674-1-mmcclain@noprivs.com> (Matthew McClain's
	message of "Wed, 18 Oct 2023 13:58:54 -0500")
References: <20231018185854.857674-1-mmcclain@noprivs.com>
Date: Wed, 18 Oct 2023 12:30:02 -0700
Message-ID: <xmqqil73sp8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCC59DB8-6DEC-11EE-96E3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Matthew McClain <mmcclain@noprivs.com> writes:

> If a symlink in your Perforce repository matches
> git-p4.largeFileExtensions, git-p4.py will attempt to put the symlink in
> LFS but will blow up when it passes a string to generateTempFile.
>
> Git LFS normal behavior does not stash symlinks in LFS.

I am not a "git p4" (or "git lfs") user, but if nobody uses LFS to
store symbolic links (which is very much understandable given what
it was invented for), then that alone is a good enough reason to
avoid the regular blob codepath, and that is true even if
generateTempFile accepted a str and silently converted it to bytes
to help callers, no?

So "but will blow up ..." and the stacktrace below are more or less
irrelevant details and do not help convince readers why this change
is desirable.  I'd suggest removing it (and perhaps place more stress
on explaining why storing symbolic links in LFS is a bad practice
nobody uses, but if it is so obvious perhaps the single sentence
explanation you have above would be sufficient).

I know I can ask brian to take a look at this change from LFS angle,
but who's authoritatively reviewing "git p4" related changes these
days (Matthew, this is not a question for you, but to the list)?

Thanks.

> Importing revision 42889 (100%)Traceback (most recent call last):
>   File "./git/git-p4.py", line 4621, in <module>
>     main()
>   File "./git/git-p4.py", line 4615, in main
>     if not cmd.run(args):
>   File "./git/git-p4.py", line 4225, in run
>     self.importRevisions(args, branch_arg_given)
>   File "./git/git-p4.py", line 4002, in importRevisions
>     self.importChanges(changes)
>   File "./git/git-p4.py", line 3876, in importChanges
>     self.initialParent)
>   File "./git/git-p4.py", line 3496, in commit
>     self.streamP4Files(files)
>   File "./git/git-p4.py", line 3336, in streamP4Files
>     cb=streamP4FilesCbSelf)
>   File "./git/git-p4.py", line 910, in p4CmdList
>     cb(entry)
>   File "./git/git-p4.py", line 3321, in streamP4FilesCbSelf
>     self.streamP4FilesCb(entry)
>   File "./git/git-p4.py", line 3266, in streamP4FilesCb
>     self.streamOneP4File(self.stream_file, self.stream_contents)
>   File "./git/git-p4.py", line 3217, in streamOneP4File
>     git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
>   File "./git/git-p4.py", line 1656, in processContent
>     return LargeFileSystem.processContent(self, git_mode, relPath, contents)
>   File "./git/git-p4.py", line 1526, in processContent
>     contentTempFile = self.generateTempFile(contents)
>   File "./git/git-p4.py", line 1488, in generateTempFile
>     contentFile.write(d)
>   File "/usr/lib64/python3.6/tempfile.py", line 485, in func_wrapper
>     return func(*args, **kwargs)
> TypeError: a bytes-like object is required, not 'str'
>
> Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
> ---
>  git-p4.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index d26a980e5a..f5fda2a3dc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1522,6 +1522,10 @@ def processContent(self, git_mode, relPath, contents):
>             file is stored in the large file system and handles all necessary
>             steps.
>             """
> +        # no need to store symlinks in LFS (generateTempFile wants bytes)
> +        if git_mode == "120000":
> +            return (git_mode, contents)
> +
>          if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
>              contentTempFile = self.generateTempFile(contents)
>              pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
