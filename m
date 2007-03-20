From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH]: remove extra-verbosity from git-clone (http)
Date: Mon, 19 Mar 2007 19:18:18 -0700
Message-ID: <20070320021818.GG10574@sequoia.sous-sol.org>
References: <58d389c20702150910x24ec218bjdb9cb49ee03fd1df@mail.gmail.com> <20070319230436.GB12555@sequoia.sous-sol.org> <7vslc0er1e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@sous-sol.org>,
	Fernando Herrera <fherrera@onirica.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 03:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTTuX-0002DJ-6i
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 03:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbXCTCRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 22:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965756AbXCTCRA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 22:17:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36380 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965795AbXCTCQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 22:16:59 -0400
Received: from sous-sol.org (localhost.localdomain [127.0.0.1])
	by sous-sol.org (8.13.8/8.13.7) with ESMTP id l2K2IIRr025662;
	Mon, 19 Mar 2007 19:18:18 -0700
Received: (from chrisw@localhost)
	by sous-sol.org (8.13.8/8.13.7/Submit) id l2K2II5r025661;
	Mon, 19 Mar 2007 19:18:18 -0700
Content-Disposition: inline
In-Reply-To: <7vslc0er1e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.1.4
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	sequoia.sous-sol.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42691>

* Junio C Hamano (junkio@cox.net) wrote:
> I saw it.  The -v option used not to be there, but we added it
> with an explicit purpose of not boring people fetching over http
> connection (which used to be slow especially before packfiles
> were introduced).  I do not care much either way, but I suspect
> there actually are people who want to see that "assuring look"
> of something happening.  I dunno.

Actually, I very much agree now that I've actually tried it
myself when testing the simple patch below.

> I am certainly *not* opposed to have an explicit option or a
> per-user configuration to make it not pass -v to http-fetch.  I
> am just wondering if we want to change the default.  Especially
> people new to git may wonder what is happening without _any_
> feedback if we turned it off by default.

Well, there's enough to go on already.  So how about this simple change
for those few that are bothered by the verbose output?  Works in my
basic testing.

thanks,
-chris
--
Subject: [PATCH] make git clone -q suppress the noise with http fetch

We already have -q in git clone.  So for those who care to suppress
the noise during an http based clone, make -q actually do a quiet
http fetch.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Fernando Herrera <fherrera@onirica.com>
---
 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 1bd54de..ab6c5c0 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -42,6 +42,7 @@ clone_dumb_http () {
 	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
 		die "Cannot get remote repository information.
 Perhaps git-update-server-info needs to be run there?"
+	test "z$quiet" = z && v=-v || v=
 	while read sha1 refname
 	do
 		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
@@ -59,7 +60,7 @@ Perhaps git-update-server-info needs to be run there?"
 		else
 			tname=$name
 		fi
-		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
+		git-http-fetch $v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
