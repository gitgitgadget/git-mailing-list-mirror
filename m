From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 13:50:50 -0800
Message-ID: <xmqqd25waqf9.fsf@gitster.dls.corp.google.com>
References: <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
	<xmqq61bocao1.fsf@gitster.dls.corp.google.com>
	<xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
	<20150130201620.GA4133@peff.net>
	<xmqqwq44auml.fsf@gitster.dls.corp.google.com>
	<20150130204805.GA10616@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 22:51:01 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHJSt-0002WR-Pj
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 22:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763455AbbA3Vuz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 16:50:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbbA3Vux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 16:50:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B483E33767;
	Fri, 30 Jan 2015 16:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9nXtqQG5c7Z/UeNIpHcyfnykTeI=; b=JbRbQh
	BDe1teUFAsEnMgMQtl85XvU3ALo4K5AQXY10o/GzPZ7ezrwzYxnAhjrzyOYt4Sxu
	ukjhwO0JgKTx13+qOvvlJNaFSABZdDkl26RcJ/UpsWzE/S5A55ArIieQUwtN0Vwz
	XWugv6joyUb3IgL4faA3DOvRpdKReoi+qH+mE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SAyZwxDLDES3YABk8YUNWf5b5Bn4NyPC
	JcMpPKrAyzQ/ENIER4MEYv3FFjdFV8pVrjMaliPty2vUXJ58XuAMegarxgVGEeua
	MOAH9mFtVB+ooB8/XV46P6+x7+oCFErzY6Dfp1paZzi9qEqs8R+TP9B+GglcLXu9
	FApJ6oSSi98=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8A7233763;
	Fri, 30 Jan 2015 16:50:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177CE33762;
	Fri, 30 Jan 2015 16:50:52 -0500 (EST)
In-Reply-To: <20150130204805.GA10616@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 15:48:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F503256-A8CA-11E4-B236-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263200>

Jeff King <peff@peff.net> writes:

> But could we instead pull this check to just before the write-out time?
> That is, to let any horrible thing happen in-core, as long as what we
> write out to the index and the filesystem is sane?

The check in-core is somewhat tricky, because we would need to (1)
catch a patch that creates a symlink and also a file as if that new
symlink is a directory and (2) allow a patch that removes a symlink
and also a file in a new directory at the location removed symlink
used to occupy.

For (1) we need to see if there is a patch in the entire input that
creates a symbolic link and reject the input.  For (2) we need to
see if there is a patch that removes the symbolic link.  (1) cannot
be caught with the approach based on fn_table[], which is inherently
meant to help incremental application, that is oblivious to a path
that will materialize after applying a later patch in the input.

Let me think about it a bit more.  The fix probably needs to abandon
depending on fn_table[] stuff, if we want to do in the "sanity check
the input and compute the final state all in-core" route.
