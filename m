From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 04 Apr 2013 12:42:54 -0700
Message-ID: <7v6202hykh.fsf@alter.siamese.dyndns.org>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNq4M-00050f-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764713Ab3DDTm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764578Ab3DDTm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19D3E13235;
	Thu,  4 Apr 2013 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5SSGqfL5JBqQCkXtyJd0hJaHLAY=; b=n7NfeA
	VCZCV7BZ1tly7V1/FiTDSfFH58cElKpn4SdarrbK6qRTR9ga2cQVzAJw8iz/u1zH
	JwvGL4IQew1Hw0gulIIArvCQO/r3vTwJQ42O0TXgQ/FKYxV5ZBRZzAERUc9wdy53
	fMRtvZh1mdo/C8HqG+pBXfABCVvv64xD1JPuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=om0YyKQyhJ2vDd+iNczCdOAo50rHHuwt
	rYqGCqPuAqCGoYRITcf9Ab6y7fwo/W3y2K6bg+JP1QZpWbACk83CpWvp5LRhESHa
	QxLpl76sf9a5KBVq49hg7qjCPo4YTG6kkLPuj7i3r5UEy/6tIniThCPVJuSnoD3S
	IIpD36c4JBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB3B13234;
	Thu,  4 Apr 2013 19:42:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FD1F13232; Thu,  4 Apr
 2013 19:42:56 +0000 (UTC)
In-Reply-To: <20130404190621.GA7484@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 15:06:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D92905B2-9D5F-11E2-BB39-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220078>

Jeff King <peff@peff.net> writes:

> +test_expect_success SYMLINKS 'replace dir with symlink to dir (same content)' '
> +	git reset --hard &&
> +	rm -rf d e &&
> +	mkdir e &&
> +	echo content >e/f &&
> +	ln -s e d &&
> +	git rm d/f &&
> +	test_must_fail git rev-parse --verify :d/f &&
> +	test -h d &&
> +	test_path_is_dir e
> +'

This does not check if e/f still exists in the working tree, and I
suspect "git rm d/f" removes it.

If you do this:

	rm -fr d e
        mkdir e
        >e/f
        ln -s e d
        git add d/f

we do complain that d/f is beyond a symlink (meaning that all you
can add is the symlink d that may happen to point at something).

Silent removal of e/f that is unrelated to the current project's
tracked contents feels very wrong, and at the same time it looks to
me that it is inconsistent with what we do when adding.

I need a bit more persuading to understand why it is not a bug, I
think.

> +test_expect_success SYMLINKS 'replace dir with symlink to dir (new content)' '
> +	git reset --hard &&
> +	rm -rf d e &&
> +	mkdir e &&
> +	echo changed >e/f &&
> +	ln -s e d &&
> +	test_must_fail git rm d/f &&
> +	git rev-parse --verify :d/f &&
> +	test -h d &&
> +	test_path_is_file e/f
> +'
> +
>  test_done
