From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 16:59:44 -0400
Message-ID: <20060523205944.GA16164@coredump.intra.peff.net>
References: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net> <20060523070007.GC6180@coredump.intra.peff.net> <118833cc0605231047o2012deefh5e77b8496da1e673@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 23:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fidyo-0001Lz-4s
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWEWU7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEWU7r
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:59:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:13552 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932214AbWEWU7q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:59:46 -0400
Received: (qmail 48852 invoked from network); 23 May 2006 20:59:44 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 20:59:44 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 16:59:44 -0400
To: Morten Welinder <mwelinder@gmail.com>
Mail-Followup-To: Morten Welinder <mwelinder@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <118833cc0605231047o2012deefh5e77b8496da1e673@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20637>

On Tue, May 23, 2006 at 01:47:01PM -0400, Morten Welinder wrote:

> Why run "env" and not just muck with %ENV?
> >+       my $pid = open2(my $commit_read, my $commit_write,
> >+               'env',
> >+               "GIT_AUTHOR_NAME=$author_name",
> >+               "GIT_AUTHOR_EMAIL=$author_email",
> >+               "GIT_AUTHOR_DATE=$commit_date",
> >+               "GIT_COMMITTER_NAME=$author_name",
> >+               "GIT_COMMITTER_EMAIL=$author_email",
> >+               "GIT_COMMITTER_DATE=$commit_date",
> >+               'git-commit-tree', $tree, @commit_args);

Oops, that's an obvious fork optimization that I should have caught.
Patch is below. Note that this will now affect the environment of all
sub-processes, but it shouldn't matter since we reset it right before
commit. However, if anyone is worried, we can stash the old %ENV in
another hash temporarily.

-Peff

PS What is the preferred format for throwing patches into replies like
this? Putting the patch at the end (as here) or throwing the reply
comments in the ignored section near the diffstat?

---
cvsimport: set up commit environment in perl instead of using env

---

44c4a9f67322302ca49146a7c143c07ea67da366
 git-cvsimport.perl |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

44c4a9f67322302ca49146a7c143c07ea67da366
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 41ee9a6..83d7d3c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -618,14 +618,13 @@ sub commit {
 	}
 
 	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
+	$ENV{GIT_AUTHOR_NAME} = $author_name;
+	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
+	$ENV{GIT_AUTHOR_DATE} = $commit_date;
+	$ENV{GIT_COMMITTER_NAME} = $author_name;
+	$ENV{GIT_COMMITTER_EMAIL} = $author_email;
+	$ENV{GIT_COMMITTER_DATE} = $commit_date;
 	my $pid = open2(my $commit_read, my $commit_write,
-		'env',
-		"GIT_AUTHOR_NAME=$author_name",
-		"GIT_AUTHOR_EMAIL=$author_email",
-		"GIT_AUTHOR_DATE=$commit_date",
-		"GIT_COMMITTER_NAME=$author_name",
-		"GIT_COMMITTER_EMAIL=$author_email",
-		"GIT_COMMITTER_DATE=$commit_date",
 		'git-commit-tree', $tree, @commit_args);
 
 	# compatibility with git2cvs
-- 
1.3.3.g40505-dirty


> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
