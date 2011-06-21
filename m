From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/13] revert: Propogate errors upwards from
 do_pick_commit
Date: Tue, 21 Jun 2011 11:22:32 -0500
Message-ID: <20110621162232.GI15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3it-0004cD-5B
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992Ab1FUQWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 12:22:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53711 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab1FUQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:22:37 -0400
Received: by iwn6 with SMTP id 6so2195420iwn.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0W7FzSNhK5cXsIGYuXeWq5ieHOlq0LCpYvxYmuACF3c=;
        b=h/cY7AILGV0cSGEZxFRxoK5LI0/Nqow9QDXG1iTzrxU70yWVWK65rn9jkYHstn0bpK
         o1e1yytoe9Rh8VZqWeOiMrBP9fRnGDeOUDRVp3ML5GOZB6z3dTx2gM5PYgFTg8WhgEAq
         PfIdlCdqEVQmIhbhJRHriiWN7D89rqfYVsFmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ym6dP9DaTnAJBPSyJq+HvskEFPqYzrww0KmfWXBR7/2GW7CgGIAM1AavRfDqv2VCB1
         RC6SSRD9bFJiKH8A/O3injX/31umxR2iMgWjolighIDaon/4A+u0q8rHTcnTWhqws62u
         5pJTm53YTyFl4ljWuAuZqkDtlHmZ0p4Gp0FNw=
Received: by 10.42.148.1 with SMTP id p1mr7538424icv.319.1308673356855;
        Tue, 21 Jun 2011 09:22:36 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id hw7sm1137349icc.15.2011.06.21.09.22.35
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 09:22:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176169>

Ramkumar Ramachandra wrote:

> Earlier, revert_or_cherry_pick only used to return a non-negative
> number or die.  Change this so that it can return negative values too;
> postive return values indicate conflicts, while negative ones indicate
> other errors, and this return status is propogated updwards from
> do_pick_commit, to be finally handled in cmd_cherry_pick and
> cmd_revert.  While revert_or_cherry_pick can still die due to several
> other reasons, this patches attempts to factor out some of the die
> calls.  In the same spirit, also introduce a new function
> error_dirty_index, based on die_dirty_index which prints some hints
> and returns an error to its caller do_pick_commit.

The "Earlier" combined with imperfect tense somehow oddly trips me up
(somehow it does not register that you mean "Before this patch").  I
usually find using the present or the simple past for the status quo
is clearer ("Currently the return value from revert_or_cherry_pick is
a non-negative integer representing the intended exit status from git
revert or git cherry-pick.  Change that by ...").

Carrying forward from that confusion, it's hard to concentrate hard
enough to parse and figure out the rest.  That shouldn't be necessary:
by setting the scene with an explanation of the problem being solved
it should be possible to make this much simpler.

Suppose, forgetting the above, that I asked you to explain what this
patch is about.  You'd say it's about teaching "revert_or_cherry_pick"
to return error() instead of die()-ing a little more often, right?
Then if I asked you why, you might say one of many things --- for
example, that in the long term the hope is to allow speeding up
multiple-cherry-pick by not writing CHERRY_PICK_HEAD et al until a
single-commit pick fails, and that die()-ing interferes with that by
not moving the thread of control to the caller that wants to write
files like CHERRY_PICK_HEAD on error.  After that, I might ask what
this patch does to address that, and you might tell me that in
addition to converting various die() calls to "return error()", it
updates the callers to cope with the negative return codes that could
result from that.  Eventually the negative value gets returned from
revert_or_cherry_pick; currently the convention there is to return a
nonnegative integer (representing an appropriate "normal" exit status
for the command) but in the new regime it can also be -1, meaning the
command failed and should die().  Finally if I asked you what the
impact of applying this patch is, you might tell me that the benefits
will require converting more die() calls so the only immediate impact
should be to change various messages from "fatal:" to "error:" and add
a new 

	fatal: cherry-pick failed

at the end.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -250,25 +250,15 @@ static struct tree *empty_tree(void)
[...]
> @@ -582,14 +572,28 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  
>  int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
> +	int res;
>  	if (isatty(0))
>  		edit = 1;
>  	action = REVERT;
> -	return revert_or_cherry_pick(argc, argv);
> +	res = revert_or_cherry_pick(argc, argv);
> +	if (res > 0)
> +		/* Exit status from conflict */
> +		return res;
> +	if (res < 0)
> +		/* Other error */
> +		die(_("%s failed"), me);
> +	return 0;
>  }

With the above explanation in mind, it seems simpler to say

	if (res < 0)
		die(...);
	return res;

the idea being that there are two cases --- the new "die for failure"
case and the old "pass on the exit status requested by
revert_or_cherry_pick" case.

>  
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
> +	int res;
>  	action = CHERRY_PICK;
> -	return revert_or_cherry_pick(argc, argv);
> +	res = revert_or_cherry_pick(argc, argv);
> +	if (res > 0)
> +		return res;
> +	if (res < 0)
> +		die(_("%s failed"), me);
> +	return 0;

Should the "revert" or "cherry-pick" here be part of the message
marked for translation?  A translator might want to paraphrase to

	fatal: failed to cherry-pick

if that is more natural in the language at hand.
