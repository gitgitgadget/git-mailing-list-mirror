Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAF56B7D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="guRNk/yz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 411841D3201;
	Thu, 11 Jan 2024 16:20:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gohymvSdstwk9fOhipnIDmjhnlhvqVGum82rbe
	gQb5A=; b=guRNk/yzLJ6AG6yzEVNuQCth7f12lBPWwykSTpAOSPEs9Glm0qPEeh
	T+5ML3a767Cr0sfCrtEHwJfmAFuVUcevg5jiU9bLQ8ozW7vGDlXfxfuttvdRFG9/
	q5Ofi9nqY68ALD7todR+GSJ/qybyQZh+bHDuiDGYvrbdKWr68S7D0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 388B61D31FF;
	Thu, 11 Jan 2024 16:20:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87B801D31FE;
	Thu, 11 Jan 2024 16:20:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-p4: stop reaching into the refdb
In-Reply-To: <33d6a062ec56be33ed50a42a420be0b023f6f4cf.1704980814.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 11 Jan 2024 14:47:27 +0100")
References: <33d6a062ec56be33ed50a42a420be0b023f6f4cf.1704980814.git.ps@pks.im>
Date: Thu, 11 Jan 2024 13:20:11 -0800
Message-ID: <xmqqa5pbftys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 34CA778A-B0C7-11EE-8F61-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The git-p4 tool creates a bunch of temporary branches that share a
> common prefix "refs/git-p4-tmp/". These branches get cleaned up via
> git-update-ref(1) after the import has finished. Once done, we try to
> manually remove the now supposedly-empty ".git/refs/git-p4-tmp/"
> directory.
>
> This last step can fail in case there still are any temporary branches
> around that we failed to delete because `os.rmdir()` refuses to delete a
> non-empty directory. It can thus be seen as kind of a sanity check to
> verify that we really did delete all temporary branches.

Wow, thanks for being very careful.  I would just have said "there
is no need for such rmdir---what's a single empty unused directory
between friends, which will be reused later when you run 'git p4'
again?" without thinking things through.

> This is a modification in behaviour for the "files" backend because the
> empty directory does not get deleted anymore. But arguably we should not
> care about such implementation details of the ref backend anyway, and
> this should not cause any user-visible change in behaviour.

Independently, it would be sensible to improve the files backend so
that it removes a subdirectory outside the hierarchies that are
created by refs/files-backend.c:files_init_db() when it becomes
empty (#leftoverbits).

And such a change would also have triggered the error from
os.rmdir(), so this patch is doubly welcomed.

Thanks.




> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-p4.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 0eb3bb4c47..3ea1c405e5 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4251,7 +4251,8 @@ def run(self, args):
>          if self.tempBranches != []:
>              for branch in self.tempBranches:
>                  read_pipe(["git", "update-ref", "-d", branch])
> -            os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
> +            if len(read_pipe(["git", "for-each-ref", self.tempBranchLocation])) > 0:
> +                   die("There are unexpected temporary branches")
>  
>          # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
>          # a convenient shortcut refname "p4".
