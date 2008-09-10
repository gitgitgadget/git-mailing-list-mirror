From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] git cherry-pick takes forever
Date: Wed, 10 Sep 2008 03:00:20 -0700
Message-ID: <7vk5dkxqvf.fsf@gitster.siamese.dyndns.org>
References: <20080910082610.GA3144@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 12:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdMW3-0007dC-UN
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 12:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYIJKA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 06:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYIJKA1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 06:00:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYIJKA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 06:00:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C6E07AF6A;
	Wed, 10 Sep 2008 06:00:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 88A447AF68; Wed, 10 Sep 2008 06:00:22 -0400 (EDT)
In-Reply-To: <20080910082610.GA3144@mageo.cz> (Michal Vitecek's message of
 "Wed, 10 Sep 2008 10:26:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4A0D22FE-7F1F-11DD-97A0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95507>

Michal Vitecek <fuf@mageo.cz> writes:

>  Hello everyone,
>
>  I have two git repositories: one is the origin of the other. However no
>  merging is being done as the projects in the repositories quite differ
>  but still use the same core. So to propagate changes I cherry-pick
>  those which are useful from one repository to another.
>
>  however 'git cherry-pick' has lately started to last almost forever:

Can you define "lately"?  Is it a function of your git version, or is it a
function of the age of your repositories?

>  $ time git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618
>  Finished one cherry-pick.
>  Created commit 7caef83: - removed some superfluous newlines
>  2 files changed, 0 insertions(+), 2 deletions(-)
>  git cherry-pick b42b77e66a83f1298d9900a9bb1078b9b42e8618  282.97s user 34.69s system 100% cpu 5:17.63 total
>
>  Both repositories have approximately 16k commits and their forking
>  point (merge base) is 250 to 490 commits far away.

When talking about cherry-pick, the size of the history (unless the
repository has too many objects and badly packed) does not matter; the
operation is purely about your current state, the cherry-picked commit
itself, and the parent commit of the cherry-picked one.

Taking 5 minutes to cherry-pick a change to only two paths, one line
deletion each, is plain ridiculous, but if the tree state of cherry-picked
commit and the tree state of the target is vastly different (e.g. almost
no common pathnames), the behaviour is certainly understandable.  Ancient
git used straight three-way merge for cherry-pick, but recent ones use
more expensive "recursive-merge", which tries to detect renames.  If the
states of trees are very dissimilar, you can end up wasting a lot of time.

    $ H=$(git rev-parse 7caef83^) ;# the commit before cherry-pick
    $ C=b42b77e6 ;# the cherry-picked one

cherry-pick operation roughly runs these two diffs:

    $ time git diff --shortstat -M $H $C
    $ time git diff --shortstat -M $H $C^1

and uses the result to perform its work.  Can you clock these?

If you rarely have renames, it may be much more efficient to run "git
format-patch -1 --stdout $C | git am -3" instead of cherry-pick.
