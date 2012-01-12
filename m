From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 10:25:17 -0800
Message-ID: <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPLA-0001oF-ME
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab2ALSZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 13:25:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab2ALSZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 13:25:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B27626519;
	Thu, 12 Jan 2012 13:25:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOM1mx+nT546CI8y26dkDbE57dI=; b=HhSUjp
	PHibhdwQV2SvZzwVCCm1zVAVxu2Ib7z+5mwdzAKtuTkOXR0kS+I/K2VL8vWZ/2DG
	7SUJIDHDB1VpFXTs3g8P0mNX1jH0N0nr3jv0bEtN5pf4DUFmPIzCevi8Zd99O1A6
	LXtSx1ZorHHcNrIMkzA2V2UiHN961KEHdIilo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4aZVjoUAH4GyjOfGXyNrzSmVqIAVSHr
	bxXFtouQ5d329DqkTW/2VcqGi3xZjN9ZN9dx2qamXOZwWTQUU4HhglhbtpVfKWy7
	ePuW8SPqaFNGL93gJLDKYfxmUUiK//INRgIu/EsgyMAL0l55k4xPuFt2M4Ki+2l+
	bCg/6rsSJT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9A66518;
	Thu, 12 Jan 2012 13:25:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BD6D6517; Thu, 12 Jan 2012
 13:25:19 -0500 (EST)
In-Reply-To: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 12 Jan 2012 22:39:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8114896-3D4A-11E1-B33D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188465>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> What are your thoughts on making it a flag in the revision API to be
> activated with "cherry-pick --literal-order commit1 commit3 commit2"
> or similar?

That is an insane UI for the sake of flexibility.

You should be able to look at revs->cmdline and tell if you need to let
cherry-pick walk (i.e. "cherry-pick master..next"), or if the user wants
individual commits (i.e. "cherry-pick A B C").

And you do prepare_revision_walk() only when you need to walk; otherwise
you use the contents of revs->pending in order.
