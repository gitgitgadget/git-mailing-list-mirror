From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 19:00:40 -0700
Message-ID: <7vy7kyl5br.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
	<461D6432.90205@vilain.net>
	<Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	<461D6858.4090007@vilain.net>
	<Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	<7vslb6mnva.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704111850240.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hboc8-0005qT-L4
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbXDLCAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbXDLCAm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:00:42 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49005 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161443AbXDLCAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:00:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412020040.MRGJ1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 22:00:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m20g1W00a1kojtg0000000; Wed, 11 Apr 2007 22:00:40 -0400
In-Reply-To: <Pine.LNX.4.64.0704111850240.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 11 Apr 2007 18:52:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44307>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 11 Apr 2007, Junio C Hamano wrote:
>>
>> The small detail in the last step is wrong, though.  Even if
>> they EXIST, they may be isolated commits that are note connected
>> to refs, and fsck in the repository would not have warned about
>> unreachable trees from such unconnected commits.
>
> The superproject *is* a ref.

But when you fsck the subproject repository in isolation in the
earlier step in your procedure, that is not taken into account,
is it?

The situation I had in mind was not about pruning, but an
earlier fetch, either the native one that unpacks the objects
into loose form or a http walker, fetched a commit near the tip
but was interrupted/killed before finishing the fetch nor
updating the ref.  The tip of such an incomplete commit chain
would be reported dangling.  They are ahead of your refs but
they may lack commits and trees to complete the chain back to
your refs yet.  When the higher-level project points at such a
commit, the existence of the commit is not a proof that
everything needed to complete the commit is available.

We need to prove that separately, and that was my suggestion to
run a "rev-list --objects $those-commits --not --all" in the
subproject repository, simlar to what the quick-fetch topic
does.
