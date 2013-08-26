From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Sun, 25 Aug 2013 23:03:54 -0700
Message-ID: <xmqqob8lj8dx.fsf@gitster.dls.corp.google.com>
References: <20130824013310.GA9343@sigill.intra.peff.net>
	<20130825061500.GR2882@elie.Belkin>
	<20130825095818.GA12556@sigill.intra.peff.net>
	<20130825195412.GA2752@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 08:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDpuK-0005GD-L6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 08:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab3HZGD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 02:03:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334Ab3HZGD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 02:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85A0372E7;
	Mon, 26 Aug 2013 06:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Qxtp/X/DbL3IvU/EiQdcWTfadc=; b=uXzRQ9
	JN12+eI5wlsP4EdLoL380gYUP+VWhvgUAsLcSH5LjRXlo7XxN0upv712heePEoWL
	riwl1XwqLaTDMmBMY11lAsyyHcKmUji09tj6VRD5W33lH4tN+pfb8oABO9Mqrju8
	YhTc5718HM61U5gnooQbKP963SxBz1sr1fJy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B3cKSTWe4DQUch3lhFv0WpcEmtDDHtKV
	BFBiW0iUWQ+WL/7L319ROCPhAtpzmnrnwWo4zUF+2oj5cugLbGFxAxmBVmP+vq18
	yAIYpDFm8bUly9rKxSFzX94/LixwRdt+qm461WFBNkH4/uasLwaYmWy2RGGgdxTx
	1dpgLnPmaBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DFFF372E6;
	Mon, 26 Aug 2013 06:03:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10AF2372E3;
	Mon, 26 Aug 2013 06:03:55 +0000 (UTC)
In-Reply-To: <20130825195412.GA2752@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 25 Aug 2013 12:54:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AA65FCA-0E15-11E3-876F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232975>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, why not use something like this?
>
> 	write_index: optionally allow broken null sha1s
>
> 	Commit 4337b58 (do not write null sha1s to on-disk index, 2012-07-28)
> 	added a safety check preventing git from writing null sha1s into the
> 	index. The intent was to catch errors in other parts of the code that
> 	might let such an entry slip into the index (or worse, a tree).
>
> 	Some existing repositories have some invalid trees that contain null
> 	sha1s already, though.  Until 4337b58, a common way to clean this up
> 	would be to use git-filter-branch's index-filter to repair such broken
> 	entries.  That now fails when filter-branch tries to write out the
> 	index.
>
> 	Introduce a GIT_ALLOW_NULL_SHA1 environment variable to relax this check
> 	and make it easier to recover from such a history.

I found this version more readable than Peff's (albeit slightly).

> After this patch, do you think (in a separate change) it would make
> sense for cache-tree.c::update_one() to check for null sha1 and error
> out unless GIT_ALLOW_NULL_SHA1 is true?  That would let us get rid of
> the caveat from the last paragraph.

Hmm, interesting thought.
