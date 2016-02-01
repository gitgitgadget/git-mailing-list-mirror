From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Mon, 01 Feb 2016 13:30:01 -0800
Message-ID: <xmqqlh74unja.fsf@gitster.mtv.corp.google.com>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB03.3020000@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:30:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQM33-0002Rx-Uv
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbcBAVaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:30:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcBAVaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:30:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB7FD41203;
	Mon,  1 Feb 2016 16:30:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDh0QZPZGSz+Iz1zPD/gkY5YauU=; b=lwhpbF
	BPcjgd108yqMpFgKMqQozbQhAb0JUEkcCLj5fX79j3V1dLzxWARkv9KMn9NAmKUS
	ikvgD2F3FhJJf92KRuKQCt9AskxyS5upsqSG87X9R0XsxrvEhBxTCTAP4NMtggaf
	OD1F3L2wB+BnPzdjNSYxBI9VszWj8x4VXo8LI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ASQHc6DKpZBS54cKQaTdr20dFfwx2UJr
	afTl1PYwG78afqDul7efJRE5cF/krx/zV+/wyXX8cn+vITU6QsDZRcs+VLxoh+pl
	0wpetUPrv0XNZA2sTE2HT7KfRutA9cx4VH2XkDoPRrjhO7eMRvjz5v4yVKICQMyz
	ZDIPJxgQMLw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C688941200;
	Mon,  1 Feb 2016 16:30:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 368D9411FB;
	Mon,  1 Feb 2016 16:30:04 -0500 (EST)
In-Reply-To: <56ACFB03.3020000@moritzneeb.de> (Moritz Neeb's message of "Sat,
	30 Jan 2016 19:03:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F516E27C-C92A-11E5-8954-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285214>

Moritz Neeb <lists@moritzneeb.de> writes:

>     The lines read from BISECT_NAMES are trimmed with strbuf_trim()
>     immediately. There is thus no logic expecting CR, so
>     strbuf_getline_lf() can be replaced by its CRLF counterpart.

We do not indent the whole log message.

You would also want to think about the necessity of strbuf_trim()
here.  Now strbuf_getline() would trim the trailing CR, would we
still need to call strbuf_trim() here?  The code will break if you
just remove the call, but on the other hand, you will realize that
the trimming done by calling it is excessive and unnecessary, once
you inspect the code and learn who writes the file being read here
and how.

> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
>  bisect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.c b/bisect.c
> index 06ec54e..bf7c885 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -440,7 +440,7 @@ static void read_bisect_paths(struct argv_array *array)
>  	if (!fp)
>  		die_errno("Could not open file '%s'", filename);
>  -	while (strbuf_getline_lf(&str, fp) != EOF) {
> +	while (strbuf_getline(&str, fp) != EOF) {
>  		strbuf_trim(&str);
>  		if (sq_dequote_to_argv_array(str.buf, array))
>  			die("Badly quoted content in file '%s': %s",
