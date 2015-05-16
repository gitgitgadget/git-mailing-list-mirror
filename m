From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Sat, 16 May 2015 16:22:41 -0700
Message-ID: <xmqqsiawds5a.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 01:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtlPt-0000yY-89
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 01:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbbEPXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 19:22:44 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34382 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbEPXWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 19:22:43 -0400
Received: by igblo3 with SMTP id lo3so62658492igb.1
        for <git@vger.kernel.org>; Sat, 16 May 2015 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Xxqdlt5KhSWcRFNM4vmuWtq4vUdh/TYGS0pPnRYnlOQ=;
        b=g2quaE8J8FY7NrUPmNEoo+Dfv7Sj708uGfQI49mBl2U7kLe6APlnJH/pJbaF3TN6Sx
         euOYDZHY8iFg51wbidd6L5S5D38aRFqOCAXRacZRwg8qH8BBMEbfM6fvEAlH0GVAcYKt
         cBVmgwmqImc/M0w9d1WH468w5ReXhOiOobDqZ2tmqulHbVjgTpicxgMnRHbHR2omXRoc
         6PA4pU7nZ5ttId2NufxLVRjEqvHCATQ+mg6o8xWS0djgFaJZSzeH2+R3fdkeJ/V9Yxk9
         YSEPjRHaZH3L3ZyR1AkhaCRo5mjGFp/op06hwOfAa+AGXeznKssD/TdGY3IHgU2s45Wo
         3oUQ==
X-Received: by 10.42.200.8 with SMTP id eu8mr28302405icb.65.1431818563041;
        Sat, 16 May 2015 16:22:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id l6sm2330085igx.10.2015.05.16.16.22.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 16:22:42 -0700 (PDT)
In-Reply-To: <1431806796-28902-1-git-send-email-gjthill@gmail.com> (Jim Hill's
	message of "Sat, 16 May 2015 13:06:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269203>

Jim Hill <gjthill@gmail.com> writes:

> `git add` of an empty file with a filter pops complaints from
> `copy_fd` about a bad file descriptor.
>
> This traces back to these lines in sha1_file.c:index_core:
>
> 	if (!size) {
> 		ret = index_mem(sha1, NULL, size, type, path, flags);
>
> The problem here is that content to be added to the index can be
> supplied from an fd, or from a memory buffer, or from a pathname. This
> call is supplying a NULL buffer pointer and a zero size.
>
> Downstream logic takes the complete absence of a buffer to mean the
> data is to be found elsewhere -- for instance, these, from convert.c:
>
> 	if (params->src) {
> 		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
> 	} else {
> 		write_err = copy_fd(params->fd, child_process.in);
> 	}
>
> ~If there's a buffer, write from that, otherwise the data must be coming
> from an open fd.~
>
> Perfectly reasonable logic in a routine that's going to write from
> either a buffer or an fd.
>
> So change `index_core` to supply an empty buffer when indexing an empty
> file.
>
> There's a patch out there that instead changes the logic quoted above to
> take a `-1` fd to mean "use the buffer", but it seems to me that the
> distinction between a missing buffer and an empty one carries intrinsic
> semantics, where the logic change is adapting the code to handle
> incorrect arguments.
>
> Signed-off-by: Jim Hill <gjthill@gmail.com>
> ---
> I promise to pay more attention to test quality in the future, thanks for the
> patience.

It's us who should thank you ;-).  Thanks for spending time to
polish essentially a one-liner this long.


>
>  sha1_file.c           |  2 +-
>  t/t0021-conversion.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index f860d67..61e2735 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3186,7 +3186,7 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
>  	int ret;
>  
>  	if (!size) {
> -		ret = index_mem(sha1, NULL, size, type, path, flags);
> +		ret = index_mem(sha1, "", size, type, path, flags);
>  	} else if (size <= SMALL_FILE_SIZE) {
>  		char *buf = xmalloc(size);
>  		if (size == read_in_full(fd, buf, size))
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index ca7d2a6..bf87e9b 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -216,4 +216,30 @@ test_expect_success EXPENSIVE 'filter large file' '
>  	! test -s err
>  '
>  
> +test_expect_success "filter: clean empty file" '
> +	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
> +	git config filter.in-repo-header.smudge "sed 1d" &&
> +
> +	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
> +	>empty-in-worktree &&
> +
> +	echo cleaned >expected &&
> +	git add empty-in-worktree &&
> +	git show :empty-in-worktree >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "filter: smudge empty file" '
> +	git config filter.empty-in-repo.clean true &&
> +	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
> +
> +	echo "empty-in-repo filter=empty-in-repo"  >>.gitattributes &&
> +	echo dead data walking >empty-in-repo &&
> +	git add empty-in-repo &&
> +
> +	echo smudged >expected &&
> +	git checkout-index --prefix=filtered- empty-in-repo &&
> +	test_cmp expected filtered-empty-in-repo
> +'
> +
>  test_done
