From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] convert: fix normalization of foreign idents
Date: Thu, 09 Sep 2010 17:26:21 -0700
Message-ID: <7vmxrqjvf6.fsf@alter.siamese.dyndns.org>
References: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
 <E1Ot4NP-0002xn-Nc@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:26:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtrRr-0006Ua-1R
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab0IJA03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 20:26:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0IJA02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 20:26:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F14D4792;
	Thu,  9 Sep 2010 20:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DinHHK2KOFffaFaRHwmaX4rFZQU=; b=TO9a5b9gsGmtl5Ah+t4NJ8+
	BNPKmFH6bpilS715EyKJiGXqTWwAsOvKQuCT7EfScN7vECf3wP+fG4M4TGZ51Gr5
	zWWFhWk9doRXTGG9OEVk/sQW0eWhFUTJHzlIuvoWCVWDqxKebaeDElrKdvnodRIC
	4fOuyfb1CNKjlGwB+i+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GVWc7oYnol6Zarz6FP4xDvb91pzyMOLBkrGxXpaJ2DY7/TOh+
	01KxUVsgG5Fbd2kHy3KRghoekFKHN5AovrI+oEG8J1i0gXz2xjDyVV1MGxL2ExcX
	bmnyRWxPZT3r44LaCh+625gDDVVhp5X/SKsbxK79yeONFi7TPqVLIT0NeM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0E75D478F;
	Thu,  9 Sep 2010 20:26:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3117D477D; Thu,  9 Sep
 2010 20:26:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0BE5D31C-BC72-11DF-B4C1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155915>

Marcus Comstedt <marcus@mc.pp.se> writes:

> Since ident_to_worktree() does not touch $Id$ tags which contain
> foreign expansions in the repository, make sure that ident_to_git()
> does not either.  This fixes the problem that such files show
> spurious modification upon checkout.
>
> There is however one case where we want ident_to_git() to normalize
> the tag to $Id$ despite the asymmetry:  When committing a modification
> to a file which has a foreign ident, the foreign ident should be
> replaced with a regular git ident.  Thus, add a new parameter to
> convert_to_git() that indicates if we want the foreign idents
> normalized after all.

Would it be possible that the real culprit is that ident_to_worktree()
does not always touch $Id$ in the first place?  Why isn't "$Id: garbage$"
first cleaned and then smudged upon checkout?

It also smells wrong that this "sometimes we convert, sometimes we don't"
is a special case for "$Id$" and for no other conversion.  Why don't
smudge/clean filter or CRLF conversion have the same issue that can be
solved with the same approach as this patch takes?
