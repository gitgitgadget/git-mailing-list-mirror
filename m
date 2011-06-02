From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/4] Refactor for_each_ref variants to use
 for_each_ref_in and avoid magic numbers
Date: Thu, 02 Jun 2011 16:29:00 -0700
Message-ID: <7v4o47dd8j.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <7vk4d4c6ns.fsf@alter.siamese.dyndns.org> <20110602205747.GA2022@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSHKS-0003Rd-VS
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 01:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab1FBX3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 19:29:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab1FBX3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 19:29:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1EB848B9;
	Thu,  2 Jun 2011 19:31:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/QnpqfjsoiSg8NjoCKFrHwYCZ4=; b=vRdmYA
	Tp0U1F16OxcUDKh7WhJgra3z6R+xoN9BjTcLqbhX10CMvs4muHksGlLdneBMAcnC
	kO8J4QQigmpM9GXfe/XrzjJIJRfCp87wP0cCtr1Ob5fJCyd1lMg+qnZ2sE4Dfppn
	uKQHA7e7w95993TbABHq9l+QhCj6CqF/nUW/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FA4kLnqegBxHEdDcoHrAooIsGjQVoMTn
	W8aq1j3OUjserHueqGMJPXL//uv78ljhgDpVIxTi5dRGA4t89tWtFZDQCgNiYgNJ
	B/DL3Jh8+NaNhAnRw6hR0Z1v1KA0FXr8lgDpmmOMjWH0OyWQvje+V6W7SpOJqTZx
	uFOVD5MLQOY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E9FF48B5;
	Thu,  2 Jun 2011 19:31:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E51148AD; Thu,  2 Jun 2011
 19:31:09 -0400 (EDT)
In-Reply-To: <20110602205747.GA2022@leaf> (Josh Triplett's message of "Thu, 2
 Jun 2011 13:57:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B922372-8D70-11E0-911C-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174987>

Josh Triplett <josh@joshtriplett.org> writes:

>> Shouldn't you be passing prefix and trim the same way as we have always
>> done, but just fixing the strncmp() at the beginning of do_one_ref()?
>
> I still think prefixcmp makes the most sense; if you pass a given base,

Using prefixcmp() instead of strncmp() there is what I meant by "fixing
the strncmp() at the beginning of do_one_ref()", so we are in agreement on
that point. What I found questionable was the removal of the trim
value. IOW, I would have expected the patch to be something like:

	if (prefixcmp(base, entry->name))
        	return 0; /* outside of our area -- ignore */
	... some other logic ...
        /* feed the callback, stripping the prefix */
        return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
