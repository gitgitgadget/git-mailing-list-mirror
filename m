From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH 5/5] RFD: Disallow out-of-refspec refs within refs/remotes/* to be used as upstream
Date: Fri, 19 Apr 2013 12:51:08 -0700
Message-ID: <7vvc7iz4cz.fsf@alter.siamese.dyndns.org>
References: <1366352442-501-1-git-send-email-johan@herland.net>
	<1366352442-501-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:51:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHL3-0002lN-8D
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab3DSTvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:51:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab3DSTvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:51:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A051917473;
	Fri, 19 Apr 2013 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YNCEKyJG0LfaQ4ViB6+OKWzvcBA=; b=ByRqIh
	IaBUB30BaTKH/hh3xR3N3kx1/SaUhy4vMcyWnMim/naSLm/DFvnpZtOJxSj3d776
	XHGyn3xyYC6B16ujwcQGxsYaWNNaH+hYPo81dAX7vOOPAWi/M+OtLEWFbakjkwRT
	KIpGfr9fZ7h96RumzS3dSvSD+JyGdF22WXOSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FqjloG4IKopqd1zJduwTfJl4o2ZR8/WZ
	chWgqfzfE1XtjQl5JXdGt2AB126kENV9E2Xv73sFT0EUX/T2bpJNX8YxJ940jc1m
	K3fVm/fXgkcXiNb7AoAmL/D+WNkkHGjNkvoR1PXbNwWPmMT4D8XGyuggwc5YKkwc
	sUNvbuvTOXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 948DE17472;
	Fri, 19 Apr 2013 19:51:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1189917471;
	Fri, 19 Apr 2013 19:51:10 +0000 (UTC)
In-Reply-To: <1366352442-501-6-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 19 Apr 2013 08:20:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C20E7AA-A92A-11E2-B98E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221813>

Johan Herland <johan@herland.net> writes:

> The previous patch adds validation of upstream remote-tracking branches by
> parsing the configured refspecs, and making sure that the candidate upstream
> (if not already matching refs/heads/* or refs/remotes/*) is indeed a
> remote-tracking branch according to some remote's refspec. For a
> default/conventional setup, this check would automatically also cover
> everything within refs/remotes/*, meaning that the preceding check for
> refs/remotes/* is redundant (although quicker than the validation against
> refspecs). One could also argue that not everything inside refs/remotes/*
> should be automatically acceptable as an upstream, if one were to keep
> other (non-branch) type of remote-tracking refs there.
>
> This patch removes the simple check for refs/remotes/*, to make sure that
> _only_ validated remote-tracking branches (in addition to local branches)
> are allowed as upstreams.
>
> However, this means that for unconventional setups that place refs within
> refs/remotes/* without configuring a corresponding refspec, those refs will
> no longer be usable as upstreams. This breaks a few existing tests, which
> are marked as test_expect_failure by this patch, to make them easy to find.

I think these tests are too loosely written, making assumptions on
what the back-then-current implementation actually does.

If refs/remotes/origin/koala/bear is a remote tracking branch for
koala/bear branch taken from the origin, we will have a refspec that
stores to refs/remotes/origin/koala/bear for _some_ remote (and in
the most normal case it would be "origin").

Instead of expecting failures, I think it is a better change to make
the test case more realistic by adding remote.origin.refspec as well.

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index be9672e..7267ee2 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -429,7 +429,7 @@ test_expect_success 'detach a symbolic link HEAD' '
>      test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
>  '
>  
> -test_expect_success \
> +test_expect_failure \
>      'checkout with --track fakes a sensible -b <name>' '
>      git update-ref refs/remotes/origin/koala/bear renamer &&
