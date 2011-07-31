From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 12/18] revert: Make pick_commits functionally act on a commit list
Date: Sun, 31 Jul 2011 22:52:50 +0200
Message-ID: <201107312252.50467.chriscool@tuxfamily.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com> <1311871951-3497-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 22:53:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnd0W-0008Lg-8a
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 22:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab1GaUxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 16:53:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45229 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab1GaUxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 16:53:00 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 83865A626F;
	Sun, 31 Jul 2011 22:52:52 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311871951-3497-13-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178275>

On Thursday 28 July 2011 18:52:25 Ramkumar Ramachandra wrote:
> @@ -743,16 +741,6 @@ static int pick_commits(struct replay_opts *opts)
>  				opts->record_origin || opts->edit));
>  	read_and_refresh_cache(opts);
> 
> -	walk_revs_populate_todo(&todo_list, opts);
> -	create_seq_dir();
> -	if (get_sha1("HEAD", sha1)) {
> -		if (opts->action == REVERT)
> -			die(_("Can't revert as initial commit"));
> -		die(_("Can't cherry-pick into empty head"));
> -	}
> -	save_head(sha1_to_hex(sha1));
> -	save_opts(opts);
> -
>  	for (cur = todo_list; cur; cur = cur->next) {
>  		save_todo(cur, opts);
>  		res = do_pick_commit(cur->item, opts);
> @@ -770,6 +758,27 @@ static int pick_commits(struct replay_opts *opts)
>  	return 0;
>  }
> 
> +static int pick_revisions(struct replay_opts *opts)
> +{
> +	struct commit_list *todo_list = NULL;
> +	unsigned char sha1[20];
> +
> +	read_and_refresh_cache(opts);
> +
> +	walk_revs_populate_todo(&todo_list, opts);
> +	create_seq_dir();
> +	if (get_sha1("HEAD", sha1)) {
> +		if (opts->action == REVERT)
> +			die(_("Can't revert as initial commit"));
> +		die(_("Can't cherry-pick into empty head"));
> +	} else

This "else" could be removed.

> +		save_head(sha1_to_hex(sha1));
> +	save_opts(opts);
> +	save_todo(todo_list, opts);

This save_todo() could be removed too as pick_commits() already does it.

> +	return pick_commits(todo_list, opts);
> +}

Thanks,
Christian.
