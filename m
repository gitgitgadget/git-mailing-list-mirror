From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: avoid work after --max-count is reached
Date: Fri, 13 Jul 2012 14:10:54 -0700
Message-ID: <7v7gu78izl.fsf@alter.siamese.dyndns.org>
References: <20120713075023.GA31618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 23:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spn8i-0003ay-6u
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 23:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823Ab2GMVK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 17:10:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab2GMVK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 17:10:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 512A289C6;
	Fri, 13 Jul 2012 17:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=czJHiS5Bkh1FAFvUGOx+pTCkzCY=; b=u+Lq14
	CJ4VnqAoNh9Bd11b4p3aFvjUYKXrC4ZMy8atOeIQA2EED1NaSZ7YfCUbVXeBjqrQ
	dl3+T2iV5gfV/QfYJk9LgFKLAdTbQeQY34gNOnoeNndxaZ36RexxurY9a7GjGZby
	azjLorGu0Wnq8OexkpSYxCZ/yMJZkyo6BTGUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jmLnVcUwalmKWPWeMgq1NV3ufvHmXZFz
	rkH6oD+8JVRXI405AanBH+w/CfRzLLI5hC8rswKSuLf6ERNPAOvZ1A05QbNyo13h
	AakRv5rK1/wMDGL/rXWb48X/O4aPY2vJ4XB+7XNpu/E50Phwzuwfg00w4Z2LIad2
	WXniHUyUIR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E62289C5;
	Fri, 13 Jul 2012 17:10:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A648489C4; Fri, 13 Jul 2012
 17:10:55 -0400 (EDT)
In-Reply-To: <20120713075023.GA31618@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Jul 2012 03:50:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C509B3E-CD2F-11E1-9911-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201423>

Jeff King <peff@peff.net> writes:

> There's no need to make this get_revision_1 call when our
> counter runs out. If we are not in --boundary mode, we will
> just throw away the result and immediately return NULL. If
> we are in --boundary mode, then we will still throw away the
> result, and then start showing the boundary commits.
>
> However, as git_revision_1 does not impact the boundary
> list, it should not have an impact.

We used to reset 'c' to NULL ("throw away the result"), run
create_boundary_commit_list(), and ask ourselves to pop the boundary
it computed.

Now we don't call get_revision_1() and leave 'c' to NULL as
initialized ("avoid work"), and do the same.

The state create_boundary_commit_list() sees would slightly be
different, as we used to dig one level deeper, smudging more commits
with bits, but the only bits that may be smudged by this digging
that may matter in create_commit_list() is CHILD_SHOWN and SHOWN,
but by definition the commits around the commit the extra call to
get_revision_1() would have returned are marked with neither during
that extra call, so I think this conversion does not affect the
boundary list.

So I think I like this change.  If anything, it makes the loop
structure simpler and a bit easier to understand.
