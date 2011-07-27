From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/18] revert: Introduce --reset to remove sequencer state
Date: Wed, 27 Jul 2011 07:11:15 +0200
Message-ID: <20110727051115.GI18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-15-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlwP6-0005K2-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab1G0FL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:11:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61703 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab1G0FL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:11:26 -0400
Received: by ewy4 with SMTP id 4so1041832ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/fI8eSIanbqrFgbJ5CRGkWoQWTntmMSpQ/gRWQjt6Ms=;
        b=uyU0BMDtsC2BKsclkHe+xpep5JApc87UPBfTFYFC36RJrezmF1FzRKcJ7Aev2FB19/
         Hj7QxFPHB1XWV+pZcTG5QgTg0sHwqUdUyeHibKLs2dP50jQhds+/yT9h9c3k8Cblgbfk
         /kq5QQeP0xHffhwd+Wz21a2fAFkKVCSjYM1m0=
Received: by 10.14.43.12 with SMTP id k12mr2658677eeb.105.1311743484906;
        Tue, 26 Jul 2011 22:11:24 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id w9sm831030eej.19.2011.07.26.22.11.22
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 22:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-15-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177931>

Ramkumar Ramachandra wrote:

> --- /dev/null
> +++ b/Documentation/sequencer.txt
> @@ -0,0 +1,4 @@
> +--reset::
> +	Forget about the current operation in progress.  Can be used
> +	to clear the sequencer state after a failed cherry-pick or
> +	revert.

Probably worth mentioning that the index, HEAD, and worktree are left
alone.

> +++ b/builtin/revert.c
[...]
> @@ -886,17 +906,22 @@ static int pick_revisions(struct replay_opts *opts)
[...]
> +	if (opts->subcommand == REPLAY_RESET) {
> +		remove_sequencer_state(1);
> +		return 0;
> +	} else {
> +		/* Start a new cherry-pick/ revert sequence */

Can un-indent by dropping the "else":

	if (opts->subcommand == REPLAY_RESET) {
		...
		return 0;
	}

	/* Start a new cherry-pick or revert. */
	...

[...]
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -37,7 +37,7 @@ test_expect_success 'cherry-pick persists data on failure' '
>  	test_path_is_file .git/sequencer/head &&
>  	test_path_is_file .git/sequencer/todo &&
>  	test_path_is_file .git/sequencer/opts &&
> -	rm -rf .git/sequencer
> +	git cherry-pick --reset
>  '

This is not about this patch, but ideally the cleanup would come at
the beginning of the next test, so if one test fails it does not take
down all the tests that come after it.
