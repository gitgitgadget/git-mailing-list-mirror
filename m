From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix recent 'unpack_trees()'-related changes breaking 'git stash'
Date: Fri, 14 Mar 2008 21:54:45 -0700
Message-ID: <7v1w6cpox6.fsf@gitster.siamese.dyndns.org>
References: <20080315014133.GB32265@neumann>
 <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER G?bor <szeder@ira.uka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 05:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaOQq-0008B0-Ip
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 05:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbYCOEzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 00:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbYCOEzG
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 00:55:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbYCOEzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 00:55:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D1B21936;
	Sat, 15 Mar 2008 00:55:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 006E81934; Sat, 15 Mar 2008 00:54:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org>
 (Linus Torvalds's message of "Fri, 14 Mar 2008 21:20:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77307>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Damn, this series has had more subtle issues than I ever expected.
>
> 'git stash' creates its saved working tree object with:
>
>         # state of the working tree
>         w_tree=$( (
>                 rm -f "$TMP-index" &&
>                 cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
>                 GIT_INDEX_FILE="$TMP-index" &&
>                 export GIT_INDEX_FILE &&
>                 git read-tree -m $i_tree &&
>                 git add -u &&
>                 git write-tree &&
>                 rm -f "$TMP-index"
>         ) ) ||
>                 die "Cannot save the current worktree state"
>
> which creates a new index file with the updates, and writes the tree from 
> that.

It would be slightly simpler to write the above sequence like this:

	w_tree=$( (
		rm -f "$TMP-index" &&
                git read-tree --index-output="$TMP-index" -m $i_tree &&
                GIT_INDEX_FILE="$TMP-index" &&
                export GIT_INDEX_FILE &&
                git add -u &&
                git write-tree &&
                rm -f "$TMP-index"
	) )

I think your fix would apply equally well if we rewrite stash to work like
this.
