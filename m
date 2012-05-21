From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] sequencer: fix leaked todo_list memory
Date: Mon, 21 May 2012 15:57:01 -0500
Message-ID: <20120521205701.GD28331@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.87598.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 21 22:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWZfL-0005el-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 22:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689Ab2EUU5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 16:57:14 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44119 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2EUU5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 16:57:12 -0400
Received: by ghrr11 with SMTP id r11so549190ghr.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GkX6SxhPl3laQSE+VtSWwg1feqPckI1ABVma5AlYkLA=;
        b=GXLBkm3IHPMKPArJ2D4HHue8L00iSKf6/cYJs1FkB7CqoLJu+pgS/hhk8Hz2Fogldo
         IGKAnOOXn7wDpiyFAMO9hZ6vLx7Vw43SQTujsRbKZlXOgLMvY08kg5Ghqyv9odX1tWU2
         HXu2SXlmbYdIsgus1m6X/8DJ9QP1MNH1mzruExcgthnlTfBAM2Xkw4+mjif6xUWVfXK/
         XCpqHBa9dbrnqyYtRF+M3/OknX5Y5FrTYOf4OBGAKH7/KzFWw9YNSIugiEB/gF4ARDPw
         vM5bmhQkCkwSjkdDEBV4l4u8OtYPnzEkrKntx9LMnePUe99CGPcKHvk2SW50PdJYeRKL
         zXpQ==
Received: by 10.50.158.168 with SMTP id wv8mr7853577igb.11.1337633831585;
        Mon, 21 May 2012 13:57:11 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yg9sm8456371igb.15.2012.05.21.13.57.07
        (version=SSLv3 cipher=OTHER);
        Mon, 21 May 2012 13:57:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521145610.1911.87598.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198129>

Christian Couder wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -900,6 +900,7 @@ static int continue_single_pick(void)
>  static int sequencer_continue(struct replay_opts *opts)
>  {
>  	struct commit_list *todo_list = NULL;
> +	int res;
>  
>  	if (!file_exists(git_path(SEQ_TODO_FILE)))
>  		return continue_single_pick();
> @@ -915,8 +916,11 @@ static int sequencer_continue(struct replay_opts *opts)
>  	}
>  	if (index_differs_from("HEAD", 0))
>  		return error_dirty_index(opts);
> -	todo_list = todo_list->next;
> -	return pick_commits(todo_list, opts);
> +	res = pick_commits(todo_list->next, opts);
> +
> +	free_commit_list(todo_list);
> +	return res;
[...]
> @@ -929,6 +933,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
[same change there]

Makes sense.  This is a one-time allocation, but it is in a somewhat
public function and freeing saves human readers and automatic
debugging tools like valgrind some distraction.

Shouldn't the error paths do this too?

	walk_revs_populate_todo(&todo_list, opts);
	if (create_seq_dir())
		goto fail;
	if (get_sha1("HEAD", sha1)) {
		error(opts->action == REPLAY_REVERT ?
			_("Can't revert as initial commit") :
			_("Can't cherry-pick into empty head"));
		goto fail;
	}
	save_head(sha1_to_hex(sha1));
	save_opts(opts);
	result = pick_commits(todo_list, opts);

	free_commit_list(todo_list);
	return result;

fail:
	free_commit_list(todo_list);
	return -1;

It does add another O(n) to the running time.  Some impatient person
watching a long post-multipick pause might want to add an optional
SEQUENCER_FORGET_THE_MEMORY_WE_WILL_BE_DYING_SOON_ANYWAY flag
argument, but probably that should happen as a separate change.

So for what it's worth, I like this change as long as it is done
consistently (meaning "in all code paths that return from the
function, not just the success case").

Thanks.
Jonathan
