From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] sha1_file: pass empty buffer to index empty file
Date: Sat, 16 May 2015 11:48:14 -0700
Message-ID: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
References: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
	<1431645434-11790-1-git-send-email-gjthill@gmail.com>
	<xmqqlhgphg8x.fsf@gitster.dls.corp.google.com>
	<20150515233153.GA4157@gadabout.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 20:48:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yth8H-0003cm-NR
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 20:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbbEPSsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 14:48:17 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33061 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbEPSsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 14:48:16 -0400
Received: by igbpi8 with SMTP id pi8so60416476igb.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i6d10NqmbdvXdVkPkkn52kE+nq/mzP1+U4zaS+N7jdw=;
        b=SFe2KOILnhefLUty6xukMbg9DhcL9FHEJB9rPlW9R4MSpfyW6T/0MHgjonqe5PMZdU
         Gz8t4+mYE8ub5E6a46ExT9qkE2JH1kbdRZjC84uDCJhaTag//mVQ+TVQRyVcc3WD+h80
         8ZWq1GuOPfsDDy0cK6EJX7cvXdRccHlqXeGLopIIakO61m3VKJMRmAX85XKx4l31jqBc
         RDE3GhlXzhW6iXc3j6hIureqYKhEG1djJywYXsOtHjCDiVyQLgOYrTHsHYO8l+HTAtiY
         u7FpjFmwGEr7fk8SQud/Z2dnRAzT4ndZqICqNg5GGclyaOVBxM8t+jChTyjkj+kWSKng
         7uzw==
X-Received: by 10.107.3.234 with SMTP id e103mr5011620ioi.74.1431802095937;
        Sat, 16 May 2015 11:48:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c15a:d232:e950:b701])
        by mx.google.com with ESMTPSA id c10sm540088ioe.25.2015.05.16.11.48.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 11:48:15 -0700 (PDT)
In-Reply-To: <20150515233153.GA4157@gadabout.domain.actdsltmp> (Jim Hill's
	message of "Fri, 15 May 2015 16:31:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269198>

Jim Hill <gjthill@gmail.com> writes:

> So, so long as we're testing empty-file filters, I figured I'd add real
> empty-file filter tests, I think that covers it.
>
> So is this better instead?

I wouldn't use "---in-repo-header--" as that extra string.  Feeding
anything that begins with '-' to 'echo' gives me portability worries
for one thing.  A single word "Extra" would suffice.

Be careful and consistent wrt redirection operator and its file; we
do not write SP there but some of yours do and some others don't.

Do not attempt to align && with excess SPs; other tests don't.

Other than that, yeah, I think that is an improvement.

Thanks.

>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 5986bb0..fc2c644 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -216,15 +216,33 @@ test_expect_success EXPENSIVE 'filter large file' '
>  	! test -s err
>  '
>  
> -test_expect_success "filtering empty file should not produce complaints" '
> -	echo "emptyfile filter=cat" >>.gitattributes &&
> -	git config filter.cat.clean cat &&
> -	git config filter.cat.smudge cat &&
> -	git add . &&
> -	git commit -m "cat filter for emptyfile" &&
> -	> emptyfile &&
> -	git add emptyfile 2>err &&
> -	! grep -Fiqs "bad file descriptor" err
> +test_expect_success "filter: clean empty file" '
> +	header=---in-repo-header--- &&
> +	git config filter.in-repo-header.clean  "echo $header && cat" &&
> +	git config filter.in-repo-header.smudge "sed 1d" &&
> +
> +	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
> +	> empty-in-worktree &&
> +
> +	echo $header              > expected &&
> +	git add empty-in-worktree            &&
> +	git show :empty-in-worktree > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "filter: smudge empty file" '
> +	git config filter.empty-in-repo.smudge "echo smudge added line && cat" &&
> +	git config filter.empty-in-repo.clean   true &&
> +
> +	echo "empty-in-repo      filter=empty-in-repo"  >>.gitattributes &&
> +
> +	echo dead data walking > empty-in-repo &&
> +	git add empty-in-repo &&
> +
> +	:			> expected &&
> +	git show :empty-in-repo	> actual &&
> +	test_cmp expected actual
>  '
>  
>  test_done
> +
