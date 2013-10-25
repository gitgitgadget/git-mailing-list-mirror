From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 25 Oct 2013 10:13:20 -0700
Message-ID: <xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Milton Soares Filho <milton.soares.filho@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 19:13:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZkx1-0006lB-7o
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 19:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab3JYRNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 13:13:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389Ab3JYRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 13:13:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E67604C79E;
	Fri, 25 Oct 2013 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTlPJxluTqUXFGjfFXP5vdsyR4E=; b=ipqrUl
	QRfisvInJoLmFLC1I2pCziqdvILPQhW4rEYzvBzqhfwI52/97bpmvoxrPcIiFa79
	H4OAPCr39dWux5GztBOM4OVMBBQdnpv83JrtkwIkQ99tSTNIC/NPYL1H7WLtcBs+
	dYH3H51WFXlSumC5u9oEEnr/DcoQGkoShPTeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FmlZ+bJhrHFOLWkTcvAgKQe1Z/Xqec9w
	74b1bRB5TF5H+4BZfrdyFFvBnqMpkT8BTUOZix/Iv1WBDjxa2J3rAlZsVsT9iZSE
	kBMUxkjUpHojNmRMLSFbXegV2vyWgB1MFngw7eMiqxe9ApRHrYdSRcr2hPsmcVw9
	OhE753otOMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1BA74C79D;
	Fri, 25 Oct 2013 17:13:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 270F24C79C;
	Fri, 25 Oct 2013 17:13:22 +0000 (UTC)
In-Reply-To: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	(Milton Soares Filho's message of "Fri, 25 Oct 2013 14:07:48 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C04A8DC0-3D98-11E3-BE92-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236711>

Milton Soares Filho <milton.soares.filho@gmail.com> writes:

>     git log --graph --oneline
>     * a1
>     * a2
>     x a3
>     * b1
>     * b2
>     x b3

I agree that the problem you are trying to solve is a good thing to
tackle, and I also agree that marking a root commit differently from
other commits is one way to solve it, but I am not sure if that is
the best way.  If the stretches of a's and b's in your history are
very long, wouldn't it be easier to spot if they are painted in
different colours, in addition to or instead of marking the roots
differently [*1*], for example?

>  	/*
> +	 * Out-stand parentless commits to enforce non-continuity on subsequent
> +	 * but separate series
> +	 */
> +	if (graph->commit->parents == NULL) {
> +		strbuf_addch(sb, 'x');
> +		return;
> +	}
> +
> +	/*
>  	 * get_revision_mark() handles all other cases without assert()
>  	 */
>  	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));

It is unclear why the update goes to this function. At the first
glance, I feel that it would be more sensible to add the equivalent
code to get_revision_mark()---we do not have to worry about what
else, other than calling get_revision_mark() and adding it to sb,
would be skipped by the added "return" when we later have to update
this function and add more code after the existing strbuf_addstr().

The change implemented your way will lose other information when a
root commit is at the boundary, marked as uninteresting, or on the
left/right side of traversal (when --left-right is requested).  I
think these pieces of information your patch seems to be losing are
a lot more relevant than "have we hit the root?", especially in the
majority of repositories where there is only one root commit.

Thanks.


[Footnote]

*1* Note that I am not saying "the change the patch introduces is
not sufficient and you have to paint the commits in different
colors" here. I myself think it would be a lot more work to do so,
and I even suspect that it may be asking for the moon---you may not
even know what root "a1" (and "b1") came from when you are showing
these commits without first digging down to the roots and then
walking the history backwards, which may not be practically
feasible.
