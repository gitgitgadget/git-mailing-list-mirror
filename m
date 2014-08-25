From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Mon, 25 Aug 2014 10:59:05 -0700
Message-ID: <xmqqd2bomowm.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 25 20:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLybV-0003Bb-DH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933139AbaHYSCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:02:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64415 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253AbaHYSCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:02:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 219CF33B67;
	Mon, 25 Aug 2014 14:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3QOCzHq7BqGsN7OYHbHsbjME2Y=; b=QYITK4
	vIIVRWxxjHKbn+yH0G6BGrTRQqgvVZNCuiCscIiZR95O0+KEwO4WtboCHLCXI1rg
	6Ic+1s0rXanQS01KPtt/WBVFxXOy6pY6PuZYckLKaahdazeRqF0QKWKfaNEgsk/J
	DF7HMog+42JtogE5eZO5ryO/8ZyJoL8b16vpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NF7qVUl8OpBcxlMNG9zh9VjLc1K3PmRE
	e3klnHfrBIptH/+XFCgFWzEvbl3YH/0SKU8alyE+AXrwYGqVSfQdVNZ907jdHhXE
	dLI1JX+FzQiSzVg+1qQIL98Mg7m2GIguQZH5DkSGHLXZVjz6d3fdUCHoNWoYLMGC
	xmyJ42fNpag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14F5A33B66;
	Mon, 25 Aug 2014 14:02:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B6923397A;
	Mon, 25 Aug 2014 13:59:08 -0400 (EDT)
In-Reply-To: <CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 22 Aug 2014 16:54:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82C8428E-2C81-11E4-B8FA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255845>

Shawn Pearce <spearce@spearce.org> writes:

> A stateless nonce could look like:
>
>   nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )
>
> where site_key is a private key known to the server. It doesn't have
> to be per-repo.
>
> receive-pack would then be willing to accept any nonce whose timestamp
> is within a window, e.g. 10 minutes of the current time, and whose
> signature verifies in the HMAC. The 10 minute window is important to
> allow clients time to generate the object list, perform delta
> compression, and begin transmitting to the server.

Hmph, don't you send the "finally tell the other end" the sequence
of "update this ref from old to new" and the packdata separately?  I
think we have a FLUSH in between, and the push certificate is given
before the FLUSH, which you do not have to wait for 10 minutes.
