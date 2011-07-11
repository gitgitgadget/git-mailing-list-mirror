From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/17] revert: Remove sequencer state when no commits are
 pending
Date: Mon, 11 Jul 2011 12:58:16 -0700
Message-ID: <7vvcv8bjmf.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-16-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNtH-0003PZ-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490Ab1GKVTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:19:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab1GKVTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:19:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E8B869F1;
	Mon, 11 Jul 2011 17:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=BRm2kWSipwYurx+e19+Wm3HLsS0=; b=HYuCDOaFdv+5DVZIuMC/
	AgJTS/pB1NsYTmKZld7CokbMZ6uITD2XVzLJoQxvt0j0lE1iErRjwHDbTwEaQv5Q
	KPASdqFNidZyVUrPBjrnXIaUbKTTcJlai4AZ9PyIqtSm7tGvJM7GqvFc0b8bZfqj
	YiWuqBLo5n7dtTLzNJNV3xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Iw3sB+sSvfOpXfcGpiSsnVoFgcnflqSeZG3Nj1SHcBcSDT
	sePwIGh46L+UKHkAlzc+MPekNUbLlnuXJrOub9RcOnoWfNqVVIFPrHSGiyVDAi93
	XIcETcC04CnkKaNJbf8rCrqfVAmlGEZXJWMGsf54S59utBkTT/SXmT0doYxr4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9657869F0;
	Mon, 11 Jul 2011 17:19:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E00E669EF; Mon, 11 Jul 2011
 17:19:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B93C47C-AC03-11E0-9D2F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176895>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index f9f5e3a..3936516 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -990,8 +990,18 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  	for (cur = todo_list; cur; cur = cur->next) {
>  		save_todo(cur, opts);
>  		res = do_pick_commit(cur->item, opts);
> -		if (res)
> +		if (res) {
> +			if (!cur->next)
> +				/*
> +				 * An error was encountered while
> +				 * picking the last commit; the
> +				 * sequencer state is useless now --
> +				 * the user simply needs to resolve
> +				 * the conflict and commit
> +				 */
> +				remove_sequencer_state();
>  			return res;
> +		}
>  	}

It may be useless for --continue, but wouldn't --abort need some clue on
what you were doing?
