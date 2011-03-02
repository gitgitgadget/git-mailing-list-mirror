From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] merge-recursive: When we detect we can skip an
 update, actually skip it
Date: Wed, 02 Mar 2011 12:19:03 -0800
Message-ID: <7vwrkhb7ig.fsf@alter.siamese.dyndns.org>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
 <1298941732-19763-4-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 21:19:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PusW3-0003j1-47
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 21:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab1CBUTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 15:19:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab1CBUTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 15:19:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1D6B3B45;
	Wed,  2 Mar 2011 15:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Is6pTdshAP3igYFuk9/5d9Vj5DE=; b=B6oqVT
	IYqop8H/SYgK3F607QkLcMbSv8PHJ6Pp10p0/LtFMRNVoysxXcmtRxRScsOYrkVj
	iqpw9+2n37qQAG810BggysqfJY6M88iCCdGPF09X+KzKdKhEttTOgMj15eVneyZN
	j0Yu6ncdORzIIfdexls7nm3hOTJAdDQsMxYvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDcZZ59MFn8EEqxljT9hwZs0OvkShzeA
	O46TKdDWtL6OhWbp1N+E6ZOuERmafiausXaTsSKaDqK6BxoJCAuyYZu6ctixCOPC
	R9efnkxMX9jCX/ELhGty/m/4m0paUQ+K5G0p6Bj939YWU55AXJf+gN21WG7mD/8r
	PMQumokNyfU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 618073B42;
	Wed,  2 Mar 2011 15:20:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C96113B3E; Wed,  2 Mar 2011
 15:20:24 -0500 (EST)
In-Reply-To: <1298941732-19763-4-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Mon\, 28 Feb 2011 18\:08\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 858AF88E-450A-11E0-88B3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168338>

Elijah Newren <newren@gmail.com> writes:

> @@ -1274,9 +1275,13 @@ static int merge_content(struct merge_options *o,
>  	}
>  
>  	if (mfi.clean && !df_conflict_remains &&
> -	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
> +	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
> +	    lstat(path, &st) == 0) {
>  		output(o, 3, "Skipped %s (merged same as existing)", path);
> -	else
> +		add_cacheinfo(mfi.mode, mfi.sha, path,
> +			      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
> +		return mfi.clean;
> +	} else

Hmmmm.  During a merge, we allow files missing from the working tree as if
it is not modified from the index.  Changing the behaviour based on the
existence of the path on the filesystem does not feel quite right.

Even if we decide that regressing in that use case were acceptable, what
guarantees that the path that happens to be in the work tree has the same
contents as what the merge result should be?  IOW, shouldn't we be looking
at the original index, making sure that our side (stage #2) at the path
had a file there that matches the merge result mfi.{sha,mode}, instead of
looking at the working tree?
