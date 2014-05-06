From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive.c: Fix case-changing merge bug
Date: Tue, 06 May 2014 10:07:18 -0700
Message-ID: <xmqqwqdyg7jt.fsf@gitster.dls.corp.google.com>
References: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
	<1398990069.19099.5.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:10:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whiq8-0004Hi-9V
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 19:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbaEFRH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 13:07:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57340 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbaEFRH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 13:07:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7502A141E9;
	Tue,  6 May 2014 13:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oHtt+9L24A1ajEfKio1py3bt1+M=; b=kBXpIV
	fzQ+B7XdGAwom9r+xEL2624sXlhR2QllqIOcp2noMKFv7Noqr/bBpbga+3Ave6tN
	NCQGUWQAWwJP8HqB7yt5LvsYG2s0xOhLSmWB6RUpjDhgsJpkeEcbi8FVYBrKz6ot
	UdUj8FDT2Q/Qhp5dTWQs6MU3U5uhIt0rIBVi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBcDS7kewBbbP8LvG5GTou03hQtE5j5n
	+C+Me67exvYr+X/pFHK4PdHL8R7fAP5Zs9SoAaZoJD3xHaoQMfN+kDCxxVmXS19m
	fYO1HEAQz9D+Z4JNX0TLlvClabzihLtoZ/9xVrFCLEi8np8gxQA2AvLr5COCIcsl
	O2/aVnqEmt0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3955D141E8;
	Tue,  6 May 2014 13:07:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81E49141E6;
	Tue,  6 May 2014 13:07:21 -0400 (EDT)
In-Reply-To: <1398990069.19099.5.camel@stross> (David Turner's message of
	"Thu, 01 May 2014 20:21:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E312EB32-D540-11E3-A5A2-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248202>

David Turner <dturner@twopensource.com> writes:

> On a case-insensitive filesystem, when merging, a file would be
> wrongly deleted from the working tree if an incoming commit had
> renamed it changing only its case.  When merging a rename, the file
> with the old name would be deleted -- but since the filesystem
> considers the old name to be the same as the new name, the new
> file would in fact be deleted.
>
> We avoid this by not deleting files that have a case-clone in the
> index at stage 0.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  merge-recursive.c           |  6 ++++++
>  t/t7063-merge-ignorecase.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100755 t/t7063-merge-ignorecase.sh
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4177092..cab16fa 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -589,6 +589,12 @@ static int remove_file(struct merge_options *o, int clean,
>  			return -1;
>  	}
>  	if (update_working_directory) {
> +		if (ignore_case) {
> +			struct cache_entry *ce;
> +			ce = cache_file_exists(path, strlen(path), ignore_case);
> +			if (ce && ce_stage(ce) == 0)
> +				return 0;
> +		}
>  		if (remove_path(path))
>  			return -1;
>  	}

Thanks.

I wonder what happens if you did the same merge using the resolve
strategy, though.  If you see a similar issue, and the true reason
of the breakage turns out to be because three-way merge performed by
unpack_trees() (with opts.update set to 1) considers that these
paths that only differ in case in "our" tree, in the index and in
the working tree are different paths (I am not saying that is the
case, but that was one of my first hunches after seeing the initial
report) then it may suggest that the above might not be the best
change to fix the issue.

> diff --git a/t/t7063-merge-ignorecase.sh b/t/t7063-merge-ignorecase.sh
> new file mode 100755
> index 0000000..6d4959f
> --- /dev/null
> +++ b/t/t7063-merge-ignorecase.sh

Hmmm, did you really have to add a file dedicated for this single
test?

> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='git-merge with case-changing rename on case-insensitive file system'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq CASE_INSENSITIVE_FS
> +then
> +	skip_all='skipping case insensitive tests - case sensitive file system'
> +	test_done
> +fi
> +
> +test_expect_success 'merge with case-changing rename with ignorecase=true' '
> +	test $(git config core.ignorecase) = true &&
> +	touch TestCase &&
> +	git add TestCase &&
> +	git commit -m "add TestCase" &&
> +	git checkout -b with-camel &&
> +	touch foo &&
> +	git add foo &&
> +	git commit -m "intervening commit" &&
> +	git checkout master &&
> +	git rm TestCase &&
> +	touch testcase &&
> +	git add testcase &&
> +	git commit -m "rename to testcase" &&
> +	git checkout with-camel &&
> +	git merge master -m "merge" &&
> +	test -e testcase
> +'
> +
> +test_done
