From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] fast-{import,export}: use get_sha1_hex() directly
Date: Fri, 03 May 2013 14:50:15 -0700
Message-ID: <7vli7vybqg.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 23:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYNrz-00053Q-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763511Ab3ECVuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:50:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab3ECVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:50:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A28881BB91;
	Fri,  3 May 2013 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GDoqfchaOYOwdcRWbHwEL8It76Y=; b=ibb1C8
	emWoxr5F5ndmWUZF0NVUdkkL4i+L3GERNJ31uyamGZ3XNCjtXXHT6I/+5aoCu3Ar
	ATc4nqdkvJzy89FocRlXY8u+Bl66sYMt6It/c84jL46wbKv49YPuUrMqpsXodIQz
	W33ff4KMJnKr64Te/CdJfqsgfXI6Mla9AwcJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rw3R9ooXkRycBdIj0T+Xaofw3duREWDg
	AUMcgrjLDK1SPUhIuDQ1JE7a9Lu+AlHIUMLQappFpR3QnYuztItiPtrMywGxwLyB
	/Gz45tAwW0QqVXR3/Q3mHE59Wp+6TOpgXQmzn5k/8wABSvSaR6qj4aLHmDTy5m+r
	pdQzjuITcxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9904F1BB90;
	Fri,  3 May 2013 21:50:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3D491BB8F;
	Fri,  3 May 2013 21:50:16 +0000 (UTC)
In-Reply-To: <1367555502-4706-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 2 May 2013 23:31:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 712DD54E-B43B-11E2-9C9E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223324>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's no point in calling get_sha1() if we know they are SHA-1s.

If we know they _have to be_ 40-hex object names, calling get_sha1()
is not just pointless but outright wrong and these calls have to be
get_sha1_hex().

Looks like a good change to me.

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c |  2 +-
>  fast-import.c         | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d60d675..a4dee14 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -621,7 +621,7 @@ static void import_marks(char *input_file)
>  
>  		mark = strtoumax(line + 1, &mark_end, 10);
>  		if (!mark || mark_end == line + 1
> -			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
> +			|| *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
>  			die("corrupt mark line: %s", line);
>  
>  		if (last_idnum < mark)
> diff --git a/fast-import.c b/fast-import.c
> index 5f539d7..e02f212 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1822,7 +1822,7 @@ static void read_marks(void)
>  		*end = 0;
>  		mark = strtoumax(line + 1, &end, 10);
>  		if (!mark || end == line + 1
> -			|| *end != ' ' || get_sha1(end + 1, sha1))
> +			|| *end != ' ' || get_sha1_hex(end + 1, sha1))
>  			die("corrupt mark line: %s", line);
>  		e = find_object(sha1);
>  		if (!e) {
> @@ -2490,7 +2490,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
>  		if (commit_oe->type != OBJ_COMMIT)
>  			die("Mark :%" PRIuMAX " not a commit", commit_mark);
>  		hashcpy(commit_sha1, commit_oe->idx.sha1);
> -	} else if (!get_sha1(p, commit_sha1)) {
> +	} else if (!get_sha1_hex(p, commit_sha1)) {
>  		unsigned long size;
>  		char *buf = read_object_with_reference(commit_sha1,
>  			commit_type, &size, commit_sha1);
> @@ -2604,7 +2604,7 @@ static int parse_from(struct branch *b)
>  			free(buf);
>  		} else
>  			parse_from_existing(b);
> -	} else if (!get_sha1(from, b->sha1))
> +	} else if (!get_sha1_hex(from, b->sha1))
>  		parse_from_existing(b);
>  	else
>  		die("Invalid ref name or SHA1 expression: %s", from);
> @@ -2632,7 +2632,7 @@ static struct hash_list *parse_merge(unsigned int *count)
>  			if (oe->type != OBJ_COMMIT)
>  				die("Mark :%" PRIuMAX " not a commit", idnum);
>  			hashcpy(n->sha1, oe->idx.sha1);
> -		} else if (!get_sha1(from, n->sha1)) {
> +		} else if (!get_sha1_hex(from, n->sha1)) {
>  			unsigned long size;
>  			char *buf = read_object_with_reference(n->sha1,
>  				commit_type, &size, n->sha1);
> @@ -2792,7 +2792,7 @@ static void parse_new_tag(void)
>  		oe = find_mark(from_mark);
>  		type = oe->type;
>  		hashcpy(sha1, oe->idx.sha1);
> -	} else if (!get_sha1(from, sha1)) {
> +	} else if (!get_sha1_hex(from, sha1)) {
>  		struct object_entry *oe = find_object(sha1);
>  		if (!oe) {
>  			type = sha1_object_info(sha1, NULL);
