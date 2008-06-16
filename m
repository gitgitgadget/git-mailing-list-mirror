From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 11:46:08 -0700
Message-ID: <7vej6xb4lr.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Jjc-0004ig-AJ
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbYFPSqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 14:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbYFPSqY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 14:46:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYFPSqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 14:46:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96CD6B692;
	Mon, 16 Jun 2008 14:46:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2960B691; Mon, 16 Jun 2008 14:46:16 -0400 (EDT)
In-Reply-To: <20080616110113.GA22945@elte.hu> (Ingo Molnar's message of "Mon,
 16 Jun 2008 13:01:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82E3C6D4-3BD4-11DD-95DF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85215>

Ingo Molnar <mingo@elte.hu> writes:

> We are running a rather complex Git tree with heavy use of git-rerere 
> (the -tip kernel tree, with more than 80 topic branches). git-rerere is 
> really nice in that it caches conflict resolutions, but there are a few 
> areas where it would be nice to have improvements:
>
>  - Fixing resolutions: currently, when i do an incorrect conflict
>    resolution, and fix it on the next run, git-rerere does not pick up
>    the new resolution but uses the old (buggy) one on the next run. To
>    fix it up i have to find the right entries in .git/rr-cache/* and
>    manually erase them. Would be nice to have "git-rerere gc <pathspec>"
>    to flush out a single bad resolution.

I agree this is a real issue (I sometimes know that the resolution is iffy
and say "rerere clear" to choose not to record it, but that is working
around the issue with a perfect foresight and is not a solution).

I think (and I think you would agree) "gc" is not the right word but
rather you would want to more actively discard the wrong one.

I agree that it is the right UI to do this to specify paths right after
you found that a bad resolution that was recorded previously was used by
rerere (I think that is what you are suggesting).  Upon such a request, we
should undo the bad resolution and bring the working tree copy to the
original conflicted state, and clear the bad rerere entry.

>  - File deletion: would be nice if git-rerere picked up git-rm
>    resolutions. We hit this every now and then and right now i know 
>    which ones need an extra git-rm pass.

I originally did not have need for anything other than three-way conflict
resolving to a result.  I do not know how safe reapplying a removal to
different context, though.

>  - Automation: would be nice to have a git-rerere modus operandi where
>    it would auto-commit things if and only if all conflicting files were 
>    resolved.

I am not sure how safe this is.  rerere as originally designed does not
even update the index with merge results so that the application of
earlier resolution can be manually inspected, and this is exactly because
I consider a blind textual reapplication of previous resolution always
iffy, even though I invented the whole mechanism.
