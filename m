From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: handle single commit pick separately
Date: Sat, 5 Nov 2011 19:35:19 -0500
Message-ID: <20111106003519.GF27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:35:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqhy-0001YB-5Q
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab1KFAfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 20:35:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61648 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1KFAf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 20:35:29 -0400
Received: by gyc15 with SMTP id 15so2811422gyc.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Kujzxis8vYK561OZNx+BR5J91B3/Mh7izWhLDCp0j2w=;
        b=qPSGXCNcli47GxPrXT9nNJBocLpadzZqe/EiRgR5DIO+LXC9NoKs/lsO2PAmalQJKp
         RQ5BxahAAuyXxOzywyh9XwFXv4fGN56cjvHR2bIMzhBSDRm+VCHC3ETWfDi6GeV7O5jO
         LVFg/0H1yLZPSA4J4LMl7NHwHVQUm/nQQSowE=
Received: by 10.236.124.17 with SMTP id w17mr27382770yhh.126.1320539728994;
        Sat, 05 Nov 2011 17:35:28 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v5sm41718438anf.3.2011.11.05.17.35.27
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 17:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184888>

Ramkumar Ramachandra wrote:

> Don't write a '.git/sequencer/todo', as CHERRY_PICK_HEAD already
> contains this information.  However, '.git/sequencer/opts' and
> '.git/sequencer/head' are required to support '--reset' and
> '--continue' operations.

This is meant as a signal to later "git cherry-pick" commands that it
is okay to forget about the cherry-pick, right?  How is the reader
supposed to know that?  Say so!

By the way, it's not clear to me yet whether the resulting UI would be
more pleasant or not.  What is the expected calling sequence?  Any odd
corners of behavior changing?  What happens if I do

	git cherry-pick foo; # conflicts!
	git cherry-pick bar; # just ignore them

or

	git cherry-pick foo; # conflicts!  but resolved in index by rerere
	git checkout something-else

Is there any potential downside to the change?

[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -746,6 +746,15 @@ static int pick_commits(struct replay_insn_list *todo_list,
>  				opts->record_origin || opts->edit));
>  	read_and_refresh_cache(opts);
>  
> +	/*
> +	 * Backward compatibility hack: when only a single commit is
> +	 * picked, don't save_todo(), because CHERRY_PICK_HEAD will
> +	 * contain this information anyway.
> +	 */

How does saving disk space by avoiding saving redundant information
affect backward compatibility?  I'm not sure what this comment is
trying to say.

> +	if (opts->subcommand == REPLAY_NONE &&
> +		todo_list->next == NULL && todo_list->action == REPLAY_PICK)
> +		return do_pick_commit(todo_list->operand, REPLAY_PICK, opts);
> +
>  	for (cur = todo_list; cur; cur = cur->next) {
