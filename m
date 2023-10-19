Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574A37148
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CeUuj0cZ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72761124
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:59:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E24CE1E9F9;
	Thu, 19 Oct 2023 13:59:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=erDdmfg0LdQmw2OiIvaCtl8BCb7r2Scwvlhi+9
	Wp8Ao=; b=CeUuj0cZ+oq6G/rE45CYD3Ta027f2L0YnFaOCxzWeYbDiN8Wi26EOx
	hnPjka8rh26NKzaJv48OMwLMFSJ9r5u2FPRsnlSn3uFzs2516oizeV16FlSYY1ul
	MQljQccuOQGgHar1rFgQxfigiXJs63w7HvLoSfO8M8v6utiiwxt54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA1BE1E9F8;
	Thu, 19 Oct 2023 13:59:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3BF4D1E9F7;
	Thu, 19 Oct 2023 13:59:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew McClain <mmcclain@noprivs.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] git-p4 shouldn't attempt to store symlinks in LFS
In-Reply-To: <20231019002558.867830-1-mmcclain@noprivs.com> (Matthew McClain's
	message of "Wed, 18 Oct 2023 19:25:58 -0500")
References: <ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net>
	<20231019002558.867830-1-mmcclain@noprivs.com>
Date: Thu, 19 Oct 2023 10:59:25 -0700
Message-ID: <xmqqzg0ewl1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E86EB92-6EA9-11EE-AD35-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Matthew McClain <mmcclain@noprivs.com> writes:

> git-p4.py would attempt to put a symlink in LFS if its file extension
> matched git-p4.largeFileExtensions.
>
> Git LFS doesn't store symlinks because smudge/clean filters don't handle
> symlinks. They never get passed to the filter process nor the
> smudge/clean filters, nor could that occur without a change to the
> protocol or command-line interface. Unless Git learned how to send them
> to the filters, Git LFS would have a hard time using them in any useful
> way.
>
> Git LFS's goal is to move large files out of the repository history, and
> symlinks are functionally limited to 4 KiB or a similar size on most
> systems.

Reads much better and easier to reason about.

Will queue and see if "git p4" stakeholders object for a few days;
if nothing happens, let's merge it down to 'next' and then to
'master' as usual.

Thanks.

> Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
> ---
>  git-p4.py | 4 ++++
>  1 file changed, 4 insertions(+)

>
> diff --git a/git-p4.py b/git-p4.py
> index d26a980e5a..0eb3bb4c47 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1522,6 +1522,10 @@ def processContent(self, git_mode, relPath, contents):
>             file is stored in the large file system and handles all necessary
>             steps.
>             """
> +        # symlinks aren't processed by smudge/clean filters
> +        if git_mode == "120000":
> +            return (git_mode, contents)
> +
>          if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
>              contentTempFile = self.generateTempFile(contents)
>              pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
