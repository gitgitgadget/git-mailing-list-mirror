From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Mon, 26 Sep 2011 16:23:55 -0700
Message-ID: <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:24:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KWq-0003k3-IA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab1IZXYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:24:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab1IZXX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:23:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 017CD4A51;
	Mon, 26 Sep 2011 19:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/4PccAz3t8PCIWkCVJjArtlxALs=; b=rL+HZa
	Zx+LeJU0scTqsMmvaPRamg0FOKheA3K56+7a6zFJZodKyNEfiBBa7Ef0JGZpM21u
	9tjOhqY44aMhUfvoBRAxObBNJRPESLSKYQNJUfzFn2ndbeOl5liaVjVE4S3NUa1V
	lYQkqvQ+9oNp3Qv2Rgibm/m1vdokU0Xye8ob0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ih7BmF9mxaOMz0hyK3lMC3+1t8VqcJqi
	GyX8jcdyCbyvN2THIDEoEg1jDk0KsBQgCTDsb6RRhNPElinpwcDkgSL6ctG1WMp5
	89J5INu8bFIsURQiPd4nwQ8HdIX5CYZ5suOtkh53bRgo1wvfon8eI5GRiZsbVg/o
	9gNxp2jRsOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA2694A50;
	Mon, 26 Sep 2011 19:23:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 530C84A4D; Mon, 26 Sep 2011
 19:23:57 -0400 (EDT)
In-Reply-To: <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com> (Sitaram
 Chamarty's message of "Sun, 25 Sep 2011 17:35:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B8C5F30-E896-11E0-BD05-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182188>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> From a philosophical point of view, update and pre-receive *check*
> things to make sure everything is OK.  IMO they should be allowed to
> run even if the ref being deleted doesn't exist -- that could well be
> an error condition that the guy who owns the repo wants to trap and
> alert himself to in some special way.  I would *not* like them
> disabled.

I think this is a sane thing to do.

> Post-{update,receive} are for *after* a successful push.  My
> suggestion would be to make sure the inputs supplied to those hooks
> (via STDIN for post-receive, and as arguments in case of post-update)
> reflect this -- only successfully updated refs are sent in as args.

Perhaps sane.

> This might mean that in the case of 'git push origin
> :refs/heads/non-existent-ref' the post-receive hook would run but
> STDIN would be empty, and post-update would run but have no arguments.

Hmm?

In that case (if "non-existent-ref" was indeed non-existent, and not just
pointing at a dangling commit), I would say the post anything hook should
not be called for that ref.  These hooks of course need to run if there
are _other_ refs that were updated, though, to handle these _other_ refs,
but I do not think they should be told about the no-op.
