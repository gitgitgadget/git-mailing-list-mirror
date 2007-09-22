From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't attempt to spawn pager if we don't want one
Date: Fri, 21 Sep 2007 18:48:45 -0700
Message-ID: <20070922014845.GA8087@mayonaise>
References: <a9691ee20709211640q63881718k75ebf416bf5e217f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Moore <christopher.ian.moore@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 03:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYu73-0006cX-2Z
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 03:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbXIVBss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbXIVBss
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 21:48:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55035 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbXIVBsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 21:48:47 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id EFC917DC029;
	Fri, 21 Sep 2007 18:48:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 21 Sep 2007 18:48:45 -0700
Content-Disposition: inline
In-Reply-To: <a9691ee20709211640q63881718k75ebf416bf5e217f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58910>

Even though config_pager() unset the $pager variable, we were
blindly calling exec() on it through run_pager().

Noticed-by: Chris Moore <christopher.ian.moore@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Chris Moore <christopher.ian.moore@gmail.com> wrote:
  > I run my git commands inside an Emacs *shell* buffer, so I don't want
  > it running 'less' all the time.  I export GIT_PAGER=cat to stop it.
  > 
  > I just tried a "git-svn log" and it failed:
  > 
  > $ GIT_PAGER=cat git-svn log
  > Use of uninitialized value in exec at /usr/bin/git-svn line 3451.
  > Use of uninitialized value in concatenation (.) or string at
  > /usr/bin/git-svn line 3451.
  > Can't run pager: Illegal seek ()
  > 
  > I don't get a shell prompt back.  It just hangs.
  > 
  > This is on ubuntu feisty with the ubuntu-backport repositories enabled:
  > 
  > ii  git-core                                     1.5.2.5-2~feisty1
  > ii  git-svn                                      1.5.2.5-2~feisty1

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 288d32c..484b057 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3578,7 +3578,7 @@ sub config_pager {
 }
 
 sub run_pager {
-	return unless -t *STDOUT;
+	return unless -t *STDOUT && defined $pager;
 	pipe my $rfd, my $wfd or return;
 	defined(my $pid = fork) or ::fatal "Can't fork: $!\n";
 	if (!$pid) {
-- 
Eric Wong
