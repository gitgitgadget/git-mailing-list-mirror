From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Thu, 07 Apr 2011 15:43:30 -0700
Message-ID: <7vsjtt65t9.fsf@alter.siamese.dyndns.org>
References: <201104071549.37187.johan@herland.net>
 <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	tutufan@gmail.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:43:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7xvb-0006sB-0H
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 00:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab1DGWnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 18:43:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab1DGWnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 18:43:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E659055DC;
	Thu,  7 Apr 2011 18:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSaL4QWFPz/jYW4YNcS/AMDTXQI=; b=WoI6qb
	/9OVDoo5Gm2Oj+f8X9gQIuvMoXBRvY3d8m7QDmGfE6mi0JaBz7G7Fw1z1Adjbdtr
	y3kKj7OBgE6QMvFwFqhsq+zemoJf5uRVWfeQTiAJ37ENcDHT49QS6uXBW7G9zqZ9
	wnzR00kZP2uRgXip8VjL7L5EL5JPQTKGoxTe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wunZnEicFEupvbpK09Che/3L93NulkE5
	EeSQgD+gPVbVIg9I+jaS95JM4T4LuQXP/mnFx42YzYTfPKdjbezgkpgzYPgNWsp9
	TyFuEq75kUuspXi452fgJRbXMKHqbkD4vAidCMQHXlFWmcH8fUlbaKKtA9V7oA/m
	bup92y1tgxA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A34CE55DB;
	Thu,  7 Apr 2011 18:45:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F6B655DA; Thu,  7 Apr 2011
 18:45:27 -0400 (EDT)
In-Reply-To: <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 7 Apr 2011 07:56:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF56BABA-6168-11E0-8C6B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171089>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, honestly, for dirstat, the big issue was that it made it
> really really simple. Look at how small the dirstat patch was (commit
> 7df7c019c2a4), and realize that it's because it just re-used the
> existing damage counting code.

Yes, the most of the logic added by the patch is to percolate the damage
point up the tree to either coalesce or filter the result into manageable
size.

Speaking of that logic, I've been wondering for about a year and a half if
this "if (permille)" exclusion was intentional:

	/*
	 * We don't report dirstat's for
	 *  - the top level
	 *  - or cases where everything came from a single directory
	 *    under this directory (sources == 1).
	 */
	if (baselen && sources != 1) {
		int permille = this_dir * 1000 / changed;
		if (permille) {
			int percent = permille / 10;
			if (percent >= dir->percent) {
				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
					percent, permille % 10, baselen, base);
				if (!dir->cumulative)
					return 0;
			}
		}
	}

If the user sets dir->percent to zero, with an expectation that it will
disable all filtering, shouldn't we show everything?
