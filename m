Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC3C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F3F23B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgLIKrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgLIKrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 05:47:32 -0500
Received: from 256bit.org (256bit.org [IPv6:2a01:4f8:192:14af::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A1FC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 02:46:51 -0800 (PST)
Received: from chrisbra by 256bit.org with local (Exim 4.90_1)
        (envelope-from <cb@256bit.org>)
        id 1kmwzh-0006Nv-RA
        for git@vger.kernel.org; Wed, 09 Dec 2020 11:46:49 +0100
Date:   Wed, 9 Dec 2020 11:45:32 +0100
From:   Christian Brabandt <cb@256bit.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <20201209104532.GL22416@256bit.org>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <20201209085356.GJ22416@256bit.org>
 <CAMP44s18FMyJoHogud3QjWGya_9bAB7yAaYUb1aTQ12fYUTNxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s18FMyJoHogud3QjWGya_9bAB7yAaYUb1aTQ12fYUTNxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cb@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mi, 09 Dez 2020, Felipe Contreras wrote:

> On Wed, Dec 9, 2020 at 2:54 AM Christian Brabandt <cb@256bit.org> wrote:
> 
> > Felipe Contreras schrieb am Mittwoch, den 09. Dezember 2020:
> >
> > > +augroup git
> > > +     au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
> > > +
> > > +     au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0
> > > +     au FileType sh setl noexpandtab tabstop=8 shiftwidth=0
> > > +     au FileType perl setl noexpandtab tabstop=8 shiftwidth=0
> > > +     au FileType asciidoc setl noexpandtab tabstop=8 shiftwidth=0 autoindent
> > > +augroup END
> >
> > This will set filetype specific options. So after this file has been
> > loaded, it will set e.g. set tabstop and shiftwidth options for
> > filetypes outside of the git project.
> >
> > Shouldn't this only apply to files inside the git code repository?
> 
> Yes. But this file can only be loaded if your cwd is inside this
> repository. That is; if "git rev-parse --show-toplevel" shows the same
> directory as this file.

Yes, however what I was trying to say was: Once I edited a file from 
within the git source repository, this means it will apply to all 
further files I will edit in this session. So I do `:e 
~/bin/my_precious_shell_script.sh` it will apply those settings there as 
well.

So I would rather call a function in the FileType autocommand, that 
checks the path of the currently edited file before it applies those 
settings.

> > > +
> > > +" vim: noexpandtab tabstop=8 shiftwidth=0
> > > diff --git a/contrib/vim/plugin/gitvimrc.vim b/contrib/vim/plugin/gitvimrc.vim
> > > new file mode 100644
> > > index 0000000000..c3946e5410
> > > --- /dev/null
> > > +++ b/contrib/vim/plugin/gitvimrc.vim
> > > @@ -0,0 +1,21 @@
> > > +let s:gitvimrc_whitelist = get(g:, 'gitvimrc_whitelist', [])
> > > +
> > > +function LoadGitVimrc()
> > > +  let l:top = trim(system('git rev-parse --show-toplevel'))
> >
> > trim needs at least vim 8.0.1630. Is this recent enough?
> 
> 2018? I think that's good enough. If not I'd be happy to include any
> other suggestion.

Not sure. CentOS 7 seems to have 7.4.629 and CentOS 8 8.0.1763, Ubuntu 
LTS 16.04 7.4.1689, all according to https://repology.org/project/vim/versions

And then there is neovim. I suppose it has trim()

> > Could also use
> > systemlist()[0] which is available starting at vim 7.4.248 or just a
> > simple split(system(), "\n")[0] which should be compatible with vim 7.
> 
> Yeah, in Linux. Will that work in Windows where carriage returns are "\r\n"?

Yes.

> > > +  if l:top == '' | return | endif
> > > +  let l:file = l:top . '/.vimrc'
> > > +  if !filereadable(l:file) | return | endif
> > > +
> > > +  let l:found = 0
> > > +  for l:pattern in s:gitvimrc_whitelist
> >
> > You could directly use `get(g:, 'gitvimrc_whitelist', [])` directly, so
> > the script local var s:gitvimrc_whitelist is not really needed.
> 
> True. It's just a force of habit to copy the global scope to the
> script scope. That being said; the "for" would call the get() function
> multiple times (probably). So I'm not entirely sure what is being
> gained.

This function is called only once and get() should be quite fast.

> 
> > > +    if (match(l:top, l:pattern) != -1)
> >
> > This uses a regex match. Perhaps do a string comparsion? If this is
> > needed, consider adding "\C" to force matching case and perhaps also \V
> > to force a literal match. Otherwise the options magic, ignorecase,
> > smartcase etc are applied to the matching.
> 
> This was straight-up copied from another solution. I just checked :h
> match() and didn't find any low-hanging fruit.
> 
> If you have a better proposal just type it out. I'm not overly
> familiar with vimscript, I just know the above works.

Is comparing literally good enough? e.g. 

if top ==# pattern

(this would match case, or use ==? to ignore case). In any case, make 
case matching explicit, so that the options `ignorecase` and `smartcase` 
are not used.

> 
> > > +      let l:found = 1
> > > +      break
> > > +    endif
> > > +  endfor
> > > +  if !l:found | return | endif
> > > +
> > > +  exec 'source ' . fnameescape(l:file)
> > > +endf
> > > +
> > > +call LoadGitVimrc()
> >
> > On the style: I personally dislike the `l:` prefix for function local
> > variables, as this does not add anything. But perhaps this is just my
> > personal preference.
> 
> I don't mind either way. I just add it for consistency since the
> syntax sometimes doesn't identify such variables (e.g "if !found"),
> but most of the time the syntax doesn't do it either way (which is
> odd).

You mean the vimscript syntax? I don't remember seeing such.

> So just s/l:// ?

Yes, unless you use a variable called count, which would be shadowed by 
v:count

Best,
Christian
-- 
Achte auf Deine Gedanken! Sie sind der Anfang Deiner Taten.
		-- Chinesisches Sprichwort
