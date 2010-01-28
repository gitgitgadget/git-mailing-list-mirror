From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/2] filter-branch: Add tests for submodules in
 tree-filter
Date: Thu, 28 Jan 2010 13:57:16 -0800
Message-ID: <7vaavxlwoz.fsf@alter.siamese.dyndns.org>
References: <201001281002.03232.sojkam1@fel.cvut.cz>
 <1264669727-9977-2-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NacMu-0005XF-69
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab0A1V5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 16:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216Ab0A1V5c
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:57:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab0A1V5b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 16:57:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9663094A17;
	Thu, 28 Jan 2010 16:57:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q9WWvh4J3G1iegTCaJZD+VO4Z0s=; b=I7G5FY
	oWEsVV1Grb9uRHsPMU5MCE/Lo/CU7oc+rGhWx45Om5Q3SXjD9mehUUVio/P9V0FF
	PpVdKOZbOj7S1Sg5y69ufJlM/kDHWBsM8oWkxK4vDRXujvzyk3/2vwgzcGZvmYHU
	6N01B5CSOk/9osxgqoQbv62xaRSyK3xSG9k7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixBkXV4rF70u0qyjNkpRsJyVLMPrpJTZ
	ubz46hN7BX3zy8pD/12m/Ouj+o+wt9fw5LxFVqs3tx7RsDzqve6Tj+pD+BG5+7dY
	hiBs+3SkiPPGhePWERJwQWKmSULe9PWnsIpWnKdny3lyo8WawfhXL5YNltBF+WcF
	YOznr1ZLIWg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5171394A16;
	Thu, 28 Jan 2010 16:57:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FB5C94A12; Thu, 28 Jan
 2010 16:57:18 -0500 (EST)
In-Reply-To: <1264669727-9977-2-git-send-email-sojkam1@fel.cvut.cz> (Michal
 Sojka's message of "Thu\, 28 Jan 2010 10\:08\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DEB884C-0C58-11DF-9E4F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138276>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> @@ -306,4 +306,43 @@ test_expect_success '--remap-to-ancestor with filename filters' '
>  	test $orig_invariant = $(git rev-parse invariant)
>  '
>  
> +test_expect_success 'setup submodule' '
> +	rm -rf * .*

Yikes.  Please don't do this.

If you cannot structure your tests following what has already been done by
the previous tests, at least name the things that you want to remove a bit
more explicitly to avoid mistakes.  The loosest form that is reasonable
would probably be (to catch a, actual, backup-refs, ... and .git):

	rm -fr ?* .?* &&

but it would be preferable to be even more explicit "rm -fr ?* .git".

Also make sure you don't break the chain of "&&" unnecessarily.

> +	git init &&
> +	test_commit file &&
> +	mkdir submod &&
> +	submodurl="$PWD/submod"
> +	( cd submod &&
> +	  git init &&
> +	  test_commit file-in-submod ) &&
> +	git submodule add "$submodurl"

"&&"?
