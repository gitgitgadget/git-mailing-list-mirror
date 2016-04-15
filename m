From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/21] bisect: replace clear_distance() by unique markers
Date: Fri, 15 Apr 2016 15:07:09 -0700
Message-ID: <xmqqoa9a8r1u.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-13-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBtY-0001Q4-SW
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcDOWHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:07:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751789AbcDOWHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:07:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EDEC13353;
	Fri, 15 Apr 2016 18:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5h6R/0MwGbRKp18tQ3Y/0lKmjA=; b=IE8t8S
	eBV0P2BjCtKrsa5g3F7Kfs16QDRTMILvl8ocUU40JaEvivQj6HLk3tuiBf8MZvwh
	GHXPvZXbZcVY7/gskz5JFVDkqlWdVdQUZJGVmmWVlxVSVkXQDXkfMUzhEsU/j4Fe
	o8llkrWapvD7rmdG5AmkuGtn2bQLGtjLd2IyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C/hWMKnm3OMOTbBYF8NK8ZJKh9SJGwxx
	Ls2nKNcEWeX5r704JwbAzqRaO9EN8eVLFh/UjkidWKURbgHY4R/Q9kJVK+36bGNT
	Ow+dKuvO3FyYjWl+Uo94Rv3NvjbxoOv+8KUnlNRO7Ggp8mmXqXvAteUe/7bZHjrf
	bcb1i629/kE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5696513352;
	Fri, 15 Apr 2016 18:07:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B78431334C;
	Fri, 15 Apr 2016 18:07:10 -0400 (EDT)
In-Reply-To: <1460294354-7031-13-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66C5784C-0356-11E6-8762-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291676>

Stephan Beyer <s-beyer@gmx.net> writes:

> @@ -43,15 +43,17 @@ static int count_distance(struct commit_list *entry)
>  	int nr = 0;
>  	struct commit_list *todo = NULL;
>  	commit_list_append(entry->item, &todo);
> +	marker++;
>  
>  	while (todo) {
>  		struct commit *commit = pop_commit(&todo);
>  
> -		if (!(commit->object.flags & (UNINTERESTING | COUNTED))) {
> +		if (!(commit->object.flags & UNINTERESTING)
> +		 && node_data(commit)->marked != marker) {

Makes sense.

> @@ -123,10 +116,9 @@ static void show_list(const char *debug, int counted, int nr,
>  		const char *subject_start;
>  		int subject_len;
>  
> -		fprintf(stderr, "%c%c%c ",
> +		fprintf(stderr, "%c%c ",
>  			(flags & TREESAME) ? ' ' : 'T',
> -			(flags & UNINTERESTING) ? 'U' : ' ',
> -			(flags & COUNTED) ? 'C' : ' ');
> +			(flags & UNINTERESTING) ? 'U' : ' ');

As this one is for debugging, could we keep the output of 'C'
intact?

It is equivalent to

	commit->util && node_data(commit)->marked == marker ? 'C' : ' '

right?

This makes me wonder if node_data(commit) should return NULL instead
of asserting on commit->util in [11/21], by the way.  That would
make the above

	node_data(commit) && node_data(commit)->marked == marker
        ? 'C' : ' '

which may be easier to read.

Another small thing I overlooked in [11/21] is that the parameter to
node_data() helper should not be called "elem", which is typically
the name used to point at an element on a linked list structure such
as commit_list.  Call it "commit" instead, as that is typically the
way we call a single parameter/variable that appears in a function
that is "struct commit".
