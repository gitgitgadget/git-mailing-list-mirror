From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Sat, 11 Feb 2012 00:06:56 -0800
Message-ID: <7vpqdln68v.fsf@alter.siamese.dyndns.org>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, krh@redhat.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 09:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7zi-00022f-I9
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 09:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab2BKIG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 03:06:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab2BKIG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 03:06:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6715E42FD;
	Sat, 11 Feb 2012 03:06:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Z9M3bCLrEQfNzNEcrAKPBRsBmc=; b=kgPrn8
	/QYsAaVvj7U2uxUCJPTvLdjqgrvbUcy1u2s9yXE8KTE0msREmwWBwrPEC9fkfS+T
	Y+1shtLdoVJbGKjfPve3Xl9t5cEQEr40fBSYto6zwCnQnojGanas+3irDBYdOM8k
	BnUkDya10W7oqKlTZuUePdIZoz9uh1S2+GqiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1+VR94lbInJpxlO9gK2DgiyPcCG5P+E
	cXv+fkFQTJ5BP+z28wSj/tl5MmmZ3dRO0gp5UJWGUyovkqLTc76/o+L+Bn9AwGDK
	Tl6byxegGj1msiTftRy/oY41uj9oJ+babm6R+MIGi0aRgRSpXMsIUnhadQI/5WqB
	QB5Ncm7QaiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD7942FC;
	Sat, 11 Feb 2012 03:06:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E677C42FB; Sat, 11 Feb 2012
 03:06:57 -0500 (EST)
In-Reply-To: <1328926618-17167-2-git-send-email-tmgrennan@gmail.com> (Tom
 Grennan's message of "Fri, 10 Feb 2012 18:16:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E70359C-5487-11E1-A48F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190500>

Tom Grennan <tmgrennan@gmail.com> writes:

> +int refname_match_patterns(const char **patterns, const char *refname)
> +{
> +	int given_match_pattern = 0, had_match = 0;
> +
> +	for (; *patterns; patterns++)
> +		if (**patterns != '!') {
> +			given_match_pattern = 1;
> +			if (!fnmatch(*patterns, refname, 0))
> +				had_match = 1;
> +		} else if (!fnmatch(*patterns+1, refname, 0))
> +			return 0;
> +	return given_match_pattern ? had_match : 1;
> +}

This, while its semantics seem sane, is highly inefficient when you have
many patterns, and you will be calling this to filter dozens of refs.  And
it can trivially improved by first pre-parsing the pattern[] array.

 * If you know the patterns do not have any negative entry, you can return
   true upon seeing the first match. Because you do not pre-parse the
   pattern[] array, this loop does not know if there is any negative one,
   and has to scan it always all the way.

 * If you arrange the pattern[] array so that it has negative ones early,
   again, you can return false upon seeing the first hit with a negative
   one. If your input has negative ones at the end, the loop ends up
   scanning all the way, noting the positive matches, only to discard upon
   seeing the negative match at the end.

That is why I said Nguyen's idea of reusing pathspec matching logic
somewhat attractive, even though I think it has downsides (the exact
matching logic for pathspec is more similar to that of for-each-ref
and very different from branch/tag).
