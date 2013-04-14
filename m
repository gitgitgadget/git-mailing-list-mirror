From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] commit: allow associating auxiliary info on-demand
Date: Sun, 14 Apr 2013 12:01:21 -0700
Message-ID: <7vfvyt543i.fsf@alter.siamese.dyndns.org>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-2-git-send-email-gitster@pobox.com>
 <20130414151229.GA1544@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSB6-0006l9-8l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab3DNTBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:01:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab3DNTBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:01:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4747E16F75;
	Sun, 14 Apr 2013 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+9iilknAWWmuRAfHewFGxjwhvGI=; b=weOzId
	noWG4JdyJcGgyGT/YD1tcZEl/zX4V8p/4FD+RyuBjI/NNeoz38JqZKyHPiDKadS3
	0RJRXXpWzKajh4t2a2AF8s2DhuzquL5KcsuBD1kLuA0tZZlOKvsUKQAJ/ZcAjOLx
	jq09boFiepk5ohdbp4EP8Ixj9IDHyuCJXCc4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JUS1lji8MiTDaZtLcCmn0U4POD66Pnh2
	zfJFirlSoDSUm01u5unliqj7GQt1VHZLqMnNhbZ++tHA44WeGiS9zYocaEL3E2OD
	TLMUsaASmfxAL92+xTcw0zWKa+aq8WlCPbM1EXm/LzrjCcc74+EH2Yn/UQAEiwf2
	o6lSAz5EFdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E86C16F74;
	Sun, 14 Apr 2013 19:01:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BEEF16F73; Sun, 14 Apr
 2013 19:01:22 +0000 (UTC)
In-Reply-To: <20130414151229.GA1544@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 14 Apr 2013 11:12:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2D1DAC8-A535-11E2-B139-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221152>

Jeff King <peff@peff.net> writes:

> Thanks, this writeup makes sense to me. Obviously,
>
>   Signed-off-by: Jeff King <peff@peff.net>
>
> Comparing a slab index versus a util pointer, I think the differences
> should be:
> ...
> So I think the util pointer is strictly better, except for point (2). And
> the main cost is point (1), the extra indirection. So if we can measure
> (1) and decide it isn't a big cost, the maintainability improvement for
> (2) is probably worth it, and we can rip out the util pointer entirely,
> saving us some extra space in "struct commit".

I am glad you brought up "util". In an earlier round of the indgree
thing, I think that it was discussed that casting the indegree to
(void *) and storing it there was a possibility.  Because sorting
was so generic a thing everybody may want in their codepath, and
some callers may already have something they want to keep in util,
we ended up adding a separate field not to interfere with the callers'
use of the util field.

In the simpler days, a single util used with careful coorination
among various codepaths may have been manageable, but I tend to
think it will become more and more cumbersome to extend the system
correctly (the same can be said for the in-object flags). We should
encourage the users of the util field to migrate to either slab or
decorate in the longer term.

A criterion to choose between the two is probably the density. The
slab mechanism is for annotations that almost everybody involved in
the processing gets, while decorate is more suited for sparse ones.
