From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Tue, 20 May 2014 13:29:42 -0700
Message-ID: <xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
References: <537B2FA4.7020001@opera.com> <537B30E7.5020505@opera.com>
	<xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:29:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmqfZ-0006qV-KD
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 22:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbaETU3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 16:29:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbaETU3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 16:29:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E5C3185AA;
	Tue, 20 May 2014 16:29:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pSptyDm/+aiDdm1vP/cLXyJOvDo=; b=dEO7r9
	Nz2UhocXk4vrZBwTR5ROnIlc1u3cmCLfr4FIP19+OUF27Tnc1LptPFljrBtHcJlc
	oWCU9j2nvge08ACEDTQbVtl+MjYIGtedZH6NkkvAK6IkhsWbUwG5PvrPxnu5Kxq9
	lcjsDRh7RTW9nIqMvbcZNbsXLlgwFECDc++O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4YAjtA3mhDnX5FZFIpiMAQCNvUMnyZ+
	IT5y/KbSpkwLkr6AJMYEIs9ouXJ2qqqntOZvlEYNbBA7MaYpBVQaFBwcs/ajEMUl
	gRI2XA+1nV+TOTWxxyaAldPNnqm7lgJkSr/W0WCTcDMY8+p3LO6p++WVEdPmrNs2
	CKO4Gm1cNAA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55EAE185A8;
	Tue, 20 May 2014 16:29:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6815C185A6;
	Tue, 20 May 2014 16:29:44 -0400 (EDT)
In-Reply-To: <xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 May 2014 12:30:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A93CFB8-E05D-11E3-95F1-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249738>

Junio C Hamano <gitster@pobox.com> writes:

> A bit safer way to organize might be to first create a list of the
> refs to be removed in-core, update packed-refs without these refs to
> be removed, and then finally remove the loose ones, but I haven't
> thought things through.

Perhaps a removal of remote can go in this order to be resistant
against an abort-in-the-middle.

 * update packed-refs without the refs that came from the remote.

   - when interrupted before the new temporary file is renamed to
     the final, it would be a no-op.

   - when interrupted after the rename, only some refs that came
     from the remote may disappear.

 * remove the loose refs that came from the remote.

 * finally, remove the configuration related to the remote.

This order would let you interrupt "remote rm" without leaving the
repository in a broken state.  Before the final state, it may appear
that you have some but not all remote-tracking refs from the remote
in your repository, but you would not have any ref that point at an
obsolete object.  Running "remote rm" again, once it finishes, will
give you the desired result.

A longer-term goal might be to have ref-transaction infrastructure
clever enough to coalesce the "repack-without-these-refs" requests
into one automatically without forcing the callers you are fixing
care about these things, though.  And such a transaction semantics
may have to also cover the updating of configuration files.
