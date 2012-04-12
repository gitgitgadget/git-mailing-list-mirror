From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Thu, 12 Apr 2012 06:49:16 -0400
Message-ID: <20120412104916.GB32669@hmsreliant.think-freely.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
 <7v1unuj8az.fsf@alter.siamese.dyndns.org>
 <20120411235509.GB16937@hmsreliant.think-freely.org>
 <7vty0phc8s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 12:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIHaq-0005HN-JG
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 12:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab2DLKtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 06:49:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:46835 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab2DLKtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 06:49:31 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SIHaX-0000fz-BQ; Thu, 12 Apr 2012 06:49:23 -0400
Content-Disposition: inline
In-Reply-To: <7vty0phc8s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195325>

On Wed, Apr 11, 2012 at 08:15:15PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> >> > -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
> >> > +int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
> >> >  {
> >> > -	/* 7 is max possible length of our args array including NULL */
> >> > -	const char *args[7];
> >> > -	int i = 0;
> >> > +	struct argv_array array;
> >> > +	int rc;
> >> > +
> >> > +	if (!empty && !opts->keep_if_made_empty) {
> >> > +		unsigned char head_sha1[20];
> >> > +		struct commit *head_commit;
> >> > +		int need_free = 0;
> >> > +
> >> > +		resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
> >> > +		head_commit = lookup_commit(head_sha1);
> >> 
> >> No error checking whatsoever?  HEAD might be pointing at a branch that
> >> hasn't been born, for example.
> >> 
> > Sorry, I had presumed that HEAD could be guaranteed to be good here, given that
> > we validate it in rollback_single_pick via read_ref_full.  But I can add
> > additional checking here.
> 
> As long as it is clear that we always have "HEAD" here, it is not strictly
> necessary, but we'd probably feel better, especially now that the function
> is (for some reason) made into a global one and may gain other new callers
> outside this file scope.
> 
Gah!  Thanks for that, its not meant to be static.  I made that global so that
gdb could see it and set a breakpoint on it, while I was figuring out the
segfault I was getting when active_cache_tree was NULL.  I'll fix that.

> >> >  	if (opts->allow_empty)
> >> > -		args[i++] = "--allow-empty";
> >> > +		argv_array_push(&array, "--allow-empty");
> >> 
> >> If --keep-if-made-empty is not given but --allow-empty was, it is fine to
> >> give --allow-empty here, but otherwise, it logically is iffy and is likely
> >> to become a cause of future bugs to pass --allow-empty to "git commit",
> >> even though the earlier check _ought_ to catch problematic cases, no?
> >> 
> > Not sure I follow your reasoning here.  We need to pass allow-empty to git
> > commit here if git cherry-pick set either allow-empty or keep-redundant-commits
> > (the latter setting opts->empty), Can you give an example of what might be
> > problematic in the future?
> 
> Thinking about it again, I think this part of your patch is correct.
> 
> We may pass an index that yields the same tree as "HEAD" if the original
> was empty, or the original was not empty but the merge found the commit
> unneeded.  In either case, if "--keep-unnecessary" or "--allow-empty" was
> given, we want to record the empty commit, and opts->allow_empty is set
> when either option was given from the command line.
> 
Yes, exactly.
Thanks.

> Thanks.
> 
