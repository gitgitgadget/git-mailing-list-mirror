From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Sat, 5 Nov 2011 19:26:45 -0500
Message-ID: <20111106002645.GE27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqZl-00076r-B5
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab1KFA0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 20:26:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36340 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1KFA0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 20:26:54 -0400
Received: by iage36 with SMTP id e36so4234752iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QkYngY75WyJn047WTUgftg89hXkeVzPGW0KmM0pNwEs=;
        b=h54bjew0cQrCz+gO9dwO684SrOhuWVq3XW8NLsKW4QSDevGT3dz4up076nuo+BZMro
         xrujvlIT/5ffLRLf8KfbkIkX7Krm6PVb9nRcJwaXoLwSaM97gPEJVgl9O5LuZb6NM6bq
         +lCn1yVtfore97bi8jWRctpq6PN0n6JBpDDEM=
Received: by 10.42.155.74 with SMTP id t10mr30166482icw.49.1320539214237;
        Sat, 05 Nov 2011 17:26:54 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm30430435ibk.6.2011.11.05.17.26.53
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 17:26:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184886>

Ramkumar Ramachandra wrote:

> Later in the series, we will not write '.git/sequencer/todo' for a
> single commit cherry-pick, because 'CHERRY_PICK_HEAD' already contains
> this information.  So, stomp the sequencer state in create_seq_state()
> unless the todo file is present.

What problem does this solve?  How does it solve it?  What does it
mean to stomp?

The usual commit-message debugging strategy applies here: imagine you
are a BIOS clone manufacturer, and for legal reasons you are not
allowed to read this part of the git implementation embedded in the
standard BIOS.  However, you are allowed to read the commit message,
and if that message is clear enough, it will explain the purpose and
behavior of that code and you will be able to implement a compatible
implementation addressing the same problem without scratching your
head too much.

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -654,11 +654,15 @@ static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
>  
>  static int create_seq_dir(void)
>  {
> +	const char *todo_file = git_path(SEQ_TODO_FILE);
>  	const char *seq_dir = git_path(SEQ_DIR);

Scary idiom.

> -	if (file_exists(seq_dir))
> -		return error(_("%s already exists."), seq_dir);
> -	else if (mkdir(seq_dir, 0777) < 0)
> +	if (file_exists(todo_file))
> +		return error(_("%s already exists."), todo_file);
> +
> +	/* If todo_file doesn't exist, discard sequencer state */
> +	remove_sequencer_state(1);
> +	if (mkdir(seq_dir, 0777) < 0)
>  		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);

I guess this patch would make more sense after patch 4.
