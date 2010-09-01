From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure show_all_errors when using porcelain error
 messages
Date: Wed, 01 Sep 2010 07:59:29 -0700
Message-ID: <7vsk1t7bn2.fsf@alter.siamese.dyndns.org>
References: <vpqeide0zkx.fsf@bauges.imag.fr>
 <1283321153-24745-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:59:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqomu-0004vN-7H
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0IAO7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 10:59:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab0IAO7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 10:59:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11C72D2AC6;
	Wed,  1 Sep 2010 10:59:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QVxSPmD0RyJX6dAKlF3l993qc4M=; b=s53g6I
	FJ86AGmLzJtt3f5NJUOG/zAUiQV2PXTt19TNBciI/eIKtiNQnHGdnlgcu/iBGgLB
	xojMufHZ1Le9ivgaX6t25Xzo1ls17/iERXLo/dv8H87o+r06wcKQRELYZCnHbf3W
	/MslfqTjG41/v4c653btmxsxJgmC/7D94wc3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ue8Mfq6Cz3QdGUXirA/IYKrSwyA4gLbL
	NZlwb84hJLp338yx4+TOxZBEEqlYboMJJG6NFV2GCNerP00r3Vp/7Z9IAgLeM195
	2nW4qxExTlw0KC2w+mpHnFbPFwBFoCqSSQ8mmizjpjyx58rjkAHTYuV0D4FpQqf7
	zNicQOSO72c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DED3ED2AC5;
	Wed,  1 Sep 2010 10:59:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27AA0D2AC4; Wed,  1 Sep
 2010 10:59:31 -0400 (EDT)
In-Reply-To: <1283321153-24745-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\,  1 Sep 2010 08\:05\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88024FEC-B5D9-11DF-8C42-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155049>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> opts.show_all_errors controls the number of errors that can be displayed,
> and set_porcelain_error_msgs gives the format. But the formatting would
> be incorrect if set_porcelain_error_msgs is called without setting
> opts.show_all_errors.

That makes it sound like a design bug of set_porcelain_error_msgs(), in
that the caller _cannot_ choose to stop at the first error if it wants to
use friendlier message than the plumbing one.

But if that is (and I do not think it is such a bad thing if we decide
that Porcelains have no option of stopping at the first error) then we
should set opts.show_all_errors in the set_porcelain_error_msgs()
function, and probably should rename the function to something saner.

The function is not about setting the error messages anymore (and it
sounds like it never has been since the current behaviour was introduced)
but is about declaring that we are a Porcelain and won't stop at the first
error.  We might end up introducing different behaviours later in this
function.

How about making it

	int setup_unpack_trees_porcelain(struct unpack_trees_options *opt,
						const char *cmd);

and possibly moving it from merge-recursive.c to unpack-trees.c?
