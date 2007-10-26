From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m) loops
Date: Fri, 26 Oct 2007 16:27:43 -0700
Message-ID: <7vy7dpv4ls.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or g>
	<alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
	<7vabq5wkri.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0710261600510.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYaw-0000ps-Hg
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXJZX1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbXJZX1u
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:27:50 -0400
Received: from rune.pobox.com ([208.210.124.79]:54809 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbXJZX1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 19:27:49 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 846A5150B26;
	Fri, 26 Oct 2007 19:28:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C9769150AF3;
	Fri, 26 Oct 2007 19:28:07 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710261600510.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 26 Oct 2007 16:10:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62453>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The nice thing about the whole counting thing is that we really don't even 
> care. What happens is:
>
>  - *if* any rename at all happens, the rename detection will increment the 
>    "rename_used" thing even more for the source (once for each rename)
>
>  - so if the rename_used started out non-zero, it will never become zero 
>    in diff_resolve_rename_copy(), and every single detected "rename" will 
>    be considered a copy - exactly like we want.
>
>  - in other words, a "rename_used++" before rename-detection guarantees 
>    that you never see a rename, only a copy of the source.

Ok, and that is because we _know_ a broken pair means that the
path itself remains in the postimage and any other postimage
that takes from its preimage can never "rename the path away".
They can only be copies.  Which makes sense.

> The above is actually true *even*if* the 
>
> 	if (!strcmp(p->one->path, p->two->path))
>
> code in diff_resolve_rename_copy() actually triggers,...
> ..., so not doing 
> the decrement there is equivalent to doing another pre-increment.

Yes, this is what confused me.  So for a broken pair, the actual
value of rename_used does not really matter.  We only care about
it not going down to zero.
