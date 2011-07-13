From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Wed, 13 Jul 2011 10:49:32 -0700
Message-ID: <7vmxgi6pg3.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <201107121241.40242.jnareb@gmail.com>
 <20110712175739.GA17031@sigill.intra.peff.net>
 <7v62n78hpk.fsf@alter.siamese.dyndns.org>
 <20110713063701.GA18238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 19:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh3Z7-00023Q-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379Ab1GMRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:49:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805Ab1GMRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:49:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3BAB52C5;
	Wed, 13 Jul 2011 13:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IW9+k3o7D+kaY/AKDmVRZ17pqY4=; b=FTzddI
	Z40Yr0aIy60p1NPKCpcj+bIHvDdkwY0FBuAe2YoiKgrsnup59EfLQ/w9WWd0bht1
	pXyGSQGtyaWZsnn4iN4I0fi1qC2drc5ZLz6MihcmBOK0CNy/zenW8TIRIokHzM8D
	uqr6m9x2cT3jfamJIHIJG1JrlEFKnpk/NnLxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDJzJm1NO+NHll05hhDoUGhetcSbZX2z
	UvJi6d6OQImPp/Zsr2v/ShoGqBaGphtd7EnyJqYBLcvD8nGCnJs6Jz+fW8RbWYMO
	kCbiSIQB12xEHLV4J1FeF0CBfSUGv9vkZHHCbA9yZPzDwZJy6wspSowY69FAs4MH
	533HfpTfpiU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97BEF52C4;
	Wed, 13 Jul 2011 13:49:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3C4752C3; Wed, 13 Jul 2011
 13:49:33 -0400 (EDT)
In-Reply-To: <20110713063701.GA18238@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Jul 2011 02:37:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77D2BCB4-AD78-11E0-857D-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177065>

Jeff King <peff@peff.net> writes:

> It would be easy to implement sha1_entry_pos in terms of sha1_pos by
> writing an access function. But it seems unnecessarily slow to add
> function call overhead in what should be a fairly tight loop.

Yeah, that could also be a double-regression as sha1_pos() implementation
is sloppier and does not protect itself from its guess overshooting the
target like sha1_entry_pos() does. The first step definitely is to remove
the duplicated comment, and the second step would probably be to unify the
"mi" selection logic in sha1_pos() and sha1_entry_pos().

Either the simplicity of the former is sufficient for the users of the
latter, or the users of the former would also benefit from the less
agressive selection of the latter.
