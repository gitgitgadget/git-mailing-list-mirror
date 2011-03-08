From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] blame: honor core.abbrevguard
Date: Mon, 07 Mar 2011 16:59:17 -0800
Message-ID: <7vipvuzau2.fsf@alter.siamese.dyndns.org>
References: <1299472540-6066-1-git-send-email-namhyung@gmail.com>
 <1299475335-8436-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 01:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwlGt-0007PS-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 01:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab1CHA71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 19:59:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab1CHA70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 19:59:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 722D94A9D;
	Mon,  7 Mar 2011 20:00:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfe1V5zh7bEVAxO+GGskUSfUwYw=; b=X/BhTq
	MM2oxK/FPPpawOXMQ1gSWFO9nimU4xdvzKF2DlXK4jGb1dGIv30jaHdzPD67hCPk
	9ZbVn+x/JQm1xyoJdnrDalO3Mb+vkSqh/pupcPbb4V05thCdNTzJyIW8RBrB6Dhb
	2t2/eNZZsfSJMUvkprIVxSfG+the32cLjLR0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TYsp6EsXybKD9/Oe7OxQTBeu+1KLexxL
	Tyn4Y9uRMiZAH/4nSXO1vR47qZXbhzS19KUcH3VSMKaxhF6y96wBdrtEZi+WV04n
	FQ6iQHD5seOfwO94VOsy/bQAhyGZt1Qka01KeMP7b6W8I+hwsamsLDtv22i9nLNS
	yB7VzA9QvUY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FC274A9C;
	Mon,  7 Mar 2011 20:00:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6037E4A9A; Mon,  7 Mar 2011
 20:00:46 -0500 (EST)
In-Reply-To: <1299475335-8436-1-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Mon, 7 Mar 2011 14:22:15 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81DAF856-491F-11E0-A5CC-B86344810875-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168626>

Namhyung Kim <namhyung@gmail.com> writes:

> Commit 72a5b561 ("core.abbrevguard: Ensure short object names stay
> unique a bit longer") introduced this config variable to make object
> name unambiguously. Use it.
>
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
> v2:
>  - re-init 'length' in every loop

In this codepath, we only aim to make sure that the shortened object name
is of the same length.  By choosing hardcoded 8, the original clearly
declares that we do not _care_ about the uniqueness.

The abbrev-guard that adds to the length that ensures the uniqueness in
the particular repository has a very different semantics.  It only makes
sense if you add to a length that you know would make the object names
minimally unique.  Adding it to hardcoded 8 does not make it less
ambiguous the same way as the configuration variable intends to do.

So I am not entirely happy with this patch.

Besides, when OUTPUT_LONG_OBJECT_NAME is specified, the value this
variable holds is _not_ "uniq_length", so the name of the variable is not
quite correct.  We colloquially call the object name "sha1" in the code,
so "sha1_length" would be a better name for it.

If we _were_ to do a change that uses the configuration variable, I would
imagine that it would be a part of a change that makes sure that the
shortened object names in the output actually uniquely identify the
commits.  It would involve find_unique_abbrev() for as many commits as the
number of lines in the blamed range at most (and at that point the abbrev
guard would automatically taken into account because find_unique_abbrev()
already does so) before calling "output()"; I suspect that find_alignment()
is the right function to do so, as that is where the column alignment
logic all happens.

It would probably need to be introduced as a new feature, with its own
command line option, similar to -l option that forces the full 40-hex
output.

So thanks for a patch, but I don't think we would want to take it in the
current shape.
