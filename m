From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 20:16:42 +0530
Message-ID: <CALkWK0==bnrRJDk1daANoZOOVLwZOPM+YhwOZs7yimoYBoyXyA@mail.gmail.com>
References: <cover.1365364193.git.john@keeping.me.uk> <cover.1365539059.git.john@keeping.me.uk>
 <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 16:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USq7T-0007Hi-Af
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967026Ab3DROrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 10:47:23 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:46439 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965506Ab3DROrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 10:47:22 -0400
Received: by mail-ia0-f174.google.com with SMTP id m10so579342iam.33
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wUvOwYJKNFUEMg1gICEuIIx+l422hwxS7Sr+UQfKWdQ=;
        b=QqBOmPgvHbJzVvkxSp3R/ugFq9DlTFIa7pDIAKBuxgDecZXZozmkBw7rvtYypRneLs
         leSYXgT+BLZosbvWszUi4r+2lv9mOpgnAWCJ/bZAjlNJtKiWyHsOkjQm1pgx9l0EIqoi
         eRTmB6/HJuRaT7eHSPtH10soC+Ns8hPUPGwHfByf8UuuW+hUD8rSimaz5Yvni0fve3gZ
         cL3NPAs4/gZDh9EmvfcMS+4NpdFWCZDsb2jgBnnnWEl244W0TLfBnPqRvgRjzZp2rglt
         Psvk9S842mR8jmRPFHVkjLu1Eu+Gx/P2vMplCVc/aQGmo+adpSghIE6FPxwM+kkuM/o/
         nouQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr7096637igb.12.1366296442118;
 Thu, 18 Apr 2013 07:47:22 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 07:46:42 -0700 (PDT)
In-Reply-To: <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221661>

John Keeping wrote:
> Use the new rev-parse --prefix option to process all paths given to the
> submodule command, dropping the requirement that it be run from the
> top-level of the repository.

Yay!

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..bbf7983 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -112,6 +115,7 @@ resolve_relative_url ()
>  #
>  module_list()
>  {
> +       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"

Nit: Why not use "--" to disambiguate between options and arguments,
like you showed in your intended usage?

So, this essentially converts all the paths specified in "$@" to
toplevel-relative paths.  Beautiful, as this is practically the only
change you require in each function.

> +       sm_path="$wt_prefix$sm_path"

Wait, isn't sm_path the value of submodule.<name>.path in .gitmodules?
 Why does it need to be prefixed?

> @@ -942,6 +948,7 @@ cmd_summary() {
>         fi
>
>         cd_to_toplevel
> +       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"

Um, what about other functions?  Yeah, it looks like all of them
except this one call module_list().

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index ff26535..7795f21 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -212,6 +212,23 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>         test_cmp empty untracked
>  '
>
> +test_expect_success 'submodule add in subdir' '
> +       echo "refs/heads/master" >expect &&
> +       >empty &&

Nit: Use : >empty.  It's clearer.

> +       (
> +               mkdir addtest/sub &&

Why is the mkdir inside the subshell?  The next statement (cd) onwards
should be in the subshell, to save you cd'ing back.

> +               cd addtest/sub &&
> +               git submodule add "$submodurl" ../realsubmod3 &&
> +               git submodule init
> +       ) &&
> +
> +       rm -f heads head untracked &&

Huh?  What is this in the middle?  The next statement (call to
inspect) write-truncates them anyway, so this is unnecessary.
