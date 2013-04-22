From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 09:32:58 -0700
Message-ID: <7vk3nupltx.fsf@alter.siamese.dyndns.org>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 18:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJg3-0008Uj-2w
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3DVQdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 12:33:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab3DVQdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:33:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27E316C37;
	Mon, 22 Apr 2013 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pwa+ozTLH2whZgtn0cmi+e6ZCeA=; b=CwREde
	b+bDGQbCeyzKRWBH5jKQoBGGOHMamK51AikhxZnkk0R/1QL0JEsNrQcWSdRTd4wI
	/nZPF0+BU9UMq+5U93+VqsDt/uVVrxSrZnRhptM09ITABTivxYlCmFbC6N+xPEFp
	jYswtBn2JtsCwFCtPOoN+2kBmehqgMRgOhrX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WfcF1f9hX6LtJ4quX1lF3O3IjihbAru9
	Vckd6d2jrINnWDNfhBGV0OfDiigJIgi4yGfdd7urN4DHK5PdAHmKg95CeVZAPDWD
	TiuFnkb9GsYDmNA+rWfoxItvtDVQ8efipS1UzQMc5tluKX8mv5F6Vf28ya2/Xggo
	Vf4IYrFclmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C9D16C34;
	Mon, 22 Apr 2013 16:33:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC09C16C27;
	Mon, 22 Apr 2013 16:32:59 +0000 (UTC)
In-Reply-To: <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Apr 2013 17:24:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BAE0520-AB6A-11E2-B781-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222037>

Thomas Rast <trast@inf.ethz.ch> writes:

> So (I think?) in the above you claim that $USER interprets
>
>   git log -- README.md
>
> as
>
>   Show me the history of README.md.
>
> But there's no such thing as the history of a file!  The command instead
> says
>
>   If I filter all history for only changes affecting a path 'README.md'
>   in the root of the repository[1], then what does it look like?

Correct.  The "design principle" I did not quote from your message
comes from one of the most important messages in the list archive
($gmane/217).

Three issues with "--follow" are:

 (1) It uses the given pathname as single pathspec and drill down
     the same way without "--follow" until it notices the path
     disappears and until then there is no attempt to detect renames
     is made.  And it only does -M variant of rename detection

 (2) The "same way" in (1) includes the merge simplification to cull
     side branches if one parent matches the end result.  In a
     history where the first parent of a merge M, i.e. M^1, did not
     have path F, its second parent M^2 had path F, and the merge
     result M deposited the contents of M^2:F at M:D/F, then running
     "log --follow F" starting from M would notice that the end
     result M did not have F in it, which is shared with its first
     parent M^1, and culls the side branch M^2.  The --full-history
     option may let you keep the history leading to M^2, though.

 (3) When (1) notices that the path being followed did not exist in
     any of the parents (be it a merge or a non-merge) and finds a
     different path with a similar looking content, it _switches_
     the pathspec to it, but the single pathspec it uses is a global
     state and affects traversals of other ancestry paths at the
     same time.  Because of this, "--follow" will not work correctly
     in a history that contains merges.  It often _appears_ to work
     only by accident.

The first two are relatively minor (the second is not even an
issue).

To solve the last one, you would need to keep track of which path it
is following per traversal path.
