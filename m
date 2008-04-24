From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] git svn accepts to clone an empty SVN repo, but then fails to dcommit
Date: Thu, 24 Apr 2008 20:06:36 +0200
Message-ID: <vpq3apbm8k3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:08:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp5rr-0005ix-Nb
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 20:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYDXSHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 14:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYDXSHX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 14:07:23 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:55365 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbYDXSHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 14:07:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m3OI6afJ017626;
	Thu, 24 Apr 2008 20:06:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jp5q8-0003ga-5Z; Thu, 24 Apr 2008 20:06:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jp5q8-0006fs-3H; Thu, 24 Apr 2008 20:06:36 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 24 Apr 2008 20:06:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80312>

Hi,

All is in the title ;-).

The command

  git svn clone (URL of an empty SVN repo here)

works, creates an empty git repository. I can perform the initial
commit there, but then, "git svn dcommit" says :

Use of uninitialized value in concatenation (.) or string at /home/moy/local/usr/bin/git-svn line 414.
Committing to  ...
Unable to determine upstream SVN information from HEAD history

I guess a correct management of the initial commit in git-svn would be
hard to implement, but at least, the error message can be improved.
First step is something like the patch below, and better would be for
"git svn clone" to warn that it won't be able to do much with the
cloned repo.

diff --git a/git-svn.perl b/git-svn.perl
index b864b54..9a70c1e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -410,10 +410,12 @@ sub cmd_dcommit {
        $head ||= 'HEAD';
        my @refs;
        my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
-       print "Committing to $url ...\n";
+       if ($url) {
+               print "Committing to $url ...\n";
+       }
        unless ($gs) {
                die "Unable to determine upstream SVN information from ",
-                   "$head history\n";
+                   "$head history.\nPerhaps the repository is empty.";
        }
        my $last_rev;
        my ($linear_refs, $parents) = linearize_history($gs, \@refs);


-- 
Matthieu
