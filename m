From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive pruning
Date: Wed, 27 Apr 2016 14:15:16 -0700
Message-ID: <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	<xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	<1461788637.11504.3.camel@twopensource.com>
	<xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:15:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWnt-00089W-58
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcD0VPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:15:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752170AbcD0VPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:15:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C75816693;
	Wed, 27 Apr 2016 17:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k8GeJwMEOvMoNvyaubz8cSaib7s=; b=Kvl0EZ
	b2zmucN0ODc/xAh4ffmf19DzzJrvZlDzOUr8raDsfIuCZpWHr53ip3RtU2lOkuP6
	OGD1pjWgHEqMFROi0zEdk/U+yUwrZqc2boRgcQnLTRSq9ydSdyeZI+t6Bs29U8YY
	KxP32Gh6SSTkAySAr3sWqXF4B5rcGiAGwlXY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VAbiKd8O4wkEyyPs24BgGJR4jIGaGy2Y
	twskxD8qWBFTsRDHqc4a9eEMPODued9UAAiteGXYmN9qFeQ9Spc5CA9wxUTLS4vJ
	vKDUO2MP7gkMjh3mVRihQu813CjxEvizeeS3IJIWb/TUQE9GId14wOohqFPyEkjq
	MpMciBryNwY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00FAD16692;
	Wed, 27 Apr 2016 17:15:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ED4E1668E;
	Wed, 27 Apr 2016 17:15:18 -0400 (EDT)
In-Reply-To: <xmqqh9em93xo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Apr 2016 13:45:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 249D1ED2-0CBD-11E6-8CB5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292827>

Junio C Hamano <gitster@pobox.com> writes:

> If a casual reader sees this code:
>
>     ref_transaction_delete(transaction, r->name, r->sha1,
> 			   REF_ISPRUNING | REF_NODEREF, NULL, &err)
>
> it gives an incorrect impression that there may also be a valid case
> to make a "delete" call with ISPRUNING alone without NODEREF, in
> other codepaths and under certain conditions, and write an incorrect
>
>     ref_transaction_delete(transaction, refname, sha1,
> 			   REF_ISPRUNING, NULL, &err)
>
> in her new code.  Or a careless programmer and reviewer may not even
> memorize and remember what the new world order is when they see such
> a code and let it pass.
>
> As I understand that we declare that "to prune a ref from set of
> loose refs is to prune the named one, never following a symbolic
> ref" is the new world order with this patch, making sure that
> ISPRUNING automatically and always mean NODEREF will eliminate the
> possibility that any new code makes an incorrect call to "delete",
> which I think is much better.

... but my understanding of the point of this patch may be flawed,
in which case I of course am willing to be enlightened ;-)
