From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 01:13:30 -0800
Message-ID: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwyWW-0004AG-3g
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 10:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWALJNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 04:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWALJNd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 04:13:33 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57594 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964974AbWALJNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 04:13:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112091128.GJYY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 04:11:28 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14555>

The underlying "git send-pack remote.host:path" pushes all the
matching refs that both local and remote has, and "git push"
blindly inherits this property.

This is bad.  A typical cloned repository (e.g. a subsystem
maintainer repository cloned from Linus repository) has at least
two branches, "master" to keep the subsystem and "origin" that
records tip of Linus "master" when the repository was cloned.
If this is the public repository, then subsystem developers
would clone from this one, and then cloned ones have "master"
and "origin".  When developers use this public subsystem
repository as a shared repository, "git push subsys:path" would
try to push the matching refs, "master" and "origin".

One workaround is to delete "origin" branch from the public
repository, because having "origin" there is meaningless.
Nobody is supposed to pull directly into it from Linus after
cloning; rather, changes in upstream would trickle in by a
developer who cloned from this subsystem repository and then
pulled from Linus into his repository and then pushed his merge
result into this public repository.

Nevertheless, exposing the default behaviour of "git send-pack"
to "git push" was probably a mistake.  I'd propose to require at
least one refspec to be specified, either on the command line or
via $GIT_DIR/remotes mechanism.  So my answer to the "Subject: "
line question is "Barf".

Unlike pull that can happen pretty much promiscuously, people
will push into the same set of a limited number of remote
repositories repeatedly over the life of the project, so it is
reasonable to assume they would want to keep a $GIT_DIR/remotes/
entry for those repositories to save typing.  Then always
requiring one or more refspecs for push is not too much to ask
for.

Opinions?

BTW, Nick, what does http-push do with "git push http://foo"
without refspecs?
