From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 13:33:22 -0700
Message-ID: <7vaach7wfh.fsf@alter.siamese.dyndns.org>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <20110713072350.GA18614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh68s-0006F7-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1GMUd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:33:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1GMUdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FAE164A7;
	Wed, 13 Jul 2011 16:33:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+RUFf5YK489q38oT+MSxAZMofu4=; b=cB2cO/
	wSw4634MYK3/9CDzJhTTUQJB3T3iMRneCe6oMnGUhlZqJg2duTAP3jv27Xjp+WE/
	2dMbMEo6jezr+7NUhaAyLTYRaIk9hJNk1ccpNMvQ2NURoMTCfBMx0XtCP6r8eARk
	mdXP4krf5A0cIimlRCxFc9i12exscjkNoZYps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=esHpSXaSVV4rPzWVUISzEmFwqcyetzHO
	3UfUMVKiyMFBDmdzCWc0tql+KsKnB1PfaacnzcqqCLdp/v6zMk/e2/75qOTAsnsg
	EKjcAYrv9WUSFDtw+efSwqcaflU8Nh/GIxORuKhCRHkflQqr7HbFLWbgiziv2tBr
	1WBCwAPNzsI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 183EE64A6;
	Wed, 13 Jul 2011 16:33:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B7AD64A5; Wed, 13 Jul 2011
 16:33:24 -0400 (EDT)
In-Reply-To: <20110713072350.GA18614@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 03:23:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B428E14-AD8F-11E0-8AEF-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177077>

Jeff King <peff@peff.net> writes:

> It takes barely any time to get the generation of the new commit, but we
> spend .25 seconds writing the whole new cache file out. This could be
> improved with a more clever disk format that contained a journal of
> unsorted newly written entries. You'd still write the full cache out
> once in a while, but the cost would be amortized.

This series consists of three somewhat related ideas:

 - A generic API to persistently annotate 20-byte keys (typically object
   names);

 - Using that API to implement commit generation numbers;

 - Using commit generation numbers in "tag --contains" traversal.

I think the first one is independently a good change, but I have been
wondering if the entire history needs to be annotated with the generation
number for the goal of the third item. There may be stretches of history
where timestamps are screwed up, but if the commits we should dig through
while traversing (because they, their parents or their children record
skewed timestamps) are minority in the history, the same generic API could
be used to mark only these commits as such, by using far smaller number of
disk I/Os, no?
