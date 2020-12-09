Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496EC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D14123BDB
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgLIJDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgLIJDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 04:03:13 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Dec 2020 01:02:33 PST
Received: from 256bit.org (256bit.org [IPv6:2a01:4f8:192:14af::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCEC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 01:02:33 -0800 (PST)
Received: from chrisbra by 256bit.org with local (Exim 4.90_1)
        (envelope-from <cb@256bit.org>)
        id 1kmvMl-0007Ld-MR
        for git@vger.kernel.org; Wed, 09 Dec 2020 10:02:31 +0100
Date:   Wed, 9 Dec 2020 09:53:56 +0100
From:   Christian Brabandt <cb@256bit.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <20201209085356.GJ22416@256bit.org>
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>, Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209065537.48802-2-felipe.contreras@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cb@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Felipe Contreras schrieb am Mittwoch, den 09. Dezember 2020:

> +augroup git
> +	au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
> +
> +	au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0
> +	au FileType sh setl noexpandtab tabstop=8 shiftwidth=0
> +	au FileType perl setl noexpandtab tabstop=8 shiftwidth=0
> +	au FileType asciidoc setl noexpandtab tabstop=8 shiftwidth=0 autoindent
> +augroup END

This will set filetype specific options. So after this file has been 
loaded, it will set e.g. set tabstop and shiftwidth options for 
filetypes outside of the git project.

Shouldn't this only apply to files inside the git code repository?

> +
> +" vim: noexpandtab tabstop=8 shiftwidth=0
> diff --git a/contrib/vim/plugin/gitvimrc.vim b/contrib/vim/plugin/gitvimrc.vim
> new file mode 100644
> index 0000000000..c3946e5410
> --- /dev/null
> +++ b/contrib/vim/plugin/gitvimrc.vim
> @@ -0,0 +1,21 @@
> +let s:gitvimrc_whitelist = get(g:, 'gitvimrc_whitelist', [])
> +
> +function LoadGitVimrc()
> +  let l:top = trim(system('git rev-parse --show-toplevel'))

trim needs at least vim 8.0.1630. Is this recent enough? Could also use 
systemlist()[0] which is available starting at vim 7.4.248 or just a 
simple split(system(), "\n")[0] which should be compatible with vim 7.

> +  if l:top == '' | return | endif
> +  let l:file = l:top . '/.vimrc'
> +  if !filereadable(l:file) | return | endif
> +
> +  let l:found = 0
> +  for l:pattern in s:gitvimrc_whitelist

You could directly use `get(g:, 'gitvimrc_whitelist', [])` directly, so 
the script local var s:gitvimrc_whitelist is not really needed.

> +    if (match(l:top, l:pattern) != -1)

This uses a regex match. Perhaps do a string comparsion? If this is 
needed, consider adding "\C" to force matching case and perhaps also \V 
to force a literal match. Otherwise the options magic, ignorecase, 
smartcase etc are applied to the matching.

> +      let l:found = 1
> +      break
> +    endif
> +  endfor
> +  if !l:found | return | endif
> +
> +  exec 'source ' . fnameescape(l:file)
> +endf
> +
> +call LoadGitVimrc()

On the style: I personally dislike the `l:` prefix for function local 
variables, as this does not add anything. But perhaps this is just my 
personal preference.

Best,
Christian
