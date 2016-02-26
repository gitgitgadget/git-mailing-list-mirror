From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] t6014: test prune with detached HEADs in separate worktrees
Date: Fri, 26 Feb 2016 10:03:39 -0800
Message-ID: <xmqqwpprjqmc.fsf@gitster.mtv.corp.google.com>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
	<47fd12af598614ca10fa28cb36fb98ca9ab6d7bb.1456504190.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 19:03:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZMk3-0004qx-BD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 19:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbcBZSDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 13:03:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030283AbcBZSDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 13:03:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23F4A46002;
	Fri, 26 Feb 2016 13:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YNdMCtScB2bGb/MC4XLup55Jt4=; b=aFESWl
	8uHqwU5ATOKwqCsvl7Rvol+vI74b7d9khzHqKEzWpswU4rNjIE0lY92HEmoz/v8z
	QkPc8QRUJRkEk69qdJB4Iy1uyqUe92gnVn15AbXb8WPflp6jr3pDuQUT+sUZJBZI
	xG4dG1Kn/eu8ufSiUOGGAtavP6Wu4S1NjS5mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qfxm4H065H+iGWf09eSgj2sIcZF8q55s
	Q/FohHlKomAK1XZyS+6NpJXLxN4PoLe9kDYeSmR0RjXb6LuivvDC+lAK6z7jMflu
	qQl35GbsuZMH8TBeUglAxUpomIes3O1t8JCZOw1nd2l5fuZm1zIzdl+tzqW2nN3C
	aTY/oW90toQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AFB445000;
	Fri, 26 Feb 2016 13:03:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8366244FFE;
	Fri, 26 Feb 2016 13:03:40 -0500 (EST)
In-Reply-To: <47fd12af598614ca10fa28cb36fb98ca9ab6d7bb.1456504190.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 26 Feb 2016 17:39:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4429F0DE-DCB3-11E5-ABBD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287600>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git prune" relies on "git rev-list --all" to list all reachable,
> non-prunable commits. In the presence of per-worktree refs such as HEAD
> this becomes more complicated.

Not "all", perhaps "majority of".  The index is another anchor point
and rev-list is not involved in it at all.

For those that are anchored by refs and ref-like things, I think the
right thing to do is not to change the semantics of "--all" like
[3/6] does, but to invent a new option to "for-each-ref" that shows
only the refs and ref-like things that are private to the worktree.
That set may include HEAD and refs/bisect/*, perhaps.

With that, the scripted equivalent of "git repack", "git prune" and
"git fsck" can ask "git worktree list" the list of worktrees to
consult, and in each of them run "git for-each-ref --private" and
"git ls-files -s" to grab the objects to be used as the starting
point of reachability traversal.
