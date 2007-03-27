From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Mon, 26 Mar 2007 22:46:34 -0700
Message-ID: <7vmz1zs0g5.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW4Vz-0000cW-Hz
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 07:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002AbXC0Fqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 01:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934007AbXC0Fqg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 01:46:36 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37892 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934002AbXC0Fqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 01:46:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327054634.DWD1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 01:46:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fhma1W00j1kojtg0000000; Tue, 27 Mar 2007 01:46:35 -0400
In-Reply-To: <20070327064957.34dad72a.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 27 Mar 2007 06:49:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43229>

Christian Couder <chriscool@tuxfamily.org> writes:

> We may be able to "run" with only one good revision given
> and then verify that the result of the first run is bad.
> And perhaps also the other way around.

Bisect fundamentally needs one bad commit (nearer to the tip,
relative to the good commits if you have any) to work, but there
is no technical reason to require a good commit.

If the commit at the tip of 'master' branch is bad, it is
entirely possible to start bisection with:

	$ git rev-list --bisect master

It will find a midpoint between the root commit and the HEAD.

However, for a project with long history, if you immediately
start bisecting once you give a bad commit, it would translate
to this rather awkward command sequence, especially when you
already know one good and bad commits:

	$ git bisect start
	$ git bisect bad master
        ... computes the midpoint in the history, which may be
        ... way in the past, and checkout that ancient commit
        ... to test.  however, because you knew a much more
        ... recent commit that is good, you do not bother to
	... test such an ancient one.
	$ git bisect good $known_good_commit
        ... computes the midpoint between $known_good_commit and
        ... master, and checks it out.

For a toy-sized project such as git.git itself, checking out an
ancient revision once, only to immediately check out a more
recent revision, is not much of an overhead, but as your project
grows into real size, such an unnecessary checkout would waste
time (because you would need to update thousands of paths, only
to immediately discard) and buffer cache (because the more
recent, relevant revision would have set of paths much closer to
what you originally had than the initial, wasteful checkout of
the ancient commit).

So our requirement to have at least one good commit is not a
fundamental one, but only a practical one.

We could give an --immediate (or --no-good) option to 'git
bisect bad' to start bisecting as soon as you give a single bad
commit.  It might turn out that the commits you test are bad all
the way down to the root commit, though ;-).
