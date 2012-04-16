From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Mon, 16 Apr 2012 11:38:27 -0400
Message-ID: <20120416153827.GC13366@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:38:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJo0q-0002oP-8z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab2DPPii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:38:38 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35852 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab2DPPih (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:38:37 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SJo0b-0000Y9-AE; Mon, 16 Apr 2012 11:38:31 -0400
Content-Disposition: inline
In-Reply-To: <20120415104212.GC6263@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195647>

On Sun, Apr 15, 2012 at 12:42:12PM +0200, Clemens Buchacher wrote:
> On Fri, Apr 13, 2012 at 02:45:05PM -0400, Neil Horman wrote:
> >
> > +                     OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_if_made_empty, "keep redundant, empty commits"),
> 
> For consistency, I'd prefer if the variable name were the same as the
> option. Then I wouldn't have to keep the option<->variable translation
> in mind.
> 
Ok

> >
> > +     if (!empty && !opts->keep_if_made_empty) {
> [...]
> > +                     return 0;
> [...]
> >       if (opts->allow_empty)
> > +             argv_array_push(&array, "--allow-empty");
> > +
> > +     rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
> 
> I find it a bit strange, that if we cherry-pick a commit that was
> already empty, we _do_ call git commit (and error out), but if we find a
> commit that is made empty, we do _not_ call git commit and quietly
> succeed (in not doing anything). But I suppose that is the legacy
> behavior?
> 
Correct, more or less.  The legacy behavior is to call git commit unilaterally.
With this change, we still do that, but we pass --allow-empty to the commit
command, allowing it to preserve the empty commit.  If we specify
keep-redundant-commits, we skip the check to see if the new commit is empty and
create the new (now empty) commit.  The only change is that if we do not specify
keep-redundant-commits, we check to see if the commit is made empty in
git-cherry-pick and skip it if it is.  We could, instead of returning prior to
calling git-commit, use that test to override the keep_empty option below, so
that we don't pass --allow-empty to git-commit instead.  That would preserve the
prior code path, but for no real advatage, as the outcome is the same, and this
way saves us having to fork the git-commit command, which I think is
adventageous.

> > +
> > +		rc = !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
> > +
> > +		if (rc)
> 
> rc is short for run_command, for which it stores the return value, no?
> Let's not abuse the variable like this and instead use the result
> directly:
> 
No.  rc is short for return code, generically used to represent the value
to be returned from a function. Its used in this fashion in any number of
places, both in git and any other project. 

>  if (!hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1))
> 
> If you make the entire paragraph leading up to this a separate function,
> say index_is_empty(), then the above would read more naturally like
> this:
> 
>  if (!opts->keep_if_made_empty && !empty && index_is_empty())
> 
> > +			/*
> > +			 * The head tree and the parent tree match
> > +			 * meaning the commit is empty.  Since it wasn't created
> 
> Don't you mean the head tree and the index?
> 
yeah.

> > +			 * empty (based on the previous test), we can conclude
> > +			 * the commit has been made redundant.  Since we don't
> > +			 * want to keep redundant commits, just skip this one
> > +			 */
> > +			return 0;
> > +	}
> > +
> > +	argv_array_init(&array);
> > +	argv_array_push(&array, "commit");
> > +	argv_array_push(&array, "-n");
> >  
> > -	args[i++] = "commit";
> > -	args[i++] = "-n";
> >  	if (opts->signoff)
> > -		args[i++] = "-s";
> > +		argv_array_push(&array, "-s");
> >  	if (!opts->edit) {
> > -		args[i++] = "-F";
> > -		args[i++] = defmsg;
> > +		argv_array_push(&array, "-F");
> > +		argv_array_push(&array, defmsg);
> >  	}
> > +
> >  	if (opts->allow_empty)
> > -		args[i++] = "--allow-empty";
> > +		argv_array_push(&array, "--allow-empty");
> > +
> > +
> 
> Why two newlines?
> 
> > +	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
> > +	argv_array_clear(&array);
> > +	return rc;
> > +}
> 
> Looks good to me otherwise.
> 
