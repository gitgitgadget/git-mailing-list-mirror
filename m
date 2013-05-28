From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix segfault with git log -c --follow
Date: Tue, 28 May 2013 10:22:17 -0700
Message-ID: <7vk3mj10l2.fsf@alter.siamese.dyndns.org>
References: <20130527224957.GA7492@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 28 19:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNbM-0006VY-RO
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781Ab3E1RWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:22:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934735Ab3E1RWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:22:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07C923432;
	Tue, 28 May 2013 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0PMnGCpx29UsW3Z0IaugkqHOhvo=; b=jeSXOG
	xVIqhrhEbVcC6MpPdQLdx53OVLiK4gp+Rers4xm4x97CX2JubHE8o0u6CGeR5SN/
	opWo/1x1jQzzgMTnnioUsEnYQfYwJ26pzPivoonp5lx4RcR6+4s8qmcWJDJVgAw+
	RUKIfrFujyNC/rhOh5txI9vvC8PJYnCUcFOzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xCCMIWMRuECi8r9eti+gkjTLVFHOcCjV
	YO9djkWVZx/lJMsxxaq8V05C7YvuEfAeefw+Xf4YlxJnJGjLlRZedzaqVMJRnbO0
	QCzCNKmwJFABosLyhJgXRPLMP8BK1BjV+vr8vw+mvUdjgIODLpBM1+mcaqw9X8Pk
	WJpeYq0rJg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C579C23431;
	Tue, 28 May 2013 17:22:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23D6F23430;
	Tue, 28 May 2013 17:22:19 +0000 (UTC)
In-Reply-To: <20130527224957.GA7492@ecki> (Clemens Buchacher's message of
	"Tue, 28 May 2013 00:49:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2665C222-C7BB-11E2-8B04-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225672>

Clemens Buchacher <drizzd@aon.at> writes:

> In diff_tree_combined we make a copy of diffopts. In
> try_to_follow_renames, called via diff_tree_sha1, we free and
> re-initialize diffopts->pathspec->items. Since we did not make a deep
> copy of diffopts in diff_tree_combined, the original diffopts does not
> get the update. By the time we return from diff_tree_combined,
> rev->diffopt->pathspec->items points to an invalid memory address. We
> get a segfault next time we try to access that pathspec.

I am not quite sure if I follow.  Do you mean

	diff_tree_combined()
        - makes a shallow copy of rev->diffopt
        - calls diff_tree_sha1()
          diff_tree_sha1()
          - tries to follow rename and clobbers diffopt
        - tries to use the shallow copy of original rev->diffopt
          that no longer is valid, which is a problem

I wonder, just like we force recursive and disable external on the
copy before we use it to call diff_tree_sha1(), if we should disable
follow-renames on it.  "--follow" is an option that is given to the
history traversal part and it should not play any role in getting
the pairwise diff with all parents diff_tree_combined() does.

Besides,

 - "--follow" hack lets us keep track of only one path; and

 - "-c" and "--cc" make sense only when dealing with a merge commit
   and the path in the child may have come from different path in
   parents,

so I am not sure if allowing combination of "--follow -c/--cc" makes
much sense in the first place.
