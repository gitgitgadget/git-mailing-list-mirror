From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 13:58:00 -0700
Message-ID: <7vprahq8iv.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-9-git-send-email-johan@herland.net>
 <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
 <200908271135.31794.johan@herland.net>
 <alpine.DEB.1.00.0908271243120.7562@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgm3J-0008St-T3
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbZH0U6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbZH0U6T
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:58:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZH0U6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:58:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C5E71B7A1;
	Thu, 27 Aug 2009 16:58:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FyYgo/eJlojDP9X7pzSIO+9aDZc=; b=D4CVNz
	ZlC8wlOju/tNn6mLcKY2R4tm77ONGEqwi+kDnKIxBebyzpcH3bpZHFXRRe98b3V8
	9UxCM9s33BUN3vp1xiCsJ1QL1eTJZwxbMqpnFSIXSRMdNV/WO3G2ykIQIttOdYKK
	qeV2dlqHqbod7QyH4+abttSlWNtxvTrUI2tI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxRM2REwy3rbJF4Elqr4uivZUWpG7hlC
	+KGunJCFCPl0i5xfz4Go5Eg2d6azcAf/zO9JdAWa8lrpaDONgY7PSOdAiekjZJyg
	pNqNViN8taBw7Z1V+Jx8C9sroVMr4AGGqVxzxzJIumti0BmIbZJchydnUVAKM2qH
	FhCzjj3q42c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3421B798;
	Thu, 27 Aug 2009 16:58:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F6DB1B789; Thu, 27 Aug
 2009 16:58:01 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908271243120.7562@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Thu\, 27 Aug 2009 12\:47\:49 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 543FD0A4-934C-11DE-AB11-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127210>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I half-agree, the code should decide which fanout scheme to use, but 
> _only_ when producing new notes.
>
> I imagine that it could merge the existing notes, and try to make sure 
> that there are no more blobs in a given subtree than a certain threshold; 
> if that threshold is reached, it could fan-out using 2-digit subtrees, 
> merging what needs merging (by concatenation) along the way.
>
> The natural precedence of shallower paths/longer basenames should cope 
> well with that (i.e. prefer to show abcd/... over ab/cd/...).

Oh, if the plan for merging the trees is such that it takes care of
"multiple notes pointing at the same commit" issues like you outline, then
I can see it would work nicely.

At that point, fan-out would become merely an implementation detail,
something the end user never needs to worry about, just like what base
object is chosen to represent another object in a packfile.
