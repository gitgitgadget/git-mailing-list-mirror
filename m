From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3][GSOC] fsck: use is_dot_or_dotdot() instead of strcmp()
Date: Mon, 17 Mar 2014 15:39:26 -0700
Message-ID: <xmqqtxawa1r5.fsf@gitster.dls.corp.google.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
	<1395091825-8330-3-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgCX-00077e-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaCQWj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:39:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbaCQWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 18:39:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995F3769C0;
	Mon, 17 Mar 2014 18:39:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCN2dhS30fzLoUts7+I8KVvY71g=; b=SCvbtq
	zJU9jtq/6L+7Bel6dUIBu3LaUeg+pCDzpNycANHLYMbmdRrCRw8qlw9WoBV5Fyxi
	hjXCQz5lomYmdWs7uyDlImzCYIpX5x4mJr2yEXz3veTdqBSFOButsG6P/4FIeJXB
	4cCCwbqB3+Y3nQNu0tjPz8NS8L5J8ExfmCaSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=agCc8kPNtPzHPkT2xf37UvYFIIcWl9Q0
	cOfY5frUt1CVmjap9x94FNbDugHS+dqNNnd7bMGzjvqsB5ZuwMPGIOO/SnKKc3A3
	CEB1XEtcjb/Sv+BWGqhmdLjdwUCPoNPQbEjofUt+v48eP5YQ61Hu+9pFMc87UyM1
	QoPQTEWSgzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829E7769BF;
	Mon, 17 Mar 2014 18:39:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8238576996;
	Mon, 17 Mar 2014 18:39:28 -0400 (EDT)
In-Reply-To: <1395091825-8330-3-git-send-email-sh19910711@gmail.com> (Hiroyuki
	Sano's message of "Tue, 18 Mar 2014 06:30:25 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFD46BEE-AE24-11E3-84EE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244303>

Hiroyuki Sano <sh19910711@gmail.com> writes:

> The is_dot_or_dotdot() is used to check if the string is either "." or "..".
>
> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  fsck.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index b3022ad..c9d7784 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -6,6 +6,7 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "fsck.h"
> +#include "dir.h"
>  
>  static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>  {
> @@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  			has_full_path = 1;
>  		if (!*name)
>  			has_empty_name = 1;
> -		if (!strcmp(name, "."))
> -			has_dot = 1;
> -		if (!strcmp(name, ".."))
> -			has_dotdot = 1;
> +		if (is_dot_or_dotdot(name)) {
> +			if (!name[1])
> +				has_dot = 1;
> +			else
> +				has_dotdot = 1;
> +		}

In what way is this an improvement?

This looks like "because I was told to", not "because the resulting
code is better" to me.

The other patch on diff-no-index looked sensible, though.



>  		if (!strcmp(name, ".git"))
>  			has_dotgit = 1;
>  		has_zero_pad |= *(char *)desc.buffer == '0';
