From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 15:06:36 -0700
Message-ID: <7v3aixqzrn.fsf@gitster.siamese.dyndns.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
 <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 00:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqEXA-00043Z-VC
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 00:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbYJOWGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 18:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYJOWGq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 18:06:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYJOWGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 18:06:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E2B48B163;
	Wed, 15 Oct 2008 18:06:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 54FCD8B162; Wed, 15 Oct 2008 18:06:39 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Wed, 15 Oct 2008 13:23:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DFFAEDA-9B05-11DD-9B59-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98334>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 15 Oct 2008, Linus Torvalds wrote:
>> 
> It's quite possible that we should remove unmerged entries. Except that's 
> not how our internal 'read_cache_unmerged()' function works. It really 
> just ignores them, and throws them on the floor. We _could_ try to just 
> turn them into a (since) stage-0 entry.
>
> Junio?

I'd agree that dropping unmerged entries to stage-0 when we can would make
sense.  An conflicted existing path would get an stage-0 entry in the
index, which is compared with the switched-to HEAD (which could be the
same as the current one when "git reset --hard" is run without a rev), we
notice that they are different and the index entry and the work tree path
is overwritten by the version from the switched-to HEAD.  For a new path
that a failed merge tried to bring in, we notice that the switched-to HEAD
does not have that path and happily remove it from the index and from the
work tree.  All will go a lot smoother than the current code.

I am not sure what should happen when we can't drop the unmerged entry
down to stage-0 due to D/F conflicts, though.  IIRC, read-tree proper
would not touch the work tree in such a case, but merge-recursive creates
our and their versions with funny suffixes, which will not be known to the
index and will be left in the working tree.
