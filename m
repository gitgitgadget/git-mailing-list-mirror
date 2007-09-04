From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 04 Sep 2007 10:52:44 -0700
Message-ID: <7v642qnwr7.fsf@gitster.siamese.dyndns.org>
References: <46DD6020.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScaA-0006SL-EY
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbXIDRww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXIDRww
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:52:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbXIDRwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:52:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B6FFF12E37F;
	Tue,  4 Sep 2007 13:53:08 -0400 (EDT)
In-Reply-To: <46DD6020.4050401@gmail.com> (Carlos Rica's message of "Tue, 04
	Sep 2007 15:39:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57628>

Carlos Rica <jasampler@gmail.com> writes:

> diff --git a/refs.c b/refs.c
> index 09a2c87..4fd5065 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1455,3 +1455,35 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_reflog("", fn, cb_data);
>  }
> +
> +int update_ref_or_die(const char *action, const char *refname,
> +				const unsigned char *sha1,
> +				const unsigned char *oldval, int flags)
> +{
> +	static struct ref_lock *lock;
> +	lock = lock_any_ref_for_update(refname, oldval, flags);
> +	if (!lock)
> +		die("Cannot lock the ref '%s'.", refname);
> +	if (write_ref_sha1(lock, sha1, action) < 0)
> +		die("Cannot update the ref '%s'.", refname);
> +	return 0;
> +}
> +
> +int update_ref_or_error(const char *action, const char *refname,
> +				const unsigned char *sha1,
> +				const unsigned char *oldval, int quiet)
> +{
> +	static struct ref_lock *lock;
> +	lock = lock_any_ref_for_update(refname, oldval, 0);
> +	if (!lock) {
> +		if (!quiet)
> +			error("Cannot lock the ref '%s'.", refname);
> +		return 1;
> +	}
> +	if (write_ref_sha1(lock, sha1, action) < 0) {
> +		if (!quiet)
> +			error("Cannot update the ref '%s'.", refname);
> +		return 1;
> +	}
> +	return 0;
> +}

This makes me wonder three things:

 - Why doesn't "or_error" side allow "flags" as "or_die" one?
   Could the 'quiet' option become part of "flags" perhaps?

 - They look quite similar.  Is it a good idea to refactor them
   further, or they are so small it does not matter?

 - Why isn't lock released with unlock_ref()?
