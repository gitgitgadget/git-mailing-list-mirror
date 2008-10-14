From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 15:07:08 -0700
Message-ID: <7vk5ca7rw3.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
 <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810131546180.19665@iabervon.org>
 <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810141148010.19665@iabervon.org>
 <alpine.DEB.1.00.0810141815490.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810141240510.19665@iabervon.org>
 <alpine.LNX.1.00.0810141258050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kps48-0004kC-88
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbYJNWHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbYJNWHT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:07:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYJNWHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:07:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A01836EA4C;
	Tue, 14 Oct 2008 18:07:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 47BE06EA4B; Tue, 14 Oct 2008 18:07:11 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0810141258050.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 14 Oct 2008 13:02:35 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 766B18F0-9A3C-11DD-9FB6-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98214>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 14 Oct 2008, Daniel Barkalow wrote:
> ...
>> That is, it uses --update-head-ok because "git pull origin master:master" 
>> will work correctly, regardless of whether the local master is 
>> yet-to-be-born or not.
>
> In particular, the --update-head-ok is from b10ac50f, which is what added 
> the check to prohibit fetching into the current branch otherwise, back in 
> August 2005. There's never been anything preventing updating the current 
> branch using "pull".

What you wrote above is correct, and it is all that is necessary to make
"pull master:master" (when 'master' is the current branch) work correctly,
in normal situations.  Dscho's patch is in itself is a good thing to do,
but is not necessary when the caller gives --update-head-ok.

Nor is it sufficient.  Have you tested the current "git-pull" with or
without Dscho's patch applied to "git-fetch" when 'master' is an unborn
branch?  "git-pull" has this piece:

        curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
        if test "$curr_head" != "$orig_head"
        then
                # The fetch involved updating the current branch.

                # The working tree and the index file is still based on the
                # $orig_head commit, but we are merging into $curr_head.
                # First update the working tree to match $curr_head.

                echo >&2 "Warning: fetch updated the current branch head."
                ...
        fi

The above part (written by yours truly) did not care what happens when the
current branch is unborn.  Back then when git-pull was originally written,
nobody was crazy enough to pull into an empty branch and expect it to
work.  The code to allow that craziness (look for "initial pull" in the
same script to find a 6-line block near the end) came much later, and the
commit that added the "initial pull" support should have adjusted the
above codeblock if it really wanted to support pulling into an unborn
branch, but it forgot to do so.  It also forgot to handle the case where
the originally unborn current branch was fetched into.

If we really care about is "git pull origin master:master" into an unborn
branch, I think we need the attached patch on top, and this is regardless
of Dscho's patch that tightens the check when -update-head-ok is not given.

 git-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/git-pull.sh w/git-pull.sh
index 75c3610..664fe34 100755
--- c/git-pull.sh
+++ w/git-pull.sh
@@ -124,7 +124,7 @@ orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
 git fetch --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
-if test "$curr_head" != "$orig_head"
+if test -n "$orig_head" && test "$curr_head" != "$orig_head"
 then
 	# The fetch involved updating the current branch.
 
@@ -172,7 +172,7 @@ esac
 
 if test -z "$orig_head"
 then
-	git update-ref -m "initial pull" HEAD $merge_head "" &&
+	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
 	git read-tree --reset -u HEAD || exit 1
 	exit
 fi
