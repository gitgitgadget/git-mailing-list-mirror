From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] sha1_file: keep track of where an SHA-1 object comes
 from
Date: Thu, 24 Jan 2013 09:45:54 -0800
Message-ID: <7va9rycw4t.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyQsV-0003ps-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 18:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3AXRp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 12:45:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab3AXRp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 12:45:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1B6BB381;
	Thu, 24 Jan 2013 12:45:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AhSMu5WjOzZU
	EQcsTHsou06KjBY=; b=ED00iRFBtGM6XmxkJh7d9ErQS/klYSgz3Di31PbSCb4b
	kl0y6iRp75dF8cyIJxF6NkxIvCRAerEgrUeysQVFQHAO12oCTY02oh2qL4B8GA21
	0pR+TgKusqWOyp8o60jV9mU7g/lThMe/FirHFAq7V1K8Jnb0nRR4EbJNmkJ4Iv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j8WWCF
	xZh0WiB4UKFII3p+9KZ2QKFLkH48+z0qzT/tsumB/MX4Xqgkjb2lu4a8YR+qOTwy
	K381ZC0LbeagRjEAHVmVTdYpC0iAr1SakuDYX7P9ZpHgq+CcwzDDSKXQdiNF1o7W
	ASLsOj/w2NLiJLplZ+SFdjM0MN2LXkoXH1Ivw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6073B380;
	Thu, 24 Jan 2013 12:45:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C538B37E; Thu, 24 Jan 2013
 12:45:55 -0500 (EST)
In-Reply-To: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24 Jan
 2013 15:42:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7B72094-664D-11E2-A3E9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214435>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> We currently know if an object is loose or packed. We do not know if
> it's from the repo's object database, or via alternates
> mechanism. With this patch, sha1_object_info_extended() can tell if a=
n
> object comes from alternates source (and which one).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  How about this way instead: we keep track of where objects come from
>  so we can verify object source when we create or update something
>  that contains SHA-1.

The overall approach taken by this series may be worth considering, but
I do not think the check implemented here is correct.

An object may be found in an alternate odb but we may also have our
own copy of the same object.  You need to prove that a suspicious
object is visible to us *ONLY* through add_submodule_odb().

Once you do add_submodule_odb() to contaminate our object pool, you
make everything a suspicious object that needs to be checked; that
is the worst part of the story.

If I understand the test case that triggers the issue correctly, it
makes a merge in the top-level superproject, and while doing so,
tries to three-way merge gitlink changes, so that it can detect
fast-forward situation inside the submodule.  It should just be done
with running "git merge-base A B" there; after all, we are in the
tree-wide merge of the top-level superproject, which is already a
heavy-weight operation. I do not see a reason to make it more brittle
than necessary.

If we rip out add_submodule_odb() we do not have to ever worry about
this kind of object database breakages that are hard to track down.
It is an optimization to allow the code become more brittle, violate
the project boundary, and break the object database faster as a
result.  That is not a good optimization at all.
