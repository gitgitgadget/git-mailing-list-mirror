From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 07:57:38 -0700
Message-ID: <7va9pzl9nh.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin> <20130319034822.GL5062@elie.Belkin>
 <7vli9kkoci.fsf@alter.siamese.dyndns.org> <20130319052805.GO5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxzx-0006oV-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260Ab3CSO5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:57:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932545Ab3CSO5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:57:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7793BB228;
	Tue, 19 Mar 2013 10:57:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+Y7FN3BZImj3ENp/32Mmm1rGgY=; b=XqppDM
	twzCag9cvUwWUuwztqYKFgtIzm5Cc6oUo4fLcE5wu3swdk1skf1x04+e0pEtM6R/
	ocrEYV8WOXBgjW8iGw07x9p6wnyFQohnC6EkOn71sWME0mZfnKZS/puWRUwez9I4
	l+awmNNNEdCR1nyOLmYJdYWU9rsMBavLqqVu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySkiWLHjnrToiVR7G3eDG6SMeByoqpqP
	JLkUBQZ+mholctlFZqiH87l6Z7Fy7nUq4PnIANGfhvEnRvAuPyxuzLierij4QtvA
	iAJfZdqyEB45/KC1u7/eggLw88+YC3pE2hcOV7f0kveh2MreHAL5uAVmpL/Zo/M+
	HJ4+V+bIBnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C34AB227;
	Tue, 19 Mar 2013 10:57:41 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C018EB225; Tue, 19 Mar 2013
 10:57:40 -0400 (EDT)
In-Reply-To: <20130319052805.GO5062@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Mar 2013 22:28:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58C7019C-90A5-11E2-8B71-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218520>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yes, that can work, for example like this (replacing the patch you're
> replying to).

I think that would be a better approach if we were to do this.  I
still have the same reservation that "this is fundamentally not
worse but still hurts the users more".

> +		/*
> +		 * Check if "git add -A" or "git add -u" was run from a
> +		 * subdirectory with a modified file outside that directory,
> +		 * and warn if so.
> +		 *
> +		 * "git add -u" will behave like "git add -u :/" instead of
> +		 * "git add -u ." in the future.  This warning prepares for
> +		 * that change.
> +		 */
> +		if (implicit_dot &&
> +		    !match_pathspec(implicit_dot, path, strlen(path), 0, NULL)) {

This one really should *not* use match_pathspec(), I think.

It is a special case where we were asked to limit to our directory
but decided to grab everything instead and filtering the outcome
outselves.  We should have a "path to the starting directory" aka
"prefix" in implicit_dot and check if path is covered by the prefix
instead.

> +			warn_pathless_add();
> +			continue;
> +		}
>  		switch (fix_unmerged_status(p, data)) {
>  		default:
>  			die(_("unexpected diff status %c"), p->status);
