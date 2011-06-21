From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/13] revert: Persist data for continuation
Date: Tue, 21 Jun 2011 12:11:39 -0500
Message-ID: <20110621171139.GO15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4UR-0005EM-MU
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167Ab1FURLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:11:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33884 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075Ab1FURLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:11:45 -0400
Received: by iyb12 with SMTP id 12so3016207iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=k0fWruACu+aUHXpLupXFR9UNvuGCkCH+IRP5HfQNULQ=;
        b=a5qrMXKBfWhF5BtIuOb4BG6+JTMOKX2Znu+uDNUPU+XurXfgl+B/IxDA5rQ7+fA2TS
         zRwfNPe/18L24JT0zbzactVa41oMcUCkviO/SltZqD1/DfqHSqBZ5e0cMCcQJgB20i93
         8dGMLAB1GoC7hNwzDV4us0bhoHv7VKoFnpJNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AZyLAcOAX5JWJzcFFLIhLfgeElF+FVWF04/9SOI5lC13cgqMrLw2UzqPx0ERFDjJFc
         x7JENY5FWzETTJFZvYi60vBMggut9AXHBjQfBXsC83B+gsibtBbmsZlv0v6sPnNdPDne
         4NeqzaxXanOVB4cOvyYqY7H9ptHKEVxPYp6u0=
Received: by 10.42.139.68 with SMTP id f4mr7837956icu.179.1308676304279;
        Tue, 21 Jun 2011 10:11:44 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id x13sm3889867ibh.67.2011.06.21.10.11.42
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 10:11:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-11-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176174>

Ramkumar Ramachandra wrote:

> Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
> one commit, 2010-06-02), a single invocation of "git cherry-pick" or
> "git revert" can perform picks of several individual commits.  To
> implement features like "--continue" to continue the whole operation,
> we will need to store some information about the state and the plan at
> the beginning.  Introduce a ".git/sequencer/head" file to store this
> state, and ".git/sequencer/todo" file to store the plan.

Makes a lot of sense.

> Don't touch
> CHERRY_PICK_HEAD -- it will still be useful when a conflict is
> encountered.

I think there's some logical connector or something missing.  Why would
introducing a .git/sequencer dir involve touching CHERRY_PICK_HEAD?

Maybe the idea is to say: "The purpose of these new files is orthogonal
to the existing CHERRY_PICK_HEAD" with some explanation of that.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -13,6 +13,7 @@
>  #include "rerere.h"
>  #include "merge-recursive.h"
>  #include "refs.h"
> +#include "dir.h"
>  
>  /*
>   * This implements the builtins revert and cherry-pick.
> @@ -25,6 +26,10 @@
>   * Copyright (c) 2005 Junio C Hamano
>   */
>  
> +#define SEQ_DIR		git_path("sequencer")
> +#define HEAD_FILE	git_path("sequencer/head")
> +#define TODO_FILE	git_path("sequencer/todo")

I've failed to convince you in the past that these fake constants are
scary, but believe me, they really are.  Consider the following code
--- what would you expect it to print?  What does it actually print?
(Hint: there's not one right answer.)

	printf("%s %s %s %s %s\n", SEQ_DIR, HEAD_FILE, TODO_FILE,
					SEQ_DIR, HEAD_FILE);

> +static void walk_revs_populate_todo(struct commit_list **todo_list,
> +				struct replay_opts *opts)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> +	struct commit_list *new_item;
> +	struct commit_list *cur = NULL;
> +
> +	/* Insert into todo_list in the same order */
> +	prepare_revs(&revs, opts);
> +	while ((commit = get_revision(&revs))) {
> +		new_item = xmalloc(sizeof(struct commit_list));
> +		new_item->item = commit;
> +		if (cur)
> +			cur->next = new_item;
> +		else
> +			*todo_list = new_item;
> +		cur = new_item;
> +	}
> +	cur->next = NULL;

The naive reader, perhaps stupidly, wonders: "why not use
commit_list_insert"?  A comment or something to explain "NEEDSWORK:
expose this as commit_list_append" could help him.

[...]
> -	return 0;
> +	/* Sequence of picks finished successfully; cleanup by
> +	   removing the .git/sequencer directory */
> +	return cleanup_sequencer_data();

GNU-style comment seems to have snuck in.

Thanks; this one was pretty pleasant.
