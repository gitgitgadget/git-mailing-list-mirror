From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and worktrees
Date: Wed, 01 Jun 2016 12:39:21 -0700
Message-ID: <xmqqmvn4y9zq.fsf@gitster.mtv.corp.google.com>
References: <574D382A.8030809@kdbg.org>
	<CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
	<20160531221415.GA3824@sigill.intra.peff.net>
	<574EA364.60408@alum.mit.edu>
	<xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
	<574F0983.5030108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:39:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8BzP-0004Jl-8s
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 21:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcFATja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 15:39:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750765AbcFATj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 15:39:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3637E21BAB;
	Wed,  1 Jun 2016 15:39:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZpXkXInoqGIbsDD8/1+RzS3AP8=; b=YwT2Z/
	hlElr79hLgN/kcQ75qpZx72mKMc+ZNNBkFfTGbHSLQWWqvsVlJiTJm57Sug5l5Gu
	+53GVQ76xN9Z3AKL+g3JNXUFtu0W/ZgqKJpxFIywIsLc8puQUFt+S54Xno6n84so
	1nMySlcKBBGjGFHD+FC4lJShcjhJLu9QpKiio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nCkRQV4ISPHCcFYuMN3QPP5rIjjw4Ayb
	AbmJE9B9lNoFLy+TR+mpB/Tcfx0zbQAhsq+iOsiEVxQ9+LdvQpqfNZTPTNsLGO/J
	tTZqoodfyC6Lpt1nbMLHE0nw7xXFpSIHS/mN5wPng+Uw+ESlteE2CsVm+WMUtxZO
	pe6q0gvF9xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B86C21BAA;
	Wed,  1 Jun 2016 15:39:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B759921BA8;
	Wed,  1 Jun 2016 15:39:22 -0400 (EDT)
In-Reply-To: <574F0983.5030108@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 1 Jun 2016 18:12:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A71E3C6-2830-11E6-9817-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296152>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I argue that the fundamental concept in terms of the implementation
> should be the individual physical reference stores, and these should be
> compounded together to form the logical reference collections and the
> sets of reachability roots that are interesting at the UI level.

That is very good in principle.  How does that principle translate
to the current setup (with possible enhancement with pluggable ref
backends) and multiple worktrees?  Let me try thinking it through
aloud.

 * Without pluggable ref backend or worktrees, we start from two
   "physical reference stores"; packed-refs file lists refs that
   will be covered (overridden) by loose refs in .git/refs/.
   Symbolic refs always being in loose falls out as a natural
   consequence that packed-refs file does not record symrefs.

 * Throw in multiple worktrees to the mix.  How?  Do we consider
   selected refs/ hierarchies (like refs/bisect/*) as separate
   physical store (even though it might be backed by the files in
   the same .git/refs/ filesystem hierarchy) and represent the
   "logical" view as an overlay across the traditional two types of
   physical reference stores?  That is:

   - loose refs in .git/HEAD, .git/refs/{bisect,...} for
     per-worktree part form one physical store.  If a ref is found
     here, that is what we use as a part of the logical view.

   - loose refs in .git/refs/{branches,tags,notes,...} for common
     part form one physical store.  For a ref that is not found
     above but is found here becomes a part of the logical view.

   - packed refs in .git/packed-refs is another physical store.  For
     a ref that is not found in the above two but is found here
     becomes a part of the logical view.

Up to this point, I am all for your "separate physical stores are
composited to give a logical view".  I can see how multi-worktree
world view fits within that framework.

 * With pluggable ref backend, we may gain yet another "physical
   reference store" possibility, e.g. one backed by lmdb.  If it
   supports symrefs, a repoitory may use lmdb backed reference store
   without the traditional two.

   But it is unclear how it would interact with the multi-worktree
   world order.
