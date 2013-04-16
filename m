From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] run-command: use thread-aware die_is_recursing
 routine
Date: Tue, 16 Apr 2013 15:09:12 -0700
Message-ID: <7v4nf6jfg7.fsf@alter.siamese.dyndns.org>
References: <20130416194418.GA7187@sigill.intra.peff.net>
 <20130416195006.GB11185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brandon Casey <drafnel@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 00:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USE41-0007Sq-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405Ab3DPWJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 18:09:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965255Ab3DPWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 18:09:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41842172FF;
	Tue, 16 Apr 2013 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VSsZ86Xa7NUY3c/P0Nd1ChDbhJA=; b=gduwdA
	nySEPCYu6yU+g057KVes5bVJBdSYnvZ6k2/LOisUkB81R0XW702MR8rnT7U35eih
	HXw8nV2h+egJuup0AL5WX3MHG4uuSo75Pp6j1ipo2ZNLleQfU6YW2c6UpSglkfr3
	HMsNIdESdeU0ZJTqxTKNBdAXQOEXaGm5mCZnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZ9NA73VkJ/dW+jmmT0quS1Eaa1o0Jbo
	ZWDOVZADi3c3fH7T4BbfVFOmFWEaTyxanK/AHPSZu8sXchqUU7bWUgY+rPvHNPsP
	AuHwLv66S8WXTzme7H3tSSsRLqq6Cu/h7oH5gSzWenQLjmddfL+cDgx70bL40ZtK
	VaP2KIy7BPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34460172FE;
	Tue, 16 Apr 2013 22:09:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90F7A172FD; Tue, 16 Apr
 2013 22:09:13 +0000 (UTC)
In-Reply-To: <20130416195006.GB11185@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Apr 2013 15:50:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45A847EE-A6E2-11E2-811C-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221482>

Jeff King <peff@peff.net> writes:

> diff --git a/run-command.c b/run-command.c
> index 765c2ce..1b32a12 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -588,6 +588,7 @@ static pthread_key_t async_key;
>  static pthread_t main_thread;
>  static int main_thread_set;
>  static pthread_key_t async_key;
> +static pthread_key_t async_die_counter;
>  
>  static void *run_thread(void *data)
>  {
> @@ -614,6 +615,14 @@ static NORETURN void die_async(const char *err, va_list params)
>  
>  	exit(128);
>  }
> +
> +static int async_die_is_recursing(void)
> +{
> +	void *ret = pthread_getspecific(async_die_counter);
> +	pthread_setspecific(async_die_counter, (void *)1);
> +	return ret != NULL;
> +}
> +
>  #endif
>  
>  int start_async(struct async *async)
> @@ -695,7 +704,9 @@ int start_async(struct async *async)
>  		main_thread_set = 1;
>  		main_thread = pthread_self();
>  		pthread_key_create(&async_key, NULL);
> +		pthread_key_create(&async_die_counter, NULL);
>  		set_die_routine(die_async);
> +		set_die_is_recursing_routine(async_die_is_recursing);
>  	}
>  
>  	if (proc_in >= 0)

Will queue; thanks.
