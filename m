From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 10:58:08 -0700
Message-ID: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <87hak74cse.fsf@pctrast.inf.ethz.ch> <87620n4clo.fsf@pctrast.inf.ethz.ch>
 <87obef2wut.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 18:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI0oO-0007yD-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 18:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933469Ab3CSR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 13:58:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933316Ab3CSR6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 13:58:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9593B028;
	Tue, 19 Mar 2013 13:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D6zgQeGBC2AVpqFoFmADZOWwgfA=; b=L8VA3W
	soNeTrWKDYIG1ZjM3FvE1IpK8rl7nQDsiiRG6GJ3U14b45MNqFFCE2wGcdLrzNtr
	3eL9ijdBgSmHIIxzvOyM27kIwFTyiYZWhbu99qA7A5ntoMi8fBBHhlRZGd9gNZxN
	KdRprkrJa5tjaGKW5IFSSr2OfXU5GEFAhpE3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ru5wY9JX4oDRxyWB6RbauhXQzQevGspw
	Lml8j9vKJht/zYo3XjP/xMVRWu5MW5mKCDM8CPswHBRc4T9AL2pvMHeHSlaCz6g/
	BG9bJUuJjjjmBuj+956CtQV2woRzvudj+nfJ8K3/spVpdeBq+h20tRNN2s1fSdTu
	emAOs2HmOA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD33AB027;
	Tue, 19 Mar 2013 13:58:10 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16394B025; Tue, 19 Mar 2013
 13:58:09 -0400 (EDT)
In-Reply-To: <87obef2wut.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Mar 2013 17:11:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F8B61A0-90BE-11E2-99A2-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218542>

Thomas Rast <trast@student.ethz.ch> writes:

> Actually scratch that again.  It *is* a stack overflow, except that this
> is a thread stack, for which the OS X defaults are 512kB apparently, as
> opposed to 2MB on linux.
> ...
> And indeed the following patch fixes it.  Sounds like the delta
> unpacking needs a rewrite to support stackless operation.  Sigh.

Yikes.  Thanks for digging it to the bottom.

I am not sure if I want to carry this patch in its current form,
though.  As this episode demonstrates, no default is good enough for
everybody, and I am not sure if a configuration variable is a good
way to go, either.

>
> diff --git i/builtin/index-pack.c w/builtin/index-pack.c
> index 6be99e2..f73291f 100644
> --- i/builtin/index-pack.c
> +++ w/builtin/index-pack.c
> @@ -1075,13 +1075,17 @@ static void resolve_deltas(void)
>  	nr_dispatched = 0;
>  	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
>  		init_thread();
> +		pthread_attr_t attr;
> +		pthread_attr_init(&attr);
> +		pthread_attr_setstacksize(&attr, 2*1024*1024);
>  		for (i = 0; i < nr_threads; i++) {
> -			int ret = pthread_create(&thread_data[i].thread, NULL,
> +			int ret = pthread_create(&thread_data[i].thread, &attr,
>  						 threaded_second_pass, thread_data + i);
>  			if (ret)
>  				die(_("unable to create thread: %s"),
>  				    strerror(ret));
>  		}
> +		pthread_attr_destroy(&attr);
>  		for (i = 0; i < nr_threads; i++)
>  			pthread_join(thread_data[i].thread, NULL);
>  		cleanup_thread();
