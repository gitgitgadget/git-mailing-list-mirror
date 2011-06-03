From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Thu, 02 Jun 2011 19:51:22 -0700
Message-ID: <7vvcwnbpat.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-2-git-send-email-jamey@minilop.net>
 <7vfwnrdfam.fsf@alter.siamese.dyndns.org> <20110602233619.GA1931@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 04:51:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSKUE-0001E6-AX
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 04:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1FCCvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 22:51:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1FCCvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 22:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D2095CAC;
	Thu,  2 Jun 2011 22:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gNXW0gCU9yqByaaUM+8EbqutASg=; b=SAnui+
	wEkvK+EOyVxcfVBqOLJcNsy6RguRSJwLeaUFVPDEZMibP+rb1FyhPU2W67WDb5yq
	3AakFLvqH4lyoExMgiQgOVdCJyYyC3CpGld0s6PzT/iUTK2D/PYA4atO7c2GocJV
	pp7JLO/K6GaGb16GqNfGn0GVMdPriXJcoozqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x48HV+XK63f1+eeqrvjfaD+iJE5cDwPJ
	JQEAAMazu6VukWNsThmePy/qW/qRAbnHpG/rRDU+AhZmW3u6rf9s9+5NSP0OxEKt
	qJVUq02ZiarVIn3I2xRqqOzbUcIISr1o0Qqixv4h9glJNxG0Cq7xAqg+HIjGisbR
	iDAX0bbITJg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F48C5CAB;
	Thu,  2 Jun 2011 22:53:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 847255C9E; Thu,  2 Jun 2011
 22:53:33 -0400 (EDT)
In-Reply-To: <20110602233619.GA1931@leaf> (Josh Triplett's message of "Thu, 2
 Jun 2011 16:36:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0F7851C-8D8C-11E0-B4EF-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174992>

Josh Triplett <josh@joshtriplett.org> writes:

> ... I don't think it
> makes sense to support passing in arbitrary namespaces when the callers
> only use it to access the currently requested namespace.  If some
> situation arises in later code that needs to handle arbitrary
> namespaces, it seems easy enough to provide a more generalized function
> at that point, but doing so now would just make the existing callers
> more complex by forcing them to do the call to get_git_namespace()
> rather than allowing for_each_namespaced_ref to do it.

If you do not pass the namespace around from day one, wouldn't it make it
more cumbersome to later extend the API so that you can have more than one
namespace active at the same time? For example, even with today's code,
when responding to a push, the receiving repository issues a ls-remote
request to its alternate repository to learn the tips of its refs, and at
that point, the side of you who is responding to a push is using the
namespace from the push client, while you acting as a fetch/ls-remote
client would be in a different namespace. The different namespace happens
to be "no funny namespace business" plain vanilla one, but I think you get
the point. I do not mind seeing the very top-level caller of ref iterator
calling get-namespace, but I would find it a bad taste if a function very
deep in a callchain has to call get-namespace (meaning, you can only have
one namespace active at a time) only because the caller does not pass it
in.

But perhaps I am looking too far into the future and worried too much.
