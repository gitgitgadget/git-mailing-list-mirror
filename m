From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 46/67] write_loose_object: convert to strbuf
Date: Wed, 16 Sep 2015 14:27:57 -0700
Message-ID: <xmqq613aoy02.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160044.GT29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKFI-0005gh-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbIPV2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:28:00 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33683 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbbIPV17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:27:59 -0400
Received: by pacex6 with SMTP id ex6so220102347pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cbq2yfZZfjfGSsM35ksv+i+CpXo7siZFSJ0DeQV5218=;
        b=i754tRkCIEgFdaX06qo9rimJSpZVKDShK/XKOIeMYv0nIUiv7WZtNZxF3cqzafX622
         cZzAV7GMDGWft1JGF/Tv/0TOlnahbPiLzXwy6jv7ijGP8GAv+LS0SxQnx7plQup5jhiU
         K+OzHQ2KKVbyMkEC/U6KxjeI9CtfCor2RpBJ7er2cjSVvXu+PvZamJNdAxGlv+5XQevL
         qQnHnscdVfPBD345BmuMmLLcQHDHk5k+IarWX6O342OV6vPP9IrGwgSDSxq+9QanIS4d
         ZRxLuimxhSYnRbakfCk25BJwStf+dpMnFaP++vuZILQGlDbgD1uAOLN0cI4dizaYcyQN
         w/ew==
X-Received: by 10.66.175.7 with SMTP id bw7mr65855793pac.155.1442438879085;
        Wed, 16 Sep 2015 14:27:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id gw3sm29584761pbc.46.2015.09.16.14.27.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 14:27:58 -0700 (PDT)
In-Reply-To: <20150915160044.GT29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 12:00:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278070>

Jeff King <peff@peff.net> writes:

> -	memcpy(buffer, filename, dirlen);
> -	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
> -	fd = git_mkstemp_mode(buffer, 0444);
> +	strbuf_reset(tmp);
> +	strbuf_add(tmp, filename, dirlen);
> +	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
> +	fd = git_mkstemp_mode(tmp->buf, 0444);
>  	if (fd < 0 && dirlen && errno == ENOENT) {
> -		/* Make sure the directory exists */
> -		memcpy(buffer, filename, dirlen);
> -		buffer[dirlen-1] = 0;
> -		if (mkdir(buffer, 0777) && errno != EEXIST)
> +		/*
> +		 * Make sure the directory exists; note that mkstemp will have
> +		 * put a NUL in our buffer, so we have to rewrite the path,
> +		 * rather than just chomping the length.
> +		 */
> +		strbuf_reset(tmp);
> +		strbuf_add(tmp, filename, dirlen - 1);
> +		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
>  			return -1;

I had to read the patch three times before understanding what the
business with NUL in this comment is about.

The old code was doing the same thing, i.e. instead of attempting to
reuse the early part of buffer[] it copied the early part of
filename[] there again, exactly for the same reason, but it didn't
even explain why the copy was necessary.  Now the new code explains
why strbuf_setlen() is not used here pretty nicely.

An unsuccessful call to git_mkstemp_mode() would destroy the
template buffer by placing a NUL at the beginning of it (and I was
confused because I did not read the unwritten "at the beginning" in
"put a NUL in our buffer" above).

The patch looks good.  Thanks.
