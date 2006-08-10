From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff machinery cleanup
Date: Thu, 10 Aug 2006 02:36:49 -0700
Message-ID: <7vejvpvsni.fsf@assigned-by-dhcp.cox.net>
References: <20060810082455.GA30739@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 10 11:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB6yd-0007iV-3g
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 11:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWHJJgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 05:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHJJgv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 05:36:51 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48013 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751488AbWHJJgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 05:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810093650.ETY29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 05:36:50 -0400
To: git@vger.kernel.org
In-Reply-To: <20060810082455.GA30739@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Aug 2006 04:24:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25172>

Jeff King <peff@peff.net> writes:

> It seems clear that there's some global magic touched by the first diff
> that impacts the second. I have to give up on finding it for tonight,
> but I'm hoping somebody who knows more about the code will find it
> obvious (or can tell me that I'm doing something else horribly wrong in
> the above, or that these functions were never intended to be called
> within the same program).

In general, run_diff_X are _not_ designed to run twice.

The run_diff_index() function munges the index while doing its
work (e.g. mark_merge_entries() hoists unmerged entries to stage
3 -- and worse yet creating duplicate entries for the same path
at stage 3; read_tree() reads the entries into stage 1 so that
it can be compared in-index with stage 0 entries).  The other
function, run_diff_files() have the same assumption but does not
touch index if I recall correctly.

If you are working in "next" branch where Johannes's merge-recur
work introduced discard_cache(), you could fake this somehow
stashing away a copy of the original index, and once you are
done with run_diff_index(), clean the slate by calling
discard_cache() once you are done, and swap the original index
in before running run_diff_files().

To solve this cleanly without doing the index munging hack, you
would (actually, I would) need to have a new path walker that
walks index, tree and working tree in parallel, which I was
working on in the git-status/git-commit rewrite I started and
discarded a few days ago.
