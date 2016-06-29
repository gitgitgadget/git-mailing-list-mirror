Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470BE20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcF2WEB (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:04:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751547AbcF2WEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:04:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F1B28DDB;
	Wed, 29 Jun 2016 18:03:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v5zh9t3DF5XWMkHTtk/VTSwjAH8=; b=BCQJ7R
	v+fgy3G9XL9lXbjYdtFDPau2RH8NbgkQFnVoloSCPDIvDgGIXsZhZ+l5yqUMF022
	uR0cjWsguYajhtNtcyZVI1WLSiaIco51/sDSGGP8Oi0wGc2JuwhufHSuu29C8sfu
	hc/wi9v165MuPJA8jYwGHhNBw6Jajxh3Azq0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QdejcUx4A5jgx17XVlo/9gJLjHr5Z73j
	n0rsN3dD7oIP9BFeWUieQksOav2BU/TQjBsSAdecjxCQCzk8imq58X4ENXfsttpB
	KTbWj5GvpsTojJg5hsJAt+lnlu3I4cCPoMYhKmI5CYpNSiPKQROJV6GVckI41IL1
	0kOrhngw9XI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DF0C28DDA;
	Wed, 29 Jun 2016 18:03:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A444328DD9;
	Wed, 29 Jun 2016 18:03:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/5] sequencer: use skip_blank_lines() to find the commit subject
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
	<69bc831064331117141c7153dc72e9e658691155.1467209576.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 15:03:02 -0700
In-Reply-To: <69bc831064331117141c7153dc72e9e658691155.1467209576.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 16:14:46 +0200
	(CEST)")
Message-ID: <xmqqpoqz1wmh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4113563A-3E45-11E6-9F77-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Just like we already taught the find_commit_subject() function (to make
> it consistent with the code in pretty.c), we now simply skip leading
> blank lines of the commit message.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 7d7add6..cdfac82 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -544,10 +544,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		 * information followed by "\n\n".
>  		 */
>  		p = strstr(msg.message, "\n\n");
> -		if (p) {
> -			p += 2;
> -			strbuf_addstr(&msgbuf, p);
> -		}
> +		if (p)
> +			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
>  
>  		if (opts->record_origin) {
>  			if (!has_conforming_footer(&msgbuf, NULL, 0))

Here, msg.message was read in get_message() by calling
logmsg_reencode() that reads from get_commit_buffer().  The code
structure is exactly the same as the previous one.

Good.
