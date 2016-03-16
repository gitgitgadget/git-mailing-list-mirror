From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 21:46:53 -0700
Message-ID: <xmqqzitz58si.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CA+55aFw8roOTTuFknzh3zRkCbgaMGmtxMRk-ctBdJ8Wsu041bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 05:47:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag3ML-0001hW-RW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 05:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933343AbcCPEq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 00:46:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbcCPEq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 00:46:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EED9545226;
	Wed, 16 Mar 2016 00:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F2sjLbj2/iEYrZXRir4rH7gsz3k=; b=Plpu/G
	MAd/ute6f8n/nrD4Xex42LL8XTPcv1lu35Rn39pebLFeoKDlUHB9hkK/noW4ssus
	t5IhDk2uNTNtIquk1uI1tk3zkUL87EfcUvcrZbTigl8hZPPgYh0R9jZO/LTt9Nuq
	PS9MZXfTbL69IshnHchNmPrzaAiMcZRD/k7iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sE5VNcpH0lTl28lHaLfrNR0Yvooqh1Mn
	/wLMsfkMdzzosJLqMlCi8auOV+o3zoMfCN4toG0tP9ytdVHFmVFyr1NmCWc56tX7
	AUMx4OXu3tPS40xR3O+LagpDmQup1+enBhm/8F1rt1rZqaYybg1LdVelDrcRjkaC
	kzHnF8F2v44=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5FB345225;
	Wed, 16 Mar 2016 00:46:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67FF945224;
	Wed, 16 Mar 2016 00:46:54 -0400 (EDT)
In-Reply-To: <CA+55aFw8roOTTuFknzh3zRkCbgaMGmtxMRk-ctBdJ8Wsu041bA@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 15 Mar 2016 21:05:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B5940D2-EB32-11E5-8333-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288944>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's a first try at it. It does tab expansion only for the cases
> that indent the commit message, so for things like "pretty=email" it
> makes no difference at all.

It also ignores that byte counts of non-HT bytes may not necessarily
match display columns.  There is utf8_width() function exported from
utf8.c for that purpose.

I think it is fine to make it default for the pretty=medium, but it
would be nicer to introduce a new command line option --no-untabify
to optionally disable the expansion.

>  pretty.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/pretty.c b/pretty.c
> index 92b2870a7eab..dcd6105d1eb2 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1652,8 +1652,26 @@ void pp_remainder(struct pretty_print_context *pp,
>  		first = 0;
>  
>  		strbuf_grow(sb, linelen + indent + 20);
> -		if (indent)
> +		if (indent) {
> +			int i, last = 0, pos = 0;
> +
>  			strbuf_addchars(sb, ' ', indent);
> +			for (i = 0; i < linelen; i++) {
> +				int expand;
> +				if (line[i] != '\t')
> +					continue;
> +				strbuf_add(sb, line+last, i-last);
> +				pos += i-last;
> +				expand = (pos + 8) & ~7;
> +				strbuf_addchars(sb, ' ', expand - pos);
> +				pos = expand;
> +				last = i+1;
> +			}
> +
> +			// Handle the tail non-tab content
> +			line += last;
> +			linelen -= last;
> +		}
>  		strbuf_add(sb, line, linelen);
>  		strbuf_addch(sb, '\n');
>  	}
