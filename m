From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] clone: open a shortcut for connectivity check
Date: Fri, 03 May 2013 09:15:15 -0700
Message-ID: <7vwqrgxcoc.fsf@alter.siamese.dyndns.org>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 18:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYIdo-0002JW-51
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 18:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005Ab3ECQPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 12:15:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759413Ab3ECQPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 May 2013 12:15:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C6E1B402;
	Fri,  3 May 2013 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kabOLvWBWajp
	AKDIDVeQKcndMsk=; b=K0KVoKsO3aKNwD5w1BvkGD90fZofhRKRgNxNYAGT+sGV
	pjapQz4cvlAeJTMNhRN2Ee48SUJQq7zYPRaV2wk9CmwhfcjH0xudwX/ox/k7PoMq
	FW987psCyXnXob5WNF07rELOZMSKxS1NjvXcanTGAlv6KdMZq92JqlBSb8gDrlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jMa4J4
	0UeoR/YrC0h4cpFg9J06EUp4CPdafyn86Yxnvo06/jHvIkM4LyUZ+nPVIiMappF8
	tama6ZqAUSYdsSq+X9QpEfjPPWZ39VHD9HGBCDqwqL0UCVpg4fvaqDjk5ZTEfVTv
	44UGSJ8noMDwErA+EFiV7EMZePKOCYKqvjDHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47BC31B401;
	Fri,  3 May 2013 16:15:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2A291B400;
	Fri,  3 May 2013 16:15:16 +0000 (UTC)
In-Reply-To: <1367584514-19806-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 May
 2013 19:35:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A47C191C-B40C-11E2-8F79-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223314>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In order to make sure the cloned repository is good, we run "rev-list
> --objects --not --all $new_refs" on the repository. This is expensive
> on large repositories. This patch attempts to mitigate the impact in
> this special case.
>
> In the "good" clone case, we only have one pack.

If "On large repositories" is the focus, we need to take into
account the fact that pack.packSizeLimit can split and store the
incoming packstream to multiple packs, so "only have one pack" is
misleading.

I think you can still do the same trick even when we split the pack
as index-pack will keep track of the objects it saw in the same
incoming pack stream (but I am writing this from memory without
looking at the original code you are touching, so please double
check).

> If all of the
> following are met, we can be sure that all objects reachable from the
> new refs exist, which is the intention of running "rev-list ...":
>
>  - all refs point to an object in the pack
>  - there are no dangling pointers in any object in the pack
>  - no objects in the pack point to objects outside the pack
>
> The second and third checks can be done with the help of index-pack a=
s
> a slight variation of --strict check (which introduces a new conditio=
n
> for the shortcut: pack transfer must be used and the number of object=
s
> large enough to call index-pack). The first is checked in
> check_everything_connected after we get an "ok" from index-pack.
>
> "index-pack + new checks" is still faster than the current "index-pac=
k
> + rev-list", which is the whole point of this patch. If any of the

Does the same check apply if we end up on the unpack-objects
codepath?

> This shortcut is not applied to shallow clones, partly because shallo=
w
> clones should have no more objects than a usual fetch and the cost of
> rev-list is acceptable, partly to avoid dealing with corner cases whe=
n
> grafting is involved.
