From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 11:21:28 -0700
Message-ID: <xmqqlh4ebumv.fsf@gitster.mtv.corp.google.com>
References: <5710A2D3.8090003@otterhall.com>
	<CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
	<CAGZ79kZifiEY1rg6KNFRnkOemjJhY9fFpxHmK0gB8fLh1siAxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Albin =?utf-8?Q?Otterh=C3=A4ll?= <gmane@otterhall.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar8NK-00059g-Tc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 20:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbcDOSVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 14:21:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751746AbcDOSVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 14:21:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C471214745;
	Fri, 15 Apr 2016 14:21:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ef2+6s3RkuCIXEV2A+aE+nEvIxE=; b=HDnmGT
	+H5FtExH9nCMAzgK6uhklpT/BMIHRyFDgv1NvsQ03DwP1gxnXkgxl1U4n7EVv3W8
	vq7u8rAGEvoqmvJVxh4VX+QnZiXUVPC7hH/wkbMcRmq1DMBl8ER6f3fFmzLH873g
	mgRSTCyFOwk4bkqzb4r9/jvX+9mGbCi0m0x18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxQA1cRhZhlddPOHPhVBgNJnfIjdQx2h
	RSefGdvGcjNWyQ7MWDh/jIOYaHTNpJZ44RAb8mQssZDQEwvYxxJlDOO03KedoCGL
	3qJVpvqo0Oq2AfGNsQQrJ0mzHZBz2nLshfnyQtAuQ8tyfbiqXgG9tWCOSRHW5DRy
	Ap0aRNNieo0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB0E114744;
	Fri, 15 Apr 2016 14:21:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D4111473E;
	Fri, 15 Apr 2016 14:21:30 -0400 (EDT)
In-Reply-To: <CAGZ79kZifiEY1rg6KNFRnkOemjJhY9fFpxHmK0gB8fLh1siAxw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 15 Apr 2016 10:59:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFECDB7C-0336-11E6-8FBA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291631>

Stefan Beller <sbeller@google.com> writes:

> I think I can reproduce the problem. A regression test (which currently fails)
> could look like

Thanks.  I however do not think this is a regression.

Changes around 0656781f (mv: update the path entry in .gitmodules
for moved submodules, 2013-08-06) did introduce "git mv dir1 dir2"
when 'dir1' is a submodule, but I do not think it went beyond that.
I do not see any effort to treat a submodule that is discovered by
scanning a directory that was given from the command line,
i.e. prepare_move_submodule() is not called for them, and the
entries in the submodule_gitfile[] array that correspond to them are
explicitly set to NULL in the loop.


> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 4008fae..3b96a9a 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
>         echo content >file &&
>         git add file &&
>         git commit -m "added sub and file" &&
> +       mkdir -p deep/directory/hierachy &&
> +       git submodule add ./. deep/directory/hierachy/sub &&
> +       git commit -m "added another submodule" &&
>         git branch submodule
>  '
>
> @@ -475,4 +478,14 @@ test_expect_success 'mv -k does not accidentally
> destroy submodules' '
>         git checkout .
>  '
>
> +test_expect_failure 'moving a submodule in nested directories' '
> +       (
> +               cd deep &&
> +               git mv directory ../ &&
> +               git status
> +               # currently git status exits with 128
> +               # fatal: Not a git repository:
> directory/hierachy/sub/../../../../.git/modules/deep/directory/hierachy/sub
> +       )
> +'
> +
>  test_done
