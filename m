From: Jan Wielemaker <jan@swi-prolog.org>
Subject: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 13:16:03 +0200
Organization: SWI-Prolog
Message-ID: <200710101316.03633.jan@swi-prolog.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 13:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfZqN-0001OY-VK
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 13:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXJJLfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 07:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXJJLfF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 07:35:05 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:1542 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXJJLfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 07:35:04 -0400
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2007 07:35:03 EDT
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9ABLvPn090965
	for <git@vger.kernel.org>; Wed, 10 Oct 2007 13:21:57 +0200 (CEST)
	(envelope-from jan@swi-prolog.org)
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60491>

[PATCH] git-cvsserver: added support for update -p
---
Hi,

Someone in our team uses "cvs update -p [-r rev] file" (somehow invoked
through TortoiseCVS). The patch below provides that. I think it is fine,
except that I don't know with wich other flags -p can be combined and
therefore when exactly this should be tested. Figured out that normal
CVS sends the file line-by-line preceeded by "M " using strace on the
client to a real CVS server.

	Enjoy --- Jan

 git-cvsserver.perl |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13dbd27..987f4d6 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -956,6 +956,21 @@ sub req_update
             $meta = $updater->getmeta($filename);
         }
 
+	# if we have a -p we should just send the file
+        if ( exists ( $state->{opt}{p} ) )
+	{
+	    if ( open my $fh, '-|', "git-cat-file", "blob", $meta->{filehash} )
+	    {   while ( <$fh> )
+		{ print "M " . $_;
+		}
+		close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
+	    } else
+	    { die("Couldn't execute git-cat-file");
+	    }
+
+	    next;
+	}
+
 	if ( ! defined $meta )
 	{
 	    $meta = {
-- 
1.5.3.4
