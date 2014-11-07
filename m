From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Fri, 07 Nov 2014 12:27:03 -0800
Message-ID: <xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.5660.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:27:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmq7o-00074e-PS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaKGU1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 15:27:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752557AbaKGU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:27:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 814331B6A9;
	Fri,  7 Nov 2014 15:27:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f22L0vp7tV0GXku3iAUWvw3trV8=; b=wAaSOE
	7UNKhNuIg/jjI91BrdqgkZCDM1bqaWs9pDdflVA+eUbEHKRihzuLBtLXdrRSxm9/
	c6ZFP5HlPaYHyVZifCbC+auH2Tllq5XCUBTyF6HTO4gfL6TAz84WupAEt4BHXVJv
	nypAD4Uvp9Y5p5fLcFrKSqubT3kQhX8saf1ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQKLvCaNfTa4wEvqwOIjZkBS/qeCZ021
	u46nSf+s444iSwbBe5zRs1Tt4koa0l5FeCK7Q0s/7Nvqr74IJpKu54eyqBhtCdk7
	d2F1u+OHj3G5rnORAqcN+4XWZLP8E3GSuE0cC00wkpzOqHUEoEpVfmtsGx+UCEuF
	+2wKtMO8V4c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74F181B6A8;
	Fri,  7 Nov 2014 15:27:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0D9C1B6A7;
	Fri,  7 Nov 2014 15:27:04 -0500 (EST)
In-Reply-To: <20141107185053.16854.5660.chriscool@tuxfamily.org> (Christian
	Couder's message of "Fri, 07 Nov 2014 19:50:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70125876-66BC-11E4-A8FD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <chriscool@tuxfamily.org> writes:

>   * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
> @@ -791,14 +792,24 @@ static int process_input_file(struct strbuf **lines,
>  			      struct trailer_item **in_tok_last)
>  {
>  	int count = 0;
> -	int patch_start, trailer_start, i;
> +	int trailer_start, trailer_end, patch_start, ignore_bytes, i;
> +	struct strbuf sb;
>  
>  	/* Get the line count */
>  	while (lines[count])
>  		count++;
>  
>  	patch_start = find_patch_start(lines, count);
> -	trailer_start = find_trailer_start(lines, patch_start);
> +
> +	/* Get the index of the end of the trailers */
> +	for (i = 0; i < patch_start; i++)
> +		strbuf_addbuf(&sb, lines[i]);
> +	ignore_bytes = ignore_non_trailer(&sb);
> +	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
> +		ignore_bytes -= lines[i]->len;
> +	trailer_end = i + 1;

Looks like there is an impedance mismatch between the caller and the
callee here.  I can sort of understand why you might want to have an
array of trailer items, one element per line in the trailer block,
as that would make it easier on your brain when you have to reorder
them, insert a new one or a remove an existing one, but you seem to
be keeping _everything_ in that format, an array of strbuf with one
strbuf per line, which sounds really wasteful.  The data structure
might need to be rethoughtbefore this code becomes ready for
production.

I would have expected it to be more like (1) slurp everything in a
single strbuf, (2) find the trailer block inside that single strbuf,
splitting what you read in the previous step into one strbuf for
stuff before the trailer block, another strbuf for stuff after the
trailer block and an array of lines in the tailer block, (3) do
whatever your trailer flipping logic inside that array without
having to worry about stuff before or after the trailer block and
then finally (4) spit the whole thing out by concatenating the stuff
before the trailer block, the stuff in the trailer block and the
stuff after the trailer block.

Oh well...
