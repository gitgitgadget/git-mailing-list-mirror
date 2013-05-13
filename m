From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 16:52:41 +0100
Message-ID: <20130513155241.GS2299@serenity.lan>
References: <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
 <20130512085934.GG2299@serenity.lan>
 <7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
 <20130513075906.GP2299@serenity.lan>
 <7vzjvzoujq.fsf@alter.siamese.dyndns.org>
 <20130513140243.GQ2299@serenity.lan>
 <7v38tros3y.fsf@alter.siamese.dyndns.org>
 <20130513145948.GR2299@serenity.lan>
 <7vd2suopda.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubv3Z-0001gg-CX
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab3EMPwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:52:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43529 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab3EMPww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:52:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E9020CDA618;
	Mon, 13 May 2013 16:52:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wneabB2h8Lqx; Mon, 13 May 2013 16:52:51 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 015E3CDA617;
	Mon, 13 May 2013 16:52:50 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CAA80161E4D6;
	Mon, 13 May 2013 16:52:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASOPBPlHMKcv; Mon, 13 May 2013 16:52:49 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 89391161E4A9;
	Mon, 13 May 2013 16:52:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vd2suopda.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224175>

On Mon, May 13, 2013 at 08:45:21AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > This has the advantage that you get the benefit of the cache if you run
> > "git log --cherry-mark" with the same paths more than once.  In my
> > testing the cache is beneficial as soon as you examine more than one
> > similar range (e.g. master...feature-A and then master...feature-B).
> 
> OK, so perhaps the notes that are keyed with commit ID will record
> multiple entries, one for each invocation pattern (i.e. all pathspec
> given, possibly with nonstandard options)?

That would be possible, but I didn't do it in the current version of the
patch.

> "git diff -- t Documentation" and "git diff -- Docu\* t", even
> though they use different pathspec, would produce the same diff;
> instead of pathspec you may need to key with the actual list of
> paths in the patch, though.

Maybe, but I think that would be overkill.

I'm interested to see how much of a benefit we could get by not
calculating the patch ID of any commits on the larger side of a
symmetric range that touch paths outside the set touched by the smaller
side.  (revision.c::cherry_pick_list() remembers patch IDs for the
smaller side of a symmetric range and then checks if anything on the
larger side matches so this fits in naturally.)

In my usage I generally compare a relatively small topic branch against
whatever has happened in some upstream branch so I think this could give
a big improvement but I haven't had time to try it yet.
