From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Thu, 18 Apr 2013 09:39:23 -0700
Message-ID: <7vmwsv94jo.fsf@alter.siamese.dyndns.org>
References: <1366275155-26244-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 18:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USrry-0005KQ-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 18:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936339Ab3DRQj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 12:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936298Ab3DRQj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 12:39:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5B0171D5;
	Thu, 18 Apr 2013 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lf15leUY0sjthscBQz+Wu8tuYjg=; b=cEBgRB
	Ye1Kv6VCFfcvhONoUARZSHNy66wHDuGHjel7m225g8o6+JaCIDRnxBMSxJfJ3KN/
	19+kIShzKY9YCycIWm1mFhxJ5I3lr1II39EDun4V5m9UzmUkThAMmCxnIMwF6NIS
	djivB9GzBg+6hl8PQFtpI98YmrftiX7Vb+7v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIt8YXji8COo2a4/9glTIzKwjxSEIiR9
	FkwQR67yujKr0cBYfH0NPBvFPN34O3xMYsaz/N5OuUB0lGFbsD8frnvkoWtlrGFS
	XkCk3EcGh1ILKrXa9WtLTxM5ZVaIKisWcGHAYcOubDDSYfPJHCkXZFeYSdjWsj/O
	g0kwO2FW7oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4094D171D4;
	Thu, 18 Apr 2013 16:39:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7F17171CE;
	Thu, 18 Apr 2013 16:39:24 +0000 (UTC)
In-Reply-To: <1366275155-26244-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 18 Apr 2013 14:22:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876A697C-A846-11E2-A25C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221665>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 'git rebase' does not recognize revisions specified as :/text.  This
> is because the attempts to rev-parse ${REV}^0, which fails in this
> case.  Add a test to document this failure.

>  - The failure occurs in git-rebase.sh:403.  Is it using the ^0 only
>    to make sure that the revision specified is a commit?  Surely,
>    there'a a better way to do this?
>
>  Can someone point me in the right direction?

How about ${REV}^0 into

	nREV=$(git rev-parse "${REV}")^0

and use it where you need an object name that needs to be parsed by
get_sha1(), e.g.
	
	git checkout -q "$nREV^0"

I would suggest a helper function in git-sh-setup, something like:

	peel_committish () {
		case "$1" in
                :/*)	
			peeltmp=$(git rev-parse --verify "$1") &&
                	git rev-parse --verify "$peeltmp^0"
                        ;;
		*)
			git rev-parse --verify "$1^0"
                        ;;
		esac
	}
