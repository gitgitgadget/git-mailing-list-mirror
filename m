From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Thu, 15 Mar 2012 14:09:26 -0700
Message-ID: <7vy5r1inax.fsf@alter.siamese.dyndns.org>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <1331736055-21019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8HvZ-0007OM-QK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 22:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030757Ab2COVJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 17:09:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031038Ab2COVJd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 17:09:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE9D7D53;
	Thu, 15 Mar 2012 17:09:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JkCi/2TNR7WT
	vNcW5Peaa5vDLaA=; b=S4xX/zJglHkJ0cPhZaQMhsL4T1DqPyI3b38AWOCU6vXZ
	YZsNY1zlTkS8100Q8f2f5Q6k7WYR3zOWP2UF/s9wVqt7RgE2y8A6+pYxwGnwv4Zb
	BOh19CLiMvHRTDE+TUf62wp1dqWdV4a2Mjs4+HTOOhpfZ6hU1UUSJMnn/pTUhQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hdQxxT
	25AtNSVanJG3L4knupY4SgpThFegbUoVgr+aJjtd2MAp8JfvT8yQJwnfDJ5ZkE4y
	TcI+UV8oTmm5MAkhgiiqVQcyfoP4SMLZ4SmHqHw0E9m6fqetMr8w7xbREZQ+90u/
	SmF5XND+1GH8MKZyHw0o44YxaXfSQLMQUHyEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D077D52;
	Thu, 15 Mar 2012 17:09:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05DD87D51; Thu, 15 Mar 2012
 17:09:27 -0400 (EDT)
In-Reply-To: <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 14 Mar
 2012 21:40:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 267F7992-6EE3-11E1-8860-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193227>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When we fetch or push, usually "git rev-list --verify-objects --not
> --all --stdin" is used to make sure that all objects between existing
> refs and new refs are good. This means no gaps in between, all object=
s
> are well-formed, object content agrees with its sha-1 signature.
>
> For the last one, --verify-objects calls check_sha1_signature() via
> parse_object(). check_sha1_signature() is an expensive operation,

After thinking about this a bit more, I am beginning to think that the
validation of object contents is unnecessary in _all_ cases that involv=
e
"git fetch".  Unpack-objects and index-pack already validate individual
objects, and the only thing we would want to catch are objects that we
already happened to have had in our repository but were unreferenced fr=
om
our refs.  But the codepaths that write out loose objects or packfiles
that must have left these objects during the earlier run in our reposit=
ory
should already have done the validation.

So the only thing that we would be catching with this extra check is a
loose object or a packfile that was deposited outside the control of gi=
t
in your repository.

But that is not something we should be trying to catch every time we ru=
n
fetch---if your repository is open to be written by a random person fro=
m
sideways bypassing git, you have a much bigger problem.  And we have th=
e
tool to catch that kind of breakage: "git fsck".

So the right solution is probably use --objects for connectivity checks=
 as
before; we could add a fetch.paranoid configuration to allow people to
still use it (with this patch to remove the over-pessimism from the cod=
e)
but only if they want to.

Cc'ing Shawn, as I took inspiration from him in the first place for the
update to --verify-objects (no, the overly-pessimistic implementation a=
nd
excess overhead you solved partially with this patch is not his fault b=
ut
is mine).

I said "partially" above in the parentheses because we would still end =
up
revalidating all the objects in quickfetch() check when you are fetchin=
g
from the repository that is your alternate, even with this patch.
