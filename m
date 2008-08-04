From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Abort with an error if 'fetch' parameter is invalid.
Date: Sun, 3 Aug 2008 17:46:18 -0700
Message-ID: <20080804004618.GA3182@untitled>
References: <1217451235-9609-1-git-send-email-apenwarr@gmail.com> <20080804000140.GA13019@untitled> <7viquh7hpq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 02:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPoEo-00079W-Fb
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 02:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYHDAqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 20:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYHDAqU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 20:46:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50158 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYHDAqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 20:46:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 545392DC01B;
	Sun,  3 Aug 2008 17:46:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viquh7hpq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91300>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
> >
> > Thanks Avery,
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> I do not seem to find the original message in mbox nor list archive, by
> the way...

Could've been Avery's original From: line not being spam filter
friendly.

Here you go (with From: line fixed)

>From 574c237f4561cf0293e7f44ab604bb701d1931f3 Mon Sep 17 00:00:00 2001
From: Avery Pennarun <apenwarr@gmail.com>
Date: Wed, 30 Jul 2008 16:53:55 -0400
Subject: [PATCH] git-svn: Abort with an error if 'fetch' parameter is invalid.

Previously, if a config entry looked like this:

         svn-remote.svn.fetch=:refs/heads/whatever

git-svn would silently do nothing if you asked it to "git svn fetch", and
give a strange error if asked to "git svn dcommit".  What it really wants is
a line that looks like this:

	svn-remote.svn.fetch=:refs/remotes/whatever

So we should simply abort if we get the wrong thing.

On the other hand, there's actually no good reason for git-svn to enforce
using the refs/remotes namespace, but the code seems to have hardcoded this
in several places and I'm not brave enough to try to fix it all right now.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 git-svn.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a346f8..1c39f45 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1423,8 +1423,12 @@ sub read_all_remotes {
 	    svn.useSvmProps/) };
 	$use_svm_props = $use_svm_props eq 'true' if $use_svm_props;
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
-		if (m!^(.+)\.fetch=\s*(.*)\s*:\s*refs/remotes/(.+)\s*$!) {
-			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
+		if (m!^(.+)\.fetch=\s*(.*)\s*:\s*(.+)\s*$!) {
+			my ($remote, $local_ref, $_remote_ref) = ($1, $2, $3);
+			die("svn-remote.$remote: remote ref '$_remote_ref' "
+			    . "must start with 'refs/remotes/'\n")
+				unless $_remote_ref =~ m{^refs/remotes/(.+)};
+			my $remote_ref = $1;
 			$local_ref =~ s{^/}{};
 			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
 			$r->{$remote}->{svm} = {} if $use_svm_props;
-- 
Eric Wong
