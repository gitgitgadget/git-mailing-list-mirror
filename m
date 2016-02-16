From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 08:20:43 -0000
Organization: OPDS
Message-ID: <C8BDC3289C184F40BFBE3B150CFBB50B@PhilipOakley>
References: <72756249.nAoBccgOj7@thunderbird> <1455590305-30923-1-git-send-email-ischis2@cox.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Ovidiu Gheorghioiu" <ovidiug@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: "Stephen P. Smith" <ischis2@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 09:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVasj-0005GY-GK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 09:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbcBPIVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 03:21:09 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:34569 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752458AbcBPIVH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 03:21:07 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AkGgCr28JWPDUjFlxeGQEBAgsBAgEBAQEBgwpSbYZibrBBbIMcGYVqAQECBAKBN00BAQEBAQEHAQEBAUEkG0EBBA0Bg2gFAQEBAQIBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgBDK9iiQyGEYQ1h12BDwWNYIkfAYFAhBKJYo0XhXCIUIJkGYFIPC6BFINNg3sBAQE
X-IPAS-Result: A2AkGgCr28JWPDUjFlxeGQEBAgsBAgEBAQEBgwpSbYZibrBBbIMcGYVqAQECBAKBN00BAQEBAQEHAQEBAUEkG0EBBA0Bg2gFAQEBAQIBCAEBHREeAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgBDK9iiQyGEYQ1h12BDwWNYIkfAYFAhBKJYo0XhXCIUIJkGYFIPC6BFINNg3sBAQE
X-IronPort-AV: E=Sophos;i="5.22,454,1449532800"; 
   d="scan'208";a="869854143"
Received: from host-92-22-35-53.as13285.net (HELO PhilipOakley) ([92.22.35.53])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Feb 2016 08:20:44 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286327>

From: "Stephen P. Smith" <ischis2@cox.net>
> The 'commit --dry-run' and commit return values differed if a

Should this have quotes around the second 'commit' as they both refer to the 
command, rather than the action?

> conflicted merge had been resolved and the commit would be the same as
> the parent.
>
> Update show_merge_in_progress to set the commitable bit if conflicts
> have been resolved and a merge is in progress.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>
> Notes:
>    In the original report when the dry run switch was passed and after
>    the merge commit was resolved head and index matched leading to a
>    returned value of 1. [1]
>
>    If the dry run switch was not passed, the commit would succeed to
>    correctly record the resolution.
>
>    The result was that a dry run would report that there would be a
>    failure, but there really isn't a failure if the commit is actually
>    attemped.
>
>    [1] $gmane/276591
>
>    It appeared that the conditional for 'Reject an attempt to record a
>    non-merge empty commit without * explicit --allow-empty.' could be
>    simplified after adding this patch.
>
>    This change can't be propagated to the conditional because it allows
>    a commit that was previously disallowed.
>
> t/t7501-commit.sh | 20 ++++++++++++++++++++
> wt-status.c       |  1 +
> 2 files changed, 21 insertions(+)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 63e0427..363abb1 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -587,4 +587,24 @@ test_expect_success '--only works on to-be-born 
> branch' '
>  test_cmp expected actual
> '
>
> +test_expect_success '--dry-run with conflicts fixed from a merge' '
> + # setup two branches with conflicting information
> + # in the same file, resolve the conflict,
> + # call commit with --dry-run
> + echo "Initial contents, unimportant" >test-file &&
> + git add test-file &&
> + git commit -m "Initial commit" &&
> + echo "commit-1-state" >test-file &&
> + git commit -m "commit 1" -i test-file &&
> + git tag commit-1 &&
> + git checkout -b branch-2 HEAD^1 &&
> + echo "commit-2-state" >test-file &&
> + git commit -m "commit 2" -i test-file &&
> + ! $(git merge --no-commit commit-1) &&
> + echo "commit-2-state" >test-file &&
> + git add test-file &&
> + git commit --dry-run &&
> + git commit -m "conflicts fixed from merge."
> +'
> +
> test_done
> diff --git a/wt-status.c b/wt-status.c
> index ab4f80d..1374b48 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -950,6 +950,7 @@ static void show_merge_in_progress(struct wt_status 
> *s,
>  status_printf_ln(s, color,
>  _("  (fix conflicts and run \"git commit\")"));
>  } else {
> + s-> commitable = 1;
>  status_printf_ln(s, color,
>  _("All conflicts fixed but you are still merging."));
>  if (s->hints)
> -- 
> 2.7.0.GIT
>
> --
Philip 
