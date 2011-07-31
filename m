From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 13/18] revert: Introduce --reset to remove sequencer state
Date: Sun, 31 Jul 2011 16:01:42 +0200
Message-ID: <201107311601.43472.chriscool@tuxfamily.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com> <1311871951-3497-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 16:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWad-00032i-O5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 16:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab1GaOBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 10:01:55 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54697 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab1GaOBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 10:01:53 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1DBFBA6257;
	Sun, 31 Jul 2011 16:01:44 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311871951-3497-14-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178259>

On Thursday 28 July 2011 18:52:26 Ramkumar Ramachandra wrote:
>
> @@ -765,17 +784,21 @@ static int pick_revisions(struct replay_opts *opts)
> 
>  	read_and_refresh_cache(opts);
> 
> -	walk_revs_populate_todo(&todo_list, opts);
> -	create_seq_dir();
> -	if (get_sha1("HEAD", sha1)) {
> -		if (opts->action == REVERT)
> -			die(_("Can't revert as initial commit"));
> -		die(_("Can't cherry-pick into empty head"));
> -	} else
> +	if (opts->subcommand == REPLAY_RESET) {
> +		remove_sequencer_state(1);
> +		return 0;
> +	} else {

Maybe you could remove this "else" so that the indentation level is reduced. 

> +		/* Start a new cherry-pick/ revert sequence */
> +		walk_revs_populate_todo(&todo_list, opts);
> +		create_seq_dir();
> +		if (get_sha1("HEAD", sha1)) {
> +			if (opts->action == REVERT)
> +				die(_("Can't revert as initial commit"));
> +			die(_("Can't cherry-pick into empty head"));
> +		}
>  		save_head(sha1_to_hex(sha1));
> -	save_opts(opts);
> -	save_todo(todo_list, opts);

It looks like this save_todo() was not necessary in the first place because 
pick_commits() does a save_todo() before processing each commit.

> -
> +		save_opts(opts);
> +	}
>  	return pick_commits(todo_list, opts);
>  }
