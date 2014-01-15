From: Junio C Hamano <gitster@pobox.com>
Subject: Re: revision: propagate flag bits from tags to pointees
Date: Wed, 15 Jan 2014 14:41:21 -0800
Message-ID: <xmqqfvoo27hq.fsf@gitster.dls.corp.google.com>
References: <52CFF27C.1090108@gmail.com>
	<20140115094945.GD14335@sigill.intra.peff.net>
	<xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
	<xmqqwqi10z6i.fsf_-_@gitster.dls.corp.google.com>
	<20140115215641.GB16401@sigill.intra.peff.net>
	<xmqqk3e0288d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 23:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Z9Y-0002XK-GX
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 23:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbaAOWlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 17:41:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbaAOWld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 17:41:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B64E56344F;
	Wed, 15 Jan 2014 17:41:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=StqIy0IgfbGsJKgEW6mJQvaqzxw=; b=WTXEWe
	Ah99uWyxnF6I/eNjV6atmlTWNQKhcVcvv7zbyM+0d3m/W2JrZ4Xe5GcpyjeEaYbM
	PfFmHjdqvMNim9bcWPbrGJDabPdIFoyrPyUz0y1VCsaweVdBn5EXyFMvl3eqUWVi
	r0dlZO8vhEREyqFkOd4NlLN+tPE2+9PdSNknE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPiLJxYo5qgwvwOaHafmUjhFRP56seSr
	/EEiHV1iSw4L7cmx8umy802FCLNQ9j547zNEMa7HjPbsLH/47z4fpfrvJQjQnFlN
	4MDoka1LEWDQWyvasCPoSgq5r2XVnOYGG3P8BWJ8ECSGIYbiLGu4zKNe4w9Pb5BR
	7GRkM0fp4gU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 626106344E;
	Wed, 15 Jan 2014 17:41:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 294D863449;
	Wed, 15 Jan 2014 17:41:30 -0500 (EST)
In-Reply-To: <xmqqk3e0288d.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Jan 2014 14:25:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D21CD86-7E36-11E3-BE20-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240485>

Junio C Hamano <gitster@pobox.com> writes:

> But I have a suspicion that my patch may break if any codepath looks
> at the current flag on the object and decides "ah, it already is
> marked" and punts.
>
> It indeed looks like mark_tree_uninteresting() does have that
> property.  When an uninteresting tag directly points at a tree, if
> we propagate the UNINTERESTING bit to the pointee while peeling,
> wouldn't we end up calling mark_tree_uninteresting() on a tree,
> whose flags already have UNINTERESTING bit set, causing it not to
> recurse?

Extending that line of thought further, what should this do?

    git rev-list --objects ^HEAD^^{tree} HEAD^{tree} |
    git pack-object --stdin pack

It says "I am interested in the objects that is used in the tree of
HEAD, but I do not need those that already appear in HEAD^".

With the current code (with or without the fix under discussion, or
even without the faulty "do not peel tags used in range notation"),
the tree of the HEAD^ is marked in handle_revision_arg() as
UNINTERESTING when it is placed in revs->pending.objects[], and the
handle_commit() --- we should rename it to handle_pending_object()
or something, by the way --- will call mark_tree_uninteresting() on
that tree, which then would say "It is already uninteresting" and
return without marking the objects common to these two trees
uninteresting, no?

I think that is a related but separate bug that dates back to
prehistoric times, and the asymmetry between handle_commit() deals
with commits and trees should have been a clear clue that tells us
something is fishy.  It calls "mark PARENTS uninteresting", leaving
the responsibility of marking the commit itself to the caller, but
it calls mark_tree_uninteresting() whose caller is not supposed to
mark the tree itself.

Which suggest me that a right fix for this separate bug would be to
introduce mark_tree_contents_uninteresting() or something, which has
the parallel semantics to mark_parents_uninteresting().  Then
mark_blob_uninteresting() call in the function can clearly go.  Such
a change will make it clear that handle_commit() is responsible for
handling the flags for the given object, and any helper functions
called by it should not peek and stop the flag of the object itself
when deciding to recurse into the objects linked to it.
