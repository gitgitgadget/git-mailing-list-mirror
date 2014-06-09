From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/15] use get_commit_buffer everywhere
Date: Mon, 09 Jun 2014 15:40:57 -0700
Message-ID: <xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181323.GL20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:41:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8FZ-0006Em-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbaFIWlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:41:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58652 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932412AbaFIWlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:41:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA1641E7CB;
	Mon,  9 Jun 2014 18:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NFAgd8qglNPn1bmkxD3lAz/WQUo=; b=i4v01Z
	JsMv3DeToJt9VdJZoN7ECCY45N1Ntc8rrwwv27cwr4wAM+1SNwUQF1HGG1JbS09e
	8HBsRegCm+3sN3GCYcrpTuq/XpyMHHPqTIsu7sBN2VC5tqoyPTt0U8AOJX0LPZeW
	Aj0w5U8xFySIrv+VJi8dg8qECVhc+lLegyqFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TzuNkf2HgVlBQnVOhROYmqdSU8OnQVkJ
	qdTneoo0ua9N27Bm1MwwT1l63iudsBVonK7B2p/iDEPGDEaNLhXUeBZ20wS+0LLv
	5MmVKKhL9xN7ZorhJ+VrN6NEEFHc6NEjX5bZjTvaEepxHiFYjWICyAc6CdhJVU/d
	AG+t8Zx/ZVc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF3121E7CA;
	Mon,  9 Jun 2014 18:41:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E53ED1E7C5;
	Mon,  9 Jun 2014 18:40:58 -0400 (EDT)
In-Reply-To: <20140609181323.GL20315@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 Jun 2014 14:13:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 206ABE3C-F027-11E3-9779-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251129>

Jeff King <peff@peff.net> writes:

> diff --git a/notes-merge.c b/notes-merge.c
> index 94a1a8a..7885ab2 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -671,7 +671,8 @@ int notes_merge_commit(struct notes_merge_options *o,
>  	DIR *dir;
>  	struct dirent *e;
>  	struct strbuf path = STRBUF_INIT;
> -	char *msg = strstr(partial_commit->buffer, "\n\n");
> +	const char *buffer = get_commit_buffer(partial_commit);
> +	const char *msg = strstr(buffer, "\n\n");

This tightening causes...

>  	struct strbuf sb_msg = STRBUF_INIT;
>  	int baselen;
>  
> @@ -720,6 +721,7 @@ int notes_merge_commit(struct notes_merge_options *o,
>  	}
>  
>  	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);

...a new error here:

notes-merge.c:723:2: error: passing argument 2 of 'strbuf_attach'
discards 'const' qualifier from pointer target type [-Werror]
strbuf.h:19:13: note: expected 'void *' but argument is of type
'const char *'
