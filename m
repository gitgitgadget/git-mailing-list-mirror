From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 04 Sep 2014 16:57:50 -0700
Message-ID: <xmqqha0nq6pt.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-19-git-send-email-gitster@pobox.com>
	<CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
	<xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
	<xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
	<CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:58:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPgul-0001bl-Ks
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 01:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbaIDX5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 19:57:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56298 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaIDX5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 19:57:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BA31383FC;
	Thu,  4 Sep 2014 19:57:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6tN4IbrD6ZT4YsfJKl4LQKaHocc=; b=gyo9Us
	MRriQKag7Z5Wxuzz7CGOQd808jhK5l2InX3XiyU3QjaWgNYfn8QfsbrjF21gbyVL
	Si+MyjLH2ln1ceVxCrE938dRFDZwhRuzROyJ8clAzd+9i+gVUbrHzehXDeM3PtKW
	GjgQrS+TwB1TFrfkG9qVfqYvOeICn5cX0y5zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K1t3BQhkh13DO+laEqx21GqLwWRtIWCW
	OepiwCLTguLI/dFvG21BKeArYDQzDLqNoiTsNWcxErmnX0/u7NFJD0By9jvK8yNP
	Gmf0g25JeM4pf7bOcVu/xCXTw9Oy3j6ysXPVvTLYPix4kPHzWb3KvLAVvsWsuYFg
	5Lr46ajjDkI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 311BD383FB;
	Thu,  4 Sep 2014 19:57:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD547383FA;
	Thu,  4 Sep 2014 19:57:51 -0400 (EDT)
In-Reply-To: <CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 22 Aug 2014 16:54:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 47C78738-348F-11E4-AA77-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256491>

Shawn Pearce <spearce@spearce.org> writes:

> As you know, the stateless HTTP thing doesn't allow the nonce on the
> server to be carried from the initial ref advertisement into the final
> receive-pack. We would either need to write the nonce to disk and load
> it back up later (ick), or use some sort of stateless nonce.
>
> A stateless nonce could look like:
>
>   nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )
>
> where site_key is a private key known to the server. It doesn't have
> to be per-repo.

Doing the above naively will force you to check 600 HMAC if your
slack is for 10 minutes.  You could just instead use

	nonce = now '-' HMAC_SHA1(path + '.' + now, site_key)

and the validation side can make sure the same site_key was used,
and also "now" readable from the plaintext part is fresh enough,
with a single HMAC.

I may be missing something, but with this, we can always validate
that "nonce" is what the repository issued (whether "stateless" is
used or not).  The hook script can decide if "now" is recent enough
or not without bothering receive-pack at all.
