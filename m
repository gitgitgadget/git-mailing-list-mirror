From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull.sh: quote $upload_pack when passing it to git-fetch
Date: Thu, 30 Jul 2015 14:13:48 -0700
Message-ID: <xmqq8u9x73hv.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
	<1438288803-17953-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Joey Hess <id@joeyh.name>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 23:14:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKv9T-0006Ev-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 23:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbbG3VOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 17:14:02 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:32862 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbG3VOB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 17:14:01 -0400
Received: by pdbmj9 with SMTP id mj9so2788436pdb.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ifNAh/6hHjBDt9QN3QaiQYchJCDiAo6slKuSxa6fRb8=;
        b=pWgdRhYFxiAIBR+W1UoTiQ/cVgWYK51kJyMbPzZNu4miuhUTqIGteWIBddvnBZXodQ
         SHBM7I3oMbviQKkLy04JtXTFTyESp5OcwAAG/D11kUQj/DJqRCycEaIEwSa8WHG02pTv
         TSHdJRvK+C4Xa8UDmtLej7rTXUYO/aDiC7W4gYhimovmtAbZohkyB0Pfz97llX9aGlAK
         GkdCdSPkvK7vgwEBZRhO+9WhxXXbLBK+zPJil0+V9J6N9Du5VJwBnJQAwXR2wd6iF6Qq
         oYu9U+R2iJNNhGQGz89PJeNXO6Rt+ude891nmuZ65WvexPPLJfxW0WhPa5by2ZgcHadP
         eH/A==
X-Received: by 10.70.129.102 with SMTP id nv6mr111802187pdb.55.1438290840621;
        Thu, 30 Jul 2015 14:14:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id j3sm3755443pdf.76.2015.07.30.14.13.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 14:13:49 -0700 (PDT)
In-Reply-To: <1438288803-17953-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 30 Jul 2015 22:40:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275028>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The previous code broke for example
>
>   git pull --upload-pack 'echo --foo'
>
> Reported-by: Joey Hess <id@joeyh.name>
> Fix-suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Junio wrote:
>> ${upload_pack+"$upload_pack"} or something.
>
> Indeed, we need to pass nothing, not the empty string if $upload_pack
> is not defined.
>
> This should fix it.

The problematic commit touches a lot more than upload-pack, but all
others that take user-supplied strings are meant for "git merge" or
"git rebase" that are properly quoted and then eval'ed, so this
should be sufficient.

Thanks.

>
>  git-pull.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index a814bf6..26c5e9f 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -295,7 +295,7 @@ test true = "$rebase" && {
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)
>  git fetch $verbosity $progress $dry_run $recurse_submodules $all $append \
> -$upload_pack $force $tags $prune $keep $depth $unshallow $update_shallow \
> +${upload_pack+"$upload_pack"} $force $tags $prune $keep $depth
> $unshallow $update_shallow \
>  $refmap --update-head-ok "$@" || exit 1
>  test -z "$dry_run" || exit 0
