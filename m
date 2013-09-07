From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH-v2] Allow git-filter-branch to process large repositories
 with lots of branches.
Date: Sun, 08 Sep 2013 00:06:24 +0100
Message-ID: <522BB170.8040507@gmail.com>
References: <CE50E29B.191B8%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lee Carver <leeca@pnambic.com>
To: Lee Carver <Lee.Carver@servicenow.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 01:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIRaL-00024v-AB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 01:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796Ab3IGXG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 19:06:29 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:39155 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3IGXG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 19:06:28 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so2316681eek.24
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yUcv/90qFgcySwNLSPEF+Yg3vtl+Hz9A/GlGFWFoOr4=;
        b=LgEyz3CIvWjMWPQNkzHJqW9rL01Vp25nImUDAmib9mXyla/h8P9MnE/SSylGKJ0um2
         oDYR+gV2QGbArkSf8YrDonemkman6KHFmwe96pHZ/nwsV7Rz/IeF3XoY52nxeI2CTZQZ
         urYBPiHORNJfsfxowylnmYB9t/x+4Fq90j/f4CrPzqDHernjbdiLbiFSZYBqI2cjZ+Dc
         5ffHq/ushHu21onw/XOafvWmg51VJy6JwsVnE9q+IFtcJ5kJEs+vHp5R5i2l/52hv0G9
         XzgctEmcz3UesjXeF/E3ZUxYC8TkoqN977s5NXZWPM/RKb0FrIQ5QXXeEe6dGsTz3MVl
         OXfw==
X-Received: by 10.14.241.74 with SMTP id f50mr16799562eer.29.1378595187005;
        Sat, 07 Sep 2013 16:06:27 -0700 (PDT)
Received: from [192.168.1.10] ([79.97.144.61])
        by mx.google.com with ESMTPSA id i1sm8821083eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 16:06:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <CE50E29B.191B8%lee.carver@corp.service-now.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234147>

On 07/09/13 22:03, Lee Carver wrote:
> As noted in several forums, a recommended way to move trees between
> repositories
> is to use git-filter-branch to revise the history for a single tree:
>
> http://gbayer.com/development/moving-files-from-one-git-repository-to-anoth
> er-preserving-history/
> http://stackoverflow.com/questions/1365541/how-to-move-files-from-one-git-r
> epo-to-another-not-a-clone-preserving-history
>
> However, this can lead to argument list too long errors when the original
> repository has many retained branches (>6k)
>
> /usr/local/git/libexec/git-core/git-filter-branch: line 270:
> /usr/local/git/libexec/git-core/git: Argument list too long
> Could not get the commits
>
> Piping the saved output from git rev-parse into git rev-list avoids this
> problem, since the rev-parse output is not processed as a command line
> argument.
> ---
>   git-filter-branch.sh | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ac2a005..60d239b 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -255,7 +255,7 @@ else
>   	remap_to_ancestor=t
>   fi
>
> -rev_args=$(git rev-parse --revs-only "$@")
> +git rev-parse --revs-only "$@" > ../parse
>
>   case "$filter_subdir" in
>   "")
> @@ -267,8 +267,9 @@ case "$filter_subdir" in
>   	;;
>   esac
>
> +cat ../parse | \
>   git rev-list --reverse --topo-order --default HEAD \
> -	--parents --simplify-merges $rev_args "$@" > ../revs ||
> +	--parents --simplify-merges --stdin "$@" > ../revs ||
 >
Useless use of cat IMO.  I'd suggest using a redirection instead:

   git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	--parents --simplify-merges --stdin "$@" > ../revs < ../parse ||

>   	die "Could not get the commits"
>   commits=$(wc -l <../revs | tr -d " ")
>
>

Regards,
   Stefano
