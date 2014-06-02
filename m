From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Mon, 02 Jun 2014 14:21:48 -0700
Message-ID: <xmqq4n033t3n.fsf@gitster.dls.corp.google.com>
References: <1401732941-6498-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, sunshine@sunshineco.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:22:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZg7-0002VX-6q
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaFBVVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:21:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59255 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300AbaFBVVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:21:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C09781D08B;
	Mon,  2 Jun 2014 17:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9TyEEDj4+7CXeQ2AT/ZwOriawFU=; b=dayK7o
	FklbqqXku/c9hc9nGfZ5shPeyiNHpq1sI408Pl9m9cjmrjEYoB7Q2HBrrynyl/mm
	Cc0PiorFOPK3dDuA5DlMOegOqxzW8KrlgCwGwziNZkPteJjU9/53ix3nTLFv6/xU
	iAFCHwj5YE5s/i65ExdqF2CvWwZynL2cMGwWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSi1J909VV5UYDWojtGeOi1S2fPWgRXE
	3oK0sLIdYtcyQEnTLEajfxqtY52ehT9gVsBDgdoAyRLahveMuu585cIZZiOmfg1t
	n+RB1aXOOBu314Y/BdB+yQasq4McXaZ2RcK48/N+mnrCUHVXUU528n1U3moA9lHa
	Ta8awt7OSoE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B729D1D08A;
	Mon,  2 Jun 2014 17:21:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 146FE1D081;
	Mon,  2 Jun 2014 17:21:50 -0400 (EDT)
In-Reply-To: <1401732941-6498-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 2 Jun 2014 11:15:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8FCC034-EA9B-11E3-AAAC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250596>

Ronnie Sahlberg <sahlberg@google.com> writes:

> read_ref_at has its own parsing of the reflog file for no really good reason
> so lets change this to use the existing reflog iterators. This removes one
> instance where we manually unmarshall the reflog file format.
>
> Log messages for errors are changed slightly. We no longer print the file
> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
> This might be a minor useability regression, but I don't really think so, since
> experienced users would know where the log is anyway and inexperienced users
> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>
> Adapt the t1400 test to handle the change in log messages.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c                | 202 ++++++++++++++++++++++++++------------------------
>  t/t1400-update-ref.sh |   4 +-
>  2 files changed, 107 insertions(+), 99 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 6898263..b45bb2f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2936,109 +2936,117 @@ static char *ref_msg(const char *line, const char *endp)
>  	return xmemdupz(line, ep - line);
>  }

If I am not mistaken, this function will become unused with this
rewrite.  Let's drop it and justify it in the log message.

> +struct read_ref_at_cb {
> +	const char *refname;
> +	unsigned long at_time;
> +	int cnt;
> +	int reccnt;
> +	unsigned char *sha1;
> +	int found_it;
> +
> +	char osha1[20];
> +	char nsha1[20];

These should be unsigned char, shouldn't they?

> +	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
> +
> +	if (!cb.reccnt)
> +		die("Log for %s is empty.", refname);
> +	if (cb.found_it)
> +		return 0;
> +
> +	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);

Hmph.

We have already scanned the same reflog in the backward direction in
full.  Do we need to make another call just to pick up the entry at
the beginning?  Is this because the callback is not told that it is
fed the last entry (in other words, if there is some clue that this
is the last call from for-each-reflog-ent-reverse to the callback,
the callback could record the value it received in its cb-data)?
