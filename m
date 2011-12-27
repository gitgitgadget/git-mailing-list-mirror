From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] write first for-merge ref to FETCH_HEAD first
Date: Tue, 27 Dec 2011 10:44:46 -0800
Message-ID: <7v1urp97mp.fsf@alter.siamese.dyndns.org>
References: <20111225173901.GA668@gnu.kitenet.net>
 <7vd3bb929n.fsf@alter.siamese.dyndns.org>
 <20111226161656.GB29582@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 27 19:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfc1W-0003NM-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 19:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab1L0Sou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 13:44:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab1L0Sot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 13:44:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BC945174;
	Tue, 27 Dec 2011 13:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lMbFWG0ni8h1UWTuj5UL5KNtb8=; b=mxDfrg
	LG6eTLvoIcJ0jZpay354a7EjsOZdc4DRGFIIJRfJXUZ3wtkhMlOQYRUJPTtCXRcX
	dqLAC71AzDlqpWhcRu1GM4JEvIrkW+AkcAEeXP4d1myJJgB5xFyEToNdM77feUCD
	dIxVhb/fG1+fS47JVDEOKbJWtvEZV+IGi2qbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZkvKvqgy2nit9spMuQ+b2j5/kt2jL/I
	6FhLIo+7DoFjS0K28g/keT5K3SnhXu9SEy+cYobUfPjUZBaCPY2zwW/OtXYAP1Fp
	Tm+UAV6Fq7LzCKNrRxdfrA4+5LEDlFlGCBWLF0Jan7Zycv1uI1q3RDj3wX2/QMAi
	I8rd4YzRByg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DEA5173;
	Tue, 27 Dec 2011 13:44:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8D8E5172; Tue, 27 Dec 2011
 13:44:47 -0500 (EST)
In-Reply-To: <20111226161656.GB29582@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 26 Dec 2011 12:16:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA239B2A-30BA-11E1-AEB4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187723>

Joey Hess <joey@kitenet.net> writes:

> The FETCH_HEAD refname is supposed to refer to the ref that was fetched
> and should be merged. However all fetched refs are written to
> .git/FETCH_HEAD in an arbitrary order, and resolve_ref_unsafe simply
> takes the first ref as the FETCH_HEAD, which is often the wrong one,
> when other branches were also fetched.
>
> The solution is to write the for-merge ref(s) to FETCH_HEAD first.
> Then, unless --append is used, the FETCH_HEAD refname behaves as intended.
> If the user uses --append, they presumably are doing so in order to
> preserve the old FETCH_HEAD.
>
> Also included a fix to documentation that assumes FETCH_HEAD contains
> only a single ref.

That "single ref" assumption is perfectly fine for the part of the
documentation you patched, actually. The "fetch" command-line the example
shows explicitly fetches a single ref.

It is a good idea to use rev-parse anyway, so the patch itself is good. A
potential problem of that example (I haven't re-tried these examples for
eons since they were written) comes from the fact that FETCH_HEAD contains
not just the object name of what we fetched, but also other information to
describe what happened to that fetched object.

> ---

Sign-off?

>  Documentation/git-read-tree.txt |    2 +-
>  builtin/fetch.c                 |  158 +++++++++++++++++++++------------------
>  2 files changed, 85 insertions(+), 75 deletions(-)
