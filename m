From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove useless temporary integer in builtin/push.c
Date: Mon, 02 Aug 2010 11:51:59 -0700
Message-ID: <7vocdklueo.fsf@alter.siamese.dyndns.org>
References: <201007300021.34061.trast@student.ethz.ch>
 <cover.1280580026.git.jaredhance@gmail.com>
 <70ee84752cb7db08c65c608a12ed321dd2c26830.1280580026.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og07S-0005VP-SX
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab0HBSwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:52:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0HBSwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C0A4C9685;
	Mon,  2 Aug 2010 14:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j4/SdsUJS6gUGPWmGeOW6ccS1NY=; b=Ldkv3/
	yW4qxR+Upv/ertYMRmM5In3yQFuw/sULNx+CCzRpvrqiSfD/DdgWxfC1oc0ayTdO
	oSqxj0/uxLS176v9FSJj6DFvGszIfuF8ZQEEV3yRWMquYReDfLvWsbwh/CFV5VL1
	rUrMqYgIGIeX5Y+6J1YbfSV9TirSxmH2OkvjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pgmikqcElkoOn6Gt2Irk0PbhcuucLYfu
	/UgZ68HIH70TQfmSdPxR1kDi0BWhZeNt9MeNLCKcEMFDct16EIjX33/5eYQJBLsy
	cAttxQBcFEXAmzW4ne5dIN4bnCg3CVoL92LOvFxVq9aRLKlif2x/eeKtpXJMXA5Q
	cqdTO0TGiMI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76188C9683;
	Mon,  2 Aug 2010 14:52:04 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E2DC9682; Mon,  2 Aug
 2010 14:52:01 -0400 (EDT)
In-Reply-To: <70ee84752cb7db08c65c608a12ed321dd2c26830.1280580026.git.jaredhance@gmail.com> (Jared Hance's message of "Sat\, 31 Jul 2010 08\:54\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0ACE758E-9E67-11DF-BC81-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152437>

Jared Hance <jaredhance@gmail.com> writes:

> Creating a variable nr here to use throughout the function only to change
> refspec_nr to nr at the end, having not used refspec_nr the entire time,
> is rather pointless. Instead, simply increment refspec_nr.

That is something a compiler can notice and optimize out, so it byitself
is not a good criteria to judge this change.  The real issue is if the use
of temporary makes the code easier to read or harder.

With the two patches squashed together to use ALLOC_GROW(), the result
conforms to the pattern many codepaths use, and that makes it easier to
read.

Will queue, with these two squashed into one commit.

Thanks.

> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---
>  builtin/push.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f4358b9..79d8192 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -25,10 +25,9 @@ static int refspec_nr;
>  
>  static void add_refspec(const char *ref)
>  {
> -	int nr = refspec_nr + 1;
> -	refspec = xrealloc(refspec, nr * sizeof(char *));
> -	refspec[nr-1] = ref;
> -	refspec_nr = nr;
> +	refspec_nr++;
> +	refspec = xrealloc(refspec, refspec_nr * sizeof(char *));
> +	refspec[refspec_nr-1] = ref;
>  }
>  
>  static void set_refspecs(const char **refs, int nr)
> -- 
> 1.7.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
