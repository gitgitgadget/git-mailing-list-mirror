From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Wed, 24 Nov 2010 11:49:58 -0800
Message-ID: <7v1v6atsbd.fsf@alter.siamese.dyndns.org>
References: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
 <1290539473-2420-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 20:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLMD-0005NR-TS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 20:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308Ab0KXTuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 14:50:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab0KXTuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 14:50:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EB722454;
	Wed, 24 Nov 2010 14:50:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yncTQxeRtZgaUvLDJ+pRyhNPvrg=; b=mrRHZ9
	5Wh/Y2IH9frqlHgMGDCeDlIB9SlBMcmsC6l2hR4B2wXd9vrBwdlLsNrqE15Eq/Zl
	AGe2/bnb+AfYax0bGmIIYSQkMNCn6c3Dapxb4ZXsrdsB3q8b3He3WU/KOozRjKrg
	uJS+7Btrqzrf7I5ojRNj25mBAZAQJdfDxdZmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubWH6JZ299Yt0B+qeayou7R/5ZKH/TOB
	TV6lFuCTCPVMimE37TfihsvFhMDgE2259ubgtQ6V3LlfmdK0eM1RGWXhbapx6guz
	bPN3IZIC7FAwbXnQCKCI6iriYLsYEwJ7UeHexDmaLwYEEsixOjPaaZIbMqxmoTxe
	d94q52TBgfo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BF3A2451;
	Wed, 24 Nov 2010 14:50:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75B452450; Wed, 24 Nov 2010
 14:50:14 -0500 (EST)
In-Reply-To: <1290539473-2420-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue\, 23 Nov 2010 20\:11\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10C349DC-F804-11DF-B489-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162075>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> @@ -320,9 +321,16 @@ const char *help_unknown_cmd(const char *cmd)
>  	uniq(&main_cmds);
>  
>  	/* This reuses cmdname->len for similarity index */
> +	for (i = 0; i < main_cmds.cnt; ++i) {
> +		main_cmds.names[i]->len = 1 +
>  			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
> +		for (n = 0; n < ARRAY_SIZE(common_cmds); ++n) {
> +			if (!strcmp(main_cmds.names[i]->name,
> +			    common_cmds[n].name) &&
> +			    !prefixcmp(main_cmds.names[i]->name, cmd))
> +				main_cmds.names[i]->len = 0;
> +		}
> +	}

So main_cmds.names[]->len (which is not "len" anymore at this point but is
just a "score") gets levenshtein distance (i.e. a smaller number indicates
cmd is more likely to be a typo of it), and in addition ->len == 0 is "it
is prefix".  Overall, the smaller the score, the likelier the match.

> @@ -330,9 +338,12 @@ const char *help_unknown_cmd(const char *cmd)
>  	if (!main_cmds.cnt)
>  		die ("Uh oh. Your system reports no Git commands at all.");
>  
> -	best_similarity = main_cmds.names[0]->len;
> -	n = 1;
> -	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
> +	n = 0;
> +	do {
> +		best_similarity = main_cmds.names[n++]->len;
> +	} while (!best_similarity);

At this point, main_cmds.names[] is sorted by the above score (smaller to
larger), and first you skip all the "prefix" ones that score 0.

This relies on the fact that there is at least one entry with non-zero
score, which in practice is true, but without even a comment?  I feel
dirty.

The score of the first non-prefix entry is in best_similarity and that
entry is at main_cmds.names[n-1] at this point.  You haven't checked
main_cmds.names[n] yet...

> +	n++;

... but you increment n to skip that entry without even looking, and then
go on to ...

> +	while (n < main_cmds.cnt && best_similarity >= main_cmds.names[n]->len)
>  		++n;

You skip the entries with the same similarity as the closest typo,
presumably to point n to the first entry that is irrelevant (i.e. 0 thru n
but not including n are candidates).

Your rewrite of the loop makes it very hard to read and spot bugs, I
think.

>  	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
>  		const char *assumed = main_cmds.names[0]->name;
> -- 
> 1.7.3.2
