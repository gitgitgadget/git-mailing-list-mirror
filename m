From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 19:20:25 -0800
Message-ID: <7vy5ru5j7q.fsf@alter.siamese.dyndns.org>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch> <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 23 04:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0PEW-0005Pb-KU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 04:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab2BWDU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 22:20:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab2BWDU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 22:20:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFC56287;
	Wed, 22 Feb 2012 22:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5b/kv72KVmL4WSAwU4sCwTLXm20=; b=DFXJhN
	YNSqhOaNPXBUftTq5X7eLsm9uaUt1ywsv2SvTbITrfwfAKIsa9VxqYHv1jeKIF3V
	392UrgOil22znTC/gAczuwvHVuMygGGCX15O4xgwdDdFJPsX8ks3mLMRpGSl7mhA
	ZfClfAP1JaY4pwztvo+FtRyeRaLvs0zsKzsXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dWs7mi0wa/Y40L1ShRo5XmDh8boa/N1Y
	XPVcxCGF+wBjnv7glxExLqLskRtz8nMHXBzH/UYgyz/K+yVMwhmVH+3o4sHk12lL
	EgYpsYh9lk31RMLyYZCfqy5yo5KU9NlC0lLihAFrxrobvEYJ3pudSJZdPAcHV9VP
	UtLHcI8jwD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44C996285;
	Wed, 22 Feb 2012 22:20:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CACB76284; Wed, 22 Feb 2012
 22:20:26 -0500 (EST)
In-Reply-To: <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 22 Feb 2012 20:34:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54B160FE-5DCD-11E1-AD8B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191325>

Thomas Rast <trast@student.ethz.ch> writes:

> +# If "ridiculous" is at least 1004 chars, this traps a bug in old
> +# versions where the resulting 1025-char line (with --pretty=oneline)
> +# was longer than a 1024-char buffer
> +test_expect_success 'ridiculously long subject in boundary' '
> +
> +	: > file4 &&
> +	test_tick &&
> +	git add file4 &&
> +	printf "abcdefghijkl %s\n" $(seq 1 100) | git commit -F - &&
> +	test_commit fifth &&
> +	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
> +	git fetch long-subject-bundle.bdl &&
> +	sed -n "/^-/{p;q}" long-subject-bundle.bdl > boundary &&
> +	grep "^-$_x40 " boundary
> +
> +'

Hmm, aside from the use of seq J6t mentioned, I am not sure what this is
testing.

I thought the point is to make "--oneline" output produce a long line
whose 1024th character is '-' and make the fgets() based parser to mistake
it as the beginning of a line that records a boundary commit, but you do
not seem to have any '-' there.
