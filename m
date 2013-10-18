From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs
Date: Fri, 18 Oct 2013 12:24:55 -0700
Message-ID: <xmqq7gdawfeg.fsf@gitster.dls.corp.google.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
	<CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
	<CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
	<20131018190537.GB11040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXFfS-0004Xn-DX
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab3JRTY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:24:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab3JRTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:24:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16E14BAF4;
	Fri, 18 Oct 2013 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ab/Daqv2kjW58MW/70vJL43Isgw=; b=S19Sev
	FSmMZe+h1CMUt0Vk+VK3qRA7vdbJL52niyf8JO+MhiGdBV5HGChNk4J9CWFB3v3e
	eEBMYjtN4e/dLhSiJ59GMjIiy7L1L/WHSgl/F8ECDzqdp6SnXMZokwgSvqjpT94s
	95pJ2v7Tukc2Z0ettLundvqWZABlScqbSe4R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MAedVrxzCDyXFH++mJ49LoMAjN1lXV1M
	mcET1bYIzF3/umWM1Zb/i5r5CZ24pCYBf9MurcQXwT+8PAyuYCeFInY5/ODwrYsB
	Xi99H/UlaD7XSXS5uaWyVEXbUuUEXtt80ZxhVtPUGzGD6Fka1p2BnwqqMiQFIac8
	xaxQzCBYAUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A53084BAF3;
	Fri, 18 Oct 2013 19:24:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B844BAF0;
	Fri, 18 Oct 2013 19:24:57 +0000 (UTC)
In-Reply-To: <20131018190537.GB11040@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 18 Oct 2013 15:05:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F92C5D3A-382A-11E3-B99E-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236366>

Jeff King <peff@peff.net> writes:

> I was almost tempted to say "we do not even need to run
> adjust_shared_perm twice", but we do, or we risk another race: one side
> loses the mkdir race, but wins the open() race, and writes to a
> wrong-permission directory. Of course, that should not matter unless the
> racers are two different users (in a shared repo), and in that case, we
> wins the adjust_shared_perm race, but does not have permission to change
> the mode.

Interesting.

> Agreed. We already leave a wrong-permission directory in place if it
> existed before we started create_tmpfile. The code before your patch,
> when racing with such a wrong-directory creator, would abort the
> tmpfile. Now it will correct the permissions. Either behavior seems fine
> to me (yours actually seems better, but the point is that it does not
> matter because they are dwarfed by the non-race cases where the
> directory is already sitting there).

Agreed.  We may notice the failure to correct the permissions in the
new code, where the old code left existing directories incorrect
permissions as they were.
