From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 12:28:51 -0800
Message-ID: <7vd542dji4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKYi-0002Gp-9p
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbXBVU2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXBVU2x
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:28:53 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63790 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbXBVU2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:28:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222202852.ITLT19643.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 15:28:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SkUr1W0091kojtg0000000; Thu, 22 Feb 2007 15:28:51 -0500
In-Reply-To: <Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Feb 2007 21:01:59 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40382>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For one thing, I want to move read_cache() out of run_diff_files() and 
>> run_diff_index() to their callers, so that the caller can use a 
>> handcrafted active_cache[] that is somewhat different from what 
>> read_cache() originally read.
>
> I don't understand. Would it not be easier to "return active_nr" in 
> read_cache_from(path) _also_ when active_cache is set? Or alternatively 
> check if active_alloc is set?

I do not understand your questions.

What I am getting at is that in the current code (without your
patch), run_diff_files() is about diff between $GIT_DIR/index
and working tree.  I want to make it diff between active_cache[]
and working tree.

The caller still can use read_cache() or read_cache_from(path)
to populate active_cache[], but it is not limited to.  It can do
other index manipulations before calling run_diff_files().  For
example, it can do read_tree() to populate active_cache[] before
calling run_diff_files() and/or run_diff_index().  Or maybe it
can run multi-tree read_tree() to populate active_cache[],
internally merge them without writing the merge results out, and
then call run_diff_files() to show "here is what would happen if
you were to run a merge now", all inside active_cache[].

Of course such a caller needs to be careful not to write
active_cache[] out when it shouldn't, but that goes without
saying.  git-diff-index already mucks with active_cache[] with
full intention of not writing it out.

Please see near the tip of 'pu', around here, for much simpler
usage pattern I had in mind:

commit 910d798768989d8fe581c2afcfd501307db81b10
Author: Junio C Hamano <junkio@cox.net>

    git-status: use in-core --refresh in a read-only repository.

commit c5cc9b14a0f36d7fab66b3152f0ebcb442674bfc
Author: Junio C Hamano <junkio@cox.net>

    git-runstatus --refresh

commit b4e1e4a787d3771f617182b3344dcdd9224bd0cb
Author: Junio C Hamano <junkio@cox.net>

    run_diff_{files,index}(): update calling convention.
