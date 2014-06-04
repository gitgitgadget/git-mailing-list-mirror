From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for check_refname_component
Date: Wed, 04 Jun 2014 14:46:28 -0700
Message-ID: <xmqqsinktkjv.fsf@gitster.dls.corp.google.com>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
	<1401853091-15535-2-git-send-email-dturner@twitter.com>
	<538ED2F1.9030003@web.de> <1401916476.18134.165.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 23:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsJ15-0003za-LS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaFDVqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 17:46:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50486 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbaFDVqe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 17:46:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70FF11C150;
	Wed,  4 Jun 2014 17:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3ixFc6JSZReS
	RM6+tWWCK8PXR8M=; b=rCM0FPdAkMGA54WZJirRSqw/KDUNFsteMQ8jI/Bbt5qK
	N3Pt2tvgsFKIpKQ1GduUEzFuMhF1Ux9Ut/DeK5GAZtI8vubtdKeOM7PkYGph048l
	BMYjowsGu6yE6fFCOfZL7NWQ+PhgtLBQC4rC1oyIl/DFNdkEqTaBgPPpWecp+OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gogavl
	9UVdUNJQWJ1IkhxccWGxbN1mvCnu9j4dAS7tt8jLOVksAsCB/SXkUijKwbNnD52E
	KpeDuxRDoyVN+XYmTaQooPuvm78BuSm2N+reznZ3RBT+1b+f2SATsFDRD+Rj5/Xb
	UV48rjDlV7qDnc7CUTq2xeH2t+cwz+gA4suAc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 658491C14F;
	Wed,  4 Jun 2014 17:46:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6F0A1C14C;
	Wed,  4 Jun 2014 17:46:29 -0400 (EDT)
In-Reply-To: <1401916476.18134.165.camel@stross> (David Turner's message of
	"Wed, 04 Jun 2014 17:14:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AFC3974C-EC31-11E3-B276-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250795>

David Turner <dturner@twopensource.com> writes:

> On Wed, 2014-06-04 at 10:04 +0200, Torsten B=C3=B6gershausen wrote:
> [snip discussion of compiler flags; I'll look into a cpuid approach]

Hmmmm, I am not sure if the complexity is really worth it.

In any case, [PATCH 1/2] is fairly uncontroversial, so I am inclined
to queue it by itself early without waiting for the discussion on
2/2 to settle.

>> The name check_refname_component_1() doesn't tell too much,
>> (check_refname_component_sse42()  or check_refname_component_nonsse4=
2() say more)
>
> I'll go with "_bytewise", since that's how it works.

That naming assumes that there will never be any alternative
implementation of the bytewise checker other than the one that uses
sse42, no?

>> can I suggest to move all SSE code out to a file under compat/,
>> like compat/refs_sse42.c, or something similar ?
>
> Since this is a relatively small section of code, I think that would =
be
> overkill.  Does anyone else have an opinion?

If we foresee people on other architectures to invent different
vectorized implementations on their favourite archs, we may end up
separating it out into compat/.  I have no opinion on how likely
that will happen, though, and because this is a small piece of code
right now, it shouldn't be too painful to reorganize when the time
comes.
