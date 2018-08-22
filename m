Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12C31F954
	for <e@80x24.org>; Wed, 22 Aug 2018 11:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeHVPQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 11:16:33 -0400
Received: from ao2.it ([92.243.12.208]:54610 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeHVPQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 11:16:32 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fsReK-0000SW-V6; Wed, 22 Aug 2018 13:50:09 +0200
Date:   Wed, 22 Aug 2018 13:51:52 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when
 it's not checked out
Message-Id: <20180822135152.1d40cd05d0b0cadb5eefb31f@ao2.it>
In-Reply-To: <20180820233755.dc7b6a6927faccc37b25075f@ao2.it>
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-8-ao2@ao2.it>
        <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
        <20180820233755.dc7b6a6927faccc37b25075f@ao2.it>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Aug 2018 23:37:55 +0200
Antonio Ospite <ao2@ao2.it> wrote:

> On Tue, 14 Aug 2018 13:36:17 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Antonio Ospite <ao2@ao2.it> writes:
[...]
> > >  
> > > +	# For more details about this check, see
> > > +	# builtin/submodule--helper.c::module_config()
> > > +	if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules > /dev/null 2>&1
> > 
[...]
> > More importantly, I think it is better to add a submodule--helper
> > subcommand that exposes the check in question, as the code is
> > already written ;-) That approach will guarantee that the logic and
> > the message stay the same between here and in the C code.  Then you
> > do not even need these two line comment.
> >
[...]
> Does the interface suggested in the patch annotation sound acceptable?
> 
> To recap:
> 
>   - add an is_gitmodules_safely_writeable() helper;
>   - expose a "submodule--helper config --is-safely-writeable"
>     subcommand for git-submodule.sh to use.
>

Maybe "submodule--helper config --check-writeable" could be a better
name to avoid confusion between the boolean return value of the C
function (0: false, 1: true) and the exit status returned to the shell
(0: safe to write, !0: unsafe).

I'll use the following to map the returned value, as I saw that in
other places in the code base:

	if (argc == 1 && command == CHECK_WRITEABLE)
		return is_gitmodules_safely_writeable() ? 0 : -1;

I am assuming a command flag to the "config" subcommand is OK instead
of a brand new subcommand.

> [...]
> > > @@ -603,8 +604,19 @@ static void submodule_cache_check_init(struct repository *repo)
> > >  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> > >  {
> > >  	if (repo->worktree) {
> > > -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> > > -		git_config_from_file(fn, file, data);
> > > +		struct git_config_source config_source = { 0 };
> > > +		const struct config_options opts = { 0 };
> > > +		struct object_id oid;
> > > +		char *file;
> > > +
> > > +		file = repo_worktree_path(repo, GITMODULES_FILE);
> > > +		if (file_exists(file))
> > > +			config_source.file = file;
> > > +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> > > +			config_source.blob = GITMODULES_HEAD;
> > 
> > What is the reason why we fall back directly to HEAD when working
> > tree file does not exist?  I thought that our usual fallback was to
> > the version in the index for other things like .gitignore/attribute
> > and this codepath look like an oddball.  Are you trying to handle
> > the case where we are in a bare repository without any file checked
> > out (and there is not even the index)?
> >
> 
> My use case is about *reading* .gitmodules when it's ignored in a sparse
> checkout, in this scenario there are usually no staged changes
> to .gitmodules, so I basically just didn't care about the index.
> 
> Would using ":.gitmodules" instead of "HEAD:.gitmodules" be enough?
> 
[...]
> 
> If so, what name should I use instead of GITMODULES_HEAD?
> GITMODULES_BLOB is already taken for something different, maybe
> GITMODULES_REF or GITMODULES_OBJECT?
>

If using ":.gitmodules" is good enough I could rename the current use
of GITMODULES_BLOB in fsck.c to GITMODULES_NONBLOB and use
GITMODULES_BLOB for ":.gitmodules" after all.

This is to avoid preprocessor clashes with the symbolic constant
GITMODULES_BLOB currently used in in fsck.c.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
