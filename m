From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Fri, 07 Jan 2011 11:44:34 -0800
Message-ID: <7vzkrc5wil.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIEx-0004xJ-Ij
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab1AGTom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 14:44:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1AGTol convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 14:44:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAE2E3551;
	Fri,  7 Jan 2011 14:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yI5sC0gNjwkC
	M+uv1nBSpl6TRAY=; b=kpaSlK3pEpniw22q47ARguUdfCB8zidSXMrDj90YJmeo
	wJUKRKnYxKCBYt4do3LrudOYl6XodJFsZBonLvbFCCkVOSzl6AMsMUz5tsj2H8Rp
	LO/uRigMLEFQxrlVkDA2NKHsElUxd6qF9C4BUkSsW3sJyD3CJYTqnoCtYoK23+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iELfUR
	G9RZZMwWkO5uLF+S4z2n6qhMecV7DEwTSK1ml+2/Os0zlXy+gEFrYVMb4700QLJO
	pZVDpg7vx3+4r247p1OkGF4IYAIFFchaCpSC8DZyCALPZeIv6T4Vdkhrt2e0afiI
	idwoseQdA8OHrAKIie9yy887GcQxL9Eo6oXHQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B63343550;
	Fri,  7 Jan 2011 14:45:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C5B40354D; Fri,  7 Jan 2011
 14:45:14 -0500 (EST)
In-Reply-To: <20110107104650.GA5399@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?= message of "Fri\, 7 Jan 2011 11\:46\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A766F0A0-1A96-11E0-BF3E-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164748>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEAD
> points to refs/heads/sgu/mxs-amba-uart

I somehow thought that we had an explicit logic to favor an exact branc=
h
name for "git checkout $branch" even when refs/something-other-than-hea=
d/$branch=20
exists, while issuing the ambiguity warning.

Ahh, what this part of the code in builtin/checkout.c does is totally
wrong:

	/* we can't end up being in (2) anymore, eat the argument */
	argv++;
	argc--;

	new.name =3D arg;
	if ((new.commit =3D lookup_commit_reference_gently(rev, 1))) {
		setup_branch_path(&new);

		if ((check_ref_format(new.path) =3D=3D CHECK_REF_FORMAT_OK) &&
		    resolve_ref(new.path, rev, 1, NULL))
			;
		else
			new.path =3D NULL;
		parse_commit(new.commit);
		source_tree =3D new.commit->tree;
	} else
		source_tree =3D parse_tree_indirect(rev);

It uses lookup_commit_reference_gently() that follows the usual
tags-then-heads preference order, but then uses setup_branch_path() to
prefix the raw name with "refs/heads", which is totally backwards.
It should do something like:

 - use setup-branch-path to get refs/heads/$name

 - check-ref-format and resolve it; if these fail, then we are detachin=
g
   head at rev;

 - otherwise, if the result of the resolution is not the same as rev, w=
hat
   we have in rev is incorrect (it was taken from the usual
   tags-then-heads rule but "checkout $name" must favor local branches)=
=2E
   update the rev with the result of resolving refs/heads/$name

 - parse new.commit out of rev.  we are checking out the branch $name.
