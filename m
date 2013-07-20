From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] config: improve support for http.<url>.* settings
Date: Fri, 19 Jul 2013 17:35:57 -0700
Message-ID: <7va9lit6du.fsf@alter.siamese.dyndns.org>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
	<2cca0770a1e8495ac1418834c57f23d@f74d39fa044aa309eaea14b9f57fe79>
	<7vehauuxqo.fsf@alter.siamese.dyndns.org>
	<2544648C-9660-48F0-888A-E78E31477A89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 02:36:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0L9Z-0006C2-6M
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 02:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3GTAgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 20:36:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab3GTAf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 20:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A487264EE;
	Sat, 20 Jul 2013 00:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yquIZt4AL/hJ/XFbCSfrhigFFU0=; b=A+E/k8
	hFDKxBwATTFaW/Yk1weRGS9gCSYZ0WpahznisbeSSsbtz+k7jyoInSwVIEdp03f7
	URoRxO/kTSnCACvaiQdqsRIKmnZCAzXX/bHkBYISkZCH6+wX+lffltVlG3JgiEHz
	eDZSxqCZjpJP8Eti8YOqFp7rhdEzcg5p470ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQVExv2pQgvqzQ7wkbh41/vYUPl9ia90
	y4uEPEfJWY6J7wiIyStC+Sv9uH9sKnZp2HNVJMoAfwLGxeUR7fwAas6ycrjjN4rC
	Ld5xHS2pw7od95yVhjqPaDpWumdZMXG2/Y/bFr4Wl6G8BGwm9tju4Lc8sAyYDi5U
	EQQfsfPuvBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306AC264ED;
	Sat, 20 Jul 2013 00:35:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 846F1264EB;
	Sat, 20 Jul 2013 00:35:58 +0000 (UTC)
In-Reply-To: <2544648C-9660-48F0-888A-E78E31477A89@gmail.com> (Kyle J. McKay's
	message of "Fri, 19 Jul 2013 16:37:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58B23D7C-F0D4-11E2-BA9B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230869>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> If you mean for all the strchr etc. calls, multiple tables would be
> required since URL_SCHEME_CHARS and URL_HOST_CHARS partially overlap,

The entries of the table could be at least 8-bit wide, so there
shouldn't be any problem, should there?

> but it could be done.  Is the speed of strchr that much of a concern?
> The code will only be invoked for http.<url>.* option settings in any
> case and I expect the user would have to set an awfully large number
> of those to even begin to notice.

We can start slow and then optimize, but I suspect that there are
sufficient number of people who are into micro-optimizing, and such
a slow implementation may quickly be replaced.
