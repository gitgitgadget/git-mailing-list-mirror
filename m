From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] revert: Separate cmdline argument handling from the
 functional code
Date: Wed, 11 May 2011 06:49:09 -0500
Message-ID: <20110511114909.GE2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBng-0003vF-4J
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab1EKP5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:57:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36367 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102Ab1EKP5J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:57:09 -0400
Received: by iwn34 with SMTP id 34so626828iwn.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sI95rOK1VJ2z3kgyFZXJ65rBapUp9oN16ccqX0fAhIA=;
        b=LxVeCHYsiS38FyjhyjnHscQhAPnrtV7NwsVGdFxffous4jY5Nq3AlI+DXAxDvSyYxL
         CDiBUoXskK5oegnelA+XlfSh3LY3PxozeL0GRZEPkKWPcZW6HQMQav9aAycDWlJ5F0hR
         dKSvnBmA1r3vP/N5027T3VBDDy28LEVJuOkXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QN8ZnaNPR8vyQLylNEhABiG8B1B4BxkzL7gYserldjjRHx0sAB61htz4SUpVXcn51X
         0lwBu41+NfnYkuJB7CCfJXiUQnBoxcQKHf8R5U93V3pm7Z2wZ1TGVBOq7EoV+ch7gDRW
         MO1kWBaGCavT1U5j6DcaiNt7/fD6oJy8IG5go=
Received: by 10.231.23.65 with SMTP id q1mr5683398ibb.74.1305114553413;
        Wed, 11 May 2011 04:49:13 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id o3sm29223ibd.10.2011.05.11.04.49.11
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 04:49:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173398>

Ramkumar Ramachandra wrote:

> Reading the Git configuration, setting environment variables, parsing
> command-line arguments, and populating the options structure should be
> done in cmd_cherry_pick/ cmd_revert.

Yes, but why? :)

> The job pick_commits of
> simplified into setting up the revision walker and calling
> do_pick_commit in a loop- later in the series, it will handle
> failures, and serve as the starting point for continuation.

ENOPARSE.  I assume the idea is that callers will want to decide what
they want pick_commits to do and specify it by filling a struct
instead of argc and argv.  Is that it?

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -603,19 +603,12 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>  	return 0;
>  }
>  
> -static int revert_or_cherry_pick(int argc, const char **argv,
> -				struct replay_opts *opts)
> +static int pick_commits(struct replay_opts *opts)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> -	const char *me;
>  	int res;
>  
> -	git_config(git_default_config, NULL);
> -	me = (opts->action == REVERT ? "revert" : "cherry-pick");
> -	setenv(GIT_REFLOG_ACTION, me, 0);
> -	parse_args(argc, argv, opts);
> -
>  	if (opts->allow_ff) {

I don't see why the caller sets up GIT_REFLOG_ACTION, since the caller
is not making the commits.  Is there an example where it would use
something other than "cherry-pick" or "revert"?

Aside from clarifying that detail, this one looks good.
