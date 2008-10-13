From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 07:23:22 -0700
Message-ID: <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
 <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpOMK-0003pz-Lm
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYJMOXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbYJMOXo
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:23:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbYJMOXm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:23:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDFA86ECC9;
	Mon, 13 Oct 2008 10:23:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 23ED46ECC8; Mon, 13 Oct 2008 10:23:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 13 Oct 2008 11:36:52 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 87F8BEA2-9932-11DD-9871-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98114>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some confusing tutorials suggested that it would be a good idea to fetch
> into the current branch with something like this:
>
> 	git fetch origin master:master
>
> (or even worse: the same command line with "pull" instead of "fetch").
> While it might make sense to store what you want to pull, it typically
> is plain wrong when the current branch is "master".
>
> As noticed by Junio, this behavior should be triggered by _not_ passing
> the --update-head-ok option, but somewhere along the lines we lost that
> behavior.

Do you mean, by "this behavior should be triggered", "we should allow
updating the current branch head only when --update-head-ok is given", in
other words, "we should error out if the user tries to update the current
head with git-fetch without passing --update-head-ok"?

> NOTE: this patch does not completely resurrect the original behavior
> without --update-head-ok: the check for the current branch is now _only_
> performed in non-bare repositories.

I think that is a sensible improvement.

> 	Strangely, some more tests refused to pass this time, because they
> 	did not use --update-head-ok; this was fixed, too.

We need to look at these changes a bit carefully, as changes to existing
tests can be either (1) fixing those that depended on broken behaviour of
the command, or (2) trying to hide regressions introduced by the patch
under the rug.

>  t/t5405-send-pack-rewind.sh |    2 +-
>  t/t5505-remote.sh           |    2 +-
>  t/t5510-fetch.sh            |   12 ++++++++++++
>  t/t9300-fast-import.sh      |    2 +-

I suspect all of these offending tests came after b888d61 (Make fetch a
builtin, 2007-09-10) which lacked the necessary check in do_fetch() to
cause the regression you are fixing (iow, I am suspecting that the
brokenness of the tests were hidden by the breakage you are fixing).  The
parts of the tests you fixed came from these:

    6738c81 (send-pack: segfault fix on forced push, 2007-11-08)
    4ebc914 (builtin-remote: prune remotes correctly ..., 2008-02-29)
    4942025 (t5510: test "git fetch" following tags minimally, 2008-09-21)
    03db452 (Support gitlinks in fast-import., 2008-07-19)
    
all of which are indeed descendants of b888d61.

With these verified, I think I should move the "Strangely" comment to the
commit log message proper (after stripping "Strangely" part -- it is not
strange anymore after we understand why).
