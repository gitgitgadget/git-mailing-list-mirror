From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 08 May 2014 12:54:55 -0700
Message-ID: <xmqqha502ghc.fsf@gitster.dls.corp.google.com>
References: <536B4680.1010806@web.de>
	<1399569814-20644-1-git-send-email-dturner@twopensource.com>
	<1399569814-20644-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Thu May 08 21:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiUPL-00055Y-4r
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 21:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbaEHTzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 15:55:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57161 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbaEHTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 15:54:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BF5315101;
	Thu,  8 May 2014 15:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VErDdIuXJ6QcTB2RW45vNQI8mYs=; b=wQq5Jh
	sOP1UWguew7QWufxHbXa4c/HYqkp8/UESDWNYfDKrOD2TVdVIAkes62FCvwp4keI
	YgRfq/+7CI6f+1rxyMdgRQ77lbw5sTYrBwoRmCdLTB1kakxWwa8sKs2OmarIlYYl
	o9V8+K21yHzn8KVoUsVEdjW2zu1JlrPVaM/9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBwZ+uxAHyu28J64qeFpnpC37JwAzhZC
	c9+JLut09XIsP+7fKSjDPDixNDCy/6wsQtXUYtqhuxf6MHgqATTP0Hjg86Wv9N3v
	PmZ8jMgIkDrQ3Qh3icsSUW/cddd7sHeB/HcK87iG1tYkSE/ZTWEZtfmLjRXCcySI
	r+5wHx/I/Rc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D79515100;
	Thu,  8 May 2014 15:54:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96766150FF;
	Thu,  8 May 2014 15:54:56 -0400 (EDT)
In-Reply-To: <1399569814-20644-3-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Thu, 8 May 2014 10:23:34
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A13172B4-D6EA-11E3-9D60-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248436>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Make it possible to change the case of a filename on a
> case-insensitive filesystem using git mv.  Change git mv to allow
> moves where the destination file exists if the destination file has
> the same name as the source file ignoring case.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/mv.c                | 3 ++-
>  t/t6039-merge-ignorecase.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 45e57f3..f4d89d0 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -202,7 +202,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			}
>  		} else if (cache_name_pos(src, length) < 0)
>  			bad = _("not under version control");
> -		else if (lstat(dst, &st) == 0) {
> +		else if (lstat(dst, &st) == 0 &&
> +			 (!ignore_case || strcasecmp(src, dst))) {

Hmm, I would find it easier to read if it were:

		... if (lstat(dst, &st) == 0 &&
                	!(ignore_case && !strcasecmp(src, dst))) {

That is, "it is an error for dst to exist, unless we are on a case
insensitive filesystem and src and dst refer to the same file.", but
maybe it is just me.

More importantly, what is the end-user visible effect of this
change?  Is it fair to summarize it like this?

    On a case-insensitive filesystem, "mv hello.txt Hello.txt"
    always trigger the "dst already exists" error, because both
    names refer to the same file to MS-DOS, requiring the user to
    pass the "--force" option.  Allow it without "--force".

Overwriting an existing file with "mv hello.txt Hello.txt" on a case
sensitive filesystem *is* an unusual operation, and that is the
reason why we require "--force" to make sure that the user means it.
I have a slight suspicion that the same "mv hello.txt Hello.txt" on
a case insensitive filesystem, where two names are known (to the end
user of such a filesystem) to refer to the same path would equally
be a very unusual thing to do, and such an operation may deserve a
similar safety precaution to make sure that the user really meant to
do so by requiring "--force".

So, I dunno.

>  			bad = _("destination exists");
>  			if (force) {
>  				/*
> diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
> index dfc9f17..a977653 100755
> --- a/t/t6039-merge-ignorecase.sh
> +++ b/t/t6039-merge-ignorecase.sh
> @@ -35,7 +35,7 @@ test_expect_success 'merge with case-changing rename on both sides' '
>  	git reset --hard baseline &&
>  	git branch -D with-camel &&
>  	git checkout -b with-camel &&
> -	git mv --force TestCase testcase &&
> +	git mv TestCase testcase &&
>  	git commit -m "recase on branch" &&
>  	>foo &&
>  	git add foo &&
