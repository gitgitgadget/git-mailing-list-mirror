From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/8] merge-recursive: internal flag to avoid touching the worktree
Date: Mon, 08 Sep 2014 10:37:37 -0700
Message-ID: <xmqqk35enhcu.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<5bd5960659d85943477d2a5fbca3dd5ccd0da686.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:37:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR2sq-00029z-HG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 19:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaIHRhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 13:37:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56698 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbaIHRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 13:37:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A64336FB0;
	Mon,  8 Sep 2014 13:37:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=C+0yelf8+06m7GObgLiUyjr1sBo=; b=oiob44QmpKpmYzPfiNy7
	crVKLLr6xrW7GkEo/KY+cb3hkqJwMIgQSu0TPOD1sjdxIn2OKCIEdsjVy8zl7l/g
	cNmWCEK5Fgvwc6m3VZjjskLMgjINewp5LhZSjtjoHpP5nV2j9uZzU3WDQmZqIhdf
	Np9GTeryIwfoDMZx0WLrB6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=AaB/4YK2VDg5VYLQ56l+NlEaD0jmmP/moLfCEmKfFDhFh2
	fAoD4Spctk/FDE106aPOqX+fas/HwNNwNXgKr1F8Jc7VdcwGlY58AcyTfpnpZz4N
	WnGaosi4OEQqEbPgTgokTtlhrf1BQ9ptY/pZJmj17pLl53Umh/e7R38tKciAk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 717AC36FAF;
	Mon,  8 Sep 2014 13:37:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE9C936FAB;
	Mon,  8 Sep 2014 13:37:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3FBD4D8-377E-11E4-A31B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256661>

Thomas Rast <tr@thomasrast.ch> writes:

> From: Thomas Rast <trast@inf.ethz.ch>
>
> o->call_depth has a double function: a nonzero call_depth means we
> want to construct virtual merge bases, but it also means we want to
> avoid touching the worktree.  Introduce a new flag o->no_worktree to
> trigger only the latter.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I notice that many hits from

   $ git grep -e '->call_depth' --and --not -e '->no_worktree'

are about how the progress is reported during recursive operations
or setting up ll_opts suitable for ancestor merges (both of which
are perfectly fine not to pay any attention to no_worktree), but
some others look iffy.  For example, function remove_file() decides
to update the in-core index only when call_depth is set (i.e. we are
doing a virtual parent) or clean (clean merge at the content level,
i.e. "both removed"), and decides to update the working tree only at
the top-level of the recursion and no_wd is passed.

 - As to "update_cache", if you do not update it while you are
   operating in the cache-only mode (aka ->no_worktree), I wonder
   where the result goes.  Shouldn't it be done for in-core merge as
   well?

 - As to "update_working_tree", there are few places where the
   function is called with no_wd that is not true, even when
   ->no_worktree is set.  Do you want to allow working tree to be
   modified in such a call?
