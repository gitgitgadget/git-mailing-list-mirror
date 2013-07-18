From: Kacper Kornet <draenog@pld-linux.org>
Subject: git svn exits with error error closing pipe: Bad file descriptor
Date: Thu, 18 Jul 2013 14:52:07 +0200
Message-ID: <20130718125207.GA14823@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 15:25:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzoDS-0001tI-CF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 15:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758946Ab3GRNZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 09:25:49 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:39458 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758547Ab3GRNZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 09:25:48 -0400
X-Greylist: delayed 1994 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2013 09:25:48 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0B8835F0002
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:53:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id G4atkxX2RnDE for <git@vger.kernel.org>;
	Thu, 18 Jul 2013 14:53:11 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 61CBD5F0005
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:53:02 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id F394C4811F; Thu, 18 Jul 2013 14:52:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230690>

After upgrade to subversion 1.8.0 on some repositories
git svn clone shows two warnings:

error closing pipe: Bad file descriptor at
/home/users/kornet/giti/libexec/git-core/git-svn line 0.

at exit. They appear because process git cat-file --batch exits before
command_close_bidi_pipe is called by destructor during perl exit.  The
solution is to call the destructor explicitly, e.q.:

index ff1ce3d..6811738 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2068,6 +2068,10 @@ sub gc_directory {
        }
 }
 
+END {
+    undef $_repository;
+}
+
 __END__
 
 Data structures:

However I'm not sure whether it is not a symptom of some other error.
What's confuses me more is that the warnings don't appear for all
repositories. For example they appear for  http://svn.pld-linux.org/svn/cdpl/
while cloning http://svn.pld-linux.org/svn/atob ends normally.
On the other hand it is consistent between two different machines with
different Linux distributions and perl versions.

-- 
  Kacper Kornet
