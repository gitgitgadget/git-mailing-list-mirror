From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsimport: setup indexes correctly for ancestors and
 incremental imports
Date: Sat, 24 Jun 2006 21:42:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606242111250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11511475882820-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jun 24 21:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuE1R-00014Q-ID
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWFXTmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 15:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWFXTmW
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 15:42:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:42435 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751067AbWFXTmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 15:42:22 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1A25C2875;
	Sat, 24 Jun 2006 21:42:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0EB932873;
	Sat, 24 Jun 2006 21:42:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E5B3721EE;
	Sat, 24 Jun 2006 21:42:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11511475882820-git-send-email-martin@catalyst.net.nz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22538>

Hi,

almost happy.

On Sat, 24 Jun 2006, Martin Langhoff wrote:

>  			unless ($index{$branch}) {
>  			    $index{$branch} = tmpnam();
>  			    $ENV{GIT_INDEX_FILE} = $index{$branch};
> -			    system("git-read-tree", $branch);
> +			}
> +			if ($ancestor) {
> +			    system("git-read-tree", $ancestor);
>  			    die "read-tree failed: $?\n" if $?;
>  			} else {
> +			    unless ($index{$branch}) {
> +				$index{$branch} = tmpnam();
> +				$ENV{GIT_INDEX_FILE} = $index{$branch};
> +				system("git-read-tree", $branch);
> +				die "read-tree failed: $?\n" if $?;
> +			    }
> +			}    

This line ^ seems to have white space at the end.

Also, in my case, this is still broken. $index{$branch} is set, $ancestor 
not, but $ENV{GIT_INDEX_FILE} ne $index{$branch}.

You can reproduce this by importing into branch origin while branch master 
(which is not equal to origin) is checked out.

Plus, the initial setting of GIT_INDEX_FILE forgot to perform a 
git-read-tree.

How about this on top of your patch (which fixes things with my setup):

---
[PATCH] cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}

Also, make sure that the initial git-read-tree is performed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-cvsimport |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

--- git-cvsimport.perl	2006-06-24 20:30:33.000000000 +0200
+++ git-cvsimport	2006-06-24 21:35:42.000000000 +0200
@@ -470,6 +470,9 @@
 $index{$opt_o} = tmpnam();
 
 $ENV{GIT_INDEX_FILE} = $index{$opt_o};
+system("git-read-tree", $opt_o);
+die "read-tree failed: $?\n" if $?;
+
 unless(-d $git_dir) {
 	system("git-init-db");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
@@ -813,17 +816,15 @@
 			unless ($index{$branch}) {
 			    $index{$branch} = tmpnam();
 			    $ENV{GIT_INDEX_FILE} = $index{$branch};
+			    system("git-read-tree", $branch);
+			    die "read-tree failed: $?\n" if $?;
 			}
+			# just in case
+			$ENV{GIT_INDEX_FILE} = $index{$branch};
 			if ($ancestor) {
+			    print "have ancestor $ancestor" if $opt_v;
 			    system("git-read-tree", $ancestor);
 			    die "read-tree failed: $?\n" if $?;
-			} else {
-			    unless ($index{$branch}) {
-				$index{$branch} = tmpnam();
-				$ENV{GIT_INDEX_FILE} = $index{$branch};
-				system("git-read-tree", $branch);
-				die "read-tree failed: $?\n" if $?;
-			    }
 			}
 		} else {
 			# just in case
