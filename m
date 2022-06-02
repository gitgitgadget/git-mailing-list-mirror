Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D67DC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiFBV4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiFBV4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 17:56:07 -0400
Received: from nmsh6.e.nsc.no (nmsh6.e.nsc.no [148.123.160.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BC2716D
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 14:56:05 -0700 (PDT)
Received: from epost.telenor.no (owweb1.e.nsc.no [193.213.121.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: joak-pet@online.no)
        by nmsh6.e.nsc.no (smtp.online.no) with ESMTPSA id 2567D1D409F;
        Thu,  2 Jun 2022 23:56:02 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jun 2022 23:56:02 +0200
From:   joak-pet@online.no
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v2] git-prompt: make colourization consistent
In-Reply-To: <20220602145935.10512-1-joak-pet@online.no>
References: <20220601134414.66825-1-joak-pet@online.no>
 <20220602145935.10512-1-joak-pet@online.no>
Message-ID: <db1c01f8413fbbfa3e19755afdec4f71@online.no>
X-Sender: joak-pet@online.no
User-Agent: Online Webmail
X-Source-IP: 193.213.121.36
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06/2022 16:59, Joakim Petersen wrote:
> The short upstream state indicator inherits the colour of the last 
> short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. Make the colourization of these
> state indicators consistent by clearing any colour before printing the
> short upstream state indicator, as this immediately follows the last
> coloured indicator.
> 
> As of 0ec7c23cdc6 (git-prompt: make upstream state indicator location
> consistent, 2022-02-27), colourization in the output of __git_ps1 has
> changed such that the short upstream state indicator inherits the 
> colour
> of the last short state indicator before it (if there is one), while
> before this change it was white/the default text colour. Some examples
> to illustrate this behaviour (assuming all indicators are enabled and
> colourization is on):
>  * If the local tree is clean and there is something in the stash, both
>    the '$' and the short upstream state indicator following it will be
>    blue.
>  * If the local tree has new, untracked files, both the '%' and the
>    short upstream state indicator will be red.
>  * If all local changes are added to the index and the stash is empty,
>    both the '+' and the short upstream state indicator following it 
> will
>    be green.
>  * If the local tree is clean and there is nothing in the stash, the
>    short upstream state indicator will be white/${default text colour}.
> 
> This appears to be an unintended side-effect of the change, and makes
> little sense semantically (e.g. why is it bad to be in sync with
> upstream when you have uncommitted local changes?). The cause of the
> change is that previously, the short upstream state indicator appeared
> immediately after the rebase/revert/bisect/merge state indicator (note
> the position of $p in $gitstring):
> 
> 	local f="$h$w$i$s$u"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
> 
> Said indicator is prepended with the clear colour code, and the short
> upstream state indicator is thus also uncoloured. Now, the short
> upstream state indicator follows the sequence of colourized indicators,
> without any clearing of colour (again note the position of $p, now in
> $f):
> 
> 	local f="$h$w$i$s$u$p"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
> 
> However, adding a clearing of colour before the short upstream state
> indicator will change how the sparsity state indicator is colourized,
> as it currently inherits (and before the change referenced also
> inherited) the colour of the last short state indicator before it.
> Reading the commit message of the change that introduced the sparsity
> state indicator, afda36dbf3b (git-prompt: include sparsity state as
> well, 2020-06-21), it appears this colourization also was unintended,
> so clearing the colour for said indicator further increases 
> consistency.
> 
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
> 
> Range-diff against v1:
> 1:  e235caa7a8 = 1:  e235caa7a8 git-prompt: make colourization 
> consistent
> 
>  contrib/completion/git-prompt.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/completion/git-prompt.sh 
> b/contrib/completion/git-prompt.sh
> index 87b2b916c0..dfd6cef35f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
>  	if [ -n "$u" ]; then
>  		u="$bad_color$u"
>  	fi
> +	p="$c_clear$p"
>  	r="$c_clear$r"
>  }

I just realized I forgot to write what changed between the RFC patch
and v2:

  * Clarify the reason why 0ec7c23cdc6 (git-prompt: make upstream state
    indicator location consistent, 2022-02-27) changed the colourization
    of the short upstream state indicator.
  * Explain the rationale for changing the sparsity state colourization.
  * Include examples of how the short upstream state indicator is
    currently colourized
