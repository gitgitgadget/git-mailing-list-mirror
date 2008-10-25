From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Fri, 24 Oct 2008 22:41:09 -0700
Message-ID: <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
References: <20081025004815.GA23851@coredump.intra.peff.net>
 <20081025005256.GD23903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 07:42:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtbvL-0001hd-3w
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 07:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYJYFli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 01:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYJYFli
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 01:41:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbYJYFlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 01:41:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CBF508F561;
	Sat, 25 Oct 2008 01:41:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8921F8F559; Sat, 25 Oct 2008 01:41:13 -0400 (EDT)
In-Reply-To: <20081025005256.GD23903@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 24 Oct 2008 20:52:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 962E05EE-A257-11DD-AD51-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99095>

Jeff King <peff@peff.net> writes:

> -static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
> +static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one,
> +		int try_textconv)
>  {
>  	const char *textconv;
>  
> @@ -304,7 +305,7 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
>  	else if (diff_populate_filespec(one, 0))
>  		return -1;
>  
> -	if ((textconv = get_textconv(one))) {
> +	if (try_textconv && (textconv = get_textconv(one))) {
>  		size_t size;
>  		mf->ptr = run_textconv(textconv, one, &size);
>  		if (!mf->ptr)
> @@ -1396,7 +1397,7 @@ static void builtin_diff(const char *name_a,
>  		}
>  	}

Isn't this function "fill_mmfile()" and its callers leaky as a sieve?

The original fill_mmfile() was to only borrow one->data and users of
mmfile_t never had to worry about freeing what's in mf->ptr (and freeing
them would have been actively wrong).

I am also somewhat worried about the performance impact of running
get_textconv() to the same filespec many times when no textconv is
defined, which is the normal case we should optimize for.  It appears that
diff_filespec_load_driver() is optimized for a wrong case (i.e. "we
already know this needs a custom driver and we know which one").

I am inclined to suggest reverting the whole series (including the ones
that are already in 'master') and start over from scratch, limiting the
run_textconv() to only inside diff.c::builtin_diff() (in the else {} block
where "Crazy xcl interfaces.." comment appears).
