From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Detailed diagnostic when parsing an object name
 fails.
Date: Mon, 30 Nov 2009 12:12:42 -0800
Message-ID: <7vtywbkc05.fsf@alter.siamese.dyndns.org>
References: <1259603421-10055-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFCcM-0000OG-VY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbZK3UMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 15:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbZK3UMy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:12:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZK3UMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 15:12:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4220F84DA7;
	Mon, 30 Nov 2009 15:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y2MVMUsILHjc4Rli0ETLXh7AQ64=; b=SkSpCT
	cCUINoiMml5egpIMx7nWnS6dlPL4sH7/BdMwnyh0T+eH6p9NfSZM+qhH9d5EUj5h
	LkFSArkuNzhGyOTy1O6If4CFfNQHIqHXjP+KWvkCe0RIEA+EO8qOyXj9MXovkStY
	lLXf03TO7tuITNTdOD61eS8bJAYD+wkG7qWWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZ2viOGqZQILX8kJHHp0VWPmVKf8K6DR
	zEViDa3TyGUMJ4BmD3TIK0ilTa3FKsJF4iI+b4wm0mzy1h0GoxiEznM5Vf/k625O
	A9KG3miwswJ3S5WCnE13xzlgDp2hz/IlXHlY9oZ0OqLDPdLlrh4mfs7bHuB2Jl3E
	QmxPwNNd+cw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5309484DA6;
	Mon, 30 Nov 2009 15:12:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1462884DA4; Mon, 30 Nov
 2009 15:12:43 -0500 (EST)
In-Reply-To: <1259603421-10055-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon\, 30 Nov 2009 18\:50\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC8C426A-DDEC-11DE-B739-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134136>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The original motivation is actually to anwser the FAQ of "git show
> HEAD:foo.txt" being relative to the root, while some users would
> expect it relative to $PWD but the patch ended up being far more
> general. At least, 
>
> $ cd git
> $ cd t
> $ ../git show HEAD:test-lib.sh 
> fatal: Path 't/test-lib.sh' exists, but not 'test-lib.sh'.
> Did you mean 'HEAD:t/test-lib.sh'?

The first thought that comes to mind is that if it makes more sense to
just fall back to the interpretation of the input when the tool has
already figured out to second guess the intention of the user like the
above message does.

That would obviously break scripts that try to make sure the _absense_ of
a path in a tree-ish (or in the index if you lack "HEAD" in your example),
expecting:

   git rev-parse HEAD:test-lib.sh ||
   echo "test-lib.sh shouldn't be at the top level"

to work regardless of where you are in the work tree, so it won't fly
well.

Perhaps the second step would be to teach the machinery to understand a
syntax like "<tree-ish>:./<path>" and have it prefix the path to the
current subdirectory from the root of the work tree, and with such an
enhancement, the suggestion given by this patch would probably change to
"Did you mean 'HEAD:./test-lib.sh'?", but that would be a separate topic.
