From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Fri, 04 Dec 2015 12:05:52 -0800
Message-ID: <xmqqlh9arnbz.fsf@gitster.mtv.corp.google.com>
References: <20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
	<CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
	<20151030210849.GA7149@sigill.intra.peff.net>
	<CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
	<20151109155342.GB27224@sigill.intra.peff.net>
	<CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
	<20151110122501.GA14418@sigill.intra.peff.net>
	<xmqqpoymrql7.fsf@gitster.mtv.corp.google.com>
	<20151204190658.GA16692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:06:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4wcC-0004sv-V9
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 21:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbbLDUF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 15:05:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754671AbbLDUFy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 15:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C622530022;
	Fri,  4 Dec 2015 15:05:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iZ8SUSmfgbtEbgQc4gPQtsIG8uw=; b=VbFA0a
	5jrY+adGfz2K58AQYrC7JoZiUSTgs3haFF4D0jBn+v0ZcQ464bbsD0zPjLzJoAlg
	HyrdAQI7wDrZkCQCSPgi5UfLjtx9BUunzSEkPyaNGzWas2R3z1l640Pxri4m7uJz
	GFij2shJOKC7CdRuOLlZIeED0j3BSPJXQBWs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSUPQrCdjbrudk9U51cudgExWXa7saPu
	r/xBNMqBY99whKL/PWzy8lvaIFSpdcI0LgOVAKfPLxRSDnoKL4969cHzsPR3tH2Q
	ydPUsfxQGL/kxXXLpHethVCxIYpjVo4IUp7Jl9x25UGnDnB1zXRttw8MWHyWzuUn
	J8m97YbYl1Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE9E830021;
	Fri,  4 Dec 2015 15:05:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E56330020;
	Fri,  4 Dec 2015 15:05:53 -0500 (EST)
In-Reply-To: <20151204190658.GA16692@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Dec 2015 14:06:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C1A913A-9AC2-11E5-A52E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281998>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 04, 2015 at 10:55:32AM -0800, Junio C Hamano wrote:
>> 
>> I was puzzled that git_config_get_bool() is used here without even
>> checking if we are inside any Git repository and wondered if it was
>> correct....
>
> This probably _does_ trigger setup_git_env() when it was not otherwise
> called, and it will back to looking at ".git/config" for the repo-level
> config. That may fail to find the file if we are in a bare repository,
> or a subdirectory of the working tree. IOW, I suspect this:
>
>   git init --bare foo.git
>   cd foo.git
>   git config credential.helper cache
>   git config credentialcache.ignoreSIGHUP true ;# goes into local config
>   git fetch https://example.com/foo.git
>
> may fail to respect the ignoreSIGHUP option.
>
> I guess the solution would be to setup_git_director_gently() in the
> daemon process.

So I guess I did notice the right breakage ;-)

At least, this won't be a regression but "a new feature initially
shipped with a broken corner case", so a follow-up fix is welcome,
but not a big deal that I've already merged it to 'master'.

Thanks.
