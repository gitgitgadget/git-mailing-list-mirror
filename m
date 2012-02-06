From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 05 Feb 2012 21:30:15 -0800
Message-ID: <7vk440a5qw.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <7vty34a6fd.fsf@alter.siamese.dyndns.org>
 <20120206051834.GA5062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHA0-0006Gj-KL
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab2BFFaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:30:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2BFFaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:30:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62501316A;
	Mon,  6 Feb 2012 00:30:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ec3YstVFkvSAGqfxOmhg6Erucj8=; b=oTNsij
	2bvB9SDLDQSKoaPRtwvBwj2awv79SYbR/uiotaX3qb6WAchmZX1BJxDMLQbsSoQP
	JqBKFVktaoUnhltLXOUb7ks6qvkGfUHd+o1J5JUKX1D9u6Y2roO8O/nxOEoUA0f1
	kKVG23v4uRjOJlAvOmvNVu5tlRPG7xG5sFfLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hF003z9cc2do6p/ZNqpB/wjmpK3sa89Q
	ko+EvUngAl0oX5ZrXq9m6KThb/HwhcCxfXpv9Ud2OkHG4d0ruoWxa7rn6GGyf+26
	pTb9LsucHG9DGLqLtS9HXDj2JvGw66WHLJ0kPFnLJ2RUrRs29QE+nSUsiq8M7Ben
	56cauCjWBww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5823C3169;
	Mon,  6 Feb 2012 00:30:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C72B93168; Mon,  6 Feb 2012
 00:30:16 -0500 (EST)
In-Reply-To: <20120206051834.GA5062@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 00:18:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6DD0E52-5083-11E1-8370-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190014>

Jeff King <peff@peff.net> writes:

> Sure, that's one way to do it. But I don't see any point in not allowing
> "git checkout -b" to be another way of doing it. Is there some other use
> case for "git checkout -b" from an unborn branch? Or is there some
> harmful outcome that can come from doing so that we need to be
> protecting against? Am I missing something?

Mostly because it is wrong at the conceptual level to do so.

	git checkout -b foo

is a short-hand for

	git checkout -b foo HEAD

which is a short-hand for

	git branch foo HEAD &&
        git checkout foo

But the last one has no chance of working if you think about it, because
"git branch foo $start" is a way to start a branch at $start and you need
to have something to point at with refs/heads/foo.

So we are breaking the equivalence between these three only when HEAD
points at an unborn branch.
