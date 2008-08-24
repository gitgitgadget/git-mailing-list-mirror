From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge: fix numerus bugs around "trivial merge" area
Date: Sat, 23 Aug 2008 18:58:37 -0700
Message-ID: <7vtzdbuqb6.fsf@gitster.siamese.dyndns.org>
References: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
 <1219489071-5679-1-git-send-email-vmiklos@frugalware.org>
 <7vk5e7y0a0.fsf@gitster.siamese.dyndns.org>
 <7vfxovy06u.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 04:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX4xU-0006kF-4r
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 04:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYHXB6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbYHXB6r
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 21:58:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYHXB6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 21:58:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 320066C09B;
	Sat, 23 Aug 2008 21:58:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 77CDE6C099; Sat, 23 Aug 2008 21:58:40 -0400 (EDT)
In-Reply-To: <7vfxovy06u.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Sat, 23 Aug 2008 12:56:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F2890A6-7180-11DD-BECE-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93510>

Junio C Hamano <gitster@pobox.com> writes:

> The primary logic of the merge, however, had an assumption that the
> process never read the index in-core, and write_cache_as_tree() call it
> makes from write_tree_trivial() will always read from the on-disk index
> the strategies created and write it out as a tree.  This assumption is now
> broken by the above fix.  It now calls discard_cache() before calling
> write_tree_trivial() when it wants to write the on-disk index as a tree to
> fix this issue.

By the way, in the medium term, if we are serious about making an internal
call to merge_recursive() from cmd_merge(), I think we may be better off
making it the responsibility for try_merge_strategy() to leave an
committable state in the in-core index (aka "the_index") when they return
with 0 (success) status.  After calling external ones via the run_command
interface, it should do a read_cache() (after calling discard_cache() if
needed); if it calls merge_recursive(), hopefully you already have the
committable state in the in-core index.

That way, when automerge succeeds, write_tree_trivial() can write that
in-core index out and create the tree object to be committed. The
callchain to use merge_recursive() can avoid having to write to the
on-disk index, read it again and write out the tree from it.
