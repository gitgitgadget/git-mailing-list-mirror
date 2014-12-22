From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bad file descriptor on filtering empty files
Date: Mon, 22 Dec 2014 10:26:47 -0800
Message-ID: <xmqq7fxja6c8.fsf@gitster.dls.corp.google.com>
References: <87sigbmfd5.fsf@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, William Throwe <wtt6@cornell.edu>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 19:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37h0-0003jP-GC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbaLVS0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:26:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754355AbaLVS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:26:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D67F28DE5;
	Mon, 22 Dec 2014 13:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6AulhQk9194RdMjNLT/hgCoMVo=; b=AdM2So
	FQsI52q6AC+pJzVtkg74DHopKJN7phgVokbNNh3BtPhd/+MyO3nZ2pLHuppcDw1W
	5VXmMqdLWiG51WNm4KyTE+lEFWJYjfj5NgBoIXUjPZtGKqdV+YlSJ0IWZwtPtzAo
	vOeHmIx3abbK4xOSBp3fAscMp8KSBGCKN3PLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrYdCGtmF5BUVhKLNoIH0wxDwQokZezo
	uOFUSf0U3auuJJipdpbGXTePt2y8N0m72QW2ipg14oZI1ygSUdxZT/5vykyXU4ul
	LJMI8V5kafCSwy37LvvNyK+j8QfWMjX979J/jcknBMD8qKnMCsmAlc+4SZ/unWA/
	a3VIRnw9+sE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2436128DE4;
	Mon, 22 Dec 2014 13:26:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98F3928DE3;
	Mon, 22 Dec 2014 13:26:48 -0500 (EST)
In-Reply-To: <87sigbmfd5.fsf@cornell.edu> (William Throwe's message of "Fri,
	19 Dec 2014 17:41:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 177C5C60-8A08-11E4-970A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261664>

William Throwe <wtt6@cornell.edu> writes:

> In git 2.2.0 (also tested on 2.2.0.65.g9abc44b), if an external
> smudge/clean filter is called on an empty file git reports something
> like:
> error: copy-fd: read returned Bad file descriptor
> error: cannot feed the input to external filter cat
> error: external filter cat failed
>
> Test case:
>
> mkdir bug
> cd bug
> git init
> git config filter.cat.clean cat
> git config filter.cat.smudge cat
> echo '* filter=cat' >.gitattributes
> touch a
> git add a
>
>
> This started in 9035d75a2be9d80d82676504d69553245017f6d4, which
> introduced the possible call to copy_fd in code called from
> apply_filter.  It appears that NULL as the src argument to apply_filter
> is being used both as a sentinel value to indicate that the fd should be
> used instead and also as a representation of the contents of an empty
> file.  I suggest switching to using fd == -1 as the sentinel as shown in
> the patch below.
>
> Thanks,
> Will
>

William, thanks for raising this issue.

Steffen, comments?

> diff --git a/convert.c b/convert.c
> index 9a5612e..0509ac1 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -355,7 +355,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
>  
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> -	if (params->src) {
> +	if (params->fd == -1) {
>  		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
>  	} else {
>  		write_err = copy_fd(params->fd, child_process.in);
