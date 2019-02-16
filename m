Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE3B1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 00:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfBPASs (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 19:18:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:60570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfBPASr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 19:18:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7228AE25;
        Sat, 16 Feb 2019 00:18:45 +0000 (UTC)
Date:   Sat, 16 Feb 2019 01:18:43 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] worktree: fix worktree add race.
Message-ID: <20190216011843.24d15051@naga>
In-Reply-To: <xmqq8syg6foq.fsf@gitster-ct.c.googlers.com>
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
        <xmqq8syg6foq.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Feb 2019 10:59:33 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > Git runs a stat loop to find a worktree name that's available and then does
> > mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> > worktree add finding the same free name and creating the directory first.  
> 
> Yeah, relying on the atomicity of mkdir(2) is much saner approach
> than "check -- ah we can use the name -- try to create" that is race
> prone.
> 
> Thanks for working on this.
> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  builtin/worktree.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 3f9907fcc994..e1a2a56c03c5 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -268,10 +268,9 @@ static int add_worktree(const char *path, const char *refname,
> >  	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
> >  	struct strbuf sb = STRBUF_INIT;
> >  	const char *name;
> > -	struct stat st;
> >  	struct child_process cp = CHILD_PROCESS_INIT;
> >  	struct argv_array child_env = ARGV_ARRAY_INIT;
> > -	int counter = 0, len, ret;
> > +	int counter = 1, len, ret;
> >  	struct strbuf symref = STRBUF_INIT;
> >  	struct commit *commit = NULL;
> >  	int is_branch = 0;
> > @@ -295,19 +294,21 @@ static int add_worktree(const char *path, const char *refname,
> >  	if (safe_create_leading_directories_const(sb_repo.buf))
> >  		die_errno(_("could not create leading directories of '%s'"),
> >  			  sb_repo.buf);
> > -	while (!stat(sb_repo.buf, &st)) {
> > +
> > +	while (mkdir(sb_repo.buf, 0777)) {
> >  		counter++;
> > +		if(!counter) break; /* don't loop forever */
> >  		strbuf_setlen(&sb_repo, len);
> >  		strbuf_addf(&sb_repo, "%d", counter);  
> 
> Style:
> 
> 		if (!counter)
> 			break; /* don't loop forever */
> 
> More importantly, how long would it take to loop thru all possible
> integers (can be simulated by making the parent directory
> unwritable)?  Don't we want to cut off with more conservative upper
> limit, say 1000 rounds or even 100 rounds or so?
> 
> Also, is the behaviour for a signed integer wrapping around due to
> getting incremented too many times well defined?  I'd feel safer,
> especially if you are willing to spin for 4 billion times like this
> patch does, if you changed the counter to "unsigned int".

If there are 4 billion worktrees ..
but there is no need to spin if the failure reason is not EEXIST.

> 
> I see you changed "counter" to start from 1, but that would mean
> that these fallback names would start with suffix 2, not 1.  Which
> would look funny.
> 
> I would have expected ".1", ".2", etc.  as suffix, but the original
> used "1", "2", etc. so I won't complain on the format, but I do find
> it questionable to start counting from 2.

Yes, there is no need to change the starting counter.

> 
> >  	}
> > +	if (!counter)
> > +		die_errno(_("could not create directory of '%s'"), sb_repo.buf);  
> 
> It would have saved reviewer's time if this die() were inside the
> loop where you punted with "break".

Yes, that's a leftover of the existing code structure.

> 
> >  	name = strrchr(sb_repo.buf, '/') + 1;
> >  
> >  	junk_pid = getpid();
> >  	atexit(remove_junk);
> >  	sigchain_push_common(remove_junk_on_signal);
> >  
> > -	if (mkdir(sb_repo.buf, 0777))
> > -		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
> >  	junk_git_dir = xstrdup(sb_repo.buf);
> >  	is_junk = 1;  

Thanks

Michal
