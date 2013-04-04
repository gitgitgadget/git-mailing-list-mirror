From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Thu, 04 Apr 2013 13:48:52 -0700
Message-ID: <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNr68-0003ey-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761581Ab3DDUs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:48:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760973Ab3DDUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:48:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4060D132F6;
	Thu,  4 Apr 2013 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yXNkVYfxLoj8dy5UkgwaWw9CtDw=; b=OAeUQl
	DAtsDpOQZ60gyp5D6nt10eRZ/D5TvXHAswQTg4/kF9+QrCAQWmb54jwSTfeKP40G
	4KlZvjxG/nX5ecrumdb3gYQF9tTgWcZCXtMyhWm3oICl/T/edsTiuwY67jozdf5Z
	vkfoHd/bvnrbuWmi8Dc7wMSoQEAsn6D73TKHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmCVKkhy1bkc1+siBO5oPftcTq+deu4+
	MWZhUjZS4wcn45VEmRj1q5DQbCua9a9J0tG2oIFwktv/d3J8rdHVHJ4vq+WkPQBG
	HnliWcQMflw5ylA4NXjC1WLKKyq1HqgyG7xRxFK5gDNCn/CdqS5DQ1XiEv/YDnYT
	MVf5jiJ9aCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34332132F5;
	Thu,  4 Apr 2013 20:48:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F9A8132F1; Thu,  4 Apr
 2013 20:48:53 +0000 (UTC)
In-Reply-To: <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
 (Simon Ruderich's message of "Thu, 4 Apr 2013 22:20:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FC12AE2-9D69-11E2-96C7-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220099>

Simon Ruderich <simon@ruderich.org> writes:

> get_textconv() is called in diff_grep() to determine the textconv driver
> before calling fill_one() and then again in fill_one(). Remove this
> unnecessary call by determining the textconv driver before calling
> fill_one().

If I am reading the code correctly, it is has_changes(), which is
used for "log -S" (not "log -G" that uses diff_grep()), that does
the unnecessary get_textconv() unconditionally.  The way diff_grep() 
divides the work to make fill_one() responsible for filling the
textconv as necessary is internally consistent, and there is no
unnecessary call.

Perhaps...

	The fill_one() function is responsible for finding and
	filling the textconv filter as necessary, and is called by
	diff_grep() function that implements "git log -G<pattern>".

	The has_changes() function calls get_textconv() for two
	sides being compared, before it checks to see if it was
	asked to perform the pickaxe limiting with the -S option.
	Move the code around to avoid this wastage.  After that,
	fill_one() is called to use the textconv.

	By adding get_textconv() to diff_grep() and relieving
	fill_one() of responsibility to find the textconv filter, we
	can avoid calling get_textconv() twice.

Explained that way, it makes me wonder why we cannot fix it the
other way around, that is, not fetching textconv in has_changes()
and instead letting fill_one() to find textconv as needed.

The answer is because has_changes() itself looks at the textconv.

But we have to wonder why it is so.  diff_grep() short-circuits when
the two sides are identical and has_changes() has a similar but
different logic to check if the identical two sides are processed
with the same textconv filter before saying this filepair is
uninteresting.

Shouldn't that logic be unified as well?
