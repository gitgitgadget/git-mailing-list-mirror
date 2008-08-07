From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn rebase - could not detach HEAD
Date: Thu, 07 Aug 2008 00:20:20 -0700
Message-ID: <7vd4kljnpn.fsf@gitster.siamese.dyndns.org>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tony Stubbs" <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 09:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQzoS-0001Fc-Dg
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbYHGHU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 03:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbYHGHU2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:20:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbYHGHU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:20:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75382342AB;
	Thu,  7 Aug 2008 03:20:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AC2EF342AA; Thu,  7 Aug 2008 03:20:22 -0400 (EDT)
In-Reply-To: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
 (Tony Stubbs's message of "Thu, 7 Aug 2008 18:49:29 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DFF0528-6451-11DD-9F20-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91563>

"Tony Stubbs" <antony.stubbs@gmail.com> writes:

> $ git svn rebase
> First, rewinding head to replay your work on top of it...
> could not detach HEAD
> rebase refs/remotes/git-svn: command returned error: 1

It is somewhat unfortunate that git-svn does not say anything about what
ref it is trying to rebase onto here.  I do not use git-svn nor know much
about the code myself, but here are some ideas.

 * Try "rebase --dry-run" and see what you see from this part of the code:

        sub cmd_rebase {
                ...
                if ($_dry_run) {
                        print "Remote Branch: " . $gs->refname . "\n";
                        print "SVN URL: " . $url . "\n";
                        return;
                }

   Most interesting is what $gs->refname is;

 * If you are using recent enough git (I think 1.5.2 is Ok), update your
   copy of git-rebase like this, so that you would at least see *why* you
   cannot detach HEAD.  It is possible that git-svn is giving a nonsense
   ref to detach to.

diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..7825f88 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -376,9 +376,7 @@ fi
 
 # Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
-git checkout "$onto^0" >/dev/null 2>&1 ||
-	die "could not detach HEAD"
-# git reset --hard "$onto^0"
+git checkout -q "$onto^0" || die "could not detach HEAD"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
